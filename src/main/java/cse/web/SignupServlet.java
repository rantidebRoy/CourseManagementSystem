package cse.web;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

// BCrypt library for password hashing
import org.mindrot.jbcrypt.BCrypt;

public class SignupServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 1. Get form input values from signup.jsp
        String username = request.getParameter("username"); // Username entered by user
        String password = request.getParameter("password"); // Password entered by user
        String role = request.getParameter("role");         // Role selected by user

        // 2. Hash the password before storing it in database
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        // 3. Connect to MongoDB
        MongoDatabase db = MongoDBConnection.getDatabase();
        MongoCollection<Document> users = db.getCollection("users");

        // 4. Check if username already exists
        Document existing = users.find(new Document("username", username)).first();
        if (existing != null) {
            response.getWriter().println("Username already exists! Please choose a different username.");
            return; // Stop execution if duplicate username found
        }

        // 5. Create a new user document and insert into MongoDB
        Document user = new Document("username", username)
                .append("password", hashedPassword) // Store hashed password
                .append("role", role);
        users.insertOne(user);

        // 6. Redirect user to login page after successful signup
        response.sendRedirect("login.jsp");
    }
}
