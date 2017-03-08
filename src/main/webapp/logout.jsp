<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="Logout" />
    <jsp:param name="minRole" value="1" />
</jsp:include>
<form action="logout.do" method="post" class="text-center">
    <p>Are you sure you want to logout?</p>
    <p>
        <button type="submit" class="btn btn-success">Yes</button>
        <a href="profile.jsp" class="btn btn-default">No</a>
    </p>
</form>
<%@ include file="footer.jsp" %>