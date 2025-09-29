<%@ page import="java.util.List" %>
<%
    String courseCode = (String) request.getAttribute("courseCode");
    List<String> students = (List<String>) request.getAttribute("students");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Students of <%= courseCode %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow-lg">
        <div class="card-header bg-success text-white">
            <h3>Registered Students for Course: <%= courseCode %></h3>
        </div>
        <div class="card-body">
            <%
                if (students != null && !students.isEmpty()) {
            %>
                <ul class="list-group">
                    <% for (String s : students) { %>
                        <li class="list-group-item"><%= s %></li>
                    <% } %>
                </ul>
            <%
                } else {
            %>
                <p class="text-muted">No students registered for this course yet.</p>
            <%
                }
            %>
            <a href="teacher.jsp" class="btn btn-secondary mt-3">Back</a>
        </div>
    </div>
</div>

</body>
</html>
