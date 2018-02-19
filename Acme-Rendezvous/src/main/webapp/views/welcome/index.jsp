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

<%--
<div id="myCarousel" class="carousel slide" data-ride="carousel" style="max-width:600px;margin:auto">
  <!-- Indicators -->
  <ol class="carousel-indicators">
    <jstl:forEach items="${rendezvouses}" var="rendezvous" varStatus="x">
    	<li data-target="#myCarousel" data-slide-to="${x.index}" <jstl:if test="${x.first}">class="active"</jstl:if> > </li>
    </jstl:forEach>
  </ol>

  <!-- Wrapper for slides -->
  <div class="carousel-inner">
       
	<jstl:forEach items="${rendezvouses}" var="rendezvous" varStatus="x">
    	<div class="item <jstl:if test='${x.first}'>active</jstl:if>" >
	      <img class="centerimage" src="${rendezvous.picture}" alt="----" style="max-height:400px;">
	      <div class="carousel-caption">
	        <h3>${rendezvous.name}</h3>
	        <p>${rendezvous.description}</p>
	      </div>
	    </div>
    </jstl:forEach>
   </div>
    
  <!-- Left and right controls -->
  <a class="left carousel-control" href="#myCarousel" data-slide="prev">
    <span class="glyphicon glyphicon-chevron-left"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="right carousel-control" href="#myCarousel" data-slide="next">
    <span class="glyphicon glyphicon-chevron-right"></span>
    <span class="sr-only">Next</span>
  </a>
</div> --%>

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
