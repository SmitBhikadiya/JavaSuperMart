
package POJOs;

public class PojoVarifyStore {
    private int vid;
    private int strid;
    private int varified;

    public PojoVarifyStore() {
    }

    public PojoVarifyStore(int strid, int varified) {
        this.strid = strid;
        this.varified = varified;
    }

    public PojoVarifyStore(int vid, int strid, int varified) {
        this.vid = vid;
        this.strid = strid;
        this.varified = varified;
    }

    public int getVid() {
        return vid;
    }

    public void setVid(int vid) {
        this.vid = vid;
    }

    public int getStrid() {
        return strid;
    }

    public void setStrid(int strid) {
        this.strid = strid;
    }

    public int getVarified() {
        return varified;
    }

    public void setVarified(int varified) {
        this.varified = varified;
    }
    
    
    
}
