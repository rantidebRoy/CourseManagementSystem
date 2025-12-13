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

    String errorMessage = (String) request.getAttribute("errorMessage");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Dashboard</title>
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

    <main class="container mx-auto px-6 flex-grow space-y-10">

        <!-- Register for Course Card -->
        <section class="bg-[#2c7be5] rounded-2xl shadow-2xl p-8 max-w-4xl mx-auto">

            <h2 class="text-3xl font-bold mb-6 drop-shadow">Student Dashboard</h2>

            <h3 class="text-xl font-semibold mb-4">Register for a Course</h3>

            <% if (errorMessage != null) { %>
                <div class="bg-red-700 text-white p-3 rounded mb-4 shadow-md">
                    <%= errorMessage %>
                </div>
            <% } %>

            <form action="RegisterCourseServlet" method="post" class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">
              <select name="courseCode" required
        class="p-3 rounded-lg text-[#2c7be5] font-semibold focus:outline-none shadow">
    <option value="">Select Course</option>
    <% for(Document c : courses.find()) { %>
        <option value="<%= c.getString("code") %>">
            <%= c.getString("name") %> (<%= c.getString("code") %>)
        </option>
    <% } %>
</select>


                <button type="submit"
                    class="bg-white text-[#2c7be5] font-semibold py-3 rounded-lg shadow hover:bg-[#e0e7ff] transition">
                    Register
                </button>
            </form>
        </section>

        <!-- My Registered Courses Card -->
        <section class="bg-[#f0f9ff] rounded-2xl shadow-2xl p-8 max-w-4xl mx-auto text-gray-900">

            <h3 class="text-2xl font-bold mb-6 drop-shadow-md">My Registered Courses</h3>

            <%
                java.util.List<Document> registeredCourses = new java.util.ArrayList<>();
                for(Document r : regs.find(new Document("student", student))) {
                    Document c = courses.find(new Document("code", r.getString("courseCode"))).first();
                    if (c != null) registeredCourses.add(c);
                }
            %>

            <% if (registeredCourses.isEmpty()) { %>
                <p class="text-gray-600 italic">You have not registered for any courses yet.</p>
            <% } else { %>
                <div class="overflow-x-auto rounded-lg shadow-lg">
                    <table class="min-w-full border border-gray-300 rounded-lg overflow-hidden shadow-md">
                        <thead class="bg-[#2c7be5] text-white">
    						<tr>
        						<th class="px-5 py-3 text-left">Course Code</th>
        						<th class="px-5 py-3 text-left">Course Name</th>
      							<th class="px-5 py-3 text-left">Action</th>
    						</tr>
						</thead>

                        <tbody>
<% for (Document c : registeredCourses) { %>
<tr class="even:bg-white odd:bg-[#dbeafe] hover:bg-[#a6c8ff] transition">
    <td class="px-5 py-3 font-semibold"><%= c.getString("code") %></td>
    <td class="px-5 py-3"><%= c.getString("name") %></td>
    <td class="px-5 py-3">
        <form action="UnregisterCourseServlet" method="post">
            <input type="hidden" name="courseCode" value="<%= c.getString("code") %>">
            <button type="submit"
                class="bg-[#2c7be5] text-white px-4 py-2 rounded shadow hover:bg-red-700 transition">
                Remove
            </button>
        </form>
    </td>
</tr>
<% } %>

                        </tbody>
                    </table>
                </div>
            <% } %>
        </section>

    </main>
</body>
</html>
