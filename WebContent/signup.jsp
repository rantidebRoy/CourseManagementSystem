<%@ page session="true" %> <%-- Enables HTTP session to allow Servlets to store user signup data --%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign Up | Course Management System</title>

    <script src="https://cdn.tailwindcss.com"></script>

    
    <style>
        @keyframes enter {
            0% { opacity: 0; transform: translateY(40px) scale(0.95); }
            100% { opacity: 1; transform: translateY(0) scale(1); }
        }
        .animate-enter { animation: enter 0.8s ease-out forwards; }
    </style>
</head>

<body class="min-h-screen flex items-center justify-center
             bg-gradient-to-br from-slate-800 via-slate-900 to-black">

<div class="w-full max-w-3xl px-6 animate-enter">
    <div class="relative rounded-3xl p-14
                bg-[#005461]/70 backdrop-blur-2xl
                border border-white/30
                shadow-[0_25px_60px_rgba(0,0,0,0.45)]
                text-white">

        <h2 class="text-5xl font-extrabold text-center mb-3 drop-shadow-xl">
            Sign Up
        </h2>

        <p class="text-center text-xl opacity-90 mb-12">
            Create your new account
        </p>

        <!-- Form sends user data to SignupServlet for processing -->
        <form action="SignupServlet" method="post"
              class="flex flex-col gap-8 max-w-xl mx-auto"> <!-- JSP → Servlet connection -->

            <!-- Username input -->
            <input type="text"
                   name="username" required
                   placeholder="Username"
                   class="w-full px-5 py-4 rounded-xl
                          bg-white text-[#005461]
                          font-semibold text-lg"> <!-- username param sent to Servlet -->

            <!-- Password input with show/hide toggle -->
            <div class="relative">
                <input type="password"
                       name="password" id="signupPassword" required
                       placeholder="Password"
                       class="w-full px-5 py-4 rounded-xl
                              bg-white text-[#005461]
                              font-semibold text-lg pr-14"> <!-- password param sent to Servlet -->

                <!-- Toggle button for show/hide password -->
                <button type="button"
                        onclick="togglePassword('signupPassword', this)"
                        class="absolute right-4 top-1/2 -translate-y-1/2 text-[#005461]">
                    <!-- Eye icon (visible when password is hidden) -->
                    <svg xmlns="http://www.w3.org/2000/svg"
                         class="w-6 h-6 eye-open"
                         fill="none" viewBox="0 0 24 24"
                         stroke="currentColor" stroke-width="2">
                        <path d="M1.5 12S5.5 4.5 12 4.5 22.5 12 22.5 12 18.5 19.5 12 19.5 1.5 12 1.5 12z"/>
                        <circle cx="12" cy="12" r="3"/>
                    </svg>

                    <!-- Eye slash icon (visible when password is shown) -->
                    <svg xmlns="http://www.w3.org/2000/svg"
                         class="w-6 h-6 eye-closed hidden"
                         fill="none" viewBox="0 0 24 24"
                         stroke="currentColor" stroke-width="2">
                        <path d="M3 3l18 18"/>
                        <path d="M10.7 5.1C11.1 5 11.5 5 12 5c6.5 0 10.5 7 10.5 7"/>
                        <path d="M6.1 6.1C3.7 8.3 1.5 12 1.5 12S5.5 19 12 19"/>
                    </svg>
                </button>
            </div>

            <!-- Role selection dropdown -->
            <select name="role" required
                    class="w-full px-5 py-4 rounded-xl
                           bg-white text-[#005461]
                           font-semibold text-lg">
                <option value="">Select Role</option>
                <option value="student">Student</option>
                <option value="teacher">Teacher</option>
                <option value="admin">Admin</option>
            </select> <!-- role param sent to Servlet -->

            <!-- Submit button triggers POST to SignupServlet -->
            <button type="submit"
                    class="mt-4 py-4 rounded-xl text-xl font-semibold
                           bg-white text-[#005461]
                           hover:scale-105 transition-all">
                Sign Up
            </button>
        </form>

        <p class="mt-10 text-center text-lg">
            Already have an account?

            <!-- Link to login.jsp for existing users -->
            <a href="login.jsp" class="font-semibold underline"> <!-- JSP → JSP navigation -->
                Login
            </a>
        </p>

    </div>
</div>

<!-- JavaScript for show/hide password functionality -->
<script>
function togglePassword(id, btn) {
    const input = document.getElementById(id);
    const openEye = btn.querySelector('.eye-open');
    const closedEye = btn.querySelector('.eye-closed');

    if (input.type === "password") {
        input.type = "text";
        openEye.classList.add("hidden");
        closedEye.classList.remove("hidden");
    } else {
        input.type = "password";
        openEye.classList.remove("hidden");
        closedEye.classList.add("hidden");
    }
}
</script>

</body>
</html>
