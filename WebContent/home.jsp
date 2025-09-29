<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Course Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #4e73df, #1cc88a);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .card { border-radius: 20px; overflow: hidden; }
        .btn-custom { background-color: #ff6600; border-color: #ff6600; color: #fff;
}

    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-7">
            <div class="card shadow-lg text-center">
                <div class="card-header bg-primary text-white">
                    <h2>Welcome to the Online Course Management System</h2>
                </div>
                <div class="card-body p-5">
                    <p class="lead mb-4">Manage Courses, Assignments, and Users with Ease.</p>
                    <div class="d-flex justify-content-center gap-3">
                        <a href="signup.jsp" class="btn btn-success btn-lg btn-custom">Sign Up</a>
                        <a href="login.jsp" class="btn btn-outline-primary btn-lg btn-custom">Log In</a>
                    </div>
                </div>
                <div class="card-footer text-muted">
                    <small>&copy; 2025 Course Management System | All Rights Reserved | 2022331023_057 </small>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
