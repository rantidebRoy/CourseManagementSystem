<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sign Up</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #1cc88a, #4e73df);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .card { border-radius: 20px; overflow: hidden; width: 400px; }
        .btn-custom { border-radius: 30px; font-weight: 500; padding: 10px 25px; }
    </style>
</head>
<body>
<div class="card shadow-lg">
    <div class="card-header bg-primary text-white text-center">
        <h3>Sign Up</h3>
    </div>
    <div class="card-body p-4">
        <form action="SignupServlet" method="post">
            <div class="mb-3">
                <input type="text" name="username" placeholder="Username" class="form-control" required>
            </div>
            <div class="mb-3">
                <input type="password" name="password" placeholder="Password" class="form-control" required>
            </div>
            <div class="mb-3">
                <select name="role" class="form-select" required>
                    <option value="">Select Role</option>
                    <option value="student">Student</option>
                    <option value="teacher">Teacher</option>
                    <option value="admin">Admin</option>
                </select>
            </div>
            <button type="submit" class="btn btn-success btn-custom w-100">Sign Up</button>
        </form>
        <p class="mt-3 text-center">
            Already have an account? <a href="login.jsp">Login</a>
        </p>
    </div>
</div>
</body>
</html>
