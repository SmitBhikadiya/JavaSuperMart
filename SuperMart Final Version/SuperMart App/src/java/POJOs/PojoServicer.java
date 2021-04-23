
package POJOs;

public class PojoServicer {
    private int servicerid;
    private int adid;
    public PojoServicer() {
    }

    
    public PojoServicer(int adid) {
        this.adid = adid;
    }

    public PojoServicer(int servicerid, int adid) {
        this.servicerid = servicerid;
        this.adid = adid;
    }

    public int getServicerid() {
        return servicerid;
    }

    public void setServicerid(int servicerid) {
        this.servicerid = servicerid;
    }

    public int getAdid() {
        return adid;
    }

    public void setAdid(int adid) {
        this.adid = adid;
    }
 
}
