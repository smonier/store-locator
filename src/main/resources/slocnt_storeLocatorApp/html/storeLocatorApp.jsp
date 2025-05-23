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
<jsp:useBean id="random" class="java.util.Random" scope="application"/>

<template:addResources type="css" resources="webapp/${requestScope.webappCssFileName}" media="screen"/>
<template:addResources type="javascript" resources="webapp/${requestScope.webappJsFileName}"/>

<c:if test="${renderContext.editMode}">
    <legend>${fn:escapeXml(jcr:label(currentNode.primaryNodeType, currentResource.locale))}</legend>
</c:if>


<c:set var="_uuid_" value="${currentNode.identifier}"/>
<c:set var="language" value="${currentResource.locale.language}"/>
<c:set var="workspace" value="${renderContext.workspace}"/>
<c:set var="isEdit" value="${renderContext.editMode}"/>

<c:set var="site" value="${renderContext.site.siteKey}"/>
<c:set var="host" value="${url.server}"/>

<c:set var="targetId" value="REACT_StoreLocator_${fn:replace(random.nextInt(),'-','_')}"/>
<jcr:node var="user" path="${renderContext.user.localPath}"/>

<script>
    const storeLocatorApp_context_${targetId} = {
        host: "${host}",
        workspace: "${workspace eq 'default' ? 'EDIT' : (workspace eq 'live' ? 'LIVE' : workspace)}",
        isEdit:${isEdit},
        scope: "${site}",//site key
        locale: "${language}",
        storeLocatorId: "${_uuid_}",
        gqlServerUrl: "${host}/modules/graphql",
        contextServerUrl: window.digitalData ? window.digitalData.contextServerPublicUrl : undefined,//digitalData is set in live mode only
    };

    window.addEventListener("DOMContentLoaded", (event) => {
        const callStoreLocatorApp = () => {
            if (typeof window.storeLocatorUIApp === 'function') {
                window.storeLocatorUIApp("${targetId}", storeLocatorApp_context_${targetId});
            } else {
                console.error("Error: window.storeLocatorUIApp is not defined or is not a function.");
            }
        };

        <c:choose>
            <c:when test="${isEdit}">
                setTimeout(callStoreLocatorApp, 500); // Delayed execution in edit mode
            </c:when>
            <c:otherwise>
                callStoreLocatorApp(); // Immediate execution in non-edit mode
            </c:otherwise>
        </c:choose>
    });
</script>
<!-- Container for the React App -->
<div
        id="${targetId}"
        class="react-store-locator-container"
        style="width: 100%; overflow: auto; box-sizing: border-box;"
></div>