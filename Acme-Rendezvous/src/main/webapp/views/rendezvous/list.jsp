<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl"	uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@taglib prefix="lib" tagdir="/WEB-INF/tags/myTagLib" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


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

<security:authorize access="hasRole('USER')"> 
<div style="padding-right:15px;padding-left:15px;margin-bottom:10px">
<ul class="nav nav-pills nav-justified">
  <li id="button1" class="active rendezvousPill"><a href="javascript:all()"><spring:message code="rendezvous.list.all"/></a></li>
  <li id="button2" class="rendezvousPill"><a class="rendezvousPill" href="javascript:mine()"><spring:message code="rendezvous.list.mine"/></a></li>
  <li id="button3" class="rendezvousPill"><a class="rendezvousPill" href="javascript:rsvp()"><spring:message code="rendezvous.list.rsvpd"/></a></li>
  <li id="button4" class="rendezvousPill"><a class="rendezvousPill" href="javascript:non_rsvp()"><spring:message code="rendezvous.list.non-rsvpd"/></a></li>
</ul>
</div>
</security:authorize>

<jstl:forEach items="${rendezvouss}" var="rendezvous">
<jstl:if test="${fn:contains(rsvpdRendezvouses, rendezvous)}">
	<jstl:set var="rsvp" value="rsvp"/>
</jstl:if>
<jstl:if test="${not fn:contains(rsvpdRendezvouses, rendezvous)}">
	<jstl:set var="rsvp" value=""/>
</jstl:if>
<jstl:if test="${rendezvous.user.userAccount.username eq pageContext.request.userPrincipal.name }">
	<jstl:set var="mine" value="mine"/>
</jstl:if>
<jstl:if test="${rendezvous.user.userAccount.username ne pageContext.request.userPrincipal.name }">
	<jstl:set var="mine" value=""/>
</jstl:if>
<div class="col-md-3 col-sm-4 col-xs-12 ${rsvp} ${mine} cardContainer">
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
		onclick="location.href = 'user-display.do?userId=${rendezvous.user.id}'" />
	</div>
</div>
</jstl:forEach>

<script>
function rsvp(){
	$('#mainContainer').find('.cardContainer').not('.rsvp').hide();
	$('#mainContainer').find('.cardContainer.rsvp').show();
	document.getElementById("button1").className = "";
	document.getElementById("button2").className = "";
	document.getElementById("button3").className = "active";
	document.getElementById("button4").className = "";
};

function non_rsvp(){
	$('#mainContainer').find('.cardContainer').not('.rsvp').show();
	$('#mainContainer').find('.cardContainer.rsvp').hide();
	document.getElementById("button1").className = "";
	document.getElementById("button2").className = "";
	document.getElementById("button3").className = "";
	document.getElementById("button4").className = "active";
};

function mine(){
	$('#mainContainer').find('.cardContainer').not('.mine').hide();
	$('#mainContainer').find('.cardContainer.mine').show();
	document.getElementById("button1").className = "";
	document.getElementById("button2").className = "active";
	document.getElementById("button3").className = "";
	document.getElementById("button4").className = "";
};

function all(){
	$('#mainContainer').find('.cardContainer').show();
	document.getElementById("button1").className = "active";
	document.getElementById("button2").className = "";
	document.getElementById("button3").className = "";
	document.getElementById("button4").className = "";
};

</script>