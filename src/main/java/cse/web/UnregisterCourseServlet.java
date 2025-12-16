package cse.web;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.mongodb.client.*;
import org.bson.Document;

public class UnregisterCourseServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get logged-in student from session
        HttpSession session = request.getSession();
        String student = (String) session.getAttribute("username");

        // 2. Get course code to unregister
        String courseCode = request.getParameter("courseCode");

        // 3. Connect to MongoDB registrations collection
        MongoDatabase db = MongoDBConnection.getDatabase();
        MongoCollection<Document> regs = db.getCollection("registrations");

        // 4. Delete the registration document
        regs.deleteOne(new Document("student", student)
                           .append("courseCode", courseCode));

        // 5. Redirect back to student dashboard
        response.sendRedirect("student.jsp");
    }
}
