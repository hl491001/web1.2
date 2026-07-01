package com.order.entity;

import java.math.BigDecimal;
import java.util.Date;

public class OrderDetail {

    private Integer recordId;
    private String orderId;
    private String productId;
    private String productName;
    private String webLink;
    private String picUrl;
    private Boolean isGift;
    private BigDecimal originalPrice;
    private BigDecimal realPrice;
    private Boolean isVaccum;
    private Boolean isKeepWarm;
    private Integer quantity;
    private Integer increasedScore;
    private Date purchasingDate;
    private String specialRequirement;
    private String provider;
    private String remark;
    private Date createTime;
    private Date updateTime;

    public Integer getRecordId() { return recordId; }
    public void setRecordId(Integer recordId) { this.recordId = recordId; }
    public String getOrderId() { return orderId; }
    public void setOrderId(String orderId) { this.orderId = orderId; }
    public String getProductId() { return productId; }
    public void setProductId(String productId) { this.productId = productId; }
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public String getWebLink() { return webLink; }
    public void setWebLink(String webLink) { this.webLink = webLink; }
    public String getPicUrl() { return picUrl; }
    public void setPicUrl(String picUrl) { this.picUrl = picUrl; }
    public Boolean getIsGift() { return isGift; }
    public void setIsGift(Boolean isGift) { this.isGift = isGift; }
    public BigDecimal getOriginalPrice() { return originalPrice; }
    public void setOriginalPrice(BigDecimal originalPrice) { this.originalPrice = originalPrice; }
    public BigDecimal getRealPrice() { return realPrice; }
    public void setRealPrice(BigDecimal realPrice) { this.realPrice = realPrice; }
    public Boolean getIsVaccum() { return isVaccum; }
    public void setIsVaccum(Boolean isVaccum) { this.isVaccum = isVaccum; }
    public Boolean getIsKeepWarm() { return isKeepWarm; }
    public void setIsKeepWarm(Boolean isKeepWarm) { this.isKeepWarm = isKeepWarm; }
    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }
    public Integer getIncreasedScore() { return increasedScore; }
    public void setIncreasedScore(Integer increasedScore) { this.increasedScore = increasedScore; }
    public Date getPurchasingDate() { return purchasingDate; }
    public void setPurchasingDate(Date purchasingDate) { this.purchasingDate = purchasingDate; }
    public String getSpecialRequirement() { return specialRequirement; }
    public void setSpecialRequirement(String specialRequirement) { this.specialRequirement = specialRequirement; }
    public String getProvider() { return provider; }
    public void setProvider(String provider) { this.provider = provider; }
    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    public Date getUpdateTime() { return updateTime; }
    public void setUpdateTime(Date updateTime) { this.updateTime = updateTime; }
}
