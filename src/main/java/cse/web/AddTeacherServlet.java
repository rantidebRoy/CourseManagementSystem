package cse.web;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.mongodb.client.MongoCollection;
import org.bson.Document;

public class AddTeacherServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String teacherName = req.getParameter("teacherName");
        String teacherEmail = req.getParameter("teacherEmail");

        if (teacherName != null && teacherEmail != null) {
            MongoCollection<Document> teachers = MongoDBConnection
                    .getDatabase()
                    .getCollection("teachers");

            Document teacher = new Document("name", teacherName)
                                        .append("email", teacherEmail);
            teachers.insertOne(teacher);
        }

        resp.sendRedirect("ViewTeacherServlet");
    }
}
