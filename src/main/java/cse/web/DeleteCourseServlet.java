package cse.web;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class DeleteCourseServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get session and verify admin role
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        if (role == null || !"admin".equals(role)) {
            response.sendRedirect("home.jsp"); // Unauthorized access
            return;
        }

        // 2. Get course code from admin.jsp delete form
        String courseCode = request.getParameter("courseCode");

        if (courseCode != null && !courseCode.isEmpty()) {
            // 3. Connect to MongoDB and delete the course document
            MongoDatabase db = MongoDBConnection.getDatabase();
            MongoCollection<Document> courses = db.getCollection("courses");
            courses.deleteOne(new Document("code", courseCode));
        }

        // 4. Redirect back to admin dashboard after deletion
        response.sendRedirect("admin.jsp");
    }
}
