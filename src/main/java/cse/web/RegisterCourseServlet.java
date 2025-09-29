package cse.web;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class RegisterCourseServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        if(role == null || !"student".equals(role)) {
            response.sendRedirect("home.jsp");
            return;
        }

        String student = (String) session.getAttribute("username");
        String courseCode = request.getParameter("courseCode");

        MongoDatabase db = MongoDBConnection.getDatabase();
        MongoCollection<Document> regs = db.getCollection("registrations");

        Document existing = regs.find(new Document("student", student).append("courseCode", courseCode)).first();
        if(existing == null) {
            regs.insertOne(new Document("student", student).append("courseCode", courseCode));
        }

        response.sendRedirect("student.jsp");
    }
}
