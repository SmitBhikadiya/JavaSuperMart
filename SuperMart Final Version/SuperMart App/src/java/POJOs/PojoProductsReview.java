
package POJOs;

public class PojoProductsReview {
    
    private int reviewid;
    private int cstmid;
    private int prdid;
    private String rname;
    private String remail;
    private String rmsg;
    private int rrating;
    private String timestamp;
    
    private int prdrating;

    public PojoProductsReview() {
    }

    public PojoProductsReview(int cstmid,int prdid, String rname, String remail, String rmsg, int rrating) {
        this.cstmid = cstmid;
        this.prdid = prdid;
        this.rname = rname;
        this.remail = remail;
        this.rmsg = rmsg;
        this.rrating = rrating;
    }

    public PojoProductsReview(int reviewid, int cstmid, int prdid, String rname, String remail, String rmsg, int rrating, String timestamp) {
        this.reviewid = reviewid;
        this.cstmid = cstmid;
        this.prdid = prdid;
        this.rname = rname;
        this.remail = remail;
        this.rmsg = rmsg;
        this.rrating = rrating;
        this.timestamp = timestamp;
    }

    public int getCstmid() {
        return cstmid;
    }

    public void setCstmid(int cstmid) {
        this.cstmid = cstmid;
    }

    public int getPrdrating() {
        return prdrating;
    }

    public void setPrdrating(int prdrating) {
        this.prdrating = prdrating;
    }
    
    

    public int getReviewid() {
        return reviewid;
    }

    public void setReviewid(int reviewid) {
        this.reviewid = reviewid;
    }

    public int getPrdid() {
        return prdid;
    }

    public void setPrdid(int prdid) {
        this.prdid = prdid;
    }

    public String getRname() {
        return rname;
    }

    public void setRname(String rname) {
        this.rname = rname;
    }

    public String getRemail() {
        return remail;
    }

    public void setRemail(String remail) {
        this.remail = remail;
    }

    public String getRmsg() {
        return rmsg;
    }

    public void setRmsg(String rmsg) {
        this.rmsg = rmsg;
    }

    public int getRrating() {
        return rrating;
    }

    public void setRrating(int rrating) {
        this.rrating = rrating;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }
    
    
    
}
