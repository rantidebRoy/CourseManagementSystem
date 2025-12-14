package cse.web;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

// BCrypt library for verifying hashed password
import org.mindrot.jbcrypt.BCrypt;

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 1. Get form input values from login.jsp
        String username = request.getParameter("username"); // Username entered by user
        String password = request.getParameter("password"); // Password entered by user

        // 2. Connect to MongoDB
        MongoDatabase db = MongoDBConnection.getDatabase();
        MongoCollection<Document> users = db.getCollection("users");

        // 3. Find user document by username
        Document user = users.find(new Document("username", username)).first();

        // 4. Check if user exists AND password matches hashed password
        if (user == null || !BCrypt.checkpw(password, user.getString("password"))) {
            response.getWriter().println("Invalid username or password");
            return; // Stop execution if login fails
        }

        // 5. Create session and store user information
        HttpSession session = request.getSession();
        session.setAttribute("username", username);         // Store username in session
        session.setAttribute("role", user.getString("role")); // Store role in session

        // 6. Redirect to role-based dashboard
        String role = user.getString("role");
        if ("admin".equals(role)) {
            response.sendRedirect("admin.jsp");    // Admin dashboard
        } else if ("teacher".equals(role)) {
            response.sendRedirect("teacher.jsp");  // Teacher dashboard
        } else {
            response.sendRedirect("student.jsp");  // Student dashboard
        }
    }
}
