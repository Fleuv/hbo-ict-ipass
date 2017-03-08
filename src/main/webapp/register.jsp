<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="Register" />
    <jsp:param name="maximumRole" value="0" />
</jsp:include>
<form class="col-sm-7 col-md-6 col-lg-5 col-centered" action="register.do" method="post">
    <c:if test="${!empty error}">
        <div class="panel panel-danger">
            <div class="panel-heading">${error}</div>
        </div>
    </c:if>
    <div class="form-group">
        <p>
            <input type="text" name="name" class="form-control" placeholder="Username (required)" required>
        </p>
        <p>
            <input type="password" name="pass" class="form-control" placeholder="Password (required)" required>
        </p>
        <p>
            <input type="password" name="passRepeat" class="form-control" placeholder="Repeat password (required)" required>
        </p>
        <p>
            <input type="url" name="avatar" class="form-control" placeholder="Avatar URL">
        </p>
        <p>
            <textarea name="about" class="form-control" placeholder="About you.."></textarea>
        </p>
        <p class="row">
            <div class="col-xs-6">
                <button type="submit" class="btn btn-success form-control">Register</button>
            </div><div class="col-xs-6">
                <button type="reset" class="btn btn-danger form-control">Reset</button>
            </div>
        </p>
    </div>
</form>
<%@include file="footer.jsp"%>