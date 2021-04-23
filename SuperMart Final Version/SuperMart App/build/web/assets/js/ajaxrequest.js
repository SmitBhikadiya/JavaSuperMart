/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function addmetocart(prdid, cstmid) {
    //alert();
    //cstmid = parseInt(cstmid);
    //alert(cstmid);
    if (cstmid === 0) {
        if (confirm("User are not login..")) {
            window.location.href = "login-register.jsp";
        }
    } else {
        $.ajax({
            type: "POST",
            url: "UserOrders",
            data: {prdid:prdid, cstmid:cstmid},
            success: function (data) {
                //alert(data);
                var status = parseInt(data);
                if (status === 0) {
                    if (confirm("Go To Login First")) {
                        window.location.href = "login-register.jsp";
                    }
                } else if (status === 1) {
                    if (confirm("Go To Cart")) {
                        window.location.href = "cart.jsp";
                    }
                } else if (status === 3) {
                    if (confirm("Your order for this shop is pending")) {
                        window.location.href = "track-order.jsp";
                    }
                } else if (status === 2) {
                    if (confirm("Go To Cart")) {
                        window.location.href = "cart.jsp";
                    }
                } else if(status === 4){
                    alert("The Store is closed right now");
                    window.location.reload();
                }
            }
        });
    }

}