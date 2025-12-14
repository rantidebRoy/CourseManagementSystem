<%@ page import="cse.web.MongoDBConnection, com.mongodb.client.MongoDatabase, com.mongodb.client.MongoCollection, org.bson.Document, com.mongodb.client.MongoCursor"%>
<%@ page session="true"%>
<%
    String role = (String) session.getAttribute("role");
    if(role == null || !"admin".equals(role)) {
        response.sendRedirect("home.jsp");
        return;
    }
    String username = (String) session.getAttribute("username");

    MongoDatabase db = MongoDBConnection.getDatabase();
    MongoCollection<Document> teachers = db.getCollection("users");
    MongoCollection<Document> courses = db.getCollection("courses");

    String errorMessage = (String) request.getAttribute("errorMessage");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="min-h-screen bg-gradient-to-br
             from-slate-800
             via-slate-900
             to-black">

<!-- Logout -->
<div class="flex justify-end p-6">
    <form action="logout" method="post">
        <button class="bg-red-600 hover:bg-red-700 text-white px-6 py-2 rounded-lg shadow font-semibold">
            Logout
        </button>
    </form>
</div>

<main class="max-w-7xl mx-auto px-6 pb-10">

<div class="bg-[#005461]/80 backdrop-blur-xl text-white rounded-3xl shadow-2xl p-12 space-y-12">

    <h1 class="text-5xl font-bold mb-6 drop-shadow text-center">
    Welcome <span class="text-white/90"><%= username%>!</span>
</h1>


    <!-- Add Course -->
    <section>
        <h2 class="text-3xl font-semibold mb-4">Add New Course</h2>

        <% if(errorMessage != null) { %>
            <div class="bg-red-600 p-3 rounded-lg mb-4"><%= errorMessage %></div>
        <% } %>

        <form action="AddCourseServlet" method="post"
              class="grid grid-cols-1 md:grid-cols-3 gap-4">

            <input name="courseCode" placeholder="Course Code" required
                   class="p-4 rounded-lg text-[#005461] font-semibold shadow">

            <input name="courseName" placeholder="Course Name" required
                   class="p-4 rounded-lg text-[#005461] font-semibold shadow">

            <select name="teacher" required
                    class="p-4 rounded-lg text-[#005461] font-semibold shadow">
                <option value="">Select Teacher</option>
                <% for(Document t : teachers.find(new Document("role","teacher"))) { %>
                    <option value="<%= t.getString("username") %>">
                        <%= t.getString("username") %>
                    </option>
                <% } %>
            </select>

            <div class="md:col-span-3 text-right">
                <button class="bg-white text-[#005461] px-8 py-3 rounded-lg font-semibold shadow">
                    Add Course
                </button>
            </div>
        </form>
    </section>

    <!-- Courses Table -->
<section class="bg-white/90 text-[#005461] rounded-2xl p-8 shadow-xl">
    <h2 class="text-3xl font-bold mb-6">All Courses</h2>

    <table class="w-full border-collapse text-lg"> <!-- Increased font size -->
        <thead class="bg-[#005461] text-white text-xl"> <!-- Header bigger -->
            <tr>
                <th class="px-5 py-3 text-left">Code</th>
                <th class="px-5 py-3 text-left">Name</th>
                <th class="px-5 py-3 text-left">Teacher</th>
                <th class="px-5 py-3 text-center">Actions</th>
            </tr>
        </thead>

        <tbody class="text-lg"> <!-- Body bigger -->
        <%
            MongoCursor<Document> cursor = courses.find().iterator();
            while(cursor.hasNext()) {
                Document c = cursor.next();
        %>
            <tr class="border-b even:bg-gray-50">
                <td class="px-5 py-3 font-semibold"><%= c.getString("code") %></td>
                <td class="px-5 py-3"><%= c.getString("name") %></td>
                <td class="px-5 py-3"><%= c.getString("teacher") %></td>

                <!-- Actions -->
                <td class="px-5 py-3">
                    <div class="flex justify-center gap-3">
                        <form action="EditCourseServlet" method="get">
                            <input type="hidden" name="courseCode" value="<%= c.getString("code") %>">
                            <button class="bg-[#005461] text-white px-4 py-2 rounded-lg shadow text-lg">
                                Edit
                            </button>
                        </form>

                        <form action="DeleteCourseServlet" method="post"
                              onsubmit="return confirm('Delete this course?');">
                            <input type="hidden" name="courseCode" value="<%= c.getString("code") %>">
                            <button class="bg-red-600 text-white px-4 py-2 rounded-lg shadow text-lg">
                                Delete
                            </button>
                        </form>
                    </div>
                </td>
            </tr>
        <% } %>
        </tbody>
    </table>
</section>


</div>
</main>
</body>
</html>
