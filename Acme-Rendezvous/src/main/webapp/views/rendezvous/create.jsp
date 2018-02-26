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
			<lib:input name="id" type="hidden" />
			
				
			<!-- Attributes -->
			<h1><spring:message code="rendezvous.new" /></h1>
			<hr>
			<lib:input name="name" type="text" />
			<lib:input name="description" type="text" />
			<lib:input name="organisationMoment" type="moment" />		
			<lib:input name="latitude" type="text" />
			<lib:input name="longitude" type="text" />				
			<lib:input name="picture" type="text" />
			
			<!-- Select rendezvouses for link them to the new rendezvous -->	
			<div class="form-group">
			<label for="linkSelect"><strong><spring:message code="rendezvous.link"/></strong></label>
			<spring:message code="rendezvous.link.explanation"/>
			<form:select id="linkSelect" class="selectpicker form-control" multiple="true" data-live-search="true" data-selected-text-format="count > 1" path="rendezvouses">
	   			<form:options items="${rendezvouses}" itemValue="id" itemLabel="name"/>
			</form:select>
			</div>
			<jstl:if test="${isAdult}">
				<span class="col-md-6 " style="padding:0; margin:0;"><lib:input name="adultOnly" type="checkBox" /></span>		
			</jstl:if>
			
			<span class="col-md-6"><lib:input name="finalMode" type="checkBox" /></span>			
			
			</br>
			<strong><spring:message code="rendezvous.questions"/>:</strong>
			<div class="questionDiv" id="questionDiv">
				<div class="form-group">
					<input class="form-control questionInput" type="text" value="">
				</div>
			</div>
			<div class="form-group">
				<button class="btn btn-primary addQuestion btn-block " style="margin-bottom:5px"><i class="fas fa-plus-square"></i></button>
			</div>
			<hr>		
			<p><hr><spring:message code="termsTextHead" /><a href="terms.do"> <spring:message code="termsAndConditions" /></a> <spring:message code="termsTextTail" />.</p>
			
			<lib:button model="rendezvous" id="${rendezvous.id}" cancelUri="/Acme-Rendezvous" />
	
			
			
		</form:form>		
	</div>
</security:authorize>

<script id="newQuestionRow" class="focus" type="text/plain">
	<div class="form-group">
		<input class="form-control questionInput" type="text" value="">
	</div>


</script>

<script>
$(function(){
	$('.addQuestion').click(function(e){
		e.preventDefault();
		$('.questionDiv').append($('#newQuestionRow').html());
	});
});
</script>
<script>
$('#rendezvous').submit(function(e){
	var questions = [];
	$('#rendezvous').find('.questionInput').each(function(){
		questions.push($(this).val());
	});
	alert(questions);
	$('#rendezvous').find('.questionInput').remove();
	$('<input />').attr('type','hidden').attr('name','questions').attr('value',questions).appendTo('#rendezvous');
	return true;
});
</script>

