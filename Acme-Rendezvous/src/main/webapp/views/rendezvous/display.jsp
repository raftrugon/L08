<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl"	uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="lib" tagdir="/WEB-INF/tags/myTagLib" %>

<jstl:set var="model" value="rendezvous" scope="request"/>

<!--  LEFT  -->
<div class="col-md-2">
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

<div class="container col-md-12 panel-group" id="accordion" style="margin-top:20px;">
		<div class="form-group">
			<textarea style="resize:none" class="form-control" rows="4" placeholder="<spring:message code='rendezvous.comment.write.placeholder'/>" ></textarea>
		</div>
		<div class="form-group">
			<div class="input-group">
				<span class="input-group-addon"><i class="fas fa-paperclip"></i> <spring:message code="rendezvous.comment.attachment"/></span>
				<input type="text" class="form-control" placeholder="http://www.url.com"/>
			</div>
		</div>
		<div class="form-group">
			<input type="button" class="btn btn-block btn-success" value="<spring:message code='rendezvous.comment.write'/>" />
		</div>
	</div>
<jstl:forEach items="${rendezvous.comments}" var="comment">
<div class="media panel panel-default">
	<div class="panel-heading commentpanel" data-toggle="collapse" data-parent="#accordion" href="#collapse${comment.id}"> 
		<div class="media-left">
		  <img src="images/avatar.png" class="media-object" style="width:45px">
		</div>
		<div class="media-body">
			<h4 class="media-heading">${comment.user.name} ${comment.user.surnames}<small><i>
			<fmt:formatDate type = "both" dateStyle = "long" timeStyle = "long" value = "${comment.creationMoment}" /></i></small></h4>
			<p>${comment.text}</p>
		</div>
		<div class="media-right">
			<img src="${comment.picture}" style="max-height:150px">
		</div>
	</div> 
<jstl:if test="${comment.replies ne null}">
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
					<jstl:if test="${reply.picture ne null}">
						<input type="button" class="btn btn-primary" id="${reply.id}" value='<spring:message code="rendezvous.picture.show"/>'/>
						<script>
							$(document).ready(function(){
							    $('#<jstl:out value="${reply.id}"/>').popover({
							    	html: true,
							        trigger: 'hover',
							    	content: '<img src="${reply.picture}" style="width:100%">'
							    });   
							});
						</script>
					</jstl:if>
				</div>
			</div>	
		</jstl:forEach>
	</div>
</jstl:if>
<div class="panel-footer">
	<div class="input-group">
		<input type="text" class="form-control" placeholder="<spring:message code='rendezvous.comment.reply.placeholder'/>" />
		<div class="input-group-btn">
			<input type="button" class="btn btn-success" value="<spring:message code='rendezvous.comment.reply'/>" />
		</div>
	</div>
</div>
</div>
</jstl:forEach>
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
        <h4 class="modal-title"><spring:message code="rendezvous.qaHeader"/></h4>
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
		});
	});
	$(document).ready(function(){
		initMap();
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
    //Script to make the textarea auto resize
    $(function() {
    	  var txt = $('#autoTextarea'),
    	    hiddenDiv = $(document.createElement('div')),
    	    content = null;

    	  txt.addClass('txtstuff');
    	  hiddenDiv.addClass('hiddenTextarea common');

    	  $('body').append(hiddenDiv);

    	  txt.on('keyup', function () {

    	    content = $(this).val();

    	    content = content.replace(/\n/g, '<br>');
    	    hiddenDiv.html(content + '<br> <br class="lbr">');

    	    $(this).css('height', hiddenDiv.height());

    	  });
    	});
    </script>
    