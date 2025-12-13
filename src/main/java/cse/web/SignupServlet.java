package cse.web;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class SignupServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        MongoDatabase db = MongoDBConnection.getDatabase();
        MongoCollection<Document> users = db.getCollection("users");

        Document existing = users.find(new Document("username", username)).first();
        if (existing != null) {
            response.getWriter().println("Username already exists!");
            return;
        }

        Document user = new Document("username", username)
                .append("password", password)
                .append("role", role);
        users.insertOne(user);

        response.sendRedirect("login.jsp");
    }
}
