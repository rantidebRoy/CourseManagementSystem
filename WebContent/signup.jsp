<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sign Up</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="min-h-screen flex flex-col items-center justify-center bg-gradient-to-br from-[#938899] via-[#a79eac] to-[#938899]">

    <div class="w-full max-w-lg bg-[#D64029] text-white rounded-2xl shadow-2xl p-10">

        <h2 class="text-4xl font-bold text-center mb-2 drop-shadow-md">Sign Up</h2>
        <p class="text-center text-lg opacity-90 mb-8">Create your new account</p>

        <form action="SignupServlet" method="post" class="flex flex-col gap-5">

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

            <select name="role" required 
                    class="w-full p-3 rounded-lg bg-white text-[#D64029] font-semibold shadow-md focus:outline-none">
                <option value="">Select Role</option>
                <option value="student">Student</option>
                <option value="teacher">Teacher</option>
                <option value="admin">Admin</option>
            </select>

            <button type="submit"
                    class="py-3 rounded-lg font-semibold bg-white text-[#D64029] shadow-lg hover:bg-[#f7e5e3] hover:shadow-xl transition-all duration-300">
                Sign Up
            </button>
        </form>

        <p class="mt-6 text-center">
            Already have an account? 
            <a href="login.jsp" class="font-semibold underline">Login</a>
        </p>
    </div>

</body>
</html>
