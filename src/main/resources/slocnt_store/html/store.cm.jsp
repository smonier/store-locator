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



<div class="card shadow-sm h-100">
	<div class="row g-0">
		<c:if test="${not empty image}">
			<div class="col-4">
				<img src="<c:url value='${image.url}'/>"
					 class="img-fluid rounded-start h-100 object-fit-cover"
					 style="max-height: 300px; width: 100%; object-fit: cover;"
					 alt="${name}" />
			</div>
		</c:if>
		<div class="col">
			<div class="card-body">
				<h5 class="card-title mb-1 fw-semibold">${name}</h5>
				<p class="card-text small text-muted mb-2">${description}</p>

				<ul class="list-unstyled small mb-2">
					<li>
						<i class="fas fa-map-marker-alt me-2 text-primary"></i>
						${streetAddress}, ${addressLocality}, ${postalCode}
					</li>
					<c:if test="${not empty telephone}">
						<li>
							<i class="fas fa-phone me-2 text-primary"></i>
							<a href="tel:${telephone}" class="text-decoration-none">${telephone}</a>
						</li>
					</c:if>
					<c:if test="${not empty url}">
						<li>
							<i class="fas fa-globe me-2 text-primary"></i>
							<a href="${url}" target="_blank" class="text-decoration-none">${url}</a>
						</li>
					</c:if>
				</ul>

				<c:if test="${not empty priceRange}">
					<div class="mb-2">
						<i class="fas fa-tags me-2 text-primary"></i>${priceRange}
					</div>
				</c:if>

				<c:if test="${not empty amenityFeature}">
					<div class="mb-2">
						<i class="fas fa-concierge-bell me-2 text-primary"></i>
						<c:forEach var="amenity" items="${amenityFeature}">
							<span class="badge bg-secondary text-light me-1">${amenity.string}</span>
						</c:forEach>
					</div>
				</c:if>

				<c:if test="${not empty openingHours}">
					<div class="mt-2">
						<h6 class="mb-1"><fmt:message key="store.openingHours" /></h6>
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
</div>