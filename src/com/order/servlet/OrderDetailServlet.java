package com.order.servlet;

import com.order.dao.OrderDetailDao;
import com.order.dto.OrderDetailVO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/detail/*")
public class OrderDetailServlet extends HttpServlet {

    private final OrderDetailDao detailDao = new OrderDetailDao();
    private static final SimpleDateFormat DATE_FMT = new SimpleDateFormat("yyyy-MM-dd");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path == null || "/".equals(path) || "/list".equals(path)) {
            handleList(req, resp);
        } else if ("/add".equals(path)) {
            handleAddForm(req, resp);
        } else if ("/edit".equals(path)) {
            handleEditForm(req, resp);
        } else if ("/view".equals(path)) {
            handleView(req, resp);
        } else if ("/delete".equals(path)) {
            handleDelete(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String path = req.getPathInfo();
        if ("/add".equals(path)) {
            handleAddSave(req, resp);
        } else if ("/edit".equals(path)) {
            handleEditSave(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void handleList(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        String orderId = req.getParameter("orderId");
        String productName = req.getParameter("productName");

        List<OrderDetailVO> list;
        if ((keyword != null && !keyword.isEmpty()) ||
            (orderId != null && !orderId.isEmpty()) ||
            (productName != null && !productName.isEmpty())) {
            list = detailDao.search(keyword, orderId, productName);
        } else {
            list = detailDao.findAll();
        }

        req.setAttribute("detailList", list);
        req.setAttribute("keyword", keyword);
        req.setAttribute("orderIdParam", orderId);
        req.setAttribute("productName", productName);

        HttpSession session = req.getSession();
        String msg = (String) session.getAttribute("msg");
        if (msg != null) {
            req.setAttribute("msg", msg);
            session.removeAttribute("msg");
        }

        req.getRequestDispatcher("/WEB-INF/views/list.jsp").forward(req, resp);
    }

    private void handleAddForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String maxOrderId = detailDao.getMaxOrderId();
        String nextOrderId = generateNextOrderId(maxOrderId);
        req.setAttribute("nextOrderId", nextOrderId);
        req.setAttribute("purchasingDate", DATE_FMT.format(new Date()));
        req.getRequestDispatcher("/WEB-INF/views/add.jsp").forward(req, resp);
    }

    private String generateNextOrderId(String maxOrderId) {
        if (maxOrderId == null || maxOrderId.isEmpty()) return "ORD000001";
        String prefix = maxOrderId.replaceAll("\\d+$", "");
        String numStr = maxOrderId.substring(prefix.length());
        try {
            int num = Integer.parseInt(numStr) + 1;
            return prefix + String.format("%0" + numStr.length() + "d", num);
        } catch (NumberFormatException e) {
            return maxOrderId + "_1";
        }
    }

    private void handleAddSave(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        OrderDetailVO d = new OrderDetailVO();
        populateFromRequest(d, req);

        if (d.getRealPrice() == null) {
            d.setRealPrice(d.getOriginalPrice());
        }
        if (d.getIsGift() != null && d.getIsGift()) {
            d.setRealPrice(BigDecimal.ZERO.setScale(1));
        }
        if (d.getPurchasingDate() == null) {
            d.setPurchasingDate(new Date());
        }

        detailDao.insert(d);
        req.getSession().setAttribute("msg", "✅ 订单明细添加成功！");
        resp.sendRedirect(req.getContextPath() + "/detail/list");
    }

    private void handleEditForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String recordIdStr = req.getParameter("recordId");
        if (recordIdStr == null || recordIdStr.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/detail/list");
            return;
        }
        Integer recordId = Integer.parseInt(recordIdStr);
        OrderDetailVO detail = detailDao.findById(recordId);
        if (detail == null) {
            resp.sendRedirect(req.getContextPath() + "/detail/list");
            return;
        }
        req.setAttribute("detail", detail);
        req.getRequestDispatcher("/WEB-INF/views/edit.jsp").forward(req, resp);
    }

    private void handleEditSave(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String recordIdStr = req.getParameter("recordId");
        if (recordIdStr == null || recordIdStr.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/detail/list");
            return;
        }
        Integer recordId = Integer.parseInt(recordIdStr);

        OrderDetailVO existing = detailDao.findById(recordId);
        if (existing == null) {
            resp.sendRedirect(req.getContextPath() + "/detail/list");
            return;
        }

        OrderDetailVO d = new OrderDetailVO();
        populateFromRequest(d, req);
        d.setRecordId(recordId);
        d.setOriginalPrice(existing.getOriginalPrice());

        if (d.getIsGift() != null && d.getIsGift()) {
            d.setRealPrice(BigDecimal.ZERO.setScale(1));
        }

        detailDao.update(d);
        req.getSession().setAttribute("msg", "✅ 订单明细更新成功！");
        resp.sendRedirect(req.getContextPath() + "/detail/list");
    }

    private void handleView(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String recordIdStr = req.getParameter("recordId");
        if (recordIdStr == null || recordIdStr.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/detail/list");
            return;
        }
        Integer recordId = Integer.parseInt(recordIdStr);
        OrderDetailVO detail = detailDao.findById(recordId);
        if (detail == null) {
            resp.sendRedirect(req.getContextPath() + "/detail/list");
            return;
        }
        req.setAttribute("detail", detail);
        req.getRequestDispatcher("/WEB-INF/views/view.jsp").forward(req, resp);
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String recordIdStr = req.getParameter("recordId");
        if (recordIdStr != null && !recordIdStr.isEmpty()) {
            Integer recordId = Integer.parseInt(recordIdStr);
            detailDao.deleteById(recordId);
            req.getSession().setAttribute("msg", "🗑️ 订单明细已删除");
        }
        resp.sendRedirect(req.getContextPath() + "/detail/list");
    }

    private void populateFromRequest(OrderDetailVO d, HttpServletRequest req) {
        d.setOrderId(req.getParameter("orderId"));
        d.setProductId(req.getParameter("productId"));
        d.setProductName(req.getParameter("productName"));
        d.setWebLink(req.getParameter("webLink"));
        d.setPicUrl(req.getParameter("picUrl"));

        String isGift = req.getParameter("isGift");
        d.setIsGift("on".equals(isGift) || "1".equals(isGift) || "true".equals(isGift));

        String origPrice = req.getParameter("originalPrice");
        if (origPrice != null && !origPrice.isEmpty()) d.setOriginalPrice(new BigDecimal(origPrice));

        String realPrice = req.getParameter("realPrice");
        if (realPrice != null && !realPrice.isEmpty()) d.setRealPrice(new BigDecimal(realPrice));

        String isVaccum = req.getParameter("isVaccum");
        d.setIsVaccum("on".equals(isVaccum) || "1".equals(isVaccum) || "true".equals(isVaccum));

        String isKeepWarm = req.getParameter("isKeepWarm");
        d.setIsKeepWarm("on".equals(isKeepWarm) || "1".equals(isKeepWarm) || "true".equals(isKeepWarm));

        String qty = req.getParameter("quantity");
        if (qty != null && !qty.isEmpty()) d.setQuantity(Integer.parseInt(qty));

        String score = req.getParameter("increasedScore");
        if (score != null && !score.isEmpty()) d.setIncreasedScore(Integer.parseInt(score));

        String dateStr = req.getParameter("purchasingDate");
        if (dateStr != null && !dateStr.isEmpty()) {
            try { d.setPurchasingDate(DATE_FMT.parse(dateStr)); } catch (ParseException ignored) {}
        }

        d.setSpecialRequirement(req.getParameter("specialRequirement"));
        d.setProvider(req.getParameter("provider"));
        d.setRemark(req.getParameter("remark"));
    }
}
