/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataEntryBean;

/**
 *
 * @author Tcs Help desk122
 */
public class GovtOrderCreationExpenseBean {
    
    private String expense_head;
    private String expense_unit;
    private String expense_rate_per_unit;
    private String expense_total_individual;
    private String expense_total_grand;
    
    private String sell;
    private String deliver;
    private String address;
    private String govtOrderId;
    private String govtOrderCode;

    public String getExpense_total_grand() {
        return expense_total_grand;
    }

    public void setExpense_total_grand(String expense_total_grand) {
        this.expense_total_grand = expense_total_grand;
    }

        public String getSell() {
        return sell;
    }

    public void setSell(String sell) {
        this.sell = sell;
    }

    public String getDeliver() {
        return deliver;
    }

    public void setDeliver(String deliver) {
        this.deliver = deliver;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getGovtOrderId() {
        return govtOrderId;
    }

    public void setGovtOrderId(String govtOrderId) {
        this.govtOrderId = govtOrderId;
    }

    public String getGovtOrderCode() {
        return govtOrderCode;
    }

    public void setGovtOrderCode(String govtOrderCode) {
        this.govtOrderCode = govtOrderCode;
    }

    public String getExpense_total_individual() {
        return expense_total_individual;
    }

    public void setExpense_total_individual(String expense_total_individual) {
        this.expense_total_individual = expense_total_individual;
    }


    public String getExpense_head() {
        return expense_head;
    }

    public void setExpense_head(String expense_head) {
        this.expense_head = expense_head;
    }

    public String getExpense_unit() {
        return expense_unit;
    }

    public void setExpense_unit(String expense_unit) {
        this.expense_unit = expense_unit;
    }

    public String getExpense_rate_per_unit() {
        return expense_rate_per_unit;
    }

    public void setExpense_rate_per_unit(String expense_rate_per_unit) {
        this.expense_rate_per_unit = expense_rate_per_unit;
    }
    
    
    
    
}
