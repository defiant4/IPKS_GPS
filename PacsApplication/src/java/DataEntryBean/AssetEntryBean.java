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
public class AssetEntryBean {
    
    private String asset_type;
    private String asset_subtype;
    private String asset_mst_id;
    private String asset_id;
    private String description;
    private String curr_val;
    private String mode_of_aqr;

    
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

    public String getCurr_val() {
        return curr_val;
    }

    public void setCurr_val(String curr_val) {
        this.curr_val = curr_val;
    }

    public String getAsset_type() {
        return asset_type;
    }

    public void setAsset_type(String asset_type) {
        this.asset_type = asset_type;
    }

    public String getAsset_subtype() {
        return asset_subtype;
    }

    public void setAsset_subtype(String asset_subtype) {
        this.asset_subtype = asset_subtype;
    }

    public String getAsset_mst_id() {
        return asset_mst_id;
    }

    public void setAsset_mst_id(String asset_mst_id) {
        this.asset_mst_id = asset_mst_id;
    }

    public String getMode_of_aqr() {
        return mode_of_aqr;
    }

    public void setMode_of_aqr(String mode_of_aqr) {
        this.mode_of_aqr = mode_of_aqr;
    }
    
    
    
}
