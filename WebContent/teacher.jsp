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
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="min-h-screen bg-gradient-to-br from-[#938899] via-[#a79eac] to-[#938899] text-white flex flex-col">

    <!-- Logout button -->
    <div class="flex justify-end p-4">
        <form action="logout" method="post">
            <button type="submit" class="bg-red-600 hover:bg-red-700 px-4 py-2 rounded shadow font-semibold transition">
                Logout
            </button>
        </form>
    </div>

    <main class="container mx-auto px-6 flex-grow">

        <section class="bg-[#28a745] rounded-2xl shadow-2xl p-8 max-w-md mx-auto">

            <h2 class="text-3xl font-bold mb-6 drop-shadow">Teacher Dashboard</h2>

            <h3 class="text-xl font-semibold mb-4">Select one of your courses:</h3>

            <form action="viewStudents" method="get" class="flex flex-col gap-4">
                <label for="course" class="mb-2 font-semibold">Courses</label>
                <select name="courseCode" id="course" class="p-3 rounded-lg text-[#28a745] font-semibold focus:outline-none shadow">
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
                <button type="submit" class="bg-white text-[#28a745] font-semibold py-3 rounded-lg shadow hover:bg-[#d1f7d3] transition">
                    View Students
                </button>
            </form>
        </section>

    </main>

</body>
</html>
