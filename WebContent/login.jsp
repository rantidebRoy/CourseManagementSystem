<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login | Course Management System</title>
<script src="https://cdn.tailwindcss.com"></script>

<style>
    @keyframes enter {
        0% { opacity: 0; transform: translateY(40px) scale(0.95); }
        100% { opacity: 1; transform: translateY(0) scale(1); }
    }
    .animate-enter {
        animation: enter 0.8s ease-out forwards;
    }
</style>
</head>

<body class="min-h-screen flex items-center justify-center
             bg-gradient-to-br from-[#938899] via-[#a79eac] to-[#938899]">

<div class="w-full max-w-3xl px-6 animate-enter">
    <div class="relative rounded-3xl p-14
                bg-[#005461]/70 backdrop-blur-2xl
                border border-white/30
                shadow-[0_25px_60px_rgba(0,0,0,0.45)]
                text-white">

        <h2 class="text-5xl font-extrabold text-center mb-3 drop-shadow-xl">
            Login
        </h2>

        <p class="text-center text-xl opacity-90 mb-12">
            Access your dashboard securely
        </p>

        <form action="LoginServlet" method="post"
              class="flex flex-col gap-8 max-w-xl mx-auto">

            <input type="text" name="username" required
                   placeholder="Username"
                   class="w-full px-5 py-4 rounded-xl
                          bg-white text-[#005461]
                          font-semibold text-lg
                          shadow-md focus:outline-none">

            <!-- Password with Eye Icon -->
            <div class="relative">
                <input type="password" name="password" id="loginPassword" required
                       placeholder="Password"
                       class="w-full px-5 py-4 rounded-xl
                              bg-white text-[#005461]
                              font-semibold text-lg
                              shadow-md focus:outline-none pr-14">

                <button type="button"
                        onclick="togglePassword('loginPassword', this)"
                        class="absolute right-4 top-1/2 -translate-y-1/2 text-[#005461]">
                    <!-- Eye Icon -->
                    <svg xmlns="http://www.w3.org/2000/svg"
                         class="w-6 h-6 eye-open"
                         fill="none" viewBox="0 0 24 24"
                         stroke="currentColor" stroke-width="2">
                        <path d="M1.5 12S5.5 4.5 12 4.5 22.5 12 22.5 12 18.5 19.5 12 19.5 1.5 12 1.5 12z"/>
                        <circle cx="12" cy="12" r="3"/>
                    </svg>

                    <!-- Eye Slash Icon -->
                    <svg xmlns="http://www.w3.org/2000/svg"
                         class="w-6 h-6 eye-closed hidden"
                         fill="none" viewBox="0 0 24 24"
                         stroke="currentColor" stroke-width="2">
                        <path d="M3 3l18 18"/>
                        <path d="M10.7 5.1C11.1 5 11.5 5 12 5c6.5 0 10.5 7 10.5 7a18.6 18.6 0 0 1-4.1 5.1"/>
                        <path d="M6.1 6.1C3.7 8.3 1.5 12 1.5 12S5.5 19 12 19c1.2 0 2.3-.2 3.3-.6"/>
                    </svg>
                </button>
            </div>

            <button type="submit"
                    class="mt-4 py-4 rounded-xl text-xl font-semibold
                           bg-white text-[#005461]
                           shadow-xl hover:shadow-2xl
                           hover:bg-[#f7e5e3]
                           hover:scale-105
                           transition-all duration-300">
                Login
            </button>
        </form>

        <p class="mt-10 text-center text-lg">
            Don’t have an account?
            <a href="signup.jsp" class="font-semibold underline">Sign Up</a>
        </p>

    </div>
</div>

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
