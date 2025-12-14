<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>

    <!-- =========================================
         META CONFIGURATION
         ========================================= -->
    <meta charset="UTF-8">
    <title>Home | Course Management System</title>

    <!-- =========================================
         TAILWIND CSS (CDN)
         ========================================= -->
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- =========================================
         CUSTOM ANIMATION STYLES
         ========================================= -->
    <style>
        @keyframes enter {
            0% {
                opacity: 0;
                transform: translateY(40px) scale(0.95);
            }
            100% {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .animate-enter {
            animation: enter 0.9s ease-out forwards;
        }
    </style>

</head>

<body
    class="min-h-screen flex flex-col items-center justify-center
           bg-gradient-to-br from-slate-800 via-slate-900 to-black">

    <!-- =========================================
         MAIN CONTAINER
         ========================================= -->
    <div class="w-full max-w-5xl px-6 animate-enter">

        <!-- =========================================
             GLASSMORPHISM CARD
             ========================================= -->
        <div
            class="relative rounded-3xl p-16
                   bg-[#005461]/70
                   backdrop-blur-2xl
                   border border-white/30
                   shadow-[0_25px_60px_rgba(0,0,0,0.45)]
                   text-white">

            <!-- Decorative glass highlight -->
            <div
                class="absolute inset-0 rounded-3xl
                       bg-white/10 blur-2xl -z-10">
            </div>

            <!-- =====================================
                 PAGE TITLE
                 ===================================== -->
            <h1
                class="text-6xl font-extrabold text-center
                       mb-4 drop-shadow-xl">
                Welcome to Course Management System
            </h1>

            <!-- =====================================
                 PAGE DESCRIPTION
                 ===================================== -->
            <p
                class="text-center text-2xl opacity-90
                       max-w-4xl mx-auto mb-14">
                Manage your courses, users, enrollments, and academic
                resources efficiently in one centralized platform.
            </p>

            <!-- =====================================
                 NAVIGATION / PAGE LINKING SECTION
                 These links connect this JSP page
                 with other JSP pages or Servlets
                 ===================================== -->
            <div class="flex flex-col sm:flex-row gap-8 justify-center">

                <!-- =================================
                     LOGIN PAGE CONNECTION
                     Redirects the user to login.jsp
                     where authentication is handled
                     ================================= -->
                <a href="login.jsp"
                   class="px-16 py-5 text-xl font-semibold
                          rounded-xl bg-white text-[#005461]
                          shadow-xl hover:shadow-2xl
                          hover:bg-[#f7e5e3]
                          hover:scale-105
                          transition-all duration-300
                          text-center">
                    Login
                </a>

                <!-- =================================
                     SIGNUP PAGE CONNECTION
                     Redirects the user to signup.jsp
                     where new user registration is handled
                     ================================= -->
                <a href="signup.jsp"
                   class="px-16 py-5 text-xl font-semibold
                          rounded-xl bg-white text-[#005461]
                          shadow-xl hover:shadow-2xl
                          hover:bg-[#f7e5e3]
                          hover:scale-105
                          transition-all duration-300
                          text-center">
                    Sign Up
                </a>

            </div>
        </div>
    </div>

    <!-- =========================================
         FOOTER SECTION
         ========================================= -->
    <footer
        class="absolute bottom-6 text-white
               text-sm opacity-90 text-center">
        © 2025 Course Management System |
        All Rights Reserved |
        2022331023_057
    </footer>

</body>
</html>
