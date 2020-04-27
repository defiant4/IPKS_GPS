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
public class GovtOrderCreationBean {
    private String govtOrderCode;
    private String desc;
    private String procStartDate;
    private String procEndDate;
    private String grandTotal;
    
    private String itemUnit;
    private String qty;
    private String itemRatePerUnit;
    private String total;
    private String procCommRate;
    private String expenseHead;
    private String expenseUnit;
    private String expenseRatePerUnit;
    private String commodityId;
    private String itemType;
    private String itemSubType;
    private String itemDesc;
    private String subTypeDesc;

    public String getItemDesc() {
        return itemDesc;
    }

    public void setItemDesc(String itemDesc) {
        this.itemDesc = itemDesc;
    }

    public String getSubTypeDesc() {
        return subTypeDesc;
    }

    public void setSubTypeDesc(String subTypeDesc) {
        this.subTypeDesc = subTypeDesc;
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
    
    

    public String getCommodityId() {
        return commodityId;
    }

    public void setCommodityId(String commodityId) {
        this.commodityId = commodityId;
    }

    
    public String getGovtOrderCode() {
        return govtOrderCode;
    }

    public void setGovtOrderCode(String govtOrderCode) {
        this.govtOrderCode = govtOrderCode;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getProcStartDate() {
        return procStartDate;
    }

    public void setProcStartDate(String procStartDate) {
        this.procStartDate = procStartDate;
    }

    public String getProcEndDate() {
        return procEndDate;
    }

    public void setProcEndDate(String procEndDate) {
        this.procEndDate = procEndDate;
    }

    public String getItemUnit() {
        return itemUnit;
    }

    public void setItemUnit(String itemUnit) {
        this.itemUnit = itemUnit;
    }

    public String getQty() {
        return qty;
    }

    public void setQty(String qty) {
        this.qty = qty;
    }

    public String getItemRatePerUnit() {
        return itemRatePerUnit;
    }

    public void setItemRatePerUnit(String itemRatePerUnit) {
        this.itemRatePerUnit = itemRatePerUnit;
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }

    public String getGrandTotal() {
        return grandTotal;
    }

    public void setGrandTotal(String grandTotal) {
        this.grandTotal = grandTotal;
    }

    public String getProcCommRate() {
        return procCommRate;
    }

    public void setProcCommRate(String procCommRate) {
        this.procCommRate = procCommRate;
    }

    public String getExpenseHead() {
        return expenseHead;
    }

    public void setExpenseHead(String expenseHead) {
        this.expenseHead = expenseHead;
    }

    public String getExpenseUnit() {
        return expenseUnit;
    }

    public void setExpenseUnit(String expenseUnit) {
        this.expenseUnit = expenseUnit;
    }

    public String getExpenseRatePerUnit() {
        return expenseRatePerUnit;
    }

    public void setExpenseRatePerUnit(String expenseRatePerUnit) {
        this.expenseRatePerUnit = expenseRatePerUnit;
    }
    
    
}
