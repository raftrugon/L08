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
	<display:table pagesize="5" class= "displaytag" keepStatus="true" name="users" requestURI="${requestUri}" id="row">
		
		<!-- Shared Variables -->
		<jstl:set var="model" value="user" scope="request"/>
		
		<!-- Attributes -->
	  	<lib:column name="name" link="/Acme-Rendezvous/user-display.do?userId=${row.id}" linkName="${row.name}"/>
		<lib:column name="surnames"/>
		<lib:column name="address"/>
		<lib:column name="phoneNumber"/>
		<lib:column name="email"/>
		<lib:column name="birthDate" format="{0,date,dd/MM/yy HH:mm}"/>

	</display:table>
</div>
