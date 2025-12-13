package cse.web;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        MongoDatabase db = MongoDBConnection.getDatabase();
        MongoCollection<Document> users = db.getCollection("users");

        Document user = users.find(new Document("username", username).append("password", password)).first();

        if (user == null) {
            response.getWriter().println("Invalid username or password");
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("username", username);
        session.setAttribute("role", user.getString("role"));

        String role = user.getString("role");
        if ("admin".equals(role)) response.sendRedirect("admin.jsp");
        else if ("teacher".equals(role)) response.sendRedirect("teacher.jsp");
        else response.sendRedirect("student.jsp");
    }
}

