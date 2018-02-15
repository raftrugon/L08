<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl"	uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="lib" tagdir="/WEB-INF/tags/myTagLib" %>

<div class="col-md-2">
	<fmt:formatDate var="formatedBirthDate" value="${rendezvous.user.birthDate}" pattern="dd/MM/yyyy"/>
	<table class="displaytag">
	<thead>
		<tr><th><a href="/user.display?userId<jstl:out value='${rendezvous.user.id}'/>"><jstl:out value='${rendezvous.user.name} ${rendezvous.user.surnames}'/></a></th></tr>
	</thead>
	<tbody>
		<tr><td><jstl:out value="${rendezvous.user.address}"/></td></tr>
		<tr><td><jstl:out value="${rendezvous.user.phoneNumber}"/></td></tr>
		<tr><td><jstl:out value="${rendezvous.user.email}"/></td></tr>
		<tr><td><jstl:out value="${formatedBirthDate}"/></td></tr>
	</tbody>
	</table>
</div>
<div class="center-text col-md-8">
	<!-- Shared Variables -->
	<jstl:set var="model" value="rendezvous" scope="request"/>
<display:table pagesize="1" class= "displaytag" keepStatus="true" name="rendezvous" requestURI="${requestUri}" id="row">
	<!-- Attributes -->
  	<lib:column name="name"/>
	<lib:column name="description"/>
	<lib:column name="organisationMoment" format="{0,date,dd/MM/yy HH:mm}"/>
	<lib:column name="picture" photoUrl="${row.picture}"/>
	<lib:column name="coordinates" value="[${row.longitude},${row.latitude}]"/>
</display:table>

<display:table pagesize="5" class= "displaytag" keepStatus="true" name="rendezvous.rendezvouses" requestURI="${requestUri}" id="row">
	<!-- Attributes -->
  	<lib:column name="name"/>
	<lib:column name="description"/>
	<lib:column name="organisationMoment" format="{0,date,dd/MM/yy HH:mm}"/>
	<lib:column name="picture" photoUrl="${row.picture}"/>
	<lib:column name="coordinates" value="[${row.longitude},${row.latitude}]"/>
	<lib:column name="user" link="#" linkName="${row.user.name} ${row.user.surnames}"/>

</display:table>
</div>