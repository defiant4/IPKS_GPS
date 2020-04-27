/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package DataEntryBean;

/**
 *
 * @author 590685
 */
public class tradingProductCreationBean {


    private String status;
    private String productName;
    private String productCode;
    private String unit;
    private String inventorySearch;
    private String statusAmend;
    private String productNameAmend;
    private String productCodeAmend;
    private String unitAmend;
    private String product_id;
    private String productCodeActivation;
    private String profitFactorAmend;
    private String profitFactor;

    
    public String getInventorySearch() {
        return inventorySearch;
    }

    public void setInventorySearch(String inventorySearch) {
        this.inventorySearch = inventorySearch;
    }

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    public String getProductCodeActivation() {
        return productCodeActivation;
    }

    public void setProductCodeActivation(String productCodeActivation) {
        this.productCodeActivation = productCodeActivation;
    }

    public String getProductCodeAmend() {
        return productCodeAmend;
    }

    public void setProductCodeAmend(String productCodeAmend) {
        this.productCodeAmend = productCodeAmend;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductNameAmend() {
        return productNameAmend;
    }

    public void setProductNameAmend(String productNameAmend) {
        this.productNameAmend = productNameAmend;
    }

    public String getProduct_id() {
        return product_id;
    }

    public void setProduct_id(String product_id) {
        this.product_id = product_id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStatusAmend() {
        return statusAmend;
    }

    public void setStatusAmend(String statusAmend) {
        this.statusAmend = statusAmend;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getUnitAmend() {
        return unitAmend;
    }

    public void setUnitAmend(String unitAmend) {
        this.unitAmend = unitAmend;
    }

    /**
     * @return the profitFactorAmend
     */
    public String getProfitFactorAmend() {
        return profitFactorAmend;
    }

    /**
     * @param profitFactorAmend the profitFactorAmend to set
     */
    public void setProfitFactorAmend(String profitFactorAmend) {
        this.profitFactorAmend = profitFactorAmend;
    }

    /**
     * @return the profitFactor
     */
    public String getProfitFactor() {
        return profitFactor;
    }

    /**
     * @param profitFactor the profitFactor to set
     */
    public void setProfitFactor(String profitFactor) {
        this.profitFactor = profitFactor;
    }


}
