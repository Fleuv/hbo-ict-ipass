<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
    <c:when test="${empty param.filename}">
        <c:set var="mode" value="Add" />
    </c:when>
    <c:otherwise>
        <c:set var="mode" value="Edit" />
    </c:otherwise>
</c:choose>
<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="${mode} level" />
    <jsp:param name="minRole" value="1" />
</jsp:include>
<div class="row">
    <form class="col-sm-7 col-md-6 col-lg-5 col-centered" action="login.do" method="post">
        <div class="form-group">
            <c:if test="${!empty error}">
                <div class="panel panel-danger">
                    <div class="panel-heading">${error}</div>
                </div>
            </c:if>
            <p>
                <input type="text" name="title" class="form-control" placeholder="Title (required)" required>
            </p>
            <p>
                <input type="text" name="version" class="form-control" placeholder="Version (required)" required>
            </p>
            <p>
                <input type="text" name="previousVersion" class="form-control" placeholder="Previous version">
            </p>
            <p>
                <input type="text" name="games" class="form-control" placeholder="Game(s) (required)">
            </p>
            <p>
                <input type="text" name="gametypes" class="form-control" placeholder="Gametype(s) (required)">
            </p>
            <p>
            <div class="panel panel-default panel-body text-center">
                <label for="level">Upload a level (required)</label>
                <input type="file" id="level" name="level" style="width:100%">
            </div>
            </p>
            <p>
                <textarea name="description" class="form-control" placeholder="Enter a description.. (required)" rows="6" required></textarea>
            </p>
            <c:if test="${param.filename}">
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
                    <button type="submit" class="btn btn-success form-control">${mode} review</button>
                </div><div class="col-xs-6">
                    <c:choose>
                        <c:when test="${empty param.review}">
                            <button type="reset" class="btn btn-danger form-control">Reset</button>
                        </c:when>
                        <c:otherwise>
                            <a href="level.jsp?filename=${param.level}#review-${param.review}" class="btn btn-danger form-control">Cancel</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </form>
</div>
<%@include file="footer.jsp"%>