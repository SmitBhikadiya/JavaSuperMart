
package POJOs;

public class PojoServicerHistory {
    private int servicerid;
    private int ordhistoryid;
    private int strid;

    public PojoServicerHistory() {
    }

    public PojoServicerHistory(int servicerid, int ordhistoryid, int strid) {
        this.servicerid = servicerid;
        this.ordhistoryid = ordhistoryid;
        this.strid = strid;
    }

    public int getServicerid() {
        return servicerid;
    }

    public void setServicerid(int servicerid) {
        this.servicerid = servicerid;
    }

    public int getOrdhistoryid() {
        return ordhistoryid;
    }

    public void setOrdhistoryid(int ordhistoryid) {
        this.ordhistoryid = ordhistoryid;
    }

    public int getStrid() {
        return strid;
    }

    public void setStrid(int strid) {
        this.strid = strid;
    }
    
    
}
