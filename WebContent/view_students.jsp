<%@ page import="java.util.List" %>

<%@ page session="true"%> <%-- Enables session-based teacher validation --%>

<%
    // ===== Authorization check (Teacher only) =====
    String role = (String) session.getAttribute("role");
    if(role == null || !"teacher".equals(role)) {
        response.sendRedirect("home.jsp"); // Block unauthorized access
        return;
    }

    // ===== Data forwarded from viewStudents Servlet =====
    // Servlet handles DB logic and forwards clean data to JSP
    String courseCode = (String) request.getAttribute("courseCode");
    String courseName = (String) request.getAttribute("courseName");
    List<String> students = (List<String>) request.getAttribute("students");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registered Students</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="min-h-screen bg-gradient-to-br
             from-slate-800 via-slate-900 to-black">

<!-- Logout → LogoutServlet -->
<div class="flex justify-end p-6">
    <form action="logout" method="post">
        <button class="bg-red-600 text-white px-6 py-2 rounded-lg shadow font-semibold">
            Logout
        </button>
    </form>
</div>

<main class="max-w-6xl mx-auto px-6 pb-10">

<div class="bg-[#005461]/80 backdrop-blur-xl text-white
            rounded-3xl shadow-2xl p-12">

    <!-- Page header -->
    <div class="flex justify-between items-center mb-10">
        <h1 class="text-4xl font-bold leading-tight">
            Registered Students for Course:
            <span class="block text-2xl font-semibold opacity-90 mt-2">
                <%= courseName %> (<%= courseCode %>)
            </span>
        </h1>

        <!-- Navigation back to teacher dashboard -->
        <a href="teacher.jsp"
           class="bg-white text-[#005461]
                  px-6 py-3 rounded-lg font-semibold shadow
                  hover:shadow-xl transition">
            Back
        </a>
    </div>

    <!-- ===== Students List ===== -->
    <% if(students != null && !students.isEmpty()) { %>

        <!-- Display registered students -->
        <div class="bg-white/90 rounded-2xl p-8 shadow-xl text-[#005461]">
            <ul class="divide-y">
                <% for(String s : students) { %>
                    <li class="py-4 px-2 font-semibold text-lg">
                        <%= s %>
                    </li>
                <% } %>
            </ul>
        </div>

    <% } else { %>

        <!-- Empty state -->
        <div class="bg-white/90 rounded-2xl p-8 shadow-xl
                    text-[#005461] italic text-lg">
            No students registered for this course yet.
        </div>

    <% } %>

</div>
</main>
</body>
</html>
