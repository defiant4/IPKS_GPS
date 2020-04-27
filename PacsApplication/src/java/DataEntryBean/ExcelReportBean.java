/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataEntryBean;

/**
 *
 * @author Tcs Helpdesk10
 */
public class ExcelReportBean {

    public String accountNo;
    public String productName; //Prod_id
    public String fromDate;
    public String toDate;
    public String fromAmount;
    public String toAmount;
    private String linkedSbAccount;

    /**
     * @return the accountNo
     */
    public String getAccountNo() {
        return accountNo;
    }

    /**
     * @param accountNo the accountNo to set
     */
    public void setAccountNo(String accountNo) {
        this.accountNo = accountNo;
    }

    /**
     * @return the productName
     */
    public String getProductName() {
        return productName;
    }

    /**
     * @param productName the productName to set
     */
    public void setProductName(String productName) {
        this.productName = productName;
    }

    /**
     * @return the fromDate
     */
    public String getFromDate() {
        return fromDate;
    }

    /**
     * @param fromDate the fromDate to set
     */
    public void setFromDate(String fromDate) {
        this.fromDate = fromDate;
    }

    /**
     * @return the toDate
     */
    public String getToDate() {
        return toDate;
    }

    /**
     * @param toDate the toDate to set
     */
    public void setToDate(String toDate) {
        this.toDate = toDate;
    }

    /**
     * @return the fromAmount
     */
    public String getFromAmount() {
        return fromAmount;
    }

    /**
     * @param fromAmount the fromAmount to set
     */
    public void setFromAmount(String fromAmount) {
        this.fromAmount = fromAmount;
    }

    /**
     * @return the toAmount
     */
    public String getToAmount() {
        return toAmount;
    }

    /**
     * @param toAmount the toAmount to set
     */
    public void setToAmount(String toAmount) {
        this.toAmount = toAmount;
    }

    /**
     * @return the linkedSbAccount
     */
    public String getLinkedSbAccount() {
        return linkedSbAccount;
    }

    /**
     * @param linkedSbAccount the linkedSbAccount to set
     */
    public void setLinkedSbAccount(String linkedSbAccount) {
        this.linkedSbAccount = linkedSbAccount;
    }

}
