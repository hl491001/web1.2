package com.order.dto;

import com.order.entity.OrderDetail;
import java.math.BigDecimal;
import java.math.RoundingMode;

public class OrderDetailVO extends OrderDetail {

    public BigDecimal getReducedMoney() {
        BigDecimal orig = getOriginalPrice();
        BigDecimal real = getRealPrice();
        if (orig == null || real == null) return BigDecimal.ZERO.setScale(1);
        return orig.subtract(real).setScale(1, RoundingMode.HALF_UP);
    }

    public BigDecimal getSubtotal() {
        BigDecimal real = getRealPrice();
        Integer qty = getQuantity();
        if (real == null || qty == null) return BigDecimal.ZERO.setScale(2);
        return real.multiply(new BigDecimal(qty)).setScale(2, RoundingMode.HALF_UP);
    }
}
