<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="min-h-screen flex flex-col items-center justify-between bg-gradient-to-br from-[#938899] via-[#a79eac] to-[#938899]">

    <!-- Main Card -->
    <div class="w-full max-w-lg bg-[#D64029] text-white rounded-2xl shadow-2xl p-10 mt-20">

        <h1 class="text-4xl font-bold text-center mb-2 drop-shadow-md">
            Welcome to Course Management System
        </h1>

        <!-- Subtitle -->
        <p class="text-center text-lg opacity-90 mb-8">
            Manage your courses, users, and resources efficiently.
        </p>

        <div class="flex flex-col gap-5 mt-6">

            <!-- Login Button -->
            <a href="login.jsp"
               class="block text-center py-3 rounded-lg font-semibold bg-white text-[#D64029] shadow-lg hover:bg-[#f7e5e3] hover:shadow-xl transition-all duration-300">
                Login
            </a>

            <!-- Signup Button -->
            <a href="signup.jsp"
               class="block text-center py-3 rounded-lg font-semibold bg-white text-[#D64029] shadow-lg hover:bg-[#f7e5e3] hover:shadow-xl transition-all duration-300">
                Sign Up
            </a>

        </div>

    </div>

    <!-- Footer -->
    <footer class="text-white text-sm mt-10 mb-6 opacity-90 text-center">
        2025 Course Management System | All Rights Reserved | 2022331023_057
    </footer>

</body>
</html>
