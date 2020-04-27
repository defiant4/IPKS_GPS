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
public class ItemProcurementBean {
    
    
    private String musterRollId;
    private String name;
    private String govtProcCode;
    private String itemType;
    private String itemSubType;
    private String ratePerUnit;
    private String qtyunit;
    private String qty;
    private String total;
    private String commodityId;

    public String getCommodityId() {
        return commodityId;
    }

    public void setCommodityId(String commodityId) {
        this.commodityId = commodityId;
    }
    
    

    public String getMusterRollId() {
        return musterRollId;
    }

    public void setMusterRollId(String musterRollId) {
        this.musterRollId = musterRollId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGovtProcCode() {
        return govtProcCode;
    }

    public void setGovtProcCode(String govtProcCode) {
        this.govtProcCode = govtProcCode;
    }

    public String getItemType() {
        return itemType;
    }

    public void setItemType(String itemType) {
        this.itemType = itemType;
    }

    public String getItemSubType() {
        return itemSubType;
    }

    public void setItemSubType(String itemSubType) {
        this.itemSubType = itemSubType;
    }

    public String getRatePerUnit() {
        return ratePerUnit;
    }

    public void setRatePerUnit(String ratePerUnit) {
        this.ratePerUnit = ratePerUnit;
    }

    public String getQtyunit() {
        return qtyunit;
    }

    public void setQtyunit(String qtyunit) {
        this.qtyunit = qtyunit;
    }

    

    public String getQty() {
        return qty;
    }

    public void setQty(String qty) {
        this.qty = qty;
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }
    
    
    
}
