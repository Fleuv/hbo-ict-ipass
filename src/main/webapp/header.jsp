<%@ page import="persistence.UserDAO" %><%@ page import="model.User" %><%@ page import="java.sql.SQLException" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%
    try {
        UserDAO dao = new UserDAO();
        User cookieUser = dao.cookieLogin(request.getCookies());
        request.setAttribute("role", cookieUser == null ? "0" : Integer.toString(cookieUser.getRole()));
        String minimumRole = (String) request.getAttribute("minRole");
        if (minimumRole != null && !"".equals(minimumRole)) {
            // What is the minimum role to view this page?
            int minRole = 1;
            try {
                minRole = Integer.parseInt(minimumRole);
            } catch (NumberFormatException nfe) {
                nfe.printStackTrace();
            }
            if (minRole >= 1 && cookieUser == null) {
                // The user is NOT authenticated in but is viewing a page what requires authentication.
                response.sendRedirect("login.jsp");
            }
        }
        String maximumRole = (String) request.getAttribute("maxRole");
        if (maximumRole != null && !"".equals(maximumRole)) {
            // What is the maximum role to view this page?
            int maxRole = 0;
            try {
                maxRole = Integer.parseInt(maximumRole);
            } catch (NumberFormatException nfe) {
                nfe.printStackTrace();
            }
            if (maxRole < 1 && cookieUser != null) {
                // The user is authenticated but is viewing a page what requires the user to NOT be authenticated.
                response.sendRedirect("profile.jsp");
            }
        }
    } catch (SQLException sqle) {
        sqle.printStackTrace();
    }
%>
<!doctype html>
<html>
<head>
    <title>${param.pageTitle} - Third Party Developer</title>
    <meta charset="utf-8">
    <link href="/css/styles.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div class="container">
    <nav class="navbar navbar-default">
        <div class="container-fluid">
            <div class="navbar-header">
                <a href="/" class="navbar-brand visible-lg">Third Party Developer</a>
                <a href="/" class="navbar-brand hidden-lg">TPD</a>
            </div>
            <ul class="nav navbar-nav nav-pills">
                <li><a href="/">Home</a></li>
                <c:if test="${role == 0}">
                    <li><a href="login.jsp">Login</a></li>
                    <li><a href="register.jsp">Register</a></li>
                </c:if>
                <c:if test="${role >= 1}">
                    <li><a href="profile.jsp">Profile</a></li>
                    <li><a href="logout.jsp">Logout</a></li>
                </c:if>
            </ul>
        </div>
    </nav>
    <div class="panel panel-default">
        <div class="panel-body">
            <div class="page-header">
                <h1>${param.pageTitle}</h1>
            </div>