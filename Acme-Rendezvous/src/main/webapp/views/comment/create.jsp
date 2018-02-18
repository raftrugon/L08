<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl"	uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="lib" tagdir="/WEB-INF/tags/myTagLib" %>


<form:form action="user/comment/save.do" modelAttribute="comment">		
	<jstl:set var="model" value="comment" scope="request"/>
	<lib:input type="hidden" name="id,version,creationMoment,replies,replyingTo,user,rendezvous"/>
	<lib:input type="textarea" name="text" rows="4"/>
	<lib:input type="text" name="picture" addon="<i class='fas fa-paperclip'></i> <spring:message code='comment.picture.addon'/>" placeholder="http://www.url.com"/>
	<lib:button id="0" noDelete="true" />
</form:form>

<script>
	$('#saveButton').click(function(e){
		var comment = {};
		$('#comment').find('input[type=text],input[type=hidden],textarea').each(function(){
			comment[$(this).attr('name')] = $(this).val();
		});
		e.preventDefault();
		alert(JSON.stringify(comment));
		$.ajax({
			type:'post',
			url:"user/comment/save.do",
			data: comment,
			processData: 'false',
			contentType: 'application/x-www-form-urlencoded',
			dataType: 'json',
			success: function(data){
			alert(data);
			}
		});
	});
</script>