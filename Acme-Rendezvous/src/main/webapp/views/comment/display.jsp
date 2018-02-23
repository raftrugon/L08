<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl"	uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="lib" tagdir="/WEB-INF/tags/myTagLib" %>

<jsp:useBean id="now" class="java.util.Date" />
	<jstl:if test="${rendezvous.organisationMoment lt now }">
		<div class="alert alert-warning" style="text-align:center"><strong><spring:message code="rendezvous.past"/></strong></div>
	</jstl:if>
	<jstl:if test="${rsvpd eq true}">
	<div id="newCommentDiv">
	<form:form modelAttribute="newComment">		
	<jstl:set var="model" value="comment" scope="request"/>
	<lib:input type="hidden" name="id,version,creationMoment,replies,replyingTo,user,rendezvous,inappropriate"/>
	<lib:input type="textarea" name="text" rows="4"/>
	<lib:input type="url" name="picture" addon="<i class='fas fa-paperclip'></i> <spring:message code='comment.picture.addon'/>" placeholder="http://www.url.com"/>
	<lib:button id="0" noDelete="true" />
	</form:form>
	</div>
	</jstl:if>
	<security:authorize access="hasRole('USER')">
		<jstl:if test="${not rsvpd and rendezvous.organisationMoment gt now }">
			<input type="button" id="RSVPbtn" class="btn btn-block btn-primary" value='<spring:message code="rendezvous.rsvp" />' />
		</jstl:if>	
	</security:authorize>
	<jstl:forEach items="${comments}" var="comment">
	<jstl:set var="rand"><%= java.lang.Math.round(java.lang.Math.random() * 9) + 1 %></jstl:set>
	<div class="media panel panel-default">
		<div class="panel-heading"> 
			<div class="media-left">
			  <img src="images/kC${rand}.png" class="media-object" style="width:45px">
			</div>
			<div class="media-body">
				<h4 class="media-heading">${comment.user.name} ${comment.user.surnames}<small><i>
				<fmt:formatDate type = "both" dateStyle = "long" timeStyle = "long" value = "${comment.creationMoment}" /></i>
				<jstl:if test="${comment.inappropriate eq false}">
					<security:authorize access="hasRole('ADMIN')">
						<a href="javascript:deleteComment();" style="color:red;padding:1em;" id="${comment.id}" class="deleteCommentLink">
							<i class="fas fa-times"></i> 
							<spring:message code="rendezvous.adminDelete"/>
						</a>
					</security:authorize>
				</jstl:if>
				</small></h4>
				<p>${comment.text}</p>
			</div>
			<div class="media-right" style="text-align:right">
				<img src="${comment.picture}" style="max-height:150px">
			</div>
		</div> 
		<jstl:if test="${not empty comment.replies}">
			<div class="panel commentpanel" style="text-align:center" data-toggle="collapse" data-parent="#accordion" href="#collapse${comment.id}">
				<span style="white-space:nowrap;"><spring:message code="rendezvous.viewReplies"/> <i class="fas fa-chevron-down"></i></span>
				<span style="white-space:nowrap;display:none"><spring:message code="rendezvous.hideReplies"/> <i class="fas fa-chevron-up"></i></span>
			</div>
			<div id="collapse${comment.id}" class="panel-collapse collapse">
				<jstl:forEach items="${comment.replies}" var="reply">
					<jstl:set var="rand"><%= java.lang.Math.round(java.lang.Math.random() * 9) + 1 %></jstl:set>
					<div class="media" style="padding-left:45px;margin-top:5px;">
						<div class="media-left">
							<img src="images/kC${rand}.png" class="media-object" style="width:45px">
						</div>
						<div class="media-body">
							<h4 class="media-heading">${reply.user.name} ${reply.user.surnames}<small><i>
							<fmt:formatDate type = "both" dateStyle = "long" timeStyle = "long" value = "${reply.creationMoment}" /></i></small></h4>
							<p>${reply.text}</p>
						</div>
						<div class="media-right">
							<img src="${reply.picture}" style="max-height:150px;margin-right:15px;margin-bottom:10px;">
						</div>
					</div>	
				</jstl:forEach>
			</div>
		</jstl:if>
		<div class="panel-footer">
			<jstl:if test="${rsvpd eq true}">
				<input id="${comment.id}" type="button" class="btn btn-block btn-success newReplyBtn" value="<spring:message code='rendezvous.comment.reply'/>" />
			</jstl:if>
		</div>
	</div>
	</jstl:forEach>