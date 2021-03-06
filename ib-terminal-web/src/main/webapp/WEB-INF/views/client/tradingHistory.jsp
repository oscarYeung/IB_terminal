<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"  %> 
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><spring:message code="ib.terminal.hycm"></spring:message></title>
<link rel="shortcut icon" href="/images/favicon.png" type="image/png" />
<link rel="stylesheet" href="/css/bootstrap.min.css" >
<link rel="stylesheet" href="/css/font-awesome.min.css" >
<link rel="stylesheet" href="/css/bootstrap-datetimepicker.min.css">
<link rel="stylesheet" href="/css/common.css?v=<%= new java.util.Date().getTime() %>">
<link rel="stylesheet" href="/css/layout.css?v=<%= new java.util.Date().getTime() %>">
<c:if test="${langType=='/chinese'}">
<link rel="stylesheet" href="/css/table_cn.css">
</c:if>
<script src="/js/jquery-1.9.1.min.js"></script> 
<!--[if IE 9]>
<style type="text/css">
@media only screen and (max-width: 760px){
  .details-table{ width:100%; overflow-x: auto;}
  .details-table td:before{ float:none; padding-left:3px; }
  }
</style>
<![endif]-->
</head>
<body>
<header>
 <jsp:include page="${langType}/include/head.html"></jsp:include>
</header>
<!--  需要分页，时间查询  -->
<!--  <spring:message code="ib.client.code"></spring:message> ==all ?  -->
<!-- left fixed -->
<div id="wrap">
<jsp:include page="/WEB-INF/include/left.jsp"></jsp:include>
  <!-- left fixed End--> 
  
  <!-- right center -->
  <div class="page-center" id="boxb">
    <div id="content">
      <div id="content_center">
        <ul class="breadcrumb">
          <li><i class="fa fa-home"></i> <a href="/index.hyml"><spring:message code="ib.home"></spring:message></a><i class="fa fa-angle-right"></i>
          <spring:message code="ib.client"></spring:message><i class="fa fa-angle-right"></i><spring:message code="ib.client.trade.histroy"></spring:message></li>
        </ul>
        <div class="container-fluid">
          <h2 class="title"><spring:message code="ib.client.trade.histroy"></spring:message></h2>
          <div class="client client-trade-history">
              <h4><i class="fa fa-chevron-right"></i><spring:message code="ib.search"></spring:message></h4> 
              <form:form action="showTradingHistory.hyml" method="post" modelAttribute="searchDto" id="tradingHistoryForm">
              <div class="select search">
              <div class="per-wid44 client-date">
                  <div class="input-group date form_date" data-date="" data-date-format="yyyy-mm-dd" data-link-field="dtp_input1">
                          <label><spring:message code="ib.from"></spring:message>:</label>
                          <form:input path="startDate" type="text"   readonly="true" size="16" />
                          <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                      </div>
                      <br>
                      <div class="input-group date form_date" data-date="" data-date-format="yyyy-mm-dd" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
                          <label><spring:message code="ib.to"></spring:message>:</label>
                           <form:input path="endDate" type="text"  readonly="true"  size="16"/>
                          <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                      </div>
                  </div>
                  
                  <div class="per-wid30">
                      <span><spring:message code="ib.client.code"></spring:message>:</span>
                      <ul class="clearfix">
                          <li class="return_reques">
                              <i class="fa fa-caret-down"></i>
                               <form:input path="clientCode" type="text"  class="local select_style provin_select Wid163" readonly=""/>
                              <div class="clearfix pa">
                                  <div class="bomb_con_style provin_con none">
                                     <dl>
                                        <dd ><spring:message code="ib.all"></spring:message></dd>
                                        <c:forEach items="${listClients}" var="clients">
                                         <dd >${ clients.client_code}</dd>
                                        </c:forEach>
                                     </dl>
                                  </div>
                              </div>
                          </li>
                      </ul>
                      </div>
                      <div class="wid150"><a href="javascript:void(0)" class="btn btn-red" onclick="ClientHistorySubmit()"><i class="fa fa-search"></i><spring:message code="ib.search"></spring:message></a></div>
                  </div>
                   <p class="errorPrompt"><form:errors path="*"></form:errors> 
                    <c:if test="${!empty errormessage}">
             			<spring:message code="${errormessage}"></spring:message>
             		</c:if>
                    </p>
                   </form:form>
                  <h4><i class="fa fa-chevron-right"></i><spring:message code="ib.details"></spring:message></h4>
                  <div class="client-details">
                      <ul>
                        <li><spring:message code="ib.total.pl"></spring:message>:<fmt:formatNumber type="number" value="${responseBody.total_pl }"  maxFractionDigits="2" minFractionDigits="2"/>  </li>
                        <li><spring:message code="ib.total.commission"></spring:message>:<fmt:formatNumber type="number" value="${responseBody.total_commission }"  maxFractionDigits="2" minFractionDigits="2"/></li>
                        <li><spring:message code="ib.total.swap"></spring:message>:<fmt:formatNumber type="number" value="${responseBody.total_swap }" maxFractionDigits="2" minFractionDigits="2"/>  </li>
                      </ul>
						
                      <div class="details-table client-trade">
                          <table class="table-hover" id="tableTrading">
                              <thead>
                                  <tr>
                                      <th><spring:message code="ib.ticket"></spring:message></th>
                                      <th><spring:message code="ib.client.code"></spring:message></th>
                                      <th><spring:message code="ib.symbol"></spring:message></th>
                                      <th><spring:message code="ib.buy.or.sell"></spring:message></th>
                                      <th><spring:message code="ib.lot"></spring:message></th>
                                      <th><spring:message code="ib.open.time"></spring:message></th>
                                      <th><spring:message code="ib.close.time"></spring:message></th>
                                      <th><spring:message code="ib.open.price"></spring:message></th>
                                      <th><spring:message code="ib.close.price"></spring:message></th>
                                      <th><spring:message code="ib.pl"></spring:message></th>
                                      <th><spring:message code="ib.commission"></spring:message></th>
                                      <th class="borRnone"><spring:message code="ib.swap"></spring:message></th>
                                  </tr>
                              </thead>
                              <c:forEach items="${responseBody.trades}" var="trades">
                              <tr>
                                <td>${trades.ticket}</td>
                                 <td>${trades.client_code}</td>
                                 <td>${trades.symbol}</td>
                                 <td>${trades.bs}</td>
                                 <td>${trades.lot}</td>
                                <td><fmt:formatDate value="${trades.open_time}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                 <td><fmt:formatDate value="${trades.close_time}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                 <td>${trades.open_price}</td>
                                 <td>${trades.close_price}</td>
                                 <td>${trades.pl}</td>
                                <td>${trades.commission}</td>
                                 <td>${trades.swap}</td>
                              </tr>
                              </c:forEach>
                              
                          </table>

                      </div>
                  </div>


          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<div style="display:none">
	<span id="m_start"><spring:message code="input.start.date"></spring:message></span>
	<span id="m_end"><spring:message code="input.end.date"></spring:message></span>
	<span id="m_clientcode"><spring:message code="input.client.code"></spring:message></span>
</div>
<jsp:include page="${langType}/include/foot.html"></jsp:include>
<script type="text/javascript" src="/js/client/tradingHistory.js"></script>
<script src="/js/adaptability.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/bootstrap-datetimepicker.min.js"></script>  
<script type="text/javascript">
  $('.form_date').datetimepicker({
        weekStart: 1,
        todayBtn:  true,
        autoclose: true,
        todayHighlight: true,
        startView: 2,
        minView: 2,
        forceParse: true,
    });
  
  
</script>
<script src="/js/jquery-1.8.3.min.js"></script>
<script src="/js/selected.js"></script>
<%@ include file="/WEB-INF/views/premission.jsp" %>
</body>
</html>