<%@ page import="java.sql.SQLException" %><%@ page import="persistence.LevelDAO" %><%@ page import="persistence.UserDAO" %><%@ page import="model.User" %><%@ page import="model.Level" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%
    String filename = request.getParameter("filename");
    if (filename != null && !"".equals(filename)) {
        LevelDAO dao = new LevelDAO();
        try {
            Level level = dao.read(filename);
            User user = new UserDAO().cookieLogin(request.getCookies());
            if (level != null && user != null) {
                if (user.getRole() > 1 || user.getName().equals(level.getUser().getName())) {
                    request.setAttribute("useForm", "1");
                } else {
                    request.setAttribute("useForm", "0");
                }
            }
            request.setAttribute("level", level);
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
    } else {
        response.sendRedirect("index.jsp");
    }
%>
<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="Level: ${level.filename}" />
</jsp:include>
<div class="container-fluid">
    <div class="row">
        <div class="col-sm-9">
            <h3>${level.title}</h3>
            <p>${level.description}</p>
        </div>
        <hr class="row visible-xs" />
        <div class="col-sm-3">
            <div class="panel panel-default">
                <div class="panel-body">
                    <p><strong>Author:</strong> <a href="profile.jsp?name=${level.user.name}">${level.user.name}</a></p>
                    <p><strong>Version:</strong> ${level.version}</p>
                    <c:if test="${!empty level.previousVersion}">
                        <p><strong>Previous version:</strong> ${level.previousVersion}</p>
                    </c:if>
                    <p><strong>Game(s):</strong><ul class="list-inline"><c:forEach items="${level.games}" var="game">
                        <li>${game}</li>
                    </c:forEach></ul></p>
                    <p><strong>Gametype(s):</strong><ul class="list-inline"><c:forEach items="${level.gametypes}" var="gametype">
                        <li>${gametype}</li>
                    </c:forEach></ul></p>
                </div>
                <c:if test="${!empty useForm}">
                    <div class="panel-footer text-center">
                        <a href="levelForm.jsp?filename=${level.filename}" class="btn btn-default">Edit level</a>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>