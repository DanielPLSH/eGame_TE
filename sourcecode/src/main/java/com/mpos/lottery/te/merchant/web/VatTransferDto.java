package com.mpos.lottery.te.merchant.web;

import java.math.BigDecimal;

public class VatTransferDto {
    public static final int CREDITTYPE_SALE = 1;
    public static final int CREDITTYPE_PAYOUT = 2;
    private String fromOperatorLoginName;
    private String toOperatorLoginName;
    private int creditType = CREDITTYPE_SALE;
    private BigDecimal amount = new BigDecimal("0");
    private BigDecimal creditBalanceOfFromOperator = new BigDecimal("0");
    private BigDecimal creditBalanceOfToOperator = new BigDecimal("0");

    public String getFromOperatorLoginName() {
        return fromOperatorLoginName;
    }

    public void setFromOperatorLoginName(String fromOperatorLoginName) {
        this.fromOperatorLoginName = fromOperatorLoginName;
    }

    public String getToOperatorLoginName() {
        return toOperatorLoginName;
    }

    public void setToOperatorLoginName(String toOperatorLoginName) {
        this.toOperatorLoginName = toOperatorLoginName;
    }

    public int getCreditType() {
        return creditType;
    }

    public void setCreditType(int creditType) {
        this.creditType = creditType;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public BigDecimal getCreditBalanceOfFromOperator() {
        return creditBalanceOfFromOperator;
    }

    public void setCreditBalanceOfFromOperator(BigDecimal creditBalanceOfFromOperator) {
        this.creditBalanceOfFromOperator = creditBalanceOfFromOperator;
    }

    public BigDecimal getCreditBalanceOfToOperator() {
        return creditBalanceOfToOperator;
    }

    public void setCreditBalanceOfToOperator(BigDecimal creditBalanceOfToOperator) {
        this.creditBalanceOfToOperator = creditBalanceOfToOperator;
    }
}
