<%--
 * index.jsp
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

<div id="map" style="height:85vh;width:100%"></div>


<script defer>
function initMap() {
	var labels = 'ABCDEFGHIJ';
	var labelIndex = 0;
    var map = new google.maps.Map(document.getElementById('map'), {
        zoom: 6,
        center: {lat:40.0,lng:-3.703790}
      });
    <jstl:forEach items="${rendezvouses}" var="rendezvous">
    <jstl:if test="${not empty rendezvous.latitude and not empty rendezvous.longitude}">
		 var pos${rendezvous.id} = {lat: ${rendezvous.latitude}, lng: ${rendezvous.longitude}};
		 var marker${rendezvous.id} = new google.maps.Marker({
		      position: pos${rendezvous.id} ,
	          label: labels[labelIndex++],
		      map: map
		    });
	 </jstl:if>
	</jstl:forEach>

  }
</script>
<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA0VftX0iPRA4ASNgBh4qcjuzBWU8YBUwI&callback=initMap">
</script>
<script defer>
	$(document).ready(function(){
		initMap();
	});
</script>
