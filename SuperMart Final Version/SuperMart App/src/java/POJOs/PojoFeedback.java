
package POJOs;

public class PojoFeedback {
    private int ordratid;
    private int ordid;
    private int overall_rat;
    private int products_rat;
    private String delivery_service;
    private String review_msg;
    private String timestamp;
    
    private int isTestimonial;

    public PojoFeedback() {
    }

    public PojoFeedback(int ordid, int overall_rat, int products_rat, String review_msg) {
        this.ordid = ordid;
        this.overall_rat = overall_rat;
        this.products_rat = products_rat;
        this.review_msg = review_msg;
    }

    public PojoFeedback(int ordid, int overall_rat, int products_rat, String delivery_service, String review_msg) {
        this.ordid = ordid;
        this.overall_rat = overall_rat;
        this.products_rat = products_rat;
        this.delivery_service = delivery_service;
        this.review_msg = review_msg;
    }
    
    

    public PojoFeedback(int ordratid, int ordid, int overall_rat, int products_rat, String delivery_service, String review_msg) {
        this.ordratid = ordratid;
        this.ordid = ordid;
        this.overall_rat = overall_rat;
        this.products_rat = products_rat;
        this.delivery_service = delivery_service;
        this.review_msg = review_msg;
    }

    public int getOrdratid() {
        return ordratid;
    }

    public void setOrdratid(int ordratid) {
        this.ordratid = ordratid;
    }

    public int getOrdid() {
        return ordid;
    }

    public void setOrdid(int ordid) {
        this.ordid = ordid;
    }

    public int getOverall_rat() {
        return overall_rat;
    }

    public void setOverall_rat(int overall_rat) {
        this.overall_rat = overall_rat;
    }

    public int getProducts_rat() {
        return products_rat;
    }

    public void setProducts_rat(int products_rat) {
        this.products_rat = products_rat;
    }

    public String getDelivery_service() {
        return delivery_service;
    }

    public void setDelivery_service(String delivery_service) {
        this.delivery_service = delivery_service;
    }
    
    

    public String getReview_msg() {
        return review_msg;
    }

    public void setReview_msg(String review_msg) {
        this.review_msg = review_msg;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public int getIsTestimonial() {
        return isTestimonial;
    }

    public void setIsTestimonial(int isTestimonial) {
        this.isTestimonial = isTestimonial;
    }
    
    
}
