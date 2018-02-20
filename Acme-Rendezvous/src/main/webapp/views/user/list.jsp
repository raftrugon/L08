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

<%--<div class=center-text>
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
</div> --%>


<jstl:forEach items="${users}" var="user">
<div class="col-md-2 col-sm-3 col-xs-6">
	<div class="userCard" >
		<div onclick="location.href = 'user-display.do?userId=${user.id}'" style="cursor:pointer;height:100%">
			<div class="nopicContainer">
				<jstl:set var="rand"><%= java.lang.Math.round(java.lang.Math.random() * 9) + 1 %></jstl:set>
				<img src="images/kS${rand}.png" style="object-fit:cover;width:100%" class="nopic"/>
			</div>
	        
		<input class="cardUserButton" type="button" name="cancel"
				value="${user.name} ${user.surnames} "/>
	        <div style="text-align:center" class="cardDate">
				<fmt:formatDate type="both" dateStyle="long" timeStyle="long" value="${user.birthDate}"/>
	        </div>
	        <div class="contactInfo">
	        	<strong><spring:message code="user.address"/></strong></br>
		        	<jstl:if test="${user.address eq null}">
		        		- </br>
		        	</jstl:if><jstl:if test="${user.address ne null}">
		        		<jstl:out value="${user.address}"/> </br>
		        	</jstl:if>
	        	<strong><spring:message code="user.phoneNumber"/></strong></br>
		        	<jstl:if test="${user.phoneNumber eq null}">
		        		-</br>
		        	</jstl:if>
		        	<jstl:if test="${user.phoneNumber ne null}">
		        		<jstl:out value="${user.phoneNumber}"/></br>
		        	</jstl:if>
	        	<strong><spring:message code="user.email"/></strong></br>
		        	<jstl:out value="${user.email}"/></br>
	        </div>
		</div>
	</div>
</div>
</jstl:forEach>
