<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl"	uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@taglib prefix="lib" tagdir="/WEB-INF/tags/myTagLib" %>

<div class=center-text>
<display:table pagesize="5" class= "displaytag" keepStatus="true" name="rendezvouss" requestURI="${requestUri}" id="row">
	<!-- Shared Variables -->
	<jstl:set var="model" value="rendezvous" scope="request"/>
	<!-- Attributes -->
  	<lib:column name="name"/>
	<lib:column name="description"/>
	<lib:column name="organisationMoment" format="{0,date,dd/MM/yy HH:mm}"/>
	<lib:column name="picture" photoUrl="${row.picture}"/>
	<lib:column name="coordinates" value="[${row.longitude},${row.latitude}]"/>
	<lib:column name="user" link="#" linkName="${row.user.name} ${row.user.surnames}"/>

</display:table>
	</div>
