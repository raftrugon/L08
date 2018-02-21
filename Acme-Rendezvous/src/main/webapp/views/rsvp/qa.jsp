<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl"	uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="lib" tagdir="/WEB-INF/tags/myTagLib" %>


<jstl:forEach items="${qa}" var="entity">
	<div class="well well-sm" style="margin-bottom:5px"><strong><jstl:out value="${entity.key}"/></strong></div>
	<p style="padding-left:3em"><jstl:out value="${entity.value}"/></p>
</jstl:forEach>

<jstl:if test="${pageContext.request.userPrincipal.name eq rsvp.user.userAccount.username}" >
	<jstl:forEach items="${pendingQuestions}" var="item">
		<div class="well well-sm" style="margin-bottom:5px"><strong><jstl:out value="${item}"/></strong></div>
		
		<form action="user/rendezvous/answer.do" method="post">
			<input type="hidden" name="question" value="${item}">
			<input type="hidden" name="rsvpId" value="${rsvp.id}">
		
		<spring:message code="rendezvous.answer" var="answerVar" />
		<p style="padding-left:3em">
			<input type="text" name="answer">
			<input type="submit" name="submit"
					value="<jstl:out value="${answerVar}"/>"	
			onclick="javascript: relativeRedir('/user/rendezvous/answer.do');" />
		</p>
		</form>
		
	</jstl:forEach>
</jstl:if>