<%@ page import="persistence.LevelDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%
    try {
        LevelDAO dao = new LevelDAO();
        request.setAttribute("levels", dao.readAll());
    } catch (SQLException sqle) {
        sqle.printStackTrace();
    }
%>
<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="Overview" />
</jsp:include>
<c:choose>
    <c:when test="${!empty levels}">
        <div class="row">
        <c:forEach items="${levels}" var="level">
            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3>${level.title}</h3>
                    </div>
                    <div class="panel-body">
                        <p><strong>${level.filename}</strong></p>
                        <p><em>Version: ${level.version}</em></p>
                        <c:if test="${!empty level.previousVersion}">
                            <p><em>Previous version: ${level.previousVersion}</em></p>
                        </c:if>
                    </div>
                    <div class="panel-footer">
                        <a class="btn btn-success" href="level.jsp?filename=${level.filename}">View</a>
                        <a class="btn btn-default" href="profile.jsp?name=${level.user.name}">Author</a>
                    </div>
                </div>
            </div>
        </c:forEach>
        </div>
    </c:when>
    <c:otherwise>No levels to display</c:otherwise>
</c:choose>

<%@include file="footer.jsp"%>