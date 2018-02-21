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

<div class=center-text>

	<!--------------------------------------------- PERSONAL DATA -----------------------------------------------  -->
	
	<!-- <div class="col-sm-1">
	
	</div> -->
	<div class="col-sm-5">
		<h1><spring:message code="personalData" /></h1>
		<div class="well"><!------------------------------ USER INFO ----------------------------------------->
		
			<a href="#personalData" class="btn btn-primary btn-lg" data-toggle="modal"><spring:message code="show"/></a>
			<div class="modal fade" id="personalData">
				<div class="modal-dialog">
					<div class="modal-content">
						<!--  Header de la ventana -->
						<div class="modal-header">
							<button style="button" class="close" data-dismiss="modal">&times;</button>
							<h3 class="modal-title"><spring:message code="personalData"/></h3>
						</div>
						
						<!-- Contenido de la ventana -->
						<div class="modal-body">
							<table class="table table-bordered">
							  	<thead>
							    	<tr>
							      		<th scope="col"><spring:message code="user.name" /></th>
							      		<th scope="col"><spring:message code="user.surnames" /></th>
							      		<th scope="col"><spring:message code="user.address" /></th>
							      		<th scope="col"><spring:message code="user.phoneNumber" /></th>
							      		<th scope="col"><spring:message code="user.email" /></th>
							      		<th scope="col"><spring:message code="user.birthDate" /></th>
							    	</tr>
							  	</thead>
							  	<tbody>
							    	<tr>
							      		<!-- <th scope="row">1</th> -->
							      		<td><jstl:out value="${user.name}"/></td>
							      		<td><jstl:out value="${user.surnames}"/></td>
							      		<td><jstl:out value="${user.address}"/></td>
							      		<td><jstl:out value="${user.phoneNumber}"/></td>
							      		<td><jstl:out value="${user.email}"/></td>
							      		<td><jstl:out value="${user.birthDate}"/></td>
							    	</tr>
							    
							  	</tbody>
							</table>
						</div>
						<!-- Footer de la ventana -->
						<div class="modal-footer">
							<button type="button" class="btn btn-primary" data-dismiss="modal">Cerrar</button>
						</div>
						
					</div>
				</div>
			</div>			
		</div>
		
		
		
		
		
		
		
		
		
		<div class="well"><!----------------------------------- OWN RENDEZVOUSES ----------------------------------->
		
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
	
	
		
	
	
	
	
	<!--------------------------------------------------- RENDEZVOUSES CORREGIR --------------------------------------------------------------------  -->
	<div class="col-sm-7">
		<h1><spring:message code="rendezvouses" /></h1>
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
