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

<div class=center-text>

	<!-- ------------- PERSONAL DATA -----------------  -->
	<h1><spring:message code="personalData" /></h1>
	<display:table pagesize="5" class= "displaytag" keepStatus="true" name="user" requestURI="${requestUri}" id="row">
		
		<!-- Shared Variables -->
		<jstl:set var="model" value="user" scope="request"/> 
		
		<!-- Attributes -->
	  	<lib:column name="name" />
		<lib:column name="surnames"/>
		<lib:column name="address"/>
		<lib:column name="phoneNumber"/>
		<lib:column name="email"/>
		<lib:column name="birthDate" format="{0,date,dd/MM/yy HH:mm}"/>
	
	</display:table>
	
	
	<!-- ------------- RENDEZVOUSES -----------------  -->
	<h1><spring:message code="rendezvouses" /></h1>
	<jstl:choose>
		<jstl:when test="${rendezvouses ne null}"> 
			<display:table pagesize="5" class= "displaytag" keepStatus="true" name="rendezvouses" requestURI="${requestUri}" id="row">
				
				<!-- Shared Variables -->
				<jstl:set var="model" value="rendezvous" scope="request"/> 
				
				<!-- Attributes -->
			  	<lib:column name="name" link="/Acme-Rendezvous/rendezvous/display.do?rendezvousId=${row.id}" linkName="${row.name}"/>
				<lib:column name="description"/>
				<lib:column name="organisationMoment" format="{0,date,dd/MM/yy HH:mm}"/>
				<lib:column name="picture" photoUrl="${row.picture}"/>
				<lib:column name="coordinates" value="[${row.longitude},${row.latitude}]"/>
			
			</display:table> 
		</jstl:when> 
		<jstl:otherwise> 
			<spring:message code="emptyRendezvouses" />
		</jstl:otherwise> 
	</jstl:choose>
</div>
