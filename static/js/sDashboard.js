const status = document.getElementById("status").innerText;
if(status === "Available"){
    document.getElementById("status").setAttribute("style","color:green;font-weight:650");
}
else{
    document.getElementById("status").setAttribute("style","color:red;font-weight:650");
}