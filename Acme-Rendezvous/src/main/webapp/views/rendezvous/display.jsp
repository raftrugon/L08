<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl"	uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="lib" tagdir="/WEB-INF/tags/myTagLib" %>



<!--  LEFT  -->
<div class="col-md-2">

<security:authorize access="hasRole('USER')">
	<jstl:if test="${rendezvous.user.userAccount.username eq pageContext.request.userPrincipal.name }">
		<form:form action="ajax/user/announcement/save.do" modelAttribute="announcement">		
			<jstl:set var="model" value="announcement" scope="request"/>
			<lib:input type="hidden" name="id,version,creationMoment,rendezvous"/>
			<lib:input type="text" name="title"/>
			<lib:input type="textarea" name="description" rows="4"/>
			<lib:button id="0" noDelete="true" />
		</form:form>
	</jstl:if>
</security:authorize>
	</br>
	
	<jstl:set var="model" value="rendezvous" scope="request"/>
	<fmt:formatDate var="formatedBirthDate" value="${rendezvous.user.birthDate}" pattern="dd/MM/yyyy"/>
	<table class="displaytag" style="margin-top:0 !important;">
	<thead>
		<tr><th><a href="user-display.do?userId=<jstl:out value='${rendezvous.user.id}'/>"><jstl:out value='${rendezvous.user.name} ${rendezvous.user.surnames}'/></a></th></tr>
	</thead>
	<tbody>
		<tr><td><jstl:out value="${rendezvous.user.address}"/></td></tr>
		<tr><td><jstl:out value="${rendezvous.user.phoneNumber}"/></td></tr>
		<tr><td><jstl:out value="${rendezvous.user.email}"/></td></tr>
		<tr><td><jstl:out value="${formatedBirthDate}"/></td></tr>
	</tbody>
	</table>
	
	<display:table pagesize="20" class= "displaytag" keepStatus="true" name="rendezvous.rsvps" requestURI="${requestUri}" id="row">
		<display:setProperty name="paging.banner.onepage" value=""/>
		<display:setProperty name="paging.banner.placement" value="bottom"/>
		<display:setProperty name="paging.banner.all_items_found" value=""/>
		<display:setProperty name="paging.banner.one_item_found" value=""/>
		<display:setProperty name="paging.banner.no_items_found" value=""/>

		<lib:column name="name" link="user/display.do?userId=${row.id}" linkName="${row.user.name} ${row.user.surnames}"/>
		<lib:btnColumn modal="q&a,info,qaModal,${row.id}"/>
	
	</display:table>
</div>


<!--  CENTER  -->
<div class="center-text col-md-8">
<div class="well well-lg" style="text-align:center"><h1><strong><jstl:out value="${rendezvous.name}"/></strong> <small><fmt:formatDate type = "both" dateStyle = "long" timeStyle = "long" value = "${rendezvous.organisationMoment}" /></small></h1></div>
<div class="col-md-6" style="text-align:right">
	<blockquote class="blockquote-reverse">
	    <p><jstl:out value="${rendezvous.description}"/></p>
	    <footer><jstl:out value="${rendezvous.user.name} ${rendezvous.user.surnames}"/></footer>
  	</blockquote>
</div>
<div class="col-md-6" style="text-align:center">
	<jstl:if test="${rendezvous.picture ne null}">
		<img src="<jstl:out value='${rendezvous.picture}'/>" style="max-height:200px"/>
	</jstl:if>
</div>
<!-- Comments -->
<ul class="nav nav-tabs">
  <li class="active"><a data-toggle="tab" href="#accordion">Commentsasd</a></li>
  <li><a data-toggle="tab" href="#announcementTab">Announcementsads</a></li>
</ul>
<div class="tab-content">
	<div class="container col-md-12 panel-group tab-pane fade in active" id="accordion" style="margin-top:20px;">
	<div id="newCommentDiv"></div>
	
	<jstl:forEach items="${rendezvous.comments}" var="comment">
	<div class="media panel panel-default">
		<div class="panel-heading"> 
			<div class="media-left">
			  <img src="images/avatar.png" class="media-object" style="width:45px">
			</div>
			<div class="media-body">
				<h4 class="media-heading">${comment.user.name} ${comment.user.surnames}<small><i>
				<fmt:formatDate type = "both" dateStyle = "long" timeStyle = "long" value = "${comment.creationMoment}" /></i></small></h4>
				<p>${comment.text}</p>
			</div>
			<div class="media-right" style="text-align:right">
				<img src="${comment.picture}" style="max-height:150px">
			</div>
		</div> 
	<jstl:if test="${not empty comment.replies}">
		<div class="panel commentpanel" style="text-align:center" data-toggle="collapse" data-parent="#accordion" href="#collapse${comment.id}">
			<span style="white-space:nowrap;">View replies<i class="fas fa-chevron-down"></i></span>
			<span style="white-space:nowrap;display:none">Hide replies<i class="fas fa-chevron-up"></i></span>
		</div>
		<div id="collapse${comment.id}" class="panel-collapse collapse">
			<jstl:forEach items="${comment.replies}" var="reply">
				<div class="media" style="padding-left:45px;margin-top:5px;">
					<div class="media-left">
						<img src="images/avatar.png" class="media-object" style="width:45px">
					</div>
					<div class="media-body">
						<h4 class="media-heading">${reply.user.name} ${reply.user.surnames}<small><i>
						<fmt:formatDate type = "both" dateStyle = "long" timeStyle = "long" value = "${reply.creationMoment}" /></i></small></h4>
						<p>${reply.text}</p>
					</div>
					<div class="media-right">
						<img src="${reply.picture}" style="max-height:150px;margin-right:15px;margin-bottom:10px;">
					</div>
				</div>	
			</jstl:forEach>
		</div>
	</jstl:if>
	<div class="panel-footer">
		<input id="${comment.id}" type="button" class="btn btn-block btn-success newReplyBtn" value="<spring:message code='rendezvous.comment.write'/>" />
	</div>
	</div>
	</jstl:forEach>
	</div>
	<div id="annoucementTab" class="tab-pane fade">
	
	</div>
</div>
</div>
<!--  RIGHT  -->
<div class="col-md-2">
<div id="map" style="height:300px;width=100%"></div>
<display:table pagesize="20" class= "displaytag" keepStatus="true" name="rendezvous.rendezvouses" requestURI="${requestUri}" id="row1">
	<display:setProperty name="paging.banner.onepage" value=""/>
	<display:setProperty name="paging.banner.placement" value="bottom"/>
	<display:setProperty name="paging.banner.all_items_found" value=""/>
	<display:setProperty name="paging.banner.one_item_found" value=""/>
	<display:setProperty name="paging.banner.no_items_found" value=""/>
	<!-- Attributes -->
  	<lib:column name="name" link="rendezvous/display.do?rendezvousId=${row1.id}" linkName="${row1.name}"/>
	<lib:column name="organisationMoment" format="{0,date,dd/MM/yy HH:mm}"/>
	<lib:column name="user" link="user-display.do?userId=<jstl:out value='${row1.user.id}'/>" linkName="${row1.user.name} ${row1.user.surnames}"/>

</display:table>
</div>

<!-- Modal -->
<div id="qaModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 id="modalTitle" class="modal-title"></h4>
      </div>
      <div id="modalBody" class="modal-body">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>

<script>
	$("[data-toggle=modal]").click(function(e){
		$.get("ajax/qa.do?rsvpId=" + $(this).attr('id'), function(data){
			$('#modalBody').html(data);
			$('#modalTitle').html('<spring:message code="rendezvous.qaHeader"/>');
		});
	});
	$(document).ready(function(){
		initMap();
		$.get("user/comment/createComment.do?rendezvousId=<jstl:out value='${rendezvous.id}'/>", function(data){
			$('#newCommentDiv').html(data);
		});
		$('.newReplyBtn').click(function(e){
			e.preventDefault();
			$.get("user/comment/replyComment.do?commentId="+$(this).attr('id'), function(data){
				$('#modalBody').html(data);
			});
			$('#modalTitle').html('<spring:message code="rendezvous.qaHeader"/>');
			$('#qaModal').modal('show');
		});
		$('.commentpanel').click(function(e){
			$(this).children('span').each(function(){
				$(this).toggle();
			});
		});
	});
</script>
<script>
      function initMap() {
        var uluru = {lat: <jstl:out value="${rendezvous.latitude}"/>, lng: <jstl:out value="${rendezvous.longitude}"/>};
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 4,
          center: uluru
        });
        var marker = new google.maps.Marker({
          position: uluru,
          map: map
        });
      }
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA0VftX0iPRA4ASNgBh4qcjuzBWU8YBUwI&callback=initMap">
    </script>
<script>
	$('#saveButtonannouncement').click(function(e){
		var announcement = {};
		$('#announcement').find('input[type=text],input[type=hidden],textarea').each(function(){
			announcement[$(this).attr('name')] = $(this).val();
		});	
		e.preventDefault();
		alert(JSON.stringify(announcement));
		$.ajax({
			type:'post',
			url:"ajax/user/announcement/save.do",
			data: announcement,
			processData: 'false',
			contentType: 'application/x-www-form-urlencoded',
			dataType: 'json',
			success: function(data){
			alert(data);
			}
		});
	});
</script>    
