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

        String courseCode = request.getParameter("courseCode");
        if (courseCode == null) {
            response.sendRedirect("teacher.jsp");
            return;
        }

        MongoDatabase db = MongoDBConnection.getDatabase();

        // Fetch students from registrations
        MongoCollection<Document> regs = db.getCollection("registrations");
        List<String> students = new ArrayList<>();
        for (Document r : regs.find(new Document("courseCode", courseCode))) {
            students.add(r.getString("student"));
        }

        // Fetch course document to get course name
        MongoCollection<Document> courses = db.getCollection("courses");
        Document courseDoc = courses.find(new Document("code", courseCode)).first();
        String courseName = (courseDoc != null) ? courseDoc.getString("name") : "Unknown";

        // Set request attributes
        request.setAttribute("courseCode", courseCode);
        request.setAttribute("courseName", courseName);
        request.setAttribute("students", students);

        // Forward to JSP
        RequestDispatcher rd = request.getRequestDispatcher("view_students.jsp");
        rd.forward(request, response);
    }
}
