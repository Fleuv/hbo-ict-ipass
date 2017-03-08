<%@ page import="persistence.LevelDAO" %><%@ page import="model.Level" %><%@ page import="java.sql.SQLException" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
    <c:when test="${empty param.filename}">
        <c:set var="mode" value="Add" />
    </c:when>
    <c:otherwise>
        <c:set var="mode" value="Edit" />
        <%
            try {
                LevelDAO dao = new LevelDAO();
                Level level = dao.read(request.getParameter("filename"));
                request.setAttribute("level", level);
            } catch (SQLException sqle) {
                sqle.printStackTrace();
            }
        %>
    </c:otherwise>
</c:choose>
<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="${mode} level" />
    <jsp:param name="minRole" value="1" />
</jsp:include>
<div class="row">
    <form class="col-sm-7 col-md-6 col-lg-5 col-centered" action="level.do" method="post" enctype="multipart/form-data">
        <input type="hidden" name="mode" value="${mode}">
        <div class="form-group">
            <c:if test="${!empty error}">
                <div class="panel panel-danger">
                    <div class="panel-heading">${error}</div>
                </div>
            </c:if>
            <p>
                <input type="text" name="title" class="form-control" placeholder="Title (required)" value="${level.title}" required>
            </p>
            <p>
                <input type="text" name="version" class="form-control" placeholder="Version (required)" value="${level.version}" required>
            </p>
            <p>
                <input type="text" name="previousVersion" class="form-control" placeholder="Previous version" value="${level.previousVersion}">
            </p>
            <p>
                <input type="text" name="games" class="form-control" placeholder="Game(s) (required)" value="<c:forEach items="${level.games}" var="game" varStatus="loop">${game}<c:if test="${!loop.last}">,</c:if></c:forEach>">
            </p>
            <p>
                <input type="text" name="gametypes" class="form-control" placeholder="Gametype(s) (required)" value="<c:forEach items="${level.gametypes}" var="gametype" varStatus="loop">${gametype}<c:if test="${!loop.last}">,</c:if></c:forEach>">
            </p>
            <div class="panel panel-default panel-body text-center">
                <label for="file">Upload a level (required)</label>
                <input type="file" id="file" name="file" style="width:100%" required>
            </div>
            <p>
                <textarea name="description" class="form-control" placeholder="Enter a description.. (required)" rows="6" required>${level.description}</textarea>
            </p>
            <c:if test="${!empty param.filename}">
                <div class="alert alert-warning media">
                    <div class="media-left">
                        <input type="checkbox" name="delete" id="delete">
                    </div>
                    <label for="delete" class="media-body">
                        Check the marker to delete the level: <em>${level.title} (${level.filename})</em>.<br><strong>This action can't be undone.</strong>
                    </label>
                </div>
            </c:if>
            <div class="row">
                <div class="col-xs-6">
                    <button type="submit" class="btn btn-success form-control">${mode} level</button>
                </div><div class="col-xs-6">
                <c:choose>
                    <c:when test="${empty param.level}">
                        <button type="reset" class="btn btn-danger form-control">Reset</button>
                    </c:when>
                    <c:otherwise>
                        <a href="level.jsp?filename=${param.level}" class="btn btn-danger form-control">Cancel</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </form>
</div>
<%@include file="footer.jsp"%>