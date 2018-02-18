<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl"	uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="lib" tagdir="/WEB-INF/tags/myTagLib" %>


<jstl:forEach items="${questions}" var="entity">
	<div class="well well-sm" style="margin-bottom:5px"><strong><jstl:out value="${entity.key}"/></strong></div>
	<p style="padding-left:3em"><input type="text" class="form-control"/></p>
</jstl:forEach>
<div class="form-group">
	<input type="button" class="btn btn-success" value="aldsfj">
</div>