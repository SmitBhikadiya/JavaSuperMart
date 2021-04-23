//navbar active script on click 
var currentLocation = location.href;
var menuItem = document.querySelectorAll('a');
var menuLength = menuItem.length;
for (var i = 0; i < menuLength; i++) {
    if (menuItem[i].href === currentLocation) {
        menuItem[i].className = "active";
    }
}

$(document).ready(function () {
//login validation
    $('#login').click(function () {
        var email = $('#email');
        var password = $('#password');

        var valid = true;

        var emailValue = email.val().trim();
        var passwordValue = password.val().trim();

        if (emailValue === "") {
            var formControl = email.parent();
            formControl.addClass("error");
            formControl.removeClass("success");
            valid = false;
        } else {
            var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
            if (!(regex.test(emailValue))) {
                var formControl = email.parent();
                formControl.removeClass("success");
                formControl.addClass("error");
                valid = false;
            } else {
                var formControl = email.parent();
                formControl.removeClass("error");
                formControl.addClass("success");
            }
        }

        if (passwordValue === '') {
            var formControl = password.parent();
            formControl.addClass("error");
            formControl.removeClass("success");
            valid = false;
        } else {
            if (!(passwordValue.length >= 8)) {
                var formControl = password.parent();
                formControl.addClass("error");
                formControl.removeClass("success");
                valid = false;
            } else {
                var formControl = password.parent();
                formControl.removeClass("error");
                formControl.addClass("success");
            }
        }

        return valid;

    });


//register validation
    $('#register').click(function () {
        var email = $('#cemail');
        var psw = $('#cpsw');
        var name = $('#cname');
        var mobile = $('#cmobile');
        var address = $('#caddress');

        var valid = true;

        var emailValue = email.val().trim();
        var passwordValue = psw.val().trim();
        var nameValue = name.val().trim();
        var mobileValue = mobile.val().trim();
        var addressValue = address.val().trim();

        //name validation
        if (nameValue === "") {
            var formControl = name.parent();
            formControl.addClass("error");
            formControl.removeClass("success");
            valid = false;
        } else {
            var formControl = name.parent();
            formControl.removeClass("error");
            formControl.addClass("success");
        }

        if (emailValue === "") {
            var formControl = email.parent();
            formControl.addClass("error");
            formControl.removeClass("success");
            valid = false;
        } else {
            var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
            if (!(regex.test(emailValue))) {
                var formControl = email.parent();
                formControl.removeClass("success");
                formControl.addClass("error");
                valid = false;
            } else {
                var formControl = email.parent();
                formControl.removeClass("error");
                formControl.addClass("success");
            }
        }

        //mobile validation
        if (mobileValue === '') {
            var formControl = mobile.parent();
            formControl.addClass("error");
            formControl.removeClass("success");
            valid = false;
        } else {
            if (!(mobileValue.length >= 8)) {
                var formControl = mobile.parent();
                formControl.addClass("error");
                formControl.removeClass("success");
                valid = false;
            } else {
                var formControl = mobile.parent();
                formControl.removeClass("error");
                formControl.addClass("success");
            }
        }

        //address validation
        if (addressValue === "") {
            var formControl = address.parent();
            formControl.addClass("error");
            formControl.removeClass("success");
            valid = false;
        } else {
            var formControl = address.parent();
            formControl.removeClass("error");
            formControl.addClass("success");
        }

        //password validation
        if (passwordValue === '') {
            var formControl = psw.parent();
            formControl.addClass("error");
            formControl.removeClass("success");
            valid = false;
        } else {
            if (!(passwordValue.length >= 8)) {
                var formControl = psw.parent();
                formControl.addClass("error");
                formControl.removeClass("success");
                valid = false;
            } else {
                var formControl = psw.parent();
                formControl.removeClass("error");
                formControl.addClass("success");
            }
        }
        return valid;
    });

//account details
    $('#update').click(function () {
        var email = $('#email');
        var name = $('#display-name');
        var mobile = $('#contact');
        var address = $('#address');

        var valid = true;

        var emailValue = email.val().trim();
        var nameValue = name.val().trim();
        var mobileValue = mobile.val().trim();
        var addressValue = address.val().trim();

        //name validation
        if (nameValue === "") {
            var formControl = name.parent();
            formControl.addClass("error");
            formControl.removeClass("success");
            valid = false;
        } else {
            var formControl = name.parent();
            formControl.removeClass("error");
            formControl.addClass("success");
        }

        if (emailValue === "") {
            var formControl = email.parent();
            formControl.addClass("error");
            formControl.removeClass("success");
            valid = false;
        } else {
            var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
            if (!(regex.test(emailValue))) {
                var formControl = email.parent();
                formControl.removeClass("success");
                formControl.addClass("error");
                valid = false;
            } else {
                var formControl = email.parent();
                formControl.removeClass("error");
                formControl.addClass("success");
            }
        }

        //address validation
        if (addressValue === "") {
            var formControl = address.parent();
            formControl.addClass("error");
            formControl.removeClass("success");
            valid = false;
        } else {
            var formControl = address.parent();
            formControl.removeClass("error");
            formControl.addClass("success");
        }

        //mobile validation
        if (mobileValue === '') {
            var formControl = mobile.parent();
            formControl.addClass("error");
            formControl.removeClass("success");
            valid = false;
        } else {
            if (!(mobileValue.length >= 8)) {
                var formControl = mobile.parent();
                formControl.addClass("error");
                formControl.removeClass("success");
                valid = false;
            } else {
                var formControl = mobile.parent();
                formControl.removeClass("error");
                formControl.addClass("success");
            }
        }
        return valid;
    });

//forgot password
    $('#update1').click(function () {
        var currentPsw = $('#current-pwd');
        var newPsw = $('#new-pwd');
        var confirmPsw = $('#confirm-pwd');

        var cpsw = currentPsw.val().trim();
        var npsw = newPsw.val().trim();
        var cnpsw = confirmPsw.val().trim();

        var valid = true;
        if (cpsw === '') {
            var formControl = currentPsw.parent();
            formControl.addClass("error");
            formControl.removeClass("success");
            valid = false;
        } else {
            if (!(cpsw.length >= 8)) {
                var formControl = currentPsw.parent();
                formControl.addClass("error");
                formControl.removeClass("success");
                valid = false;
            } else {
                var formControl = currentPsw.parent();
                formControl.removeClass("error");
                formControl.addClass("success");
            }
        }

        if (npsw === '') {
            var formControl = newPsw.parent();
            formControl.addClass("error");
            formControl.removeClass("success");
            valid = false;
        } else {
            if (!(npsw.length >= 8)) {
                var formControl = newPsw.parent();
                formControl.addClass("error");
                formControl.removeClass("success");
                valid = false;
            } else {
                var formControl = newPsw.parent();
                formControl.removeClass("error");
                formControl.addClass("success");
            }
        }

        if (cnpsw === '') {
            var formControl = confirmPsw.parent();
            formControl.addClass("error");
            formControl.removeClass("success");
            valid = false;
        } else {
            if (!(cnpsw.length >= 8)) {
                var formControl = confirmPsw.parent();
                formControl.addClass("error");
                formControl.removeClass("success");
                valid = false;
            } else {
                var formControl = confirmPsw.parent();
                formControl.removeClass("error");
                formControl.addClass("success");
            }
        }

        if (cnpsw !== npsw || (cnpsw === '' && npsw === '')) {
            var newPassword = newPsw.parent();
            var confirmPassword = confirmPsw.parent();
            newPassword.addClass("error");
            newPassword.removeClass("success");
            confirmPassword.addClass("error");
            confirmPassword.removeClass("success");
            valid = false;
        } else {
            var newPassword = newPsw.parent();
            var confirmPassword = confirmPsw.parent();
            newPassword.addClass("success");
            newPassword.removeClass("error");
            confirmPassword.addClass("success");
            confirmPassword.removeClass("error");
        }

        return valid;
    });
});
