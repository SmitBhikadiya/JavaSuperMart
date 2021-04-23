
package POJOs;

public class PojoCompare {
    private int cmprid;
    private int prdid;
    private int cstmid;

    public PojoCompare() {
    }

    public int getCmprid() {
        return cmprid;
    }

    public PojoCompare(int prdid, int cstmid) {
        this.prdid = prdid;
        this.cstmid = cstmid;
    }

    public void setCmprid(int cmprid) {
        this.cmprid = cmprid;
    }

    public int getPrdid() {
        return prdid;
    }

    public void setPrdid(int prdid) {
        this.prdid = prdid;
    }

    public int getCstmid() {
        return cstmid;
    }

    public void setCstmid(int cstmid) {
        this.cstmid = cstmid;
    }
    
    
}
