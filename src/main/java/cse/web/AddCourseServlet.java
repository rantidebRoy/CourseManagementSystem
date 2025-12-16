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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get current HTTP session
        HttpSession session = request.getSession();

        // 2. Fetch role from session to ensure only admin can add courses
        String role = (String) session.getAttribute("role");
        if (role == null || !"admin".equals(role)) {
            response.sendRedirect("home.jsp"); // Unauthorized access
            return;
        }

        // 3. Read course details submitted from admin.jsp form
        String code = request.getParameter("courseCode");
        String name = request.getParameter("courseName");
        String teacher = request.getParameter("teacher");

        // 4. Connect to MongoDB and select courses collection
        MongoDatabase db = MongoDBConnection.getDatabase();
        MongoCollection<Document> courses = db.getCollection("courses");

        // 5. Check if a course with the same code already exists
        Document existingCourse = courses.find(Filters.eq("code", code)).first();

        if (existingCourse != null) {
            // 6. If duplicate found, send error message back to admin.jsp
            request.setAttribute("errorMessage", "Course with code " + code + " already exists.");
            RequestDispatcher rd = request.getRequestDispatcher("admin.jsp");
            rd.forward(request, response);
            return;
        }

        // 7. Create new course document and insert into MongoDB
        Document course = new Document("code", code)
                .append("name", name)
                .append("teacher", teacher);
        courses.insertOne(course);

        // 8. Redirect back to admin dashboard after successful insertion
        response.sendRedirect("admin.jsp");
    }
}
