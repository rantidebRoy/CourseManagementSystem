package cse.web;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import com.mongodb.client.model.Updates;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class EditCourseServlet extends HttpServlet {

    // Handles loading course data into edit_course.jsp
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Verify admin access using session
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        if (role == null || !"admin".equals(role)) {
            response.sendRedirect("home.jsp");
            return;
        }

        // 2. Get course code from edit link/button
        String courseCode = request.getParameter("courseCode");

        if (courseCode != null) {
            // 3. Fetch course details from database
            MongoDatabase db = MongoDBConnection.getDatabase();
            MongoCollection<Document> courses = db.getCollection("courses");
            Document course = courses.find(new Document("code", courseCode)).first();

            // 4. Send course data to JSP for pre-filled edit form
            request.setAttribute("course", course);
            RequestDispatcher rd = request.getRequestDispatcher("edit_course.jsp");
            rd.forward(request, response);
        }
    }

    // Handles update submission from edit_course.jsp
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 5. Verify admin access again for POST request
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        if (role == null || !"admin".equals(role)) {
            response.sendRedirect("home.jsp");
            return;
        }

        // 6. Read updated course data from form
        String courseCode = request.getParameter("courseCode");
        String courseName = request.getParameter("courseName");
        String teacher = request.getParameter("teacher");

        if (courseCode != null && !courseCode.isEmpty()) {
            // 7. Update course document in MongoDB
            MongoDatabase db = MongoDBConnection.getDatabase();
            MongoCollection<Document> courses = db.getCollection("courses");

            courses.updateOne(
                new Document("code", courseCode),
                Updates.combine(
                    Updates.set("name", courseName),
                    Updates.set("teacher", teacher)
                )
            );
        }

        // 8. Redirect back to admin dashboard after update
        response.sendRedirect("admin.jsp");
    }
}
