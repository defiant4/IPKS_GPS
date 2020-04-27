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
public class AssetRegisterBean {
    
    private String asset_type;
    private String asset_subtypoe;
    private String asset_mst_id;
    

    private String asset_id;
    private String int_value;
    private String pres_val;
    private String description;
    private String mode_of_aqr;
    private String detail_id;
    private String status;
    private String entry_date;

    public String getEntry_date() {
        return entry_date;
    }

    public void setEntry_date(String entry_date) {
        this.entry_date = entry_date;
    }
    
    
    public String getDetail_id() {
        return detail_id;
    }

    public void setDetail_id(String detail_id) {
        this.detail_id = detail_id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
    public String getInt_value() {
        return int_value;
    }

    public void setInt_value(String int_value) {
        this.int_value = int_value;
    }

    public String getPres_val() {
        return pres_val;
    }

    public void setPres_val(String pres_val) {
        this.pres_val = pres_val;
    }



    public String getAsset_id() {
        return asset_id;
    }

    public void setAsset_id(String asset_id) {
        this.asset_id = asset_id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    
    public String getMode_of_aqr() {
        return mode_of_aqr;
    }

    public void setMode_of_aqr(String mode_of_aqr) {
        this.mode_of_aqr = mode_of_aqr;
    }
   
  

    public String getAsset_type() {
        return asset_type;
    }

    public void setAsset_type(String asset_type) {
        this.asset_type = asset_type;
    }

    public String getAsset_subtypoe() {
        return asset_subtypoe;
    }

    public void setAsset_subtypoe(String asset_subtypoe) {
        this.asset_subtypoe = asset_subtypoe;
    }

    public String getAsset_mst_id() {
        return asset_mst_id;
    }

    public void setAsset_mst_id(String asset_mst_id) {
        this.asset_mst_id = asset_mst_id;
    }
    
}
