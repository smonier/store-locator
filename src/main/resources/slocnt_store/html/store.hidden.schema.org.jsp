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

<script type="application/ld+json">
	{
      "@context": "https://schema.org",
      "@type": "Store",
      "name": "${fn:escapeXml(name)}",
  "description": "${fn:escapeXml(description)}",
	<c:if test="${not empty image}">
		"image": "<c:url value='${image.url}'/>",
	</c:if>
  <c:if test="${not empty url}">
	"url": "${fn:escapeXml(url)}",
</c:if>
  <c:if test="${not empty telephone}">
	"telephone": "${telephone}",
</c:if>
	"address": {
      "@type": "PostalAddress",
      "streetAddress": "${streetAddress}",
    "addressLocality": "${addressLocality}",
    "addressRegion": "${addressRegion}",
    "postalCode": "${postalCode}",
    "addressCountry": "${addressCountry}"
  },
	<c:if test="${not empty latitude and not empty longitude}">
		"geo": {
		"@type": "GeoCoordinates",
		"latitude": ${latitude},
		"longitude": ${longitude}
		},
	</c:if>
  <c:if test="${not empty openingHours}">
	"openingHoursSpecification": [
	<c:forEach var="hour" items="${openingHours}" varStatus="loop">
		<c:set var="entry" value="${hour.string}" />
		<c:if test="${fn:contains(entry, 'dayOfWeek') and fn:contains(entry, 'opens') and fn:contains(entry, 'closes')}">
			{
			"@type": "OpeningHoursSpecification",
			"dayOfWeek": "https://schema.org/${fn:substringBefore(fn:substringAfter(entry, 'dayOfWeek\\\": \\\"'), '\"')}",
			"opens": "${fn:substringBefore(fn:substringAfter(entry, 'opens\\\": \\\"'), '\"')}",
			"closes": "${fn:substringBefore(fn:substringAfter(entry, 'closes\\\": \\\"'), '\"')}"
			}<c:if test="${!loop.last}">,</c:if>
		</c:if>
	</c:forEach>
	],
</c:if>
  <c:if test="${not empty amenityFeature}">
	"additionalProperty": [
	<c:forEach var="amenity" items="${amenityFeature}" varStatus="loop">
		{
		"@type": "PropertyValue",
		"name": "${fn:escapeXml(amenity.string)}"
		}<c:if test="${!loop.last}">,</c:if>
	</c:forEach>
	],
</c:if>
	"priceRange": "${priceRange}"
}
</script>