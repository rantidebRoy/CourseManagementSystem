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

        HttpSession session = request.getSession();
        String student = (String) session.getAttribute("username");
        String courseCode = request.getParameter("courseCode");

        MongoDatabase db = MongoDBConnection.getDatabase();
        MongoCollection<Document> regs = db.getCollection("registrations");

        // Delete the registration
        regs.deleteOne(new Document("student", student)
                           .append("courseCode", courseCode));

        response.sendRedirect("student.jsp");
    }
}
