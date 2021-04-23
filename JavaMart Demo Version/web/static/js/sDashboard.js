
var check1 = document.getElementById("check1");
var check2 = document.getElementById("check2");

check1.addEventListener("change",function(){
    if(this.checked===false){
        check2.checked = false;
    }
});

check2.addEventListener("change",function(){
    if(this.checked===true){
        if(check1.checked === true){
            this.checked = true;
        }
        else{
            this.checked = false;
        }
    }
});