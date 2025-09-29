<%@ page import="cse.web.MongoDBConnection, com.mongodb.client.MongoDatabase, com.mongodb.client.MongoCollection, org.bson.Document"%>
<%@ page session="true"%>
<%
    String role = (String) session.getAttribute("role");
    String student = (String) session.getAttribute("username");
    if(role == null || !"student".equals(role)) {
        response.sendRedirect("home.jsp");
        return;
    }
    MongoDatabase db = MongoDBConnection.getDatabase();
    MongoCollection<Document> courses = db.getCollection("courses");
    MongoCollection<Document> regs = db.getCollection("registrations");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<!-- Logout button -->
<form action="logout" method="post" style="text-align:right; margin:10px;">
    <button type="submit" class="btn btn-danger btn-sm">Logout</button>
</form>
<div class="container mt-5">
    <div class="card shadow-lg mb-4">
        <div class="card-header bg-primary text-white">
            <h3>Student Dashboard</h3>
        </div>
        <div class="card-body">
            <h5>Register for a Course</h5>
            <form action="RegisterCourseServlet" method="post" class="row g-3">
                <div class="col-md-6">
                    <select name="courseCode" class="form-select" required>
                        <option value="">Select Course</option>
                        <% for(Document c : courses.find()) { %>
                            <option value="<%= c.getString("code") %>"><%= c.getString("name") %></option>
                        <% } %>
                    </select>
                </div>
                <div class="col-md-6">
                    <button type="submit" class="btn btn-success">Register</button>
                </div>
            </form>

            <h5 class="mt-4">My Registered Courses</h5>
            <ul class="list-group">
                <% for(Document r : regs.find(new Document("student", student))) {
                       Document c = courses.find(new Document("code", r.getString("courseCode"))).first();
                %>
                    <li class="list-group-item"><%= c.getString("name") %> (<%= c.getString("code") %>)</li>
                <% } %>
            </ul>
        </div>
    </div>
</div>
</body>
</html>
