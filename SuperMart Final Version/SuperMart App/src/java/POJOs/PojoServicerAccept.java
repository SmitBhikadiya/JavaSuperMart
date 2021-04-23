
package POJOs;

public class PojoServicerAccept {
    private int said;
    private int servicerid;
    private int ordid;

    public PojoServicerAccept() {
    }

    public PojoServicerAccept(int servicerid, int ordid) {
        this.servicerid = servicerid;
        this.ordid = ordid;
    }

    
    
    public PojoServicerAccept(int said, int servicerid, int ordid) {
        this.said = said;
        this.servicerid = servicerid;
        this.ordid = ordid;
    }

    public int getSaid() {
        return said;
    }

    public void setSaid(int said) {
        this.said = said;
    }

    public int getServicerid() {
        return servicerid;
    }

    public void setServicerid(int servicerid) {
        this.servicerid = servicerid;
    }

    public int getOrdid() {
        return ordid;
    }

    public void setOrdid(int ordid) {
        this.ordid = ordid;
    }
    
    
}


