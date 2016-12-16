<%@ page import="com.sap.ui2.proxy.*" %>
<%@ page import="java.util.Collection" %>
<%@ page import="static com.sap.ui2.proxy.UIHelper.*" %>
<!DOCTYPE html>
<!-- Copyright (c) 2009-2014 SAP SE, All Rights Reserved -->
<html>
  <head>
    <title>Proxy Servlet Configuration</title>
    <style type="text/css">
      .rulename { font-weight: bold; }
      .path { font-family: monospace; }
      .no_match { font-style: italic; }
      a { text-decoration: none; color: black; }
    </style>
  </head>
  <body>
    <h1>Proxy Servlet Configuration</h1>
<%
  Configuration configuration = Configuration.getInstance();
  configuration.load(config);
  Collection<Configuration.Error> errors = configuration.getErrors();
  if (errors != null) {
%>
    <h2>Test Failures</h2>
<%  for (Configuration.Error error : errors) { %>
      <dl>
        <dt class="rulename"><%= secure(error.testName) %></dt>
        <dd>
          <table>
<%    if (error.port >= 0) { %>
            <tr><td>Port:</td><td class="path"><%= error.port %></td><tr>
<%    } %>
            <tr><td>Path:</td><td class="path"><%= secure(error.path) %></td><tr>
            <tr><td>Expected:</td><td><%= forward(error.expectedForward, error.expectedRule) %></td></tr>
            <tr><td>Actual:</td><td><%= forward(error.mapping) %></td></tr>
<%    if (error.conflict != null) { %>
            <tr><td>Actual:</td><td><%= forward(error.conflict) %></td><tr>
<%    } %>
          </table>
        <dd>
      </dl>
<%  } %>
    <h2>Rules</h2>
<%
  }
  for (Rule rule : configuration.getRules()) {
    String options = rule.getOptions();
    String filter = rule.getFilterClass();
    String proxy = rule.getProxy();
%>
    <dl>
      <dt class="rulename" id="<%= secure(rule) %>"><%= secure(rule) %></dt>
      <dd class="ruledetails">
        <table>
          <tr><td>Pattern:</td><td><span class="path"><%= secure(rule.getPattern()) %></span></td></tr>
          <tr><td>Target:</td><td><span class="path"><%= secure(rule.getReplacement()) %></span></td></tr>
<%  if (options != null) { %>
          <tr><td>Options:</td><td><%= secure(options) %></td></tr>
<%
    }
    if (filter != null) {
%>
          <tr><td>Filter:</td><td><span class="path"><%= secure(filter) %></span></td></tr>
<%
    }
    if (proxy != null) {
%>
          <tr><td>Proxy:</td><td><span class="path"><%= secure(proxy) %></span></td></tr>
<%
    }
    for (Rule.Header header : rule.getHeaders()) {
%>
          <tr><td>Header:</td><td><span class="path"><%= secure(header) %></span></td></tr>
<%  } %>
        </table>
      </dd>
    </dl>
<%
  }
%>
  </body>
</html>
