package cse.web;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.mongodb.client.*;
import org.bson.Document;

import java.util.ArrayList;
import java.util.List;

public class ViewStudentsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get course code from teacher.jsp
        String courseCode = request.getParameter("courseCode");
        if (courseCode == null) {
            response.sendRedirect("teacher.jsp");
            return;
        }

        // 2. Connect to MongoDB
        MongoDatabase db = MongoDBConnection.getDatabase();

        // 3. Fetch registered students for the course
        MongoCollection<Document> regs = db.getCollection("registrations");
        List<String> students = new ArrayList<>();
        for (Document r : regs.find(new Document("courseCode", courseCode))) {
            students.add(r.getString("student"));
        }

        // 4. Fetch course name for display
        MongoCollection<Document> courses = db.getCollection("courses");
        Document courseDoc = courses.find(new Document("code", courseCode)).first();
        String courseName = (courseDoc != null) ? courseDoc.getString("name") : "Unknown";

        // 5. Send data to JSP
        request.setAttribute("courseCode", courseCode);
        request.setAttribute("courseName", courseName);
        request.setAttribute("students", students);

        // 6. Forward request to view_students.jsp
        RequestDispatcher rd = request.getRequestDispatcher("view_students.jsp");
        rd.forward(request, response);
    }
}
