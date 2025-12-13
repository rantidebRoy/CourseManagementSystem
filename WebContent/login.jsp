<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="min-h-screen flex flex-col items-center justify-center bg-gradient-to-br from-[#938899] via-[#a79eac] to-[#938899]">

    <div class="w-full max-w-lg bg-[#D64029] text-white rounded-2xl shadow-2xl p-10">

        <h2 class="text-4xl font-bold text-center mb-2 drop-shadow-md">Login</h2>
        <p class="text-center text-lg opacity-90 mb-8">Access your dashboard securely</p>

        <form action="LoginServlet" method="post" class="flex flex-col gap-5">

            <input type="text" 
                   name="username" 
                   placeholder="Username"
                   required
                   class="w-full p-3 rounded-lg bg-white text-[#D64029] font-semibold shadow-md focus:outline-none">

            <input type="password" 
                   name="password" 
                   placeholder="Password"
                   required
                   class="w-full p-3 rounded-lg bg-white text-[#D64029] font-semibold shadow-md focus:outline-none">

            <button type="submit"
                    class="py-3 rounded-lg font-semibold bg-white text-[#D64029] shadow-lg hover:bg-[#f7e5e3] hover:shadow-xl transition-all duration-300">
                Login
            </button>
        </form>

        <p class="mt-6 text-center">
            Don't have an account? 
            <a href="signup.jsp" class="font-semibold underline">Sign Up</a>
        </p>
    </div>

</body>
</html>
