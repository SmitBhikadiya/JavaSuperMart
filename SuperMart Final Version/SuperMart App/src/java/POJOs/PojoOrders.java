
package POJOs;

public class PojoOrders {
    private int ordid;
    private int strid;
    private int cstmid;
    private String paymentmethod;
    private int ordtotalbill;
    private int ordcharge;

    public PojoOrders() {
    }

    public PojoOrders(int strid, int cstmid) {
        this.strid = strid;
        this.cstmid = cstmid;
    }

    public PojoOrders(int strid, int cstmid, String paymentmethod, int ordtotalbill) {
        this.strid = strid;
        this.cstmid = cstmid;
        this.paymentmethod = paymentmethod;
        this.ordtotalbill = ordtotalbill;
    }

    public int getOrdcharge() {
        return ordcharge;
    }

    public void setOrdcharge(int ordcharge) {
        this.ordcharge = ordcharge;
    }
    
    
    public int getOrdid() {
        return ordid;
    }

    public void setOrdid(int ordid) {
        this.ordid = ordid;
    }

    public int getStrid() {
        return strid;
    }

    public void setStrid(int strid) {
        this.strid = strid;
    }

    public int getCstmid() {
        return cstmid;
    }

    public void setCstmid(int cstmid) {
        this.cstmid = cstmid;
    }

    public String getPaymentmethod() {
        return paymentmethod;
    }

    public void setPaymentmethod(String paymentmethod) {
        this.paymentmethod = paymentmethod;
    }

    public int getOrdtotalbill() {
        return ordtotalbill;
    }

    public void setOrdtotalbill(int ordtotalbill) {
        this.ordtotalbill = ordtotalbill;
    }
    
    
}
