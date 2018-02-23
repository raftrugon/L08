<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl"	uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="lib" tagdir="/WEB-INF/tags/myTagLib" %>

<div class="timeline">
			<jstl:forEach items="${announcements}" var="announcementItem" varStatus="x">
			<jstl:choose>
			<jstl:when test="${x.count mod 2 eq 1}">
				<div class="timelinecontainer timelineleft ">
				    <div class="timelinecontent ">
				      <h2 style="text-align:center"><strong><jstl:out value="${announcementItem.title}"/></strong><br/><small class="text-primary"><i><fmt:formatDate value="${announcementItem.creationMoment}" type="both" dateStyle="long" timeStyle="long"/></i></small></h2>
				      <p style="margin-bottom:25px"><jstl:out value="${announcementItem.description}"/></p>
				      <jstl:if test="${announcementItem.inappropriate eq false }">
					      <security:authorize access="hasRole('ADMIN')">
							  <button id="${announcementItem.id}" class="btn btn-danger deleteAnnouncementButton" style="position:absolute; right:20px; bottom:10px;">
							  	<spring:message code="rendezvous.adminDelete"/>
							  </button>
						  </security:authorize>
					  </jstl:if>
				    </div>
				 </div>
			</jstl:when>
			<jstl:otherwise>
				<div class="timelinecontainer timelineright ">
				    <div class="timelinecontent ">
				      <h2 style="text-align:center"><strong><jstl:out value="${announcementItem.title}"/></strong><br/><small class="text-primary"><i><fmt:formatDate value="${announcementItem.creationMoment}" type="both" dateStyle="long" timeStyle="long"/></i></small></h2>
				      <p style="margin-bottom:25px"><jstl:out value="${announcementItem.description}"/></p>
				      <jstl:if test="${announcementItem.inappropriate eq false }">
					      <security:authorize access="hasRole('ADMIN')">
							  <button id="${announcementItem.id}" class="btn btn-danger deleteAnnouncementButton" style="position:absolute; right:20px; bottom:10px;">
							  	<spring:message code="rendezvous.adminDelete"/>
							  </button>
						  </security:authorize>
					  </jstl:if>
				     </div>
				 </div>
			</jstl:otherwise>
			</jstl:choose>
			</jstl:forEach>
		</div>