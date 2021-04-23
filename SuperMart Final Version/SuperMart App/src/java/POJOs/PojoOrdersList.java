
package POJOs;

public class PojoOrdersList {
    private int ordlistid;
    private int ordid;
    private int prdid;
    private int prdqty;
    private int prdtotalamount;

    public PojoOrdersList() {
    }

    public PojoOrdersList(int ordid, int prdid) {
        this.ordid = ordid;
        this.prdid = prdid;
    }

    public PojoOrdersList(int ordid, int prdid, int prdqty, int prdtotalamount) {
        this.ordid = ordid;
        this.prdid = prdid;
        this.prdqty = prdqty;
        this.prdtotalamount = prdtotalamount;
    }
    
    public int getOrdid() {
        return ordid;
    }

    public void setOrdid(int ordid) {
        this.ordid = ordid;
    }

    public int getOrdlistid() {
        return ordlistid;
    }

    public void setOrdlistid(int ordlistid) {
        this.ordlistid = ordlistid;
    }

    public int getPrdid() {
        return prdid;
    }

    public void setPrdid(int prdid) {
        this.prdid = prdid;
    }

    public int getPrdqty() {
        return prdqty;
    }

    public void setPrdqty(int prdqty) {
        this.prdqty = prdqty;
    }

    public int getPrdtotalamount() {
        return prdtotalamount;
    }

    public void setPrdtotalamount(int prdtotalamount) {
        this.prdtotalamount = prdtotalamount;
    }
    
    
}
