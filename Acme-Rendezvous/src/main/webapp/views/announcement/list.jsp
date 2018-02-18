<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl"	uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@taglib prefix="lib" tagdir="/WEB-INF/tags/myTagLib" %>

<div class=center-text>
<display:table pagesize="100" class= "displaytag" keepStatus="true" name="announcements" requestURI="${requestUri}" id="row">
	<display:caption> 
	 	<spring:message code='announcement.title'/>
	 </display:caption>
	
	<!-- Shared Variables -->
	<jstl:set var="model" value="announcement" scope="request"/>
	<!-- Attributes -->
  	<lib:column name="title"/>
	<lib:column name="description"/>
	<lib:column name="creationMoment" format="{0,date,dd/MM/yy HH:mm}"/>
	<lib:column name="rendezvous" link="rendezvous/display.do?rendezvousId=${row.rendezvous.id}" linkName="${row.rendezvous.name}"/>
	
	<display:setProperty name="paging.banner.onepage" value=""/>
    <display:setProperty name="paging.banner.placement" value="bottom"/>
    <display:setProperty name="paging.banner.all_items_found" value=""/>
    <display:setProperty name="paging.banner.one_item_found" value=""/>
    <display:setProperty name="paging.banner.no_items_found" value=""/>
</display:table>
	</div>
