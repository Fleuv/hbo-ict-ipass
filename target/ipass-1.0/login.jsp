<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="Login" />
    <jsp:param name="maxRole" value="0" />
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
                <input type="text" name="name" class="form-control" placeholder="Username" required>
            </p>
            <p>
                <input type="password" name="pass" class="form-control" placeholder="Password" required>
            </p>
            <p class="row">
                <div class="col-xs-6">
                    <button type="submit" class="btn btn-success form-control">Login</button>
                </div><div class="col-xs-6">
                    <button type="reset" class="btn btn-danger form-control">Reset</button>
                </div>
            </p>
        </div>
    </form>
</div>
<%@include file="footer.jsp"%>