package cse.web;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AddCourseServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        if(role == null || !"admin".equals(role)) {
            response.sendRedirect("home.jsp");
            return;
        }

        String code = request.getParameter("courseCode");
        String name = request.getParameter("courseName");
        String teacher = request.getParameter("teacher");

        MongoDatabase db = MongoDBConnection.getDatabase();
        MongoCollection<Document> courses = db.getCollection("courses");

        Document course = new Document("code", code)
                .append("name", name)
                .append("teacher", teacher);
        courses.insertOne(course);

        response.sendRedirect("admin.jsp");
    }
}
