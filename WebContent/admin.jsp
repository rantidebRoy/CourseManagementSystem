<%@ page import="cse.web.MongoDBConnection, com.mongodb.client.MongoDatabase, com.mongodb.client.MongoCollection, org.bson.Document, com.mongodb.client.MongoCursor"%>
<%@ page session="true"%>
<%
    String role = (String) session.getAttribute("role");
    if(role == null || !"admin".equals(role)) {
        response.sendRedirect("home.jsp");
        return;
    }

    MongoDatabase db = MongoDBConnection.getDatabase();
    MongoCollection<Document> teachers = db.getCollection("users");
    MongoCollection<Document> courses = db.getCollection("courses");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<!-- Logout button -->
<form action="logout" method="post" style="text-align:right; margin:10px;">
    <button type="submit" class="btn btn-danger btn-sm">Logout</button>
</form>

<div class="container mt-5">
    <!-- Add Course Form -->
    <div class="card shadow-lg mb-4">
        <div class="card-header bg-primary text-white">
            <h3>Admin Dashboard</h3>
        </div>
        <div class="card-body">
            <h5>Add a New Course</h5>
            <form action="AddCourseServlet" method="post" class="row g-3">
                <div class="col-md-4">
                    <input type="text" name="courseCode" placeholder="Course Code" class="form-control" required>
                </div>
                <div class="col-md-4">
                    <input type="text" name="courseName" placeholder="Course Name" class="form-control" required>
                </div>
                <div class="col-md-4">
                    <select name="teacher" class="form-select" required>
                        <option value="">Select Teacher</option>
                        <% for(Document t : teachers.find(new Document("role","teacher"))) { %>
                            <option value="<%= t.getString("username") %>"><%= t.getString("username") %></option>
                        <% } %>
                    </select>
                </div>
                <div class="col-12">
                    <button type="submit" class="btn btn-success">Add Course</button>
                </div>
            </form>
        </div>
    </div>

    <!-- View All Courses -->
    <div class="card shadow-lg">
        <div class="card-header bg-secondary text-white">
            <h5>All Courses and Assigned Teachers</h5>
        </div>
        <div class="card-body">
            <%
                MongoCursor<Document> courseCursor = courses.find().iterator();
                if(!courseCursor.hasNext()) {
            %>
                <p class="text-muted">No courses added yet.</p>
            <%
                } else {
            %>
                <table class="table table-bordered table-striped">
                    <thead class="table-dark">
                        <tr>
                            <th>Course Code</th>
                            <th>Course Name</th>
                            <th>Assigned Teacher</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            while(courseCursor.hasNext()) {
                                Document c = courseCursor.next();
                                String code = c.getString("code");
                        %>
                        <tr>
                            <td><%= code %></td>
                            <td><%= c.getString("name") %></td>
                            <td><%= c.getString("teacher") %></td>
                            <td>
                                <!-- Edit button -->
                                <form action="EditCourseServlet" method="get" style="display:inline-block;">
                                    <input type="hidden" name="courseCode" value="<%= code %>">
                                    <button type="submit" class="btn btn-sm btn-warning">Edit</button>
                                </form>
                                <!-- Delete button -->
                                <form action="DeleteCourseServlet" method="post" style="display:inline-block;" 
                                      onsubmit="return confirm('Are you sure you want to delete this course?');">
                                    <input type="hidden" name="courseCode" value="<%= code %>">
                                    <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                                </form>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            <%
                }
            %>
        </div>
    </div>
</div>

</body>
</html>
