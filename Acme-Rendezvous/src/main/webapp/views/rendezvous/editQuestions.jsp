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

<security:authorize access="hasRole('USER')">
	<div class=center-text>
		<form:form action="${actionUri}" modelAttribute="rendezvous">		
				
			<!-- Shared Variables -->
			<jstl:set var="model" value="rendezvous" scope="request"/>	
			
			<!-- Hidden Attributes -->
			
				
			<!-- Attributes -->
			<!-- ------------- ACCOUNT DATA -----------------  -->
			<!--  <h1><spring:message code="accountData" /></h1> -->
			
			<lib:input name="questions" type="text" />		
			
			<lib:button model="rendezvous" id="${rendezvousId}" cancelUri="/Acme-Rendezvous/display.do?rendezvousId=${rendezvousId}" />
		
		</form:form>		
	</div>
</security:authorize>