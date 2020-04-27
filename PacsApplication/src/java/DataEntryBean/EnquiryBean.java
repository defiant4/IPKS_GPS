/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataEntryBean;

/**
 *
 * @author Shubhrangshu
 */
public class EnquiryBean {
    
    public String accountNo;
    public String fromDate;
    public String toDate;
    public String productName;
    public String fromAmount;
    public String toAmount;
    public String productId;
    public String productCode;
    
    public String linkedSbAccount;

    //for display
    public String accountOpenDate;
    public String availBalance;
    public String customerNo;
    public String sanctionAmount;
    public String screenName;
    public String prinOutstanding;
    public String inttOutstanding;
    public String penalIntt;
    public String customerName;
    
    //added later
    public String productNameDisplay;
    public String limitExpiryDate;
    public String prinPaid;
    public String inttPaid;
    public String penalInttOutstanding;
    public String linkAccNo;
    

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
     * @return the accountOpenDate
     */
    public String getAccountOpenDate() {
        return accountOpenDate;
    }

    /**
     * @param accountOpenDate the accountOpenDate to set
     */
    public void setAccountOpenDate(String accountOpenDate) {
        this.accountOpenDate = accountOpenDate;
    }

    /**
     * @return the availBalance
     */
    public String getAvailBalance() {
        return availBalance;
    }

    /**
     * @param availBalance the availBalance to set
     */
    public void setAvailBalance(String availBalance) {
        this.availBalance = availBalance;
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
     * @return the customerNo
     */
    public String getCustomerNo() {
        return customerNo;
    }

    /**
     * @param customerNo the customerNo to set
     */
    public void setCustomerNo(String customerNo) {
        this.customerNo = customerNo;
    }

    /**
     * @return the sanctionAmount
     */
    public String getSanctionAmount() {
        return sanctionAmount;
    }

    /**
     * @param sanctionAmount the sanctionAmount to set
     */
    public void setSanctionAmount(String sanctionAmount) {
        this.sanctionAmount = sanctionAmount;
    }

    /**
     * @return the screenName
     */
    public String getScreenName() {
        return screenName;
    }

    /**
     * @param screenName the screenName to set
     */
    public void setScreenName(String screenName) {
        this.screenName = screenName;
    }

    /**
     * @return the prinOutstanding
     */
    public String getPrinOutstanding() {
        return prinOutstanding;
    }

    /**
     * @param prinOutstanding the prinOutstanding to set
     */
    public void setPrinOutstanding(String prinOutstanding) {
        this.prinOutstanding = prinOutstanding;
    }

    /**
     * @return the inttOutstanding
     */
    public String getInttOutstanding() {
        return inttOutstanding;
    }

    /**
     * @param inttOutstanding the inttOutstanding to set
     */
    public void setInttOutstanding(String inttOutstanding) {
        this.inttOutstanding = inttOutstanding;
    }

    /**
     * @return the penalIntt
     */
    public String getPenalIntt() {
        return penalIntt;
    }

    /**
     * @param penalIntt the penalIntt to set
     */
    public void setPenalIntt(String penalIntt) {
        this.penalIntt = penalIntt;
    }

    /**
     * @return the customerName
     */
    public String getCustomerName() {
        return customerName;
    }

    /**
     * @param customerName the customerName to set
     */
    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }
    
    /**
     * @return the productId
     */
    public String getProductId() {
        return productId;
    }

    /**
     * @param productId the productId to set
     */
    public void setProductId(String productId) {
        this.productId = productId;
    }

    /**
     * @return the limitExpiryDate
     */
    public String getLimitExpiryDate() {
        return limitExpiryDate;
    }

    /**
     * @param limitExpiryDate the limitExpiryDate to set
     */
    public void setLimitExpiryDate(String limitExpiryDate) {
        this.limitExpiryDate = limitExpiryDate;
    }

    /**
     * @return the prinPaid
     */
    public String getPrinPaid() {
        return prinPaid;
    }

    /**
     * @param prinPaid the prinPaid to set
     */
    public void setPrinPaid(String prinPaid) {
        this.prinPaid = prinPaid;
    }

    /**
     * @return the inttPaid
     */
    public String getInttPaid() {
        return inttPaid;
    }

    /**
     * @param inttPaid the inttPaid to set
     */
    public void setInttPaid(String inttPaid) {
        this.inttPaid = inttPaid;
    }

    /**
     * @return the penalInttOutstanding
     */
    public String getPenalInttOutstanding() {
        return penalInttOutstanding;
    }

    /**
     * @param penalInttOutstanding the penalInttOutstanding to set
     */
    public void setPenalInttOutstanding(String penalInttOutstanding) {
        this.penalInttOutstanding = penalInttOutstanding;
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

    /**
     * @return the productNameDisplay
     */
    public String getProductNameDisplay() {
        return productNameDisplay;
    }

    /**
     * @param productNameDisplay the productNameDisplay to set
     */
    public void setProductNameDisplay(String productNameDisplay) {
        this.productNameDisplay = productNameDisplay;
    }
    
    public String getLinkAccNo() {
        return linkAccNo;
    }

    /**
     * @param productNameDisplay the productNameDisplay to set
     */
    public void setLinkAccNo(String linkAccNo) {
        this.linkAccNo = linkAccNo;
    }

}
