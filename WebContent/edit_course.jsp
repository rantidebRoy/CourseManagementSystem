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
    <meta charset="UTF-8" />
    <title>Edit Course</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="min-h-screen bg-gradient-to-br from-[#938899] via-[#a79eac] to-[#938899] flex items-center justify-center p-6">

    <div class="bg-[#D64029] rounded-2xl shadow-2xl p-8 max-w-3xl w-full text-gray-900">
        <h2 class="text-3xl font-bold mb-6 drop-shadow-sm text-white">Edit Course</h2>

        <form action="EditCourseServlet" method="post" class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <input type="hidden" name="courseCode" value="<%= course.getString("code") %>" />

            <input 
                type="text" 
                name="courseName" 
                value="<%= course.getString("name") %>" 
                placeholder="Course Name" 
                required
                class="col-span-1 md:col-span-2 p-3 rounded-lg font-semibold focus:outline-none shadow-md"
            />

            <select 
                name="teacher" 
                required
                class="col-span-1 p-3 rounded-lg font-semibold focus:outline-none shadow-md"
            >
                <% for(Document t : teachers.find(new Document("role","teacher"))) { %>
                    <option value="<%= t.getString("username") %>" 
                        <%= t.getString("username").equals(course.getString("teacher")) ? "selected" : "" %>>
                        <%= t.getString("username") %>
                    </option>
                <% } %>
            </select>

            <div class="col-span-1 md:col-span-3 flex justify-end gap-4 mt-4">
                <button 
                    type="submit" 
                    class="bg-green-600 hover:bg-green-700 text-white font-semibold py-3 px-6 rounded-lg shadow-md transition"
                >
                    Update Course
                </button>

                <a 
                    href="admin.jsp" 
                    class="bg-gray-500 hover:bg-gray-600 text-white font-semibold py-3 px-6 rounded-lg shadow-md transition flex items-center justify-center"
                >
                    Cancel
                </a>
            </div>
        </form>
    </div>

</body>
</html>
