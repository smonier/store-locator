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


<div class="card mb-4 shadow-sm">
	<c:if test="${not empty image}">
		<img src="${image.url}" class="card-img-top" alt="${name}" style="object-fit: cover; height: 200px;">
	</c:if>

	<div class="card-body">
		<h5 class="card-title">${name}</h5>

		<c:if test="${not empty description}">
			<p class="card-text text-muted">${description}</p>
		</c:if>

		<ul class="list-unstyled mb-3">
			<li><strong><fmt:message key="slocmix_address"/></strong> ${streetAddress}, ${postalCode} ${addressLocality}, ${addressRegion} (${addressCountry})</li>
			<li><strong><fmt:message key="slocnt_store.telephone"/></strong> ${telephone}</li>
			<li><strong><fmt:message key="slocnt_store.priceRange"/></strong> ${priceRange}</li>
		</ul>

		<c:if test="${not empty amenityFeature}">
			<div class="mb-2">
				<strong><fmt:message key="slocnt_store.amenityFeature"/> :</strong>
				<c:forEach items="${amenityFeature}" var="item">
					<span class="badge bg-secondary me-1">${item.string}</span>
				</c:forEach>
			</div>
		</c:if>

		<c:if test="${not empty openingHours}">
			<div class="mb-3">
				<strong><fmt:message key="slocnt_store.openingHours"/> :</strong>
				<ul class="mb-0 ps-3" id="opening-hours-list-${currentNode.identifier}">
				<c:forEach items="${openingHours}" var="item" varStatus="loop">
					<li>${item}</li>
				</c:forEach>
					</ul>
			</div>
		</c:if>

		<div class="d-flex justify-content-between align-items-center">
			<a href="${url}" target="_blank" class="btn btn-outline-primary">Visiter le site</a>
			<br/>
			<small class="text-muted">${latitude}, ${longitude}</small>
		</div>
	</div>
</div>