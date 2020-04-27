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
public class CBSDataPostingBean {
    
    private String serialNumber;
    private String fileName;
    private String uploadStatus;
    private String dccbName;

    /**
     * @return the serialNumber
     */
    public String getSerialNumber() {
        return serialNumber;
    }

    /**
     * @param serialNumber the serialNumber to set
     */
    public void setSerialNumber(String serialNumber) {
        this.serialNumber = serialNumber;
    }

    /**
     * @return the fileName
     */
    public String getFileName() {
        return fileName;
    }

    /**
     * @param fileName the fileName to set
     */
    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    /**
     * @return the uploadStatus
     */
    public String getUploadStatus() {
        return uploadStatus;
    }

    /**
     * @param uploadStatus the uploadStatus to set
     */
    public void setUploadStatus(String uploadStatus) {
        this.uploadStatus = uploadStatus;
    }

    /**
     * @return the dccbName
     */
    public String getDccbName() {
        return dccbName;
    }

    /**
     * @param dccbName the dccbName to set
     */
    public void setDccbName(String dccbName) {
        this.dccbName = dccbName;
    }
    
}
