<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl"	uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="lib" tagdir="/WEB-INF/tags/myTagLib" %>

<form:form id="rsvpForm" modelAttribute="rsvp">
<lib:input type="hidden" name="id,version,user,rendezvous,questionsAndAnswers"/>
<jstl:forEach items="${rsvp.questionsAndAnswers}" var="entity">
	<div class="form-group">
		<div class="well well-sm" style="margin-bottom:5px"><strong><jstl:out value="${entity.key}"/></strong></div>
		<input type="text" class="form-control answerInput" value="${entity.value}" />
	</div>
</jstl:forEach>
<div class="form-group">
	<input id="saveButtonrsvp" type="button" class="btn btn-block btn-success" value="<spring:message code='rendezvous.rsvp'/> ">
</div>
</form:form>

<script>
	$('#saveButtonrsvp').click(function(e){
		var rsvp = {};
		var questionsAndAnswers = {};
		$('#rsvpForm').find('input[type=text],input[type=hidden]').not('.answerInput').each(function(){
			rsvp[$(this).prev().html()] = $(this).val();
		});
		$('#rsvpForm').find('.answerInput').each(function(){
			questionsAndAnswers[$(this).attr('name')] = $(this).val();
		});
		rsvp['questionsAndAnswers'] = questionsAndAnswers;
		e.preventDefault();
		alert(JSON.stringify(questionsAndAnswers));
		alert(JSON.stringify(rsvp));
		$.ajax({
			type:'post',
			url:"ajax/rsvp/save.do",
			data: rsvp,
			processData: 'false',
			contentType: 'application/x-www-form-urlencoded',
			dataType: 'json',
			success: function(data){
			alert(data);
			}
		});
	});
</script>