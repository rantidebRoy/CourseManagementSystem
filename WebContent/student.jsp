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
<script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="min-h-screen bg-gradient-to-br
             from-slate-800
             via-slate-900
             to-black">

<div class="flex justify-end p-6">
    <form action="logout" method="post">
        <button class="bg-red-600 text-white px-6 py-2 rounded-lg shadow">
            Logout
        </button>
    </form>
</div>

<main class="max-w-7xl mx-auto px-6 pb-10">

<div class="bg-[#005461]/80 backdrop-blur-xl text-white rounded-3xl shadow-2xl p-12">

    <h1 class="text-5xl font-bold mb-6 drop-shadow text-center">
    Welcome <span class="text-white/90"><%= student%>!</span>
</h1>


    <!-- Register -->
    <div class="mb-10">
        <h2 class="text-2xl font-semibold mb-4">Register for Course</h2>
        <form action="RegisterCourseServlet" method="post"
              class="flex gap-4">
            <select name="courseCode" required
                    class="flex-1 p-4 rounded-lg text-[#005461] font-semibold shadow">
                <option value="">Select Course</option>
                <% for(Document c : courses.find()) { %>
                    <option value="<%= c.getString("code") %>">
                        <%= c.getString("name") %>
                    </option>
                <% } %>
            </select>

            <button class="bg-white text-[#005461] px-8 py-4 rounded-lg font-semibold shadow">
                Register
            </button>
        </form>
    </div>

    <!-- My Courses -->
    <div class="bg-white/90 text-[#005461] rounded-2xl p-8 shadow-xl">
        <h2 class="text-2xl font-bold mb-6">My Courses</h2>

        <% for(Document r : regs.find(new Document("student", student))) {
            Document c = courses.find(new Document("code", r.getString("courseCode"))).first();
            if(c != null) { %>

        <div class="flex justify-between items-center border-b py-4">
            <div>
                <p class="font-semibold text-lg"><%= c.getString("name") %></p>
                <p class="text-sm opacity-70"><%= c.getString("code") %></p>
            </div>

            <form action="UnregisterCourseServlet" method="post">
                <input type="hidden" name="courseCode" value="<%= c.getString("code") %>">
                <button class="bg-red-600 text-white px-5 py-2 rounded-lg shadow">
                    Remove
                </button>
            </form>
        </div>

        <% }} %>
    </div>

</div>
</main>
</body>
</html>
