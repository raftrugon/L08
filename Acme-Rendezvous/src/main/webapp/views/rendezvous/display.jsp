<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl"	uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="lib" tagdir="/WEB-INF/tags/myTagLib" %>

	<div id="callbackModal" class="modal fade" role="dialog">
  		<div class="modal-dialog" style="margin-top:45vh">
		    <div class="modal-content">
		     	<div id="callbackAlert" class="alert" style="margin:0;text-align:center;font-weight:bold;"></div>
		    </div>
	 	</div>
	</div>
	
<jstl:if test="${rendezvous.inappropriate eq true}">
	<script>
		$(function(){
			$('#inappropriateBlur').css("filter","blur(5px)").css("-webkit-filter","blur(5px)");
			$('#inappropriateModal').modal({backdrop: 'static', keyboard: false});
		});
	</script>

	<div id="inappropriateModal" class="modal fade" role="dialog">
  		<div class="modal-dialog" style="margin-top:45vh">
		    <div class="modal-content">
		     	<div class="alert alert-danger" style="margin:0;text-align:center"><strong><spring:message code="rendezvous.inappropriate.alert"/></strong></div>
		    </div>
	 	</div>
	</div>
</jstl:if>
<jstl:if test="${isAdult eq false and rendezvous.adultOnly eq true}">
	<script>
		$(function(){
			$('#inappropriateBlur').css("filter","blur(5px)").css("-webkit-filter","blur(5px)");
			$('#under18Modal').modal({backdrop: 'static', keyboard: false});
		});
	</script>

	<div id="under18Modal" class="modal fade" role="dialog">
  		<div class="modal-dialog" style="margin-top:45vh">
		    <div class="modal-content">
		     	<div class="alert alert-danger" style="margin:0;text-align:center"><strong><spring:message code="rendezvous.under18.alert"/></strong></div>
		    </div>
	 	</div>
	</div>
</jstl:if>
<div id="inappropriateBlur">
<!--  LEFT  -->
<div class="col-md-2">
<security:authorize access="hasRole('USER')">
	<jstl:if test="${rendezvous.user.userAccount.username eq pageContext.request.userPrincipal.name }">
	<div class="panel panel-default">
		<div class="well" style="margin-bottom:10px;text-align:center"><strong><i class="fas fa-bullhorn"></i> <spring:message code="rendezvous.announcement.new"/></strong></div>
		<form:form action="ajax/user/announcement/save.do" modelAttribute="announcement" style="margin-bottom:10px !important;width:95%;margin:auto">		
			<jstl:set var="model" value="announcement" scope="request"/>
			<lib:input type="hidden" name="id,version,creationMoment,rendezvous,inappropriate"/>
			<spring:message code='announcement.title' var="titlePlaceholder"/>
			<lib:input type="text" name="title" placeholder="${titlePlaceholder}" noLabel="true"/>
			<lib:input type="textarea" name="description" rows="4"/>
			<lib:button id="0" noDelete="true" />
		</form:form>
	</div>
	</jstl:if>
</security:authorize>
	<jstl:set var="model" value="rendezvous" scope="request"/>
	<fmt:formatDate var="formatedBirthDate" value="${rendezvous.user.birthDate}" pattern="dd/MM/yyyy"/>
	
	<div id="userCardDiv"></div>
	
	<jstl:if test="${rendezvous.user.userAccount.username eq pageContext.request.userPrincipal.name }">
		<a style="margin-bottom:10px" href="user/rendezvous/editQuestions.do?rendezvousId=${rendezvous.id}" class="btn btn-block btn-primary" id="${rendezvous.id}" ><spring:message code="rendezvous.questions.edit" /></a>
	</jstl:if>
	
	<jstl:forEach items="${rendezvous.rsvps}" var="r">
		<div class="chip">
		<img src="images/kC1.png" width="96" height="96">
		<small><jstl:out value="${r.user.name} ${r.user.surnames}"/></small>
		<button class="btn btn-info chipQA" id="${r.id}"><small>Q&#38;A</small></button>
		</div>
	</jstl:forEach>
	
</div>


<!--  CENTER  -->
<div class="center-text col-md-8">
<div class="well well-lg" style="text-align:center"><h1><strong><jstl:out value="${rendezvous.name}"/></strong> <small><fmt:formatDate type = "both" dateStyle = "long" timeStyle = "long" value = "${rendezvous.organisationMoment}" /></small></h1></div>
<div class="col-md-7" style="text-align:right">
	<blockquote class="blockquote-reverse">
	    <p><jstl:out value="${rendezvous.description}"/></p>
	    <footer><jstl:out value="${rendezvous.user.name} ${rendezvous.user.surnames}"/></footer>
  	</blockquote>
  	<jstl:if test="${rendezvous.inappropriate eq false}">
	  	<security:authorize access="hasRole('ADMIN')">
		    <button id="${rendezvous.id}" class="btn btn-danger deleteRendezvousButton">
				<spring:message code="rendezvous.adminDelete"/>
			</button>
		</security:authorize>
	</jstl:if>
</div>
<div class="col-md-5" style="text-align:center">
	<jstl:if test="${rendezvous.picture ne null}">
		<img src="<jstl:out value='${rendezvous.picture}'/>" style="max-height:200px;width:100%;object-fit:cover"/>
	</jstl:if>
	<jstl:if test="${rendezvous.picture eq null}">
		<div class="nopicContainer">
			<img src="images/nopic.jpg" style="max-height:200px;width:100%;object-fit:cover" class="nopic"/>
			<div class="nopicCaption alert alert-warning"><spring:message code="master.page.nopic"/></div>
		</div>
	</jstl:if>
</div>

<!-- Comments & Announcements -->
<ul class="nav nav-tabs nav-justified col-md-12" style="margin-top:20px;padding-left:15px">
  <li class="active"><a data-toggle="tab" href="#accordion"><spring:message code="rendezvous.comments.tab"/></a></li>
  <li><a data-toggle="tab" href="#announcementTab"><spring:message code="rendezvous.announcements.tab"/></a></li>
</ul>
<div class="tab-content">
	<div class="container col-md-12 panel-group tab-pane fade in active" id="accordion" style="margin-top:20px;">
	<jsp:useBean id="now" class="java.util.Date" />
	<jstl:if test="${rendezvous.organisationMoment lt now }">
		<div class="alert alert-warning" style="text-align:center"><strong><spring:message code="rendezvous.past"/></strong></div>
	</jstl:if>
	<jstl:if test="${rsvpd eq true}">
	<div id="newCommentDiv">
	<form:form modelAttribute="newComment">		
	<jstl:set var="model" value="comment" scope="request"/>
	<lib:input type="hidden" name="id,version,creationMoment,replies,replyingTo,user,rendezvous,inappropriate"/>
	<lib:input type="textarea" name="text" rows="4"/>
	<lib:input type="url" name="picture" addon="<i class='fas fa-paperclip'></i> <spring:message code='comment.picture.addon'/>" placeholder="http://www.url.com"/>
	<lib:button id="0" noDelete="true" />
	</form:form>
	</div>
	</jstl:if>
	<security:authorize access="hasRole('USER')">
		<jstl:if test="${not rsvpd and rendezvous.organisationMoment gt now }">
			<input type="button" id="RSVPbtn" class="btn btn-block btn-primary" value='<spring:message code="rendezvous.rsvp" />' />
		</jstl:if>	
	</security:authorize>
	<jstl:forEach items="${comments}" var="comment">
	<jstl:set var="rand"><%= java.lang.Math.round(java.lang.Math.random() * 9) + 1 %></jstl:set>
	<div class="media panel panel-default">
		<div class="panel-heading"> 
			<div class="media-left">
			  <img src="images/kC${rand}.png" class="media-object" style="width:45px">
			</div>
			<div class="media-body">
				<h4 class="media-heading">${comment.user.name} ${comment.user.surnames}<small><i>
				<fmt:formatDate type = "both" dateStyle = "long" timeStyle = "long" value = "${comment.creationMoment}" /></i>
				<jstl:if test="${comment.inappropriate eq false}">
					<security:authorize access="hasRole('ADMIN')">
						<a href="javascript:deleteComment();" style="color:red;padding:1em;" id="${comment.id}" class="deleteCommentLink">
							<i class="fas fa-times"></i> 
							<spring:message code="rendezvous.adminDelete"/>
						</a>
					</security:authorize>
				</jstl:if>
				</small></h4>
				<p>${comment.text}</p>
			</div>
			<div class="media-right" style="text-align:right">
				<img src="${comment.picture}" style="max-height:150px">
			</div>
		</div> 
		<jstl:if test="${not empty comment.replies}">
			<div class="panel commentpanel" style="text-align:center" data-toggle="collapse" data-parent="#accordion" href="#collapse${comment.id}">
				<span style="white-space:nowrap;"><spring:message code="rendezvous.viewReplies"/> <i class="fas fa-chevron-down"></i></span>
				<span style="white-space:nowrap;display:none"><spring:message code="rendezvous.hideReplies"/> <i class="fas fa-chevron-up"></i></span>
			</div>
			<div id="collapse${comment.id}" class="panel-collapse collapse">
				<jstl:forEach items="${comment.replies}" var="reply">
					<jstl:set var="rand"><%= java.lang.Math.round(java.lang.Math.random() * 9) + 1 %></jstl:set>
					<div class="media" style="padding-left:45px;margin-top:5px;">
						<div class="media-left">
							<img src="images/kC${rand}.png" class="media-object" style="width:45px">
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
			<jstl:if test="${rsvpd eq true}">
				<input id="${comment.id}" type="button" class="btn btn-block btn-success newReplyBtn" value="<spring:message code='rendezvous.comment.reply'/>" />
			</jstl:if>
		</div>
	</div>
	</jstl:forEach>
	</div>
	<div id="announcementTab" class="tab-pane fade col-md-12">
		<div class="timeline">
			<jstl:forEach items="${announcements}" var="announcementItem" varStatus="x">
			<jstl:choose>
			<jstl:when test="${x.count mod 2 eq 1}">
				<div class="timelinecontainer timelineleft ">
				    <div class="timelinecontent ">
				      <h2 style="text-align:center"><strong><jstl:out value="${announcementItem.title}"/></strong><br/><small class="text-primary"><i><fmt:formatDate value="${announcementItem.creationMoment}" type="both" dateStyle="long" timeStyle="long"/></i></small></h2>
				      <p style="margin-bottom:25px"><jstl:out value="${announcementItem.description}"/></p>
				      <jstl:if test="${announcementItem.inappropriate eq false }">
					      <security:authorize access="hasRole('ADMIN')">
							  <button id="${announcementItem.id}" class="btn btn-danger deleteAnnouncementButton" style="position:absolute; right:20px; bottom:10px;">
							  	<spring:message code="rendezvous.adminDelete"/>
							  </button>
						  </security:authorize>
					  </jstl:if>
				    </div>
				 </div>
			</jstl:when>
			<jstl:otherwise>
				<div class="timelinecontainer timelineright ">
				    <div class="timelinecontent ">
				      <h2 style="text-align:center"><strong><jstl:out value="${announcementItem.title}"/></strong><br/><small class="text-primary"><i><fmt:formatDate value="${announcementItem.creationMoment}" type="both" dateStyle="long" timeStyle="long"/></i></small></h2>
				      <p style="margin-bottom:25px"><jstl:out value="${announcementItem.description}"/></p>
				      <jstl:if test="${announcementItem.inappropriate eq false }">
					      <security:authorize access="hasRole('ADMIN')">
							  <button id="${announcementItem.id}" class="btn btn-danger deleteAnnouncementButton" style="position:absolute; right:20px; bottom:10px;">
							  	<spring:message code="rendezvous.adminDelete"/>
							  </button>
						  </security:authorize>
					  </jstl:if>
				     </div>
				 </div>
			</jstl:otherwise>
			</jstl:choose>
			</jstl:forEach>
		</div>
	</div>
</div> 
</div>
<!--  RIGHT  -->
<div class="col-md-2">
<div id="map" style="height:300px;width:100%"></div>
<jstl:forEach items="${rendezvous.rendezvouses}" var="rend">
	<div class="cardDisplay col-xs-12">
		<div onclick="location.href = 'rendezvous/display.do?rendezvousId=${rend.id}'" style="cursor:pointer;height:100%">
			<jstl:if test="${rend.picture eq null}">
				<div class="nopicContainer">
					<img src="images/nopic.jpg" style="object-fit:cover;width:100%;max-height:150px" class="nopic"/>
					<div class="nopicCaption alert alert-warning"><spring:message code="master.page.nopic"/></div>
				</div>
			</jstl:if>
			<jstl:if test="${rend.picture ne null}">
				<img src="${rend.picture}" style="object-fit:cover;width:100%;max-height:150px">
			</jstl:if>
	        <h1>
	        	<jstl:out value="${rend.name}"/>
	        </h1>
	        <div style="text-align:center" class="cardDate">
				<fmt:formatDate type="both" dateStyle="long" timeStyle="long" value="${rend.organisationMoment}"/>
	        </div>
		</div>
		<input class="cardButton" type="button" name="cancel" style="position:inherit"
				value="${rend.user.name} ${rend.user.surnames} "	
		onclick="location.href = 'user-display.do?userId=${rend.user.id}'" />
	</div>
</jstl:forEach>
</div>

<!-- Modal -->
<div id="qaModal" class="modal fade" role="dialog">
  <div class="modal-dialog" style="margin:100px auto;">

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
<script defer>
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

<script>
	$(document).ready(function(){
		$('.chipQA').click(function(e){
			e.preventDefault();
			$.get("ajax/qa.do?rsvpId=" + $(this).attr('id'), function(data){
				$('#modalBody').html(data);
				$('#modalTitle').html('<spring:message code="rendezvous.qaHeader"/>');
				$('#qaModal').modal('show');
			});
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
		$('#RSVPbtn').click(function(e){
			e.preventDefault();
			$.get("ajax/rsvp/create.do?rendezvousId=<jstl:out value='${rendezvous.id}'/>", function(data){
				$('#modalBody').html(data);
				$('#qaModal').modal('show');
			});
		});
		$.get("ajax/user-card.do?userId=<jstl:out value='${rendezvous.user.id}'/>", function(data){
			$('#userCardDiv').html(data);
		});
	});
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
				if(data===1)notify('success','<spring:message code="announcement.create.success"/>');
				else if (data==0) notify('danger','<spring:message code="announcement.create.bindingError"/>');
				else notify('danger','<spring:message code="announcement.create.error"/>');
			}
		});
	});
</script>    

<script>
$(function(){
	$('.deleteRendezvousButton').click(function(e){
		e.preventDefault();
		$.post( "ajax/admin/rendezvous/delete.do",{rendezvousId: $(this).attr('id') }, function( data ) {
			if(data==1) notify('success','<spring:message code="rendezvous.delete.success"/>');
			else notify('danger','<spring:message code="rendezvous.delete.error"/>');
			});
	});
});

</script>
<script>
$(function(){
	$('.deleteAnnouncementButton').click(function(e){
		e.preventDefault();
		$.post( "ajax/admin/announcement/delete.do",{announcementId: $(this).attr('id') }, function( data ) {
			if(data==1) notify('success','<spring:message code="rendezvous.announcement.delete.success"/>');
			else notify('danger','<spring:message code="rendezvous.announcement.delete.error"/>');
			});
	});
});

</script>
<script>
$(function deleteComment(){
	$('.deleteCommentLink').click(function(e){
		e.preventDefault();
		$.post( "ajax/admin/comment/delete.do",{commentId: $(this).attr('id') }, function( data ) {
			if(data==1) notify('success','<spring:message code="rendezvous.comment.delete.success"/>');
			else notify('danger','<spring:message code="rendezvous.comment.delete.error"/>');
			});
	});
});

</script>
<script>
	$('.saveButtoncomment').click(function(e){
		e.preventDefault();
		var comment = {};
		$(this).parent().parent().parent().find('input[type=text],input[type=hidden],textarea').each(function(){
			comment[$(this).attr('name')] = $(this).val();
		});
		$.ajax({
			type:'post',
			url:"user/comment/save.do",
			data: comment,
			processData: 'false',
			contentType: 'application/x-www-form-urlencoded',
			dataType: 'json',
			success: function(data){
				if(data===1){
					notify('success','<spring:message code="comment.create.success"/>');
					$('#qaModal').modal('hide');
				}
				else if (data==0) notify('danger','<spring:message code="comment.create.bindingError"/>');
				else notify('danger','<spring:message code="comment.create.error"/>');
			}
		});
	});
</script>
</div>