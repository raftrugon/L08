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
	<div class="center-text col-md-8 col-md-offset-2 well">
		<form:form action="user/rendezvous/save.do" modelAttribute="rendezvous">		

			<!-- Shared Variables -->
			<jstl:set var="model" value="rendezvous" scope="request"/>	
			
			<!-- Hidden Attributes -->
			<lib:input name="rendezvousId" type="hidden" />
			
				
			<!-- Attributes -->
			<!-- ------------- ACCOUNT DATA -----------------  -->
			<h1><spring:message code="rendezvous.new" /></h1>
			<hr>
			<lib:input name="name" type="text" />
			<lib:input name="description" type="text" />
			<lib:input name="organisationMoment" type="moment" />		
			<lib:input name="latitude" type="text" />
			<lib:input name="longitude" type="text" />				
			<lib:input name="picture" type="text" />
			
			<span class="col-md-6 " style="padding:0; margin:0;"><lib:input name="adultOnly" type="checkBox" /></span>			
			<span class="col-md-6"><lib:input name="finalMode" type="checkBox" /></span>		
			
			<hr>		
			<p><hr><spring:message code="termsTextHead" /><a href="profile/terms.do"> <spring:message code="termsAndConditions" /></a> <spring:message code="termsTextTail" />.</p>
			
			<lib:button model="rendezvous" id="${rendezvous.rendezvousId}" cancelUri="/Acme-Rendezvous" />
	
			
			
		</form:form>		
	</div>
</security:authorize>