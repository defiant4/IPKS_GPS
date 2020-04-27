/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataEntryBean;

import java.io.Serializable;
import java.lang.reflect.Method;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Tcs Helpdesk10
 */
public class JasperReportBean {



    private String downloadOption;
    private String pacs_id ;
    private String txn_date;
    private String dccb_code;
    private String requisitionId;
    private String from_Date;
    private String to_Date;

    public String getFrom_Date() {
        return from_Date;
    }

    public void setFrom_Date(String from_Date) {
        this.from_Date = from_Date;
    }

    public String getTo_Date() {
        return to_Date;
    }

    public void setTo_Date(String to_Date) {
        this.to_Date = to_Date;
    }
       

    public String getRequisitionId() {
        return requisitionId;
    }

    public void setRequisitionId(String requisitionId) {
        this.requisitionId = requisitionId;
    }

    
    public String getDownloadOption() {
        return downloadOption;
    }

    public void setDownloadOption(String newDownloadOption) {
        this.downloadOption = newDownloadOption;
    }

    /**
     * @return the pacs_id
     */
    public String getPacs_id() {
        return pacs_id;
    }

    /**
     * @param pacs_id the pacs_id to set
     */
    public void setPacs_id(String pacs_id) {
        this.pacs_id = pacs_id;
    }

    /**
     * @return the txn_date
     */
    public String getTxn_date() {
        return txn_date;
    }

    /**
     * @param txn_date the txn_date to set
     */
    public void setTxn_date(String txn_date) {
        this.txn_date = txn_date;
    }

    /**
     * @return the dccb_code
     */
    public String getDccb_code() {
        return dccb_code;
    }

    /**
     * @param dccb_code the dccb_code to set
     */
    public void setDccb_code(String dccb_code) {
        this.dccb_code = dccb_code;
    } 
    
    
    
    public Serializable getData(HttpServletRequest req) {
        HashMap data = new HashMap();
        Class BeanClass = this.getClass();
        //if (logger.isInfoEnabled()) logger.info("Form Bean Class "+formBeanClass);
        Method[] methods = BeanClass.getDeclaredMethods();
        Object val;
        String methodName;
        StringBuffer fieldName = new StringBuffer();
        for (int i = 0; i < methods.length; i++) {
            methodName = methods[i].getName();
            if (!methodName.startsWith("get")) {
                continue;
            }
            if (methods[i].getParameterTypes().length > 0) {
                continue;
            }
            try {
                val = methods[i].invoke(this, null);
                if (null != val && val instanceof String && ((String) val).trim().length() == 0) {
                    val = null;
                }

                fieldName.append(methodName.substring(3, 4).toLowerCase());
                fieldName.append(methodName.substring(4));

                data.put(fieldName.toString(), val);
                fieldName.delete(0, fieldName.length());
            } catch (Exception e) {
                e.printStackTrace();

            }
        }
        return (Serializable) data;
    }

   }
