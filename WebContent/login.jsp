<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #4e73df, #1cc88a);
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
        <h3>Login</h3>
    </div>
    <div class="card-body p-4">
        <form action="LoginServlet" method="post">
            <div class="mb-3">
                <input type="text" name="username" placeholder="Username" class="form-control" required>
            </div>
            <div class="mb-3">
                <input type="password" name="password" placeholder="Password" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-success btn-custom w-100">Login</button>
        </form>
        <p class="mt-3 text-center">
            Don't have an account? <a href="signup.jsp">Sign Up</a>
        </p>
    </div>
</div>
</body>
</html>
