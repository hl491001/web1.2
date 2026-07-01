<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="include/header.jsp"/>

<div class="grid grid-cols-1 gap-6 lg:grid-cols-3">
  <div class="lg:col-span-2 rounded-xl border border-slate-200 bg-white shadow-sm">
    <div class="border-b border-slate-100 px-6 py-4 flex items-center justify-between">
      <div>
        <h3 class="text-base font-semibold text-slate-800">订单明细详情</h3>
        <p class="mt-0.5 text-xs text-slate-400">序号 #${detail.recordId}</p>
      </div>
      <c:if test="${detail.isGift}">
        <span class="inline-flex items-center gap-1 rounded-full bg-amber-100 px-3 py-1 text-xs font-semibold text-amber-700">
          <i class="bi bi-gift-fill"></i> 赠品
        </span>
      </c:if>
    </div>
    <div class="px-6 py-4">
      <table class="w-full text-sm">
        <tbody>
          <tr class="border-b border-slate-50"><td class="w-32 py-2.5 text-xs font-medium text-slate-400 uppercase tracking-wide">序号</td><td class="py-2.5 text-slate-800 font-mono">${detail.recordId}</td></tr>
          <tr class="border-b border-slate-50"><td class="py-2.5 text-xs font-medium text-slate-400 uppercase tracking-wide">订单编号</td><td class="py-2.5 font-mono text-indigo-600 font-medium">${detail.orderId}</td></tr>
          <tr class="border-b border-slate-50"><td class="py-2.5 text-xs font-medium text-slate-400 uppercase tracking-wide">商品编号</td><td class="py-2.5 font-mono text-slate-800">${detail.productId}</td></tr>
          <tr class="border-b border-slate-50"><td class="py-2.5 text-xs font-medium text-slate-400 uppercase tracking-wide">商品名称</td><td class="py-2.5 font-medium text-slate-800">${detail.productName}</td></tr>
          <tr class="border-b border-slate-50"><td class="py-2.5 text-xs font-medium text-slate-400 uppercase tracking-wide">商品网址</td><td class="py-2.5"><a href="${detail.webLink}" target="_blank" class="text-blue-500 hover:text-blue-700 underline text-xs">${detail.webLink}</a></td></tr>
          <tr class="border-b border-slate-50"><td class="py-2.5 text-xs font-medium text-slate-400 uppercase tracking-wide">标准单价</td><td class="py-2.5 font-mono text-slate-700 font-medium">&yen;<fmt:formatNumber value="${detail.originalPrice}" pattern="#,##0.0"/></td></tr>
          <tr class="border-b border-slate-50"><td class="py-2.5 text-xs font-medium text-slate-400 uppercase tracking-wide">成交单价</td><td class="py-2.5 font-mono ${detail.isGift ? 'text-amber-600' : 'text-slate-700'} font-semibold">&yen;<fmt:formatNumber value="${detail.realPrice}" pattern="#,##0.0"/></td></tr>
          <tr class="border-b border-slate-50"><td class="py-2.5 text-xs font-medium text-slate-400 uppercase tracking-wide">优惠金额</td><td class="py-2.5 font-mono ${detail.reducedMoney > 0 ? 'text-emerald-600' : (detail.reducedMoney < 0 ? 'text-red-500' : 'text-slate-400')} font-semibold">&yen;<fmt:formatNumber value="${detail.reducedMoney}" pattern="#,##0.0"/></td></tr>
          <tr class="border-b border-slate-50"><td class="py-2.5 text-xs font-medium text-slate-400 uppercase tracking-wide">购买数量</td><td class="py-2.5 font-semibold text-slate-800">${detail.quantity}</td></tr>
          <tr class="border-b border-slate-50"><td class="py-2.5 text-xs font-medium text-slate-400 uppercase tracking-wide">小计</td><td class="py-2.5 font-mono text-slate-800 font-semibold">&yen;<fmt:formatNumber value="${detail.subtotal}" pattern="#,##0.00"/></td></tr>
          <tr class="border-b border-slate-50"><td class="py-2.5 text-xs font-medium text-slate-400 uppercase tracking-wide">增加积分</td><td class="py-2.5 text-slate-800">${detail.increasedScore}</td></tr>
          <tr class="border-b border-slate-50"><td class="py-2.5 text-xs font-medium text-slate-400 uppercase tracking-wide">购买日期</td><td class="py-2.5 text-slate-800"><fmt:formatDate value="${detail.purchasingDate}" pattern="yyyy-MM-dd"/></td></tr>
          <tr class="border-b border-slate-50"><td class="py-2.5 text-xs font-medium text-slate-400 uppercase tracking-wide">特殊要求</td><td class="py-2.5 text-slate-800">${detail.specialRequirement}</td></tr>
          <tr class="border-b border-slate-50"><td class="py-2.5 text-xs font-medium text-slate-400 uppercase tracking-wide">供货商</td><td class="py-2.5 text-slate-800">${detail.provider}</td></tr>
          <tr><td class="py-2.5 text-xs font-medium text-slate-400 uppercase tracking-wide">备注</td><td class="py-2.5 text-slate-500">${detail.remark}</td></tr>
        </tbody>
      </table>
    </div>
  </div>

  <div class="space-y-4">
    <div class="rounded-xl border border-slate-200 bg-white shadow-sm overflow-hidden">
      <div class="border-b border-slate-100 px-5 py-3">
        <h4 class="text-xs font-semibold text-slate-500 uppercase tracking-wide">商品图片</h4>
      </div>
      <div class="p-5 flex items-center justify-center min-h-[200px] bg-slate-50/50">
        <c:choose>
          <c:when test="${not empty detail.picUrl}">
            <img src="${detail.picUrl}" alt="商品图"
                 class="product-thumb max-w-full max-h-48 rounded-lg border border-slate-200 object-cover cursor-pointer"
                 onerror="this.onerror=null;this.outerHTML='<div class=text-slate-300+text-center><i class=bi+bi-image+text-4xl></i><p class=text-xs+mt-2>图片加载失败</p></div>';">
          </c:when>
          <c:otherwise>
            <div class="flex flex-col items-center text-slate-300"><i class="bi bi-image text-4xl"></i><p class="text-xs mt-2">暂无图片</p></div>
          </c:otherwise>
        </c:choose>
      </div>
    </div>

    <div class="rounded-xl border border-slate-200 bg-white shadow-sm">
      <div class="border-b border-slate-100 px-5 py-3">
        <h4 class="text-xs font-semibold text-slate-500 uppercase tracking-wide">商品属性</h4>
      </div>
      <div class="px-5 py-4 space-y-3">
        <div class="flex items-center justify-between"><span class="text-sm text-slate-600">是否赠品</span><c:choose><c:when test="${detail.isGift}"><span class="rounded-full bg-amber-100 px-2.5 py-0.5 text-xs font-semibold text-amber-700">是</span></c:when><c:otherwise><span class="rounded-full bg-slate-100 px-2.5 py-0.5 text-xs text-slate-400">否</span></c:otherwise></c:choose></div>
        <div class="flex items-center justify-between"><span class="text-sm text-slate-600">真空包装</span><c:choose><c:when test="${detail.isVaccum}"><span class="rounded-full bg-blue-100 px-2.5 py-0.5 text-xs font-semibold text-blue-700">是</span></c:when><c:otherwise><span class="rounded-full bg-slate-100 px-2.5 py-0.5 text-xs text-slate-400">否</span></c:otherwise></c:choose></div>
        <div class="flex items-center justify-between"><span class="text-sm text-slate-600">是否保温</span><c:choose><c:when test="${detail.isKeepWarm}"><span class="rounded-full bg-orange-100 px-2.5 py-0.5 text-xs font-semibold text-orange-700">是</span></c:when><c:otherwise><span class="rounded-full bg-slate-100 px-2.5 py-0.5 text-xs text-slate-400">否</span></c:otherwise></c:choose></div>
      </div>
    </div>

    <div class="rounded-xl border border-slate-200 bg-white shadow-sm">
      <div class="px-5 py-4 space-y-2 text-xs text-slate-400">
        <div class="flex justify-between"><span>创建时间</span><span><fmt:formatDate value="${detail.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span></div>
        <div class="flex justify-between"><span>更新时间</span><span><fmt:formatDate value="${detail.updateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span></div>
      </div>
    </div>

    <div class="flex gap-2">
      <a href="${pageContext.request.contextPath}/detail/edit?recordId=${detail.recordId}"
         class="flex-1 inline-flex items-center justify-center gap-1.5 rounded-lg bg-indigo-600 px-4 py-2.5 text-sm font-medium text-white hover:bg-indigo-700 transition shadow-sm">
        <i class="bi bi-pencil"></i> 编辑
      </a>
      <a href="${pageContext.request.contextPath}/detail/list"
         class="flex-1 inline-flex items-center justify-center gap-1.5 rounded-lg border border-slate-300 bg-white px-4 py-2.5 text-sm font-medium text-slate-700 hover:bg-slate-50 transition">
        <i class="bi bi-arrow-left"></i> 返回列表
      </a>
    </div>
  </div>
</div>

<jsp:include page="include/footer.jsp"/>
