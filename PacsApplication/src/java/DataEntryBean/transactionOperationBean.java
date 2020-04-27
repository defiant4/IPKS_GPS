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
public class transactionOperationBean {

    //For transaction Div 
    private String tranType;
    private String accNo;
    private String trAmount;

    /**
     * @return the tranType
     */
    public String getTranType() {
        return tranType;
    }

    /**
     * @param tranType the tranType to set
     */
    public void setTranType(String tranType) {
        this.tranType = tranType;
    }

    /**
     * @return the accNo
     */
    public String getAccNo() {
        return accNo;
    }

    /**
     * @param accNo the accNo to set
     */
    public void setAccNo(String accNo) {
        this.accNo = accNo;
    }

    /**
     * @return the trAmount
     */
    public String getTrAmount() {
        return trAmount;
    }

    /**
     * @param trAmount the trAmount to set
     */
    public void setTrAmount(String trAmount) {
        this.trAmount = trAmount;
    }

}
