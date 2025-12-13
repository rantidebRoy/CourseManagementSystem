<%@ page import="java.util.List" %>
<%
    String courseCode = (String) request.getAttribute("courseCode");
    List<String> students = (List<String>) request.getAttribute("students");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Students of <%= courseCode %></title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="min-h-screen bg-gradient-to-br from-[#938899] via-[#a79eac] to-[#938899] flex items-center justify-center p-6">

    <div class="bg-green-600 rounded-2xl shadow-2xl max-w-3xl w-full text-white">
        <div class="p-6 border-b border-green-700">
            <h2 class="text-3xl font-bold drop-shadow-sm">
                Registered Students for Course: <span class="italic"><%= courseCode %></span>
            </h2>
        </div>
        <div class="p-6">
            <%
                if (students != null && !students.isEmpty()) {
            %>
                <ul class="divide-y divide-green-700">
                    <% for (String s : students) { %>
                        <li class="py-3 px-4 hover:bg-green-700 rounded cursor-default transition">
                            <%= s %>
                        </li>
                    <% } %>
                </ul>
            <%
                } else {
            %>
                <p class="text-green-200 italic">No students registered for this course yet.</p>
            <%
                }
            %>
            <a href="teacher.jsp" 
               class="inline-block mt-6 bg-gray-300 text-gray-900 font-semibold py-2 px-6 rounded shadow hover:bg-gray-400 transition">
               Back
            </a>
        </div>
    </div>

</body>
</html>
