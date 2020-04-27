/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package DataEntryBean;

/**
 *
 * @author 590685
 */
public class raiseRequisitionBean {

    private String product;
    private String quantity;
    private String price;
    private String linetotal;
    private String product_id;
    private String stock_quantity;
    private String stock_id;
    private String requisitionId;

    public String getRequisitionId() {
        return requisitionId;
    }

    public void setRequisitionId(String requisitionId) {
        this.requisitionId = requisitionId;
    }

    public String getStock_quantity() {
        return stock_quantity;
    }

    public void setStock_quantity(String stock_quantity) {
        this.stock_quantity = stock_quantity;
    }

    public String getStock_id() {
        return stock_id;
    }

    public void setStock_id(String stock_id) {
        this.stock_id = stock_id;
    }


    public String getLinetotal() {
        return linetotal;
    }

    public void setLinetotal(String linetotal) {
        this.linetotal = linetotal;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getProduct() {
        return product;
    }

    public void setProduct(String product) {
        this.product = product;
    }

    public String getQuantity() {
        return quantity;
    }

    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }

    /**
     * @return the product_id
     */
    public String getProduct_id() {
        return product_id;
    }

    /**
     * @param product_id the product_id to set
     */
    public void setProduct_id(String product_id) {
        this.product_id = product_id;
    }

   

}
