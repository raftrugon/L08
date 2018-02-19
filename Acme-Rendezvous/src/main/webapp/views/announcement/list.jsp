<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl"	uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@taglib prefix="lib" tagdir="/WEB-INF/tags/myTagLib" %>

<div class=center-text>
	<div class="container well" style="padding: 30px 40px 30px 40px;">
	  	<h2 style="text-align:center;"><spring:message code='announcements'/></h2>
	  	<p style="text-align:center;"><spring:message code='announcements.description'/></p><br>
		
	  	<jstl:forEach var="announcement" items="${announcements}" varStatus="x" >
	  		<hr>
	  		
	  		<jstl:choose>
				<jstl:when test="${x.count mod 2 eq 1}">
					<div class="media" >
				  		<div class="media-left" >
				      		<img src="${announcement.rendezvous.picture}" class="media-object" style="width:70px;height:46px;">
				    	</div>
				    	<div class="media-body">
				      		<h4 class="media-heading"><a href="/Acme-Rendezvous/user-display.do?userId=${announcement.rendezvous.user.id}" ><jstl:out value="${announcement.rendezvous.user.name} ${announcement.rendezvous.user.surnames}"/></a>
				      			<small><i>
				      				<spring:message code='announcements.postedOn' /> <jstl:out value="${announcement.creationMoment}"/>
				      				<spring:message code='announcements.about' /> <a href="/Acme-Rendezvous/rendezvous/display.do?rendezvousId=${announcement.rendezvous.id}" ><jstl:out value="${announcement.rendezvous.name}"/></a>.
				      			</i></small>
				      		</h4>
				      		<p><jstl:out value="${announcement.description}"/></p>
				    	</div>
					</div>
				</jstl:when>
				
				
				
				<jstl:otherwise>
					<div class="media" >
				  		
				    	<div class="media-body">
				      		<h4 class="media-heading" style="text-align: right;"><a href="/Acme-Rendezvous/user-display.do?userId=${announcement.rendezvous.user.id}" ><jstl:out value="${announcement.rendezvous.user.name} ${announcement.rendezvous.user.surnames}"/></a>
				      			<small><i>
				      				<spring:message code='announcements.postedOn' /> <jstl:out value="${announcement.creationMoment}"/>
				      				<spring:message code='announcements.about' /> <a href="/Acme-Rendezvous/rendezvous/display.do?rendezvousId=${announcement.rendezvous.id}" ><jstl:out value="${announcement.rendezvous.name}"/></a>.
				      			</i></small>
				      		</h4>
				      		<p style="text-align:right;"><jstl:out value="${announcement.description}"/></p>
				    	</div>
				    	<div class="media-right">
				      		<img src="${announcement.rendezvous.picture}" class="media-object" style="width:70px;height:46px;">
				    	</div>
					</div>
				</jstl:otherwise>
			</jstl:choose>
			
		</jstl:forEach>
	</div>
  
  
</div>

