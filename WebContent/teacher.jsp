<%@ page import="cse.web.MongoDBConnection, com.mongodb.client.MongoDatabase, com.mongodb.client.MongoCollection, org.bson.Document"%>
<%@ page session="true"%>
<%
    String role = (String) session.getAttribute("role");
    String teacher = (String) session.getAttribute("username");
    if(role == null || !"teacher".equals(role)) {
        response.sendRedirect("home.jsp");
        return;
    }

    MongoDatabase db = MongoDBConnection.getDatabase();
    MongoCollection<Document> courses = db.getCollection("courses");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Teacher Dashboard</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="min-h-screen bg-gradient-to-br from-[#938899] via-[#a79eac] to-[#938899]">

<div class="flex justify-end p-6">
    <form action="logout" method="post">
        <button class="bg-red-600 text-white px-6 py-2 rounded-lg shadow">
            Logout
        </button>
    </form>
</div>

<main class="max-w-6xl mx-auto px-6 pb-10">

<div class="bg-[#005461]/80 backdrop-blur-xl text-white rounded-3xl shadow-2xl p-12">

    <h1 class="text-4xl font-bold mb-10">Teacher Dashboard</h1>

    <h2 class="text-2xl font-semibold mb-4">Select Course</h2>

    <form action="viewStudents" method="get"
          class="flex gap-4">
        <select name="courseCode"
                class="flex-1 p-4 rounded-lg text-[#005461] font-semibold shadow">
            <% for(Document c : courses.find(new Document("teacher", teacher))) { %>
                <option value="<%= c.getString("code") %>">
                    <%= c.getString("name") %>
                </option>
            <% } %>
        </select>

        <button class="bg-white text-[#005461] px-8 py-4 rounded-lg font-semibold shadow">
            View Students
        </button>
    </form>

</div>
</main>
</body>
</html>
