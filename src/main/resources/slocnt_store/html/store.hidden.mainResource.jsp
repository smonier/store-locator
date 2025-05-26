<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>
<c:if test="${renderContext.editMode}">
	<legend>${fn:escapeXml(jcr:label(currentNode.primaryNodeType, currentResource.locale))}</legend>
</c:if>

<c:set var="name" value="${currentNode.properties['name'].string}"/>
<c:set var="description" value="${currentNode.properties['description'].string}"/>
<c:set var="url" value="${currentNode.properties['url'].string}"/>
<c:set var="telephone" value="${currentNode.properties['telephone'].string}"/>
<c:set var="image" value="${currentNode.properties['image'].node}"/>
<c:set var="priceRange" value="${currentNode.properties['priceRange'].string}"/>
<c:set var="amenityFeature" value="${currentNode.properties['amenityFeature']}"/>
<c:set var="openingHours" value="${currentNode.properties['openingHours']}"/>

<c:set var="latitude" value="${currentNode.properties['latitude'].double}"/>
<c:set var="longitude" value="${currentNode.properties['longitude'].double}"/>
<c:set var="streetAddress" value="${currentNode.properties['streetAddress'].string}"/>
<c:set var="addressLocality" value="${currentNode.properties['addressLocality'].string}"/>
<c:set var="addressRegion" value="${currentNode.properties['addressRegion'].string}"/>
<c:set var="postalCode" value="${currentNode.properties['postalCode'].string}"/>
<c:set var="addressCountry" value="${currentNode.properties['addressCountry'].string}"/>

<template:include view="hidden.schema.org">
	<template:param name="name" value="${name}" />
	<template:param name="description" value="${description}" />
	<template:param name="url" value="${url}" />
	<template:param name="telephone" value="${telephone}" />
	<template:param name="image" value="${image.url}" />
	<template:param name="priceRange" value="${priceRange}" />
	<template:param name="latitude" value="${latitude}" />
	<template:param name="longitude" value="${longitude}" />
	<template:param name="streetAddress" value="${streetAddress}" />
	<template:param name="addressLocality" value="${addressLocality}" />
	<template:param name="addressRegion" value="${addressRegion}" />
	<template:param name="postalCode" value="${postalCode}" />
	<template:param name="addressCountry" value="${addressCountry}" />
	<template:param name="amenityFeature" value="${amenityFeature}" />
	<template:param name="openingHours" value="${openingHours}" />
</template:include>

<div class="inner-page">
	<div class="slider-item" style="background-image: url('${image.url}');">
		<div class="container">
			<div class="row slider-text align-items-center justify-content-center">


			</div>
		</div>
	</div>
</div>

<div style="display: flex; justify-content: center; margin-top: -80px; padding-bottom: 50px;">
	<div class="card shadow-sm" style="width: 600px; max-height: 600px; overflow-y: auto; z-index: 2; background: white;">
		<div class="card-body text-center">
			<h5 class="card-title fw-bold">${name}</h5>
			<p class="card-text text-muted">${description}</p>

			<div class="mb-2">
				<i class="fas fa-map-marker-alt text-primary"></i>
				${streetAddress}, ${addressLocality}, ${addressRegion} ${postalCode}, ${addressCountry}<br/>
				<a class="small" href="https://www.google.com/maps/dir/?api=1&destination=${latitude},${longitude}" target="_blank">
					<fmt:message key="store.directions" />
				</a>
			</div>

			<c:if test="${not empty telephone}">
				<div class="mb-2">
					<i class="fas fa-phone text-primary"></i>
					<a href="tel:${telephone}" class="text-decoration-none">${telephone}</a>
				</div>
			</c:if>

			<c:if test="${not empty url}">
				<div class="mb-2">
					<i class="fas fa-globe text-primary"></i>
					<a href="${url}" class="text-decoration-none" target="_blank">${url}</a>
				</div>
			</c:if>

			<c:if test="${not empty priceRange}">
				<div class="mb-2">
					<i class="fas fa-tags text-primary"></i> ${priceRange}
				</div>
			</c:if>

			<c:if test="${not empty amenityFeature}">
				<div class="mb-2">
					<h6><fmt:message key="store.amenityFeature" /></h6>
					<i class="fas fa-concierge-bell text-primary"></i>
					<c:forEach var="amenity" items="${amenityFeature}">
						<span class="badge bg-light text-dark border me-1">${amenity.string}</span>
					</c:forEach>
				</div>
			</c:if>

			<c:if test="${not empty openingHours}">
				<div class="mt-3">
					<h6><fmt:message key="store.openingHours" /></h6>
					<ul class="list-unstyled small">
						<c:forEach var="hour" items="${openingHours}">
							<c:set var="entry" value="${hour.string}" />
							<c:if test="${fn:contains(entry, 'dayOfWeek') and fn:contains(entry, 'opens') and fn:contains(entry, 'closes')}">
								<c:set var="day" value="${fn:substringBefore(fn:substringAfter(entry, 'dayOfWeek\\\": \\\"'), '\"')}" />
								<c:set var="opens" value="${fn:substringBefore(fn:substringAfter(entry, 'opens\\\": \\\"'), '\"')}" />
								<c:set var="closes" value="${fn:substringBefore(fn:substringAfter(entry, 'closes\\\": \\\"'), '\"')}" />
								<li><fmt:message key="store.day.${fn:toLowerCase(day)}" /> : ${opens} - ${closes}</li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
			</c:if>
		</div>
	</div>
</div>