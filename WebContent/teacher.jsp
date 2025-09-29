<%@ page import="cse.web.MongoDBConnection, com.mongodb.client.MongoDatabase, com.mongodb.client.MongoCollection, org.bson.Document, com.mongodb.client.MongoCursor"%>
<%@ page session="true"%>
<%
    String role = (String) session.getAttribute("role");
    String teacher = (String) session.getAttribute("username");

    if (role == null || !"teacher".equals(role)) {
        response.sendRedirect("home.jsp");
        return;
    }

    MongoDatabase db = MongoDBConnection.getDatabase();
    MongoCollection<Document> courses = db.getCollection("courses");
    MongoCursor<Document> courseCursor = courses.find(new Document("teacher", teacher)).iterator();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Teacher Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<!-- Logout button -->
<form action="logout" method="post" style="text-align:right; margin:10px;">
    <button type="submit" class="btn btn-danger btn-sm">Logout</button>
</form>

<div class="container mt-5">
    <div class="card shadow-lg">
        <div class="card-header bg-primary text-white">
            <h3>Teacher Dashboard</h3>
        </div>
        <div class="card-body">
            <h5>Select one of your courses:</h5>

            <form action="viewStudents" method="get">
                <div class="mb-3">
                    <label for="course" class="form-label">Courses</label>
                    <select name="courseCode" id="course" class="form-select">
                        <%
                            boolean hasCourses = false;
                            while (courseCursor.hasNext()) {
                                hasCourses = true;
                                Document c = courseCursor.next();
                        %>
                            <option value="<%= c.getString("code") %>">
                                <%= c.getString("name") %> (<%= c.getString("code") %>)
                            </option>
                        <%
                            }
                            if (!hasCourses) {
                        %>
                            <option disabled>No courses assigned</option>
                        <%
                            }
                        %>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">View Students</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>
