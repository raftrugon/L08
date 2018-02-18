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

<security:authorize access="isAnonymous()">
	<div class=center-text>
		
		<form:form action="register/user.do" modelAttribute="user">		
				
			<!-- Shared Variables -->
			<jstl:set var="model" value="user" scope="request"/>	
			
			<!-- Hidden Attributes -->
			<lib:input name="userId" type="hidden" />
			
				
			<!-- Attributes -->
			<!-- ------------- ACCOUNT DATA -----------------  -->
			<h1><spring:message code="accountData" /></h1>
			<lib:input name="username" type="text" />
			<lib:input name="password" type="text" />
			
			<!-- ------------- PERSONAL DATA -----------------  -->
			<h1><spring:message code="personalData" /></h1>
			<lib:input name="name" type="text" />
			<lib:input name="surnames" type="text" />
			<lib:input name="address" type="text" />
			<lib:input name="phoneNumber" type="text" />
			<lib:input name="email" type="text" />
			<lib:input name="birthDate" type="date" />
			
			
			
			<lib:button model="user" id="${id}" cancelUri="/Acme-Rendezvous" noDelete="a" />
		
		</form:form>		
	</div>
</security:authorize>