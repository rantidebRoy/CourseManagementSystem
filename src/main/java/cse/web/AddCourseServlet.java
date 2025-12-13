package cse.web;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import org.bson.Document;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AddCourseServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        if (role == null || !"admin".equals(role)) {
            response.sendRedirect("home.jsp");
            return;
        }

        String code = request.getParameter("courseCode");
        String name = request.getParameter("courseName");
        String teacher = request.getParameter("teacher");

        MongoDatabase db = MongoDBConnection.getDatabase();
        MongoCollection<Document> courses = db.getCollection("courses");

        // Check if course code already exists
        Document existingCourse = courses.find(Filters.eq("code", code)).first();

        if (existingCourse != null) {
            // Course with same code exists
            request.setAttribute("errorMessage", "Course with code " + code + " already exists.");
            RequestDispatcher rd = request.getRequestDispatcher("admin.jsp");
            rd.forward(request, response);
            return;
        }

        // Insert new course if not exists
        Document course = new Document("code", code)
                .append("name", name)
                .append("teacher", teacher);
        courses.insertOne(course);

        response.sendRedirect("admin.jsp");
    }
}
