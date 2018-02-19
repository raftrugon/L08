<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl"	uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@taglib prefix="lib" tagdir="/WEB-INF/tags/myTagLib" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>


<%-- <div class=center-text>
<display:table pagesize="5" class= "displaytag" keepStatus="true" name="rendezvouss" requestURI="${requestUri}" id="row">
	<!-- Shared Variables -->
	<jstl:set var="model" value="rendezvous" scope="request"/>
	<!-- Attributes -->
  	<lib:column name="name" link="rendezvous/display.do?rendezvousId=${row.id}" linkName="${row.name}"/>
	<lib:column name="description"/>
	<lib:column name="organisationMoment" format="{0,date,dd/MM/yy HH:mm}"/>
	<lib:column name="picture" photoUrl="${row.picture}"/>
	<lib:column name="coordinates" value="[${row.longitude},${row.latitude}]"/>
	<lib:column name="user" link="user-display.do?userId=${row.user.id}" linkName="${row.user.name} ${row.user.surnames}"/>
	
</display:table> --%>

<jstl:forEach items="${rendezvouss}" var="rendezvous">
<div class="col-md-3 col-sm-4 col-xs-12">
	<div class="card" >
		<div onclick="location.href = 'rendezvous/display.do?rendezvousId=${rendezvous.id}'" style="cursor:pointer;height:100%">
			<jstl:if test="${rendezvous.picture eq null}">
				<div class="nopicContainer">
					<img src="images/nopic.jpg" style="object-fit:cover;width:100%" class="nopic"/>
					<div class="nopicCaption alert alert-warning"><spring:message code="master.page.nopic"/></div>
				</div>
			</jstl:if>
			<jstl:if test="${rendezvous.picture ne null}">
				<img src="${rendezvous.picture}" style="object-fit:cover;height:60%;width:100%">
			</jstl:if>
	        <h1>
	        	<jstl:out value="${rendezvous.name}"/>
	        </h1>
	        <div style="text-align:center" class="cardDate">
				<fmt:formatDate type="both" dateStyle="long" timeStyle="long" value="${rendezvous.organisationMoment}"/>
	        </div>
		</div>
		<input class="cardButton" type="button" name="cancel"
				value="${rendezvous.user.name} ${rendezvous.user.surnames} "	
		onclick="javascript: relativeRedir('user-display.do?userId=${rendezvous.user.id}');" />
	</div>
</div>
</jstl:forEach>

