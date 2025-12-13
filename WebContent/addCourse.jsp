<!DOCTYPE html>
<html>
<head>
    <title>Add Course</title>
</head>
<body>
    <h2>Add Course</h2>
    <form action="AddCourseServlet" method="post">
        Course Name: <input type="text" name="courseName" required><br><br>
        Course Code: <input type="text" name="courseCode" required><br><br>
        <input type="submit" value="Add Course">
    </form>
    <br>
    <a href="ViewCourseServlet">View Courses</a>
</body>
</html>
