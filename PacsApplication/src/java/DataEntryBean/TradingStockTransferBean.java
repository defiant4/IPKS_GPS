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
public class TradingStockTransferBean {
    
    private String fromPacsId;
    private String toPacsId;
    private String productId;
    private String sellingRate;
    private String quantity;
    private String transportationType;
    private String transportationCost;
    private String transferDate;
    private String total;
    private String stockId;
    
    
    private String product_name;
    private String product_code;
    private String from_date;
    private String to_date;

    public String getFrom_date() {
        return from_date;
    }

    public void setFrom_date(String from_date) {
        this.from_date = from_date;
    }

    public String getTo_date() {
        return to_date;
    }

    public void setTo_date(String to_date) {
        this.to_date = to_date;
    }
    
    
    
    public String getProduct_name() {
        return product_name;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    public String getProduct_code() {
        return product_code;
    }

    public void setProduct_code(String product_code) {
        this.product_code = product_code;
    }

    
    
    public String getStockId() {
        return stockId;
    }

    public void setStockId(String stockId) {
        this.stockId = stockId;
    }
    

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }
    

    public String getFromPacsId() {
        return fromPacsId;
    }

    public void setFromPacsId(String fromPacsId) {
        this.fromPacsId = fromPacsId;
    }

    public String getToPacsId() {
        return toPacsId;
    }

    public void setToPacsId(String toPacsId) {
        this.toPacsId = toPacsId;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getSellingRate() {
        return sellingRate;
    }

    public void setSellingRate(String sellingRate) {
        this.sellingRate = sellingRate;
    }

    public String getQuantity() {
        return quantity;
    }

    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }

    public String getTransportationType() {
        return transportationType;
    }

    public void setTransportationType(String transportationType) {
        this.transportationType = transportationType;
    }

    public String getTransportationCost() {
        return transportationCost;
    }

    public void setTransportationCost(String transportationCost) {
        this.transportationCost = transportationCost;
    }

    public String getTransferDate() {
        return transferDate;
    }

    public void setTransferDate(String transferDate) {
        this.transferDate = transferDate;
    }
    
    
    
}
