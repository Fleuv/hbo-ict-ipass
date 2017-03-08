<%@ page import="persistence.UserDAO" %><%@ page import="model.User" %><%@ page import="java.sql.SQLException" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%
    try {
        UserDAO dao = new UserDAO();
        User cookieUser = dao.cookieLogin(request.getCookies());

        // The user is logged in and viewing page what requires authentication.
        String requestedName = request.getParameter("name") == null ? "" : request.getParameter("name");
        if (!"".equals(requestedName)) {
            // An user was specified.
            User requestedUser = dao.read(requestedName);
            if (requestedUser != null) {
                if (requestedUser.getName().equals(cookieUser.getName()) || cookieUser.getRole() > 1) {
                    // The user is permitted to edit the requested profile.
                    request.setAttribute("user", requestedUser);
                } else {
                    // The user is NOT permitted to edit the requested profile.
                    response.sendRedirect("profile.jsp");
                }
            } else {
                // The requested user does NOT exists.
                response.sendRedirect("profileForm.jsp");
            }
        } else {
            // No user was specified, so use the one currently logged in.
            request.setAttribute("user", cookieUser);
        }
    } catch (SQLException sqle) {
        sqle.printStackTrace();
    }
%>
<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="Edit profile of ${user.name}" />
    <jsp:param name="minRole" value="1" />
</jsp:include>
<div class="row">
    <form class="col-sm-7 col-md-6 col-lg-5 col-centered" action="profile.do" method="post">
        <input type="hidden" name="where" value="${user.name}">
        <div class="form-group">
            <c:if test="${!empty error}">
                <div class="panel panel-danger">
                    <div class="panel-heading">${error}</div>
                </div>
            </c:if>
            <p>
                <input type="text" name="name" class="form-control" placeholder="Username (required)" value="${user.name}" required>
            </p>
            <p>
                <input type="password" name="pass" class="form-control" placeholder="New password (required)" required>
            </p>
            <p>
                <input type="password" name="passRepeat" class="form-control" placeholder="Repeat new password (required)" required>
            </p>
            <p>
                <input type="url" name="avatar" class="form-control" placeholder="Avatar URL" value="${user.avatar}">
            </p>
            <p>
                <textarea name="about" class="form-control" placeholder="About you..">${user.about}</textarea>
            </p>
            <div class="alert alert-warning media">
                <div class="media-left">
                    <input type="checkbox" name="delete" id="delete">
                </div>
                <label for="delete" class="media-body">
                    Check the marker to delete the user: <em>${user.name}</em>.<br><strong>This action can't be undone.</strong>
                </label>
            </div>
            <div class="row">
                <div class="col-xs-6">
                    <button type="submit" class="btn btn-success form-control">Save</button>
                </div><div class="col-xs-6">
                    <a href="profile.jsp" class="btn btn-danger form-control">Cancel</a>
                </div>
            </div>
        </div>
    </form>
</div>
<%@include file="footer.jsp"%>