<%--
 * header.jsp
 *
 * Copyright (C) 2017 Universidad de Sevilla
 * 
 * The use of this project is hereby constrained to the conditions of the 
 * TDG Licence, a copy of which you may download from 
 * http://www.tdg-seville.info/License.html
 --%>

<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>

<div style="height:250px;background-image:url('${bannerUrl}');background-repeat:repeat-x;background-size:auto 250px">
	
</div>

<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="containter-fluid">
		<div class="navbar-header">
		 <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>                        
	      </button>
			<a class="navbar-brand" href="#">Tanzanika</a>
		</div>
		<div class="collapse navbar-collapse" id="myNavbar">
		<ul class="nav navbar-nav">			
				
			

					
			<%-- <security:authorize access="hasRole('ADMIN')">
				<li><a  href="#"><spring:message code="master.page.legalText"/></a></li>  -->
				<%--  
				<li class="dropdown">
				<a class="dropdown-toggle" data-toggle="dropdown" href="#"><spring:message code="actor.adminRegister"/>
				<span class="caret"></span> </a>
					<ul class="dropdown-menu">
						<li><a href="profile/registerByAdmin.do?type=explorer"><spring:message code="actor.adminExplorer" /></a></li>
						<li><a href="profile/registerByAdmin.do?type=auditor"><spring:message code="actor.adminAuditor" /></a></li>
						<li><a href="profile/registerByAdmin.do?type=sponsor"><spring:message code="actor.adminSponsor" /></a></li>
						<li><a href="profile/registerByAdmin.do?type=ranger"><spring:message code="actor.adminRanger" /></a></li>
						<li><a href="profile/registerByAdmin.do?type=manager"><spring:message code="actor.adminManager" /></a></li>	
						
					</ul>
				</li>-->
			</security:authorize>
			
		
		
			<%-- <security:authorize access="role('ADMIN')">
				<button onClick="javascript:window.location.href = 'admin/panel.do'" class="btn btn-danger navbar-btn"><spring:message code="master.page.admin" /></button>
			</security:authorize> --%>
			
		<%-- <security:authorize access="all()"> 
		<form class="navbar-form navbar-left" action="trip/list.do">
		  <div class="input-group">
		    <input id="ajaxTripInput" type="text" class="form-control" name="keyword" placeholder='<spring:message code="trip.search"/>'>
		    <div class="input-group-btn">
		      <button class="btn btn-default" type="submit">
		       <spring:message code="trip.search"/>
		      </button>
		    </div>
		  </div>
		</form>
		</security:authorize> --%>
		
			
			</ul>	
		<ul class="nav navbar-nav navbar-right">
		
		<li class="btn-group">	
			<button onClick="javascript:window.location.href = '?language=en'" class="btn navbar-btn btn-info" >en</button>
			<button onClick="javascript:window.location.href = '?language=es'" class="btn navbar-btn btn-info" >es</button>
		</li>
		
			<security:authorize access="isAuthenticated()">
				<li class="dropdown">
				<a class="dropdown-toggle" data-toggle="dropdown" href="#"><span class="glyphicon glyphicon-user"></span> <security:authentication property="principal.username"/>
				<span class="caret"></span> </a>
					<ul class="dropdown-menu">
						<li><a href="profile/edit.do"><spring:message code="master.page.profile.edit" /></a></li>
						<li><a href="profile/editUserAccount.do"><spring:message code="master.page.profile.editUserAccount" /></a></li>			
					</ul>
				</li>
				<li><a href="j_spring_security_logout"><span class="glyphicon glyphicon-log-out"> </span><spring:message code="master.page.logout" /> &nbsp; </a></li>
			</security:authorize>
			
			
			
			<security:authorize access="isAnonymous()">
				<li><a class="dropdown-toggle" data-toggle="dropdown" href="#"><span class="glyphicon glyphicon-user"></span> <spring:message code="master.page.register" /> &nbsp;</a></li>
				<li><a  href="security/login.do"><span class="glyphicon glyphicon-log-in"></span> <spring:message code="master.page.login" /> &nbsp; </a></li>
			</security:authorize>
		</ul>
		</div>
	</div>
</nav>

