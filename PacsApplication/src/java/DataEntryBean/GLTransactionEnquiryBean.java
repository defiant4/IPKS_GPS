/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataEntryBean;

/**
 *
 * @author Kaushik
 */
public class GLTransactionEnquiryBean {
    
    private String accountNo;
    private String productName; //Prod_id
    private String fromDate;
    private String toDate;
    private String fromAmount;
    private String toAmount;
    
    //for display
    private String cbs_Ref_No;
    private String transactionDate;
    private String transactionType;
    private String transactionAmount;
    private String journalNumber;
    private String screenName;
    private String productCode;
    private String productId;
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
     * @return the cbs_Ref_No
     */
    public String getCbs_Ref_No() {
        return cbs_Ref_No;
    }

    /**
     * @param cbs_Ref_No the cbs_Ref_No to set
     */
    public void setCbs_Ref_No(String cbs_Ref_No) {
        this.cbs_Ref_No = cbs_Ref_No;
    }

    /**
     * @return the transactionDate
     */
    public String getTransactionDate() {
        return transactionDate;
    }

    /**
     * @param transactionDate the transactionDate to set
     */
    public void setTransactionDate(String transactionDate) {
        this.transactionDate = transactionDate;
    }

    /**
     * @return the transactionType
     */
    public String getTransactionType() {
        return transactionType;
    }

    /**
     * @param transactionType the transactionType to set
     */
    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }

    /**
     * @return the transactionAmount
     */
    public String getTransactionAmount() {
        return transactionAmount;
    }

    /**
     * @param transactionAmount the transactionAmount to set
     */
    public void setTransactionAmount(String transactionAmount) {
        this.transactionAmount = transactionAmount;
    }

    /**
     * @return the journalNumber
     */
    public String getJournalNumber() {
        return journalNumber;
    }

    /**
     * @param journalNumber the journalNumber to set
     */
    public void setJournalNumber(String journalNumber) {
        this.journalNumber = journalNumber;
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
     * @return the productCode
     */
    public String getProductCode() {
        return productCode;
    }

    /**
     * @param productCode the productCode to set
     */
    public void setProductCode(String productCode) {
        this.productCode = productCode;
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
    
}
