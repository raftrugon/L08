<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl"	uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@taglib prefix="lib" tagdir="/WEB-INF/tags/myTagLib" %>
<%@taglib prefix="fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div style="padding-right:15px;padding-left:15px;margin-bottom:10px">
<ul class="nav nav-pills nav-justified">
  <li id="button1" class="active "><a href="javascript:load(0)"><spring:message code="announcement.list.all"/></a></li>
  <li id="button2" class=""><a class="" href="javascript:load(1)"><spring:message code="announcement.list.mine"/></a></li>
  <li id="button3" class=""><a class="" href="javascript:load(2)"><spring:message code="announcement.list.rsvpd"/></a></li>
</ul>
</div>

<div id="announcementContainer" class=center-text></div>

<script>
function load(i){
	$.get('ajax/loadAnnouncements.do?type='+i,function(data){
		$('announcementContainer').html(data);
	});		
}
</script>