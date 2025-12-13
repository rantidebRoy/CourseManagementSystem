<!DOCTYPE html>
<html>
<head>
    <title>Add Teacher</title>
</head>
<body>
    <h2>Add Teacher</h2>
    <form action="AddTeacherServlet" method="post">
        Teacher Name: <input type="text" name="teacherName" required><br><br>
        Teacher Email: <input type="email" name="teacherEmail" required><br><br>
        <input type="submit" value="Add Teacher">
    </form>
    <br>
    <a href="ViewTeacherServlet">View Teachers</a>
</body>
</html>
