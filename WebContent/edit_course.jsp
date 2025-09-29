<%@ page import="cse.web.MongoDBConnection, com.mongodb.client.MongoDatabase, com.mongodb.client.MongoCollection, org.bson.Document"%>
<%@ page session="true"%>
<%
    String role = (String) session.getAttribute("role");
    if(role == null || !"admin".equals(role)) {
        response.sendRedirect("home.jsp");
        return;
    }

    Document course = (Document) request.getAttribute("course");
    MongoDatabase db = MongoDBConnection.getDatabase();
    MongoCollection<Document> teachers = db.getCollection("users");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Course</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow-lg">
        <div class="card-header bg-warning text-white">
            <h3>Edit Course</h3>
        </div>
        <div class="card-body">
            <form action="EditCourseServlet" method="post" class="row g-3">
                <input type="hidden" name="courseCode" value="<%= course.getString("code") %>">
                <div class="col-md-4">
                    <input type="text" name="courseName" value="<%= course.getString("name") %>" class="form-control" required>
                </div>
                <div class="col-md-4">
                    <select name="teacher" class="form-select" required>
                        <% for(Document t : teachers.find(new Document("role","teacher"))) { %>
                            <option value="<%= t.getString("username") %>" 
                                <%= t.getString("username").equals(course.getString("teacher")) ? "selected" : "" %>>
                                <%= t.getString("username") %>
                            </option>
                        <% } %>
                    </select>
                </div>
                <div class="col-12">
                    <button type="submit" class="btn btn-success">Update Course</button>
                    <a href="admin.jsp" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>
