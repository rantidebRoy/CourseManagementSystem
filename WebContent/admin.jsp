<%@ page import="cse.web.MongoDBConnection, com.mongodb.client.MongoDatabase, com.mongodb.client.MongoCollection, org.bson.Document, com.mongodb.client.MongoCursor"%>
<%@ page session="true"%>
<%
    String role = (String) session.getAttribute("role");
    if(role == null || !"admin".equals(role)) {
        response.sendRedirect("home.jsp");
        return;
    }

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
<body class="min-h-screen bg-gradient-to-br from-[#938899] via-[#a79eac] to-[#938899] text-gray-900 flex flex-col">

    <!-- Logout button -->
    <div class="flex justify-end p-4">
        <form action="logout" method="post">
            <button type="submit" class="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded shadow font-semibold transition">
                Logout
            </button>
        </form>
    </div>

    <main class="container mx-auto px-6 flex-grow space-y-10">

        <!-- Add Course Card -->
        <section class="bg-[#D64029] rounded-2xl shadow-2xl p-8 max-w-5xl mx-auto text-white">
            <h2 class="text-3xl font-bold mb-6 drop-shadow">Admin Dashboard</h2>
            <h3 class="text-xl font-semibold mb-4">Add a New Course</h3>

            <% if (errorMessage != null) { %>
                <div class="bg-red-700 text-white p-3 rounded mb-6 shadow-md">
                    <%= errorMessage %>
                </div>
            <% } %>

            <form action="AddCourseServlet" method="post" class="grid grid-cols-1 md:grid-cols-3 gap-4">
                <input type="text" name="courseCode" placeholder="Course Code" required
                    class="p-3 rounded-lg text-[#D64029] font-semibold focus:outline-none shadow" />
                <input type="text" name="courseName" placeholder="Course Name" required
                    class="p-3 rounded-lg text-[#D64029] font-semibold focus:outline-none shadow" />
                <select name="teacher" required
                    class="p-3 rounded-lg text-[#D64029] font-semibold focus:outline-none shadow">
                    <option value="">Select Teacher</option>
                    <% for(Document t : teachers.find(new Document("role","teacher"))) { %>
                        <option value="<%= t.getString("username") %>"><%= t.getString("username") %></option>
                    <% } %>
                </select>
                <div class="md:col-span-3 text-right">
                    <button type="submit"
                        class="bg-white text-[#D64029] font-semibold py-3 px-6 rounded-lg shadow hover:bg-[#ffe1dc] transition">
                        Add Course
                    </button>
                </div>
            </form>
        </section>

        <!-- All Courses Card -->
        <section class="bg-[#F7D9D9] rounded-2xl shadow-2xl p-8 max-w-5xl mx-auto text-gray-900">
            <h3 class="text-2xl font-bold mb-6 drop-shadow-md">All Courses and Assigned Teachers</h3>

            <%
                MongoCursor<Document> courseCursor = courses.find().iterator();
                if(!courseCursor.hasNext()) {
            %>
                <p class="text-gray-600 italic">No courses added yet.</p>
            <%
                } else {
            %>
                <table class="min-w-full border border-gray-300 rounded-lg overflow-hidden shadow-md">
                    <thead class="bg-[#D64029] text-white">
                        <tr>
                            <th class="px-4 py-3 text-left">Course Code</th>
                            <th class="px-4 py-3 text-left">Course Name</th>
                            <th class="px-4 py-3 text-left">Assigned Teacher</th>
                            <th class="px-4 py-3 text-left">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            while(courseCursor.hasNext()) {
                                Document c = courseCursor.next();
                                String code = c.getString("code");
                        %>
                        <tr class="even:bg-white odd:bg-[#ffe1dc]">
                            <td class="px-4 py-3 font-semibold"><%= code %></td>
                            <td class="px-4 py-3"><%= c.getString("name") %></td>
                            <td class="px-4 py-3"><%= c.getString("teacher") %></td>
                            <td class="px-4 py-3 space-x-2">

                                <form action="EditCourseServlet" method="get" class="inline-block">
                                    <input type="hidden" name="courseCode" value="<%= code %>" />
										<button type="submit"
										    class="bg-[#FF8E72] hover:bg-[#ff7a59] text-white px-3 py-1 rounded shadow font-semibold transition">
										    Edit
										</button>
								</form>

                                <form action="DeleteCourseServlet" method="post" class="inline-block" 
                                      onsubmit="return confirm('Are you sure you want to delete this course?');">
                                    <input type="hidden" name="courseCode" value="<%= code %>" />
                                    <button type="submit"
									    class="bg-[#D64029] hover:bg-[#B7311E] text-white px-3 py-1 rounded shadow font-semibold transition">
									    Delete
									</button>

                                </form>

                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            <%
                }
            %>
        </section>

    </main>
</body>
</html>
