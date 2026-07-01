package com.order.dao;

import com.order.dto.OrderDetailVO;
import com.order.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDetailDao {

    public List<OrderDetailVO> findAll(boolean asc) {
        String sql = "SELECT * FROM order_details ORDER BY OrderID " + (asc ? "ASC" : "DESC");
        return queryList(sql, null);
    }

    public List<OrderDetailVO> search(String keyword, String orderId, String productName, boolean asc) {
        StringBuilder sql = new StringBuilder("SELECT * FROM order_details WHERE 1=1");
        List<Object> params = new ArrayList<>();
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (OrderID LIKE ? OR ProductID LIKE ? OR ProductName LIKE ? OR Provider LIKE ?)");
            String kw = "%" + keyword.trim() + "%";
            params.add(kw); params.add(kw); params.add(kw); params.add(kw);
        }
        if (orderId != null && !orderId.trim().isEmpty()) {
            sql.append(" AND OrderID LIKE ?");
            params.add("%" + orderId.trim() + "%");
        }
        if (productName != null && !productName.trim().isEmpty()) {
            sql.append(" AND ProductName LIKE ?");
            params.add("%" + productName.trim() + "%");
        }
        sql.append(" ORDER BY OrderID ").append(asc ? "ASC" : "DESC");
        return queryList(sql.toString(), params.toArray());
    }

    public OrderDetailVO findById(Integer recordId) {
        String sql = "SELECT * FROM order_details WHERE RecordID = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, recordId);
            rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, ps, rs);
        }
        return null;
    }

    public String getMaxOrderId() {
        String sql = "SELECT MAX(OrderID) FROM order_details";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getString(1);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, ps, rs);
        }
        return null;
    }

    public int insert(OrderDetailVO d) {
        String sql = "INSERT INTO order_details (" +
            "OrderID, ProductID, ProductName, WebLink, Pic_Url, IsGift, " +
            "OriginalPrice, RealPrice, IsVaccum, IsKeepWarm, Quantity, " +
            "IncreasedScore, PurchasingDate, SpecialRequirement, Provider, Remark" +
            ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return executeUpdate(sql, buildParams(d));
    }

    public int update(OrderDetailVO d) {
        String sql = "UPDATE order_details SET " +
            "OrderID=?, ProductID=?, ProductName=?, WebLink=?, Pic_Url=?, IsGift=?, " +
            "OriginalPrice=?, RealPrice=?, IsVaccum=?, IsKeepWarm=?, Quantity=?, " +
            "IncreasedScore=?, PurchasingDate=?, SpecialRequirement=?, Provider=?, Remark=? " +
            "WHERE RecordID=?";
        Object[] base = buildParams(d);
        Object[] params = new Object[base.length + 1];
        System.arraycopy(base, 0, params, 0, base.length);
        params[base.length] = d.getRecordId();
        return executeUpdate(sql, params);
    }

    public int deleteById(Integer recordId) {
        String sql = "DELETE FROM order_details WHERE RecordID = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, recordId);
            return ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, ps, null);
        }
        return 0;
    }

    private List<OrderDetailVO> queryList(String sql, Object[] params) {
        List<OrderDetailVO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            if (params != null) {
                for (int i = 0; i < params.length; i++) ps.setObject(i + 1, params[i]);
            }
            rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, ps, rs);
        }
        return list;
    }

    private int executeUpdate(String sql, Object[] params) {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            for (int i = 0; i < params.length; i++) ps.setObject(i + 1, params[i]);
            return ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, ps, null);
        }
        return 0;
    }

    private Object[] buildParams(OrderDetailVO d) {
        return new Object[] {
            d.getOrderId(), d.getProductId(), d.getProductName(),
            d.getWebLink(), d.getPicUrl(),
            d.getIsGift() != null && d.getIsGift() ? 1 : 0,
            d.getOriginalPrice(), d.getRealPrice(),
            d.getIsVaccum() != null && d.getIsVaccum() ? 1 : 0,
            d.getIsKeepWarm() != null && d.getIsKeepWarm() ? 1 : 0,
            d.getQuantity(), d.getIncreasedScore(),
            d.getPurchasingDate() != null ? new java.sql.Date(d.getPurchasingDate().getTime()) : null,
            d.getSpecialRequirement(), d.getProvider(), d.getRemark()
        };
    }

    private OrderDetailVO mapRow(ResultSet rs) throws SQLException {
        OrderDetailVO d = new OrderDetailVO();
        d.setRecordId(rs.getInt("RecordID"));
        d.setOrderId(rs.getString("OrderID"));
        d.setProductId(rs.getString("ProductID"));
        d.setProductName(rs.getString("ProductName"));
        d.setWebLink(rs.getString("WebLink"));
        d.setPicUrl(rs.getString("Pic_Url"));
        d.setIsGift(rs.getInt("IsGift") == 1);
        d.setOriginalPrice(rs.getBigDecimal("OriginalPrice"));
        d.setRealPrice(rs.getBigDecimal("RealPrice"));
        d.setIsVaccum(rs.getInt("IsVaccum") == 1);
        d.setIsKeepWarm(rs.getInt("IsKeepWarm") == 1);
        d.setQuantity(rs.getInt("Quantity"));
        d.setIncreasedScore(rs.getInt("IncreasedScore"));
        d.setPurchasingDate(rs.getDate("PurchasingDate"));
        d.setSpecialRequirement(rs.getString("SpecialRequirement"));
        d.setProvider(rs.getString("Provider"));
        d.setRemark(rs.getString("Remark"));
        d.setCreateTime(rs.getTimestamp("CreateTime"));
        d.setUpdateTime(rs.getTimestamp("UpdateTime"));
        return d;
    }
}
