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

        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        if(role == null || !"admin".equals(role)) {
            response.sendRedirect("home.jsp");
            return;
        }

        String courseCode = request.getParameter("courseCode");
        if(courseCode != null && !courseCode.isEmpty()) {
            MongoDatabase db = MongoDBConnection.getDatabase();
            MongoCollection<Document> courses = db.getCollection("courses");
            courses.deleteOne(new Document("code", courseCode));
        }

        response.sendRedirect("admin.jsp"); // reload page after deletion
    }
}
