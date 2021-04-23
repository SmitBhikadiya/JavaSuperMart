
package POJOs;

public class PojoShopkeeper {
    private int skid;
    private int adid;
    private int strid;
    private String updatedtime;

    public PojoShopkeeper() {
    }

    public PojoShopkeeper(int adid, int strid) {
        this.adid = adid;
        this.strid = strid;
    }

    public int getSkid() {
        return skid;
    }

    public void setSkid(int skid) {
        this.skid = skid;
    }

    public int getAdid() {
        return adid;
    }

    public void setAdid(int adid) {
        this.adid = adid;
    }

    public int getStrid() {
        return strid;
    }

    public void setStrid(int strid) {
        this.strid = strid;
    }

    public String getUpdatedtime() {
        return updatedtime;
    }

    public void setUpdatedtime(String updatedtime) {
        this.updatedtime = updatedtime;
    }
    
    
}
