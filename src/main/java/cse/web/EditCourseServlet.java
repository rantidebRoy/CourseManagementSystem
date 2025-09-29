package cse.web;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import com.mongodb.client.model.Updates;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class EditCourseServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        if(role == null || !"admin".equals(role)) {
            response.sendRedirect("home.jsp");
            return;
        }

        String courseCode = request.getParameter("courseCode");
        if(courseCode != null) {
            MongoDatabase db = MongoDBConnection.getDatabase();
            MongoCollection<Document> courses = db.getCollection("courses");
            Document course = courses.find(new Document("code", courseCode)).first();

            request.setAttribute("course", course);
            RequestDispatcher rd = request.getRequestDispatcher("edit_course.jsp");
            rd.forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        if(role == null || !"admin".equals(role)) {
            response.sendRedirect("home.jsp");
            return;
        }

        String courseCode = request.getParameter("courseCode");
        String courseName = request.getParameter("courseName");
        String teacher = request.getParameter("teacher");

        if(courseCode != null && !courseCode.isEmpty()) {
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

        response.sendRedirect("admin.jsp"); // reload admin page after update
    }
}
