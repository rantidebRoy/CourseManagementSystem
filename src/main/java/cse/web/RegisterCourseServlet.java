package cse.web;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class RegisterCourseServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get session and verify student role
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        if (role == null || !"student".equals(role)) {
            response.sendRedirect("home.jsp");
            return;
        }

        // 2. Get logged-in student username from session
        String student = (String) session.getAttribute("username");

        // 3. Get selected course data from student.jsp
        String courseCode = request.getParameter("courseCode");
        String courseName = request.getParameter("courseName");

        // 4. Connect to MongoDB registrations collection
        MongoDatabase db = MongoDBConnection.getDatabase();
        MongoCollection<Document> regs = db.getCollection("registrations");

        // 5. Check if student is already registered for this course
        Document existing = regs.find(
                new Document("student", student).append("courseCode", courseCode)
        ).first();

        if (existing != null) {
            // 6. Send error back if already registered
            request.setAttribute("errorMessage", "You are already registered for this course.");
            RequestDispatcher rd = request.getRequestDispatcher("student.jsp");
            rd.forward(request, response);
            return;
        }

        // 7. Insert new registration record
        regs.insertOne(new Document("student", student)
                .append("courseCode", courseCode));

        // 8. Redirect back to student dashboard
        response.sendRedirect("student.jsp");
    }
}
