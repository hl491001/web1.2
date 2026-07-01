<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="include/header.jsp"/>

<div class="mb-6 rounded-xl border border-slate-200 bg-white p-5 shadow-sm">
  <form method="get" action="${pageContext.request.contextPath}/detail/list" class="flex flex-wrap items-end gap-3">
    <div class="flex-1 min-w-[200px]">
      <label class="mb-1 block text-xs font-medium text-slate-500">关键词搜索</label>
      <input type="text" name="keyword" value="${keyword}" placeholder="订单编号 / 商品编号 / 商品名 / 供货商"
             class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 focus:outline-none transition">
    </div>
    <div class="w-[180px]">
      <label class="mb-1 block text-xs font-medium text-slate-500">订单编号</label>
      <input type="text" name="orderId" value="${orderIdParam}" placeholder="ORD000001"
             class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 focus:outline-none transition">
    </div>
    <div class="w-[180px]">
      <label class="mb-1 block text-xs font-medium text-slate-500">商品名称</label>
      <input type="text" name="productName" value="${productName}" placeholder="商品名称"
             class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 focus:outline-none transition">
    </div>
    <div class="flex gap-2">
      <button type="submit" class="inline-flex items-center gap-1.5 rounded-lg bg-indigo-600 px-4 py-2 text-sm font-medium text-white hover:bg-indigo-700 transition shadow-sm">
        <i class="bi bi-search"></i> 搜索
      </button>
      <a href="${pageContext.request.contextPath}/detail/list"
         class="inline-flex items-center gap-1.5 rounded-lg border border-slate-300 bg-white px-4 py-2 text-sm font-medium text-slate-700 hover:bg-slate-50 transition">
        <i class="bi bi-arrow-clockwise"></i> 重置
      </a>
    </div>
  </form>
</div>

<div class="rounded-xl border border-slate-200 bg-white shadow-sm overflow-hidden">
  <div class="flex items-center justify-between border-b border-slate-100 px-5 py-3">
    <div class="flex items-center gap-3">
      <div class="text-sm text-slate-500">
        共 <span class="font-semibold text-slate-700">${detailList.size()}</span> 条记录
      </div>
      <a href="${pageContext.request.contextPath}/detail/list?sort=${asc ? 'desc' : 'asc'}&keyword=${keyword}&orderId=${orderIdParam}&productName=${productName}"
         class="inline-flex items-center gap-1 rounded-lg border border-slate-300 px-2.5 py-1.5 text-xs font-medium text-slate-600 hover:bg-slate-50 transition">
        <i class="bi ${asc ? 'bi-sort-down' : 'bi-sort-down-alt'}"></i> ${asc ? '正序' : '倒序'}
      </a>
    </div>
    <a href="${pageContext.request.contextPath}/detail/add"
       class="inline-flex items-center gap-1.5 rounded-lg bg-indigo-600 px-3 py-1.5 text-xs font-medium text-white hover:bg-indigo-700 transition shadow-sm">
      <i class="bi bi-plus-lg"></i> 新增明细
    </a>
  </div>

  <c:choose>
    <c:when test="${empty detailList}">
      <div class="flex flex-col items-center justify-center py-20 text-slate-400">
        <i class="bi bi-inbox text-5xl mb-3"></i>
        <p class="text-sm">暂无订单明细数据</p>
        <a href="${pageContext.request.contextPath}/detail/add" class="mt-2 text-sm text-indigo-600 hover:text-indigo-700">+ 添加第一条记录</a>
      </div>
    </c:when>
    <c:otherwise>
      <div class="overflow-x-auto">
        <table class="w-full text-xs">
          <thead>
            <tr class="border-b border-slate-100 bg-slate-50/80 text-left">
              <th class="whitespace-nowrap px-2 py-2.5 font-semibold text-slate-600 text-xs">序号</th>
              <th class="whitespace-nowrap px-2 py-2.5 font-semibold text-slate-600 text-xs">订单编号</th>
              <th class="whitespace-nowrap px-2 py-2.5 font-semibold text-slate-600 text-xs">商品编号</th>
              <th class="whitespace-nowrap px-2 py-2.5 font-semibold text-slate-600 text-xs">商品名称</th>
              <th class="whitespace-nowrap px-2 py-2.5 font-semibold text-slate-600 text-xs">商品网址</th>
              <th class="whitespace-nowrap px-2 py-2.5 font-semibold text-slate-600 text-xs">商品小图</th>
              <th class="whitespace-nowrap px-2 py-2.5 font-semibold text-slate-600 text-xs text-center">赠品</th>
              <th class="whitespace-nowrap px-2 py-2.5 font-semibold text-slate-600 text-xs text-right">标准单价</th>
              <th class="whitespace-nowrap px-2 py-2.5 font-semibold text-slate-600 text-xs text-right">成交单价</th>
              <th class="whitespace-nowrap px-2 py-2.5 font-semibold text-slate-600 text-xs text-right">优惠金额</th>
              <th class="whitespace-nowrap px-2 py-2.5 font-semibold text-slate-600 text-xs text-center">真空</th>
              <th class="whitespace-nowrap px-2 py-2.5 font-semibold text-slate-600 text-xs text-center">保温</th>
              <th class="whitespace-nowrap px-2 py-2.5 font-semibold text-slate-600 text-xs text-right">数量</th>
              <th class="whitespace-nowrap px-2 py-2.5 font-semibold text-slate-600 text-xs text-right">小计</th>
              <th class="whitespace-nowrap px-2 py-2.5 font-semibold text-slate-600 text-xs text-right">积分</th>
              <th class="whitespace-nowrap px-2 py-2.5 font-semibold text-slate-600 text-xs">购买日期</th>
              <th class="whitespace-nowrap px-2 py-2.5 font-semibold text-slate-600 text-xs">特殊要求</th>
              <th class="whitespace-nowrap px-2 py-2.5 font-semibold text-slate-600 text-xs">供货商</th>
              <th class="whitespace-nowrap px-2 py-2.5 font-semibold text-slate-600 text-xs">备注</th>
              <th class="whitespace-nowrap px-2 py-2.5 font-semibold text-slate-600 text-xs text-center">操作</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${detailList}" var="d" varStatus="s">
              <tr class="border-b border-slate-50 hover:bg-slate-50/60 transition-colors ${s.index % 2 == 1 ? 'bg-slate-50/30' : ''}">
                <td class="px-2 py-2.5 text-slate-600 font-mono text-xs">${s.count}</td>
                <td class="px-2 py-2.5 font-mono text-xs text-indigo-600">${d.orderId}</td>
                <td class="px-2 py-2.5 font-mono text-xs">${d.productId}</td>
                <td class="px-2 py-2.5 font-medium text-slate-800 max-w-[130px] truncate text-xs" title="${d.productName}">
                  <c:if test="${d.isGift}"><span class="mr-1 rounded bg-amber-100 px-1.5 py-0.5 text-[10px] font-semibold text-amber-700">赠</span></c:if>
                  ${d.productName}
                </td>
                <td class="px-2 py-2.5 max-w-[100px] truncate">
                  <a href="${d.webLink}" target="_blank" class="text-blue-500 hover:text-blue-700 underline text-xs" title="${d.webLink}">链接</a>
                </td>
                <td class="px-2 py-2">
                  <c:choose>
                    <c:when test="${not empty d.picUrl}">
                      <img src="${d.picUrl}" alt="商品图" class="product-thumb h-8 w-8 rounded-md object-cover border border-slate-200 cursor-pointer"
                           onerror="this.onerror=null;this.outerHTML='<span class=text-slate-300><i class=bi bi-image></i></span>';">
                    </c:when>
                    <c:otherwise><span class="text-slate-300 text-xs"><i class="bi bi-image"></i></span></c:otherwise>
                  </c:choose>
                </td>
                <td class="px-2 py-2.5 text-center">
                  <c:choose>
                    <c:when test="${d.isGift}"><span class="inline-flex items-center rounded-full bg-amber-100 px-2 py-0.5 text-[10px] font-semibold text-amber-700">是</span></c:when>
                    <c:otherwise><span class="text-slate-300 text-xs">-</span></c:otherwise>
                  </c:choose>
                </td>
                <td class="px-2 py-2.5 text-right font-mono text-xs text-slate-600">&yen;<fmt:formatNumber value="${d.originalPrice}" pattern="#,##0.0"/></td>
                <td class="px-2 py-2.5 text-right font-mono text-xs ${d.isGift ? 'text-amber-600' : 'text-slate-700'} font-semibold">&yen;<fmt:formatNumber value="${d.realPrice}" pattern="#,##0.0"/></td>
                <td class="px-2 py-2.5 text-right font-mono text-xs ${d.reducedMoney > 0 ? 'text-emerald-600' : (d.reducedMoney < 0 ? 'text-red-500' : 'text-slate-400')}">
                  <fmt:formatNumber value="${d.reducedMoney}" pattern="#,##0.0"/>
                </td>
                <td class="px-2 py-2.5 text-center">
                  <c:choose>
                    <c:when test="${d.isVaccum}"><span class="inline-flex items-center rounded-full bg-blue-100 px-2 py-0.5 text-[10px] font-semibold text-blue-700">是</span></c:when>
                    <c:otherwise><span class="text-slate-300 text-xs">-</span></c:otherwise>
                  </c:choose>
                </td>
                <td class="px-2 py-2.5 text-center">
                  <c:choose>
                    <c:when test="${d.isKeepWarm}"><span class="inline-flex items-center rounded-full bg-orange-100 px-2 py-0.5 text-[10px] font-semibold text-orange-700">是</span></c:when>
                    <c:otherwise><span class="text-slate-300 text-xs">-</span></c:otherwise>
                  </c:choose>
                </td>
                <td class="px-2 py-2.5 text-right font-semibold text-slate-700 text-xs">${d.quantity}</td>
                <td class="px-2 py-2.5 text-right font-mono text-xs text-slate-700 font-semibold">&yen;<fmt:formatNumber value="${d.subtotal}" pattern="#,##0.00"/></td>
                <td class="px-2 py-2.5 text-right text-slate-600 text-xs">${d.increasedScore}</td>
                <td class="px-2 py-2.5 whitespace-nowrap text-slate-600 text-xs"><fmt:formatDate value="${d.purchasingDate}" pattern="yyyy-MM-dd"/></td>
                <td class="px-2 py-2.5 max-w-[90px] truncate text-slate-600 text-xs" title="${d.specialRequirement}">${d.specialRequirement}</td>
                <td class="px-2 py-2.5 max-w-[90px] truncate text-slate-600 text-xs" title="${d.provider}">${d.provider}</td>
                <td class="px-2 py-2.5 max-w-[80px] truncate text-slate-400 text-xs" title="${d.remark}">${d.remark}</td>
                <td class="px-2 py-2.5">
                  <div class="flex items-center justify-center gap-1">
                    <a href="${pageContext.request.contextPath}/detail/view?recordId=${d.recordId}"
                       class="inline-flex h-7 w-7 items-center justify-center rounded-md text-slate-400 hover:bg-indigo-50 hover:text-indigo-600 transition" title="查看">
                      <i class="bi bi-eye text-xs"></i>
                    </a>
                    <a href="${pageContext.request.contextPath}/detail/edit?recordId=${d.recordId}"
                       class="inline-flex h-7 w-7 items-center justify-center rounded-md text-slate-400 hover:bg-amber-50 hover:text-amber-600 transition" title="编辑">
                      <i class="bi bi-pencil text-xs"></i>
                    </a>
                    <a href="javascript:void(0)"
                       onclick="if(confirm('确定要删除记录【${d.recordId}】吗？此操作不可恢复。')){location.href='${pageContext.request.contextPath}/detail/delete?recordId=${d.recordId}'}"
                       class="inline-flex h-7 w-7 items-center justify-center rounded-md text-slate-400 hover:bg-red-50 hover:text-red-600 transition" title="删除">
                      <i class="bi bi-trash text-xs"></i>
                    </a>
                  </div>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </c:otherwise>
  </c:choose>
</div>

<jsp:include page="include/footer.jsp"/>
