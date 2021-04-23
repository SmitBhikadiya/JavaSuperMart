$(document).ready(function () {
    $(".product-action-link").click(function () {
        var product_name = $(this).siblings(".product-name").children("h4").text().trim();
        var product_prize = $(this).siblings(".price-box").children(".regular-price").text().trim();
        var store_id = $(this).siblings(".price-box").children(".store-id").val();
        var product_id = $(this).siblings(".price-box").children(".product-id").val();
        var product_imgsrc = $(".product-thumb").children("a").prop("href");
        var product_qty = 1;

        /*step1 : check store_id exists 
                -> yes : store your product-data  
                -> no : create new object with store id*/

        var data = {
            store_id: [
                product_id,
                product_imgsrc,
                product_name,
                product_prize,
                product_qty,
            ]
        }

        var xml = new XMLHttpRequest();
        xml.open("GET", "assets/data/addtocart.json", true);
        xml.setRequestHeader("content-type", "application/json");
        xml.onreadystatechange = function () {
            if (xml.readyState == 4 && xml.status == 200) {
                var jsonobj = JSON.parse(xml.responseText)["shops"];
                if(matchid(1, jsonobj)){
                    alert("find");
                }else{
                    alert("not find");
                }
            }
        }
        xml.send(null);
    });

    function matchid(id_,json){
        for(var x in json){
            console.log(x,id_)
            if(x === id_){
                console.log(x);
                return true;
            }
        }
        return false;
    }
});