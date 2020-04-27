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
public class ProcurementRegisterBean {

    private String procurementId;
    private String procurementCode;
    private String procurementDate;
    private String unit;
    private String ratePerUnit;
    private String baseQty;
    private String qtyAvailable;
    private String toDate;
    private String fromDate;
    private String itemCode;
    private String itemSubTypeCode;
    private String itemCodeAmmend;
    private String itemSubTypeCodeAmmend;

    public String getItemCodeAmmend() {
        return itemCodeAmmend;
    }

    public void setItemCodeAmmend(String itemCodeAmmend) {
        this.itemCodeAmmend = itemCodeAmmend;
    }

    public String getItemSubTypeCodeAmmend() {
        return itemSubTypeCodeAmmend;
    }

    public void setItemSubTypeCodeAmmend(String itemSubTypeCodeAmmend) {
        this.itemSubTypeCodeAmmend = itemSubTypeCodeAmmend;
    }

    public String getProcurementId() {
        return procurementId;
    }

    public void setProcurementId(String procurementId) {
        this.procurementId = procurementId;
    }

    public String getProcurementCode() {
        return procurementCode;
    }

    public void setProcurementCode(String procurementCode) {
        this.procurementCode = procurementCode;
    }

    public String getProcurementDate() {
        return procurementDate;
    }

    public void setProcurementDate(String procurementDate) {
        this.procurementDate = procurementDate;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getRatePerUnit() {
        return ratePerUnit;
    }

    public void setRatePerUnit(String ratePerUnit) {
        this.ratePerUnit = ratePerUnit;
    }

    public String getBaseQty() {
        return baseQty;
    }

    public void setBaseQty(String baseQty) {
        this.baseQty = baseQty;
    }

    public String getQtyAvailable() {
        return qtyAvailable;
    }

    public void setQtyAvailable(String qtyAvailable) {
        this.qtyAvailable = qtyAvailable;
    }

    public String getToDate() {
        return toDate;
    }

    public void setToDate(String toDate) {
        this.toDate = toDate;
    }

    public String getFromDate() {
        return fromDate;
    }

    public void setFromDate(String fromDate) {
        this.fromDate = fromDate;
    }

    public String getItemCode() {
        return itemCode;
    }

    public void setItemCode(String itemCode) {
        this.itemCode = itemCode;
    }

    public String getItemSubTypeCode() {
        return itemSubTypeCode;
    }

    public void setItemSubTypeCode(String itemSubTypeCode) {
        this.itemSubTypeCode = itemSubTypeCode;
    }

}
