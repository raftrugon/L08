<%--
 * action-1.jsp
 *
 * Copyright (C) 2017 Universidad de Sevilla
 * 
 * The use of this project is hereby constrained to the conditions of the 
 * TDG Licence, a copy of which you may download from 
 * http://www.tdg-seville.info/License.html
 --%>

<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl"	uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@taglib prefix="lib" tagdir="/WEB-INF/tags/myTagLib" %>
<%@taglib prefix="fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<div>

<div class="col-md-5">
		<div class="well "><!----------------------------------- OWN RENDEZVOUSES ----------------------------------->
		
			<h3><spring:message code="ownRendezvouses" /></h3>
			<table class="table">
				<thead class="thead-dark">
					<tr>
				    	<th scope="col">#</th>
				    	<th scope="col"><spring:message code="rendezvous.name" /></th>
				      	<th scope="col"><spring:message code="rendezvous.organisationMoment" /></th>
				      	<th scope="col"><spring:message code="rendezvous.coordinates" /></th>
				    </tr>
				</thead>
			  	<tbody>
			  		<jstl:forEach var="ownRendezvous" items="${user.rendezvouses}" varStatus="x" >
			  			<tr>
					      	<th scope="row">${x.count}</th>
					      	<td><a href="/Acme-Rendezvous/rendezvous/display.do?rendezvousId=${ownRendezvous.id}"><jstl:out value="${ownRendezvous.name}"/></a></td>
					      	<td><fmt:formatDate type="both" dateStyle="long" timeStyle="long" value="${ownRendezvous.organisationMoment}"/></td>
					      	<td>(<jstl:out value="${ownRendezvous.latitude}"/>, <jstl:out value="${ownRendezvous.longitude}"/>)</td>
			    		</tr>
			  		</jstl:forEach>
			  	</tbody>
			</table>
	</div>
	</div>
	
	
	<!--------------------------------------------- PERSONAL DATA -----------------------------------------------  -->
		<div class="userCard col-md-2" style="overflow:hidden;padding:0">
		  <img src="images/kS1.png" style="width:100%;margin-top:-25px;">
		  <button class="cardUserButton" style="margin-top:-25px;cursor:initial"><jstl:out value="${user.name} ${user.surnames}"/></button>
		  <p><strong><spring:message code="user.address" /></strong></p>
		  <p><jstl:if test="${user.address eq null}">-</jstl:if><jstl:out value="${user.address}"/></p>
		  <p><strong><spring:message code="user.phoneNumber" /></strong></p>
		  <p><jstl:if test="${user.phoneNumber eq null}">-</jstl:if><jstl:out value="${user.phoneNumber}"/></p>
		  <p><strong><spring:message code="user.email" /></strong></p>
		  <p><jstl:out value="${user.email}"/></p>
		  <p><strong><spring:message code="user.birthDate" /></strong></p>
		  <p><fmt:formatDate value="${user.birthDate}" type="date" dateStyle="long"/></p>
		</div>

	<!--------------------------------------------------- RENDEZVOUSES RSVP --------------------------------------------------------------------  -->
	<div class="col-md-5">
		<div class="well">
			
			<jstl:forEach var="rsvpRendezvous" items="${rendezvouses}" varStatus="x" >
				<div class="col-sm-12 card"  style="padding: 10px 5px 5px 10px;cursor:pointer;height:100px;" onclick="location.href = 'rendezvous/display.do?rendezvousId=${rsvpRendezvous.id}'">
					
					<!-- PICTURE -->
					<div class="col-sm-2" style="height:100%;padding: 0px 0px 0px 0px">
					<jstl:if test="${rsvpRendezvous.picture eq null}">
						<div class="nopicContainer" style="align:left;">
							<img src="images/nopic.jpg" style="height:100%;" class="nopic"/>
							<div class="nopicCaption alert alert-warning"><spring:message code="master.page.nopic"/></div>
						</div>
					</jstl:if>
					<jstl:if test="${rsvpRendezvous.picture ne null}">
						<img src="${rsvpRendezvous.picture}" style="height:100%;width:110%;" >
					</jstl:if>
					</div>	
					<div class="col-sm-1"></div>
					<!-- INFO -->
					<div class="col-sm-9" style="text-align:left;">
						<strong><jstl:out value="${rsvpRendezvous.name}"/></strong><br>
						<small><spring:message code="organisedBy" /> <a href="/Acme-Rendezvous/user-display.do?userId=${rsvpRendezvous.user.id}"><jstl:out value="${rsvpRendezvous.user.name}"/> <jstl:out value="${rsvpRendezvous.user.surnames}"/></a></small>
					</div>		        
										
				</div>
			</jstl:forEach>
			.
		</div>
	</div>

</div>
