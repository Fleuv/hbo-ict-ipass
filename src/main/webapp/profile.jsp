<%@ page import="model.User" %><%@ page import="persistence.UserDAO" %><%@ page import="java.sql.SQLException" %>
<%@ page import="persistence.LevelDAO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%
    try {
        UserDAO dao = new UserDAO();
        LevelDAO levelDAO = new LevelDAO();
        User cookieUser = dao.cookieLogin(request.getCookies());

        // Load the levels in a request attribute

        // The user is logged in and viewing page what requires authentication.
        String requestedName = request.getParameter("name") == null ? "" : request.getParameter("name");
        if (cookieUser != null) {
            if (!"".equals(requestedName)) {
                // An user was specified.
                User requestedUser = dao.read(requestedName);
                if (requestedUser != null) {
                    request.setAttribute("user", requestedUser);
                    request.setAttribute("levels", levelDAO.readWhereUser(requestedUser.getName()));
                    if (requestedUser.getName().equals(cookieUser.getName()) || cookieUser.getRole() > 1) {
                        // The user is permitted to edit the requested profile.
                        request.setAttribute("useForm", "1");
                    } else {
                        // The user is NOT permitted to edit the requested profile.
                        request.setAttribute("useForm", "0");
                    }
                } else {
                    // The requested user does NOT exists.
                    response.sendRedirect("profile.jsp");
                }
            } else {
                // No user was specified, so use the one currently logged in.
                request.setAttribute("user", cookieUser);
                request.setAttribute("useForm", "1");
                request.setAttribute("levels", levelDAO.readWhereUser(cookieUser.getName()));
            }
        }
    } catch (SQLException sqle) {
        sqle.printStackTrace();
    }
%>
<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="Profile of ${user.name}" />
    <jsp:param name="minRole" value="1" />
</jsp:include>
<div class="container-fluid">
    <div class="row">
        <div class="col-sm-9">
            <ul class="nav nav-tabs">
                <li class="active"><a data-toggle="tab" href="#about">About</a></li>
                <li><a data-toggle="tab" href="#levels">Levels</a></li>
                <li><a data-toggle="tab" href="#reviews">Reviews</a></li>
            </ul>
            <div class="tab-content panel-body">
                <div role="tabpanel" id="about" class="tab-pane fade in active">${user.about}</div>
                <div role="tabpanel" id="levels" class="tab-pane fade">
                    <p>
                        <c:choose>
                            <c:when test="${!empty levels}">
                                <table class="table table-striped table-responsive">
                                    <thead>
                                        <tr>
                                            <th>Filename</th>
                                            <th>Title</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${levels}" var="level">
                                            <tr>
                                                <td>${level.filename}</td>
                                                <td>${level.title}</td>
                                                <td>
                                                    <a href="level.jsp?filename=${level.filename}" class="btn btn-default">View</a>
                                                    <c:if test="${!empty useForm}">
                                                        <a href="levelForm.jsp?filename=${level.filename}" class="btn btn-default">Edit</a>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>
                            <c:otherwise>The user didn't create a level yet.</c:otherwise>
                        </c:choose>
                    </p>
                    <p><a href="levelForm.jsp" class="btn btn-default">Add level</a></p>
                </div>
                <div role="tabpanel" id="reviews" class="tab-pane fade">
                    <p>
                        <c:choose>
                            <c:when test="${!empty reviews}">
                                <table class="table table-striped table-responsive">
                                    <thead>
                                        <tr>
                                            <th>Level</th>
                                            <th>Rating</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${reviews}" var="review">
                                            <tr>
                                                <td>${review.level}</td>
                                                <td>Graphics: ${review.technicalRating}, Technical:${review.technicalRating}</td>
                                                <td>
                                                    <a href="level.jsp?filename=${review.level}#review-${review.id}" class="btn btn-default">View</a>
                                                    <c:if test="${!empty useForm}">
                                                        <a href="reviewForm.jsp?level=${review.level}&id=${review.id}" class="btn btn-default">Edit</a>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>
                            <c:otherwise>The user didn't create a level yet.</c:otherwise>
                        </c:choose>
                    </p>
                </div>
            </div>
        </div>
        <hr class="row visible-xs" />
        <div class="col-sm-3">
            <div class="panel panel-default">
                <c:if test="${!empty user.avatar}">
                    <div class="panel-heading">
                        <img src="${user.avatar}" class="img-responsive img-rounded center-block" alt="${user.name}" title="Avatar of ${user.name}" />
                    </div>
                </c:if>
                <div class="panel-body">
                    <h4>${user.name}</h4>
                    <small>Rank #${user.role}</small>
                </div>
                <c:if test="${!empty useForm}">
                    <div class="panel-footer text-center">
                        <a href="profileForm.jsp" class="btn btn-default">Edit profile</a>
                    </div>
                </c:if>
            </div>
        </div>

    </div>
</div>
<%@ include file="footer.jsp" %>