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
<script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="min-h-screen bg-gradient-to-br
             from-slate-800
             via-slate-900
             to-black">

<!-- Logout -->
<div class="flex justify-end p-6">
    <form action="logout" method="post">
        <button class="bg-red-600 text-white px-6 py-2 rounded-lg shadow">
            Logout
        </button>
    </form>
</div>

<main class="max-w-5xl mx-auto px-6 pb-10">

<div class="bg-[#005461]/80 backdrop-blur-xl text-white
rounded-3xl shadow-2xl p-12">

    <h1 class="text-4xl font-bold mb-10">Edit Course</h1>

    <form action="EditCourseServlet" method="post"
          class="grid grid-cols-1 md:grid-cols-3 gap-6">

        <input type="hidden" name="courseCode"
               value="<%= course.getString("code") %>">

        <div class="md:col-span-2">
            <label class="block mb-2 font-semibold">Course Name</label>
            <input type="text" name="courseName"
                   value="<%= course.getString("name") %>"
                   required
                   class="w-full p-4 rounded-lg text-[#005461]
                          font-semibold shadow focus:outline-none">
        </div>

        <div>
            <label class="block mb-2 font-semibold">Assigned Teacher</label>
            <select name="teacher" required
                    class="w-full p-4 rounded-lg text-[#005461]
                           font-semibold shadow focus:outline-none">
                <% for(Document t : teachers.find(new Document("role","teacher"))) { %>
                    <option value="<%= t.getString("username") %>"
                        <%= t.getString("username").equals(course.getString("teacher"))
                            ? "selected" : "" %>>
                        <%= t.getString("username") %>
                    </option>
                <% } %>
            </select>
        </div>

        <!-- Actions -->
        <div class="md:col-span-3 flex justify-end gap-4 mt-8">
            <a href="admin.jsp"
               class="bg-gray-400 hover:bg-gray-500 text-white
                      px-6 py-3 rounded-lg font-semibold shadow transition">
                Cancel
            </a>

            <button type="submit"
                    class="bg-white text-[#005461]
                           px-8 py-3 rounded-lg font-semibold
                           shadow hover:shadow-xl transition">
                Update Course
            </button>
        </div>
    </form>

</div>
</main>
</body>
</html>
