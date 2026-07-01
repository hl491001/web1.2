<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="include/header.jsp"/>

<div class="rounded-xl border border-slate-200 bg-white shadow-sm">
  <div class="border-b border-slate-100 px-6 py-4">
    <h3 class="text-base font-semibold text-slate-800">新增订单明细</h3>
    <p class="mt-0.5 text-xs text-slate-400">标记 <span class="text-red-400">*</span> 的字段为必填项</p>
  </div>

  <form method="post" action="${pageContext.request.contextPath}/detail/add" class="px-6 py-5" id="detailForm">
    <div class="mb-6">
      <h4 class="mb-3 text-xs font-semibold uppercase tracking-wider text-slate-400">基本信息</h4>
      <div class="grid grid-cols-1 gap-4 md:grid-cols-3">
        <div>
          <label class="mb-1.5 block text-xs font-medium text-slate-600">订单编号 <span class="text-red-400">*</span></label>
          <select name="orderId" required class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 focus:outline-none transition bg-white">
            <option value="">-- 请选择订单 --</option>
            <c:forEach items="${orders}" var="o">
              <option value="${o.orderId}">${o.orderId} - ${o.customerName}</option>
            </c:forEach>
          </select>
        </div>
        <div>
          <label class="mb-1.5 block text-xs font-medium text-slate-600">商品编号 <span class="text-red-400">*</span></label>
          <input type="text" name="productId" required maxlength="5" placeholder="P0001"
                 class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm font-mono focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 focus:outline-none transition">
        </div>
        <div>
          <label class="mb-1.5 block text-xs font-medium text-slate-600">商品名称 <span class="text-red-400">*</span></label>
          <input type="text" name="productName" required maxlength="30" placeholder="输入商品名称"
                 class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 focus:outline-none transition">
        </div>
      </div>
    </div>

    <div class="mb-6">
      <h4 class="mb-3 text-xs font-semibold uppercase tracking-wider text-slate-400">链接与图片</h4>
      <div class="grid grid-cols-1 gap-4 md:grid-cols-2">
        <div>
          <label class="mb-1.5 block text-xs font-medium text-slate-600">商品网址 <span class="text-red-400">*</span></label>
          <input type="url" name="webLink" required maxlength="100" placeholder="https://..."
                 class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 focus:outline-none transition">
        </div>
        <div>
          <label class="mb-1.5 block text-xs font-medium text-slate-600">商品小图 URL <span class="text-red-400">*</span></label>
          <div class="flex gap-2">
            <input type="url" name="picUrl" id="picUrl" required maxlength="100" placeholder="https://...图片地址"
                   class="flex-1 rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 focus:outline-none transition">
            <button type="button" onclick="previewImage()" class="rounded-lg border border-slate-300 px-3 py-2 text-sm text-slate-600 hover:bg-slate-50 transition">
              <i class="bi bi-eye"></i> 预览
            </button>
          </div>
          <div id="imgPreview" class="mt-2 hidden">
            <img id="previewImg" src="" alt="预览" class="h-16 w-16 rounded-lg border border-slate-200 object-cover">
          </div>
        </div>
      </div>
    </div>

    <div class="mb-6">
      <h4 class="mb-3 text-xs font-semibold uppercase tracking-wider text-slate-400">价格信息</h4>
      <div class="grid grid-cols-2 gap-4 md:grid-cols-5">
        <div>
          <label class="mb-1.5 block text-xs font-medium text-slate-600">标准单价 <span class="text-red-400">*</span></label>
          <div class="relative">
            <span class="absolute left-3 top-1/2 -translate-y-1/2 text-sm text-slate-400">&yen;</span>
            <input type="number" name="originalPrice" id="originalPrice" required step="0.1" min="0" placeholder="0.0"
                   class="w-full rounded-lg border border-slate-300 py-2 pl-7 pr-3 text-sm focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 focus:outline-none transition">
          </div>
        </div>
        <div>
          <label class="mb-1.5 block text-xs font-medium text-slate-600">成交单价 <span class="text-red-400">*</span></label>
          <div class="relative">
            <span class="absolute left-3 top-1/2 -translate-y-1/2 text-sm text-slate-400">&yen;</span>
            <input type="number" name="realPrice" id="realPrice" required step="0.1" min="0" placeholder="0.0"
                   class="w-full rounded-lg border border-slate-300 py-2 pl-7 pr-3 text-sm focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 focus:outline-none transition">
          </div>
        </div>
        <div>
          <label class="mb-1.5 block text-xs font-medium text-slate-400">优惠金额</label>
          <div class="relative">
            <span class="absolute left-3 top-1/2 -translate-y-1/2 text-sm text-slate-300">&yen;</span>
            <input type="text" id="reducedMoney" readonly
                   class="w-full rounded-lg border border-slate-200 bg-slate-50 py-2 pl-7 pr-3 text-sm text-slate-500">
          </div>
        </div>
        <div>
          <label class="mb-1.5 block text-xs font-medium text-slate-600">购买数量 <span class="text-red-400">*</span></label>
          <input type="number" name="quantity" id="quantity" required min="1" value="1"
                 class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 focus:outline-none transition">
        </div>
        <div>
          <label class="mb-1.5 block text-xs font-medium text-slate-400">小计</label>
          <div class="relative">
            <span class="absolute left-3 top-1/2 -translate-y-1/2 text-sm text-slate-300">&yen;</span>
            <input type="text" id="subtotal" readonly
                   class="w-full rounded-lg border border-slate-200 bg-slate-50 py-2 pl-7 pr-3 text-sm text-slate-500">
          </div>
        </div>
      </div>
    </div>

    <div class="mb-6">
      <h4 class="mb-3 text-xs font-semibold uppercase tracking-wider text-slate-400">商品属性</h4>
      <div class="flex flex-wrap gap-6">
        <label class="flex items-center gap-2.5 cursor-pointer select-none">
          <input type="checkbox" name="isGift" id="isGift" class="peer sr-only">
          <div class="h-5 w-9 rounded-full bg-slate-200 peer-checked:bg-amber-500 transition-colors after:content-[''] after:absolute relative after:h-4 after:w-4 after:rounded-full after:bg-white after:top-0.5 after:left-0.5 after:transition-transform peer-checked:after:translate-x-4"></div>
          <span class="text-sm text-slate-700">是否赠品</span>
        </label>
        <label class="flex items-center gap-2.5 cursor-pointer select-none">
          <input type="checkbox" name="isVaccum" class="peer sr-only">
          <div class="h-5 w-9 rounded-full bg-slate-200 peer-checked:bg-blue-500 transition-colors after:content-[''] after:absolute relative after:h-4 after:w-4 after:rounded-full after:bg-white after:top-0.5 after:left-0.5 after:transition-transform peer-checked:after:translate-x-4"></div>
          <span class="text-sm text-slate-700">真空包装</span>
        </label>
        <label class="flex items-center gap-2.5 cursor-pointer select-none">
          <input type="checkbox" name="isKeepWarm" class="peer sr-only">
          <div class="h-5 w-9 rounded-full bg-slate-200 peer-checked:bg-orange-500 transition-colors after:content-[''] after:absolute relative after:h-4 after:w-4 after:rounded-full after:bg-white after:top-0.5 after:left-0.5 after:transition-transform peer-checked:after:translate-x-4"></div>
          <span class="text-sm text-slate-700">是否保温</span>
        </label>
      </div>
    </div>

    <div class="mb-6">
      <h4 class="mb-3 text-xs font-semibold uppercase tracking-wider text-slate-400">其他信息</h4>
      <div class="grid grid-cols-1 gap-4 md:grid-cols-3">
        <div>
          <label class="mb-1.5 block text-xs font-medium text-slate-600">增加积分</label>
          <input type="number" name="increasedScore" min="0" value="0"
                 class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 focus:outline-none transition">
        </div>
        <div>
          <label class="mb-1.5 block text-xs font-medium text-slate-600">购买日期</label>
          <input type="date" name="purchasingDate" id="purchasingDate"
                 class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 focus:outline-none transition">
        </div>
        <div>
          <label class="mb-1.5 block text-xs font-medium text-slate-600">供货商</label>
          <input type="text" name="provider" maxlength="60" placeholder="输入供货商"
                 class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 focus:outline-none transition">
        </div>
        <div>
          <label class="mb-1.5 block text-xs font-medium text-slate-600">特殊要求</label>
          <input type="text" name="specialRequirement" maxlength="100" placeholder="如：加饭、宰杀、切片..."
                 class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 focus:outline-none transition">
        </div>
        <div class="md:col-span-2">
          <label class="mb-1.5 block text-xs font-medium text-slate-600">备注</label>
          <input type="text" name="remark" maxlength="100" placeholder="促销活动等备注信息（可选）"
                 class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 focus:outline-none transition">
        </div>
      </div>
    </div>

    <div class="flex items-center gap-3 border-t border-slate-100 pt-5">
      <button type="submit" class="inline-flex items-center gap-1.5 rounded-lg bg-indigo-600 px-5 py-2.5 text-sm font-medium text-white hover:bg-indigo-700 transition shadow-sm">
        <i class="bi bi-check-lg"></i> 保存
      </button>
      <button type="reset" class="inline-flex items-center gap-1.5 rounded-lg border border-slate-300 bg-white px-5 py-2.5 text-sm font-medium text-slate-700 hover:bg-slate-50 transition">
        <i class="bi bi-arrow-counterclockwise"></i> 重置
      </button>
      <a href="${pageContext.request.contextPath}/detail/list" class="ml-auto text-sm text-slate-500 hover:text-slate-700 transition">
        <i class="bi bi-arrow-left"></i> 返回列表
      </a>
    </div>
  </form>
</div>

<script>
(function() {
  var d = document.getElementById('purchasingDate');
  if (d && !d.value) d.value = new Date().toISOString().split('T')[0];
})();

var origEl = document.getElementById('originalPrice');
var realEl = document.getElementById('realPrice');
var qtyEl  = document.getElementById('quantity');
var giftEl = document.getElementById('isGift');
var reducedEl = document.getElementById('reducedMoney');
var subtotalEl = document.getElementById('subtotal');

function recalc() {
  var orig  = parseFloat(origEl.value) || 0;
  var real  = parseFloat(realEl.value) || 0;
  var qty   = parseInt(qtyEl.value) || 0;
  var isGift = giftEl && giftEl.checked;
  if (isGift) { realEl.value = '0.0'; realEl.readOnly = true; real = 0; }
  else { realEl.readOnly = false; }
  reducedEl.value = (orig - real).toFixed(1);
  subtotalEl.value = (real * qty).toFixed(2);
}

if (origEl) origEl.addEventListener('input', function() { if (!realEl.value || realEl.readOnly !== true) realEl.value = origEl.value; recalc(); });
if (realEl) realEl.addEventListener('input', recalc);
if (qtyEl)  qtyEl.addEventListener('input', recalc);
if (giftEl) giftEl.addEventListener('change', recalc);

function previewImage() {
  var url = document.getElementById('picUrl').value;
  var wrap = document.getElementById('imgPreview');
  var img = document.getElementById('previewImg');
  if (url) { img.src = url; wrap.classList.remove('hidden'); }
}
</script>

<jsp:include page="include/footer.jsp"/>
