<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="zh-CN" class="h-full">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>客户订单明细管理系统</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {
      theme: {
        extend: {
          colors: {
            primary: { 50:'#eef2ff',100:'#e0e7ff',200:'#c7d2fe',300:'#a5b4fc',400:'#818cf8',500:'#6366f1',600:'#4f46e5',700:'#4338ca',800:'#3730a3',900:'#312e81' }
          },
          fontFamily: {
            sans: ['Inter','system-ui','-apple-system','sans-serif']
          }
        }
      }
    }
  </script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body class="h-full bg-slate-50 antialiased">

<aside class="fixed inset-y-0 left-0 z-50 flex w-60 flex-col bg-slate-900 text-slate-300">
  <div class="flex h-16 items-center gap-3 border-b border-slate-700/60 px-5">
    <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-indigo-500 text-white">
      <i class="bi bi-box-seam text-lg"></i>
    </div>
    <div>
      <h1 class="text-sm font-semibold text-white leading-tight">订单明细管理</h1>
      <p class="text-[10px] text-slate-400">Order Detail System</p>
    </div>
  </div>
  <nav class="flex-1 overflow-y-auto px-3 py-4 space-y-1">
    <p class="mb-2 px-2 text-[10px] font-semibold uppercase tracking-widest text-slate-500">主菜单</p>
    <a href="${pageContext.request.contextPath}/detail/list"
       class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-sm font-medium transition-colors hover:bg-slate-800 hover:text-white">
      <i class="bi bi-table text-base"></i>
      <span>明细列表</span>
    </a>
    <a href="${pageContext.request.contextPath}/detail/add"
       class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-sm font-medium transition-colors hover:bg-slate-800 hover:text-white">
      <i class="bi bi-plus-circle text-base"></i>
      <span>新增明细</span>
    </a>
  </nav>
  <div class="border-t border-slate-700/60 px-5 py-3">
    <p class="text-[10px] text-slate-500">© 2026 OrderMS v1.0</p>
  </div>
</aside>

<main class="ml-60 min-h-screen">
  <header class="sticky top-0 z-40 flex h-16 items-center justify-between border-b border-slate-200 bg-white/80 backdrop-blur px-6">
    <h2 class="text-lg font-semibold text-slate-800">客户订单明细管理系统</h2>
  </header>

  <div class="px-6 py-6">
    <c:if test="${not empty msg}">
      <div id="flashMsg" class="mb-4 flex items-center gap-2 rounded-lg border border-emerald-200 bg-emerald-50 px-4 py-3 text-sm text-emerald-700 shadow-sm">
        <i class="bi bi-check-circle-fill text-emerald-500"></i>
        <span>${msg}</span>
        <button onclick="this.parentElement.remove()" class="ml-auto text-emerald-400 hover:text-emerald-600"><i class="bi bi-x-lg"></i></button>
      </div>
    </c:if>
