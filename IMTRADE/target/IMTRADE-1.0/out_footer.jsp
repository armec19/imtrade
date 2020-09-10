<script src="assets/node_modules/jquery/jquery-3.2.1.min.js"></script>
<script src="assets/node_modules/popper/popper.min.js"></script>
<script src="assets/node_modules/bootstrap/dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
    $(function () {
        $(".preloader").fadeOut();
    });
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
    });

    $('#to-recover').on("click", function () {
        $("#loginform").slideUp();
        $("#recoverform").fadeIn();
    });
</script>

<script type="text/javascript">
    $(document).ready(function () {
       
        $("#userlogin").bind("change paste keyup", function () {
            validateEmail(this);
        });
        $("#passlogin").bind("change paste keyup", function () {
            $(this).val($(this).val().replace(/[^a-z0-9]/gi, ''));
            validatePass(this);
        });

    });

    function validateEmail(emailField) {
        var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;


        if (emailField.value.length >= 1) {
            if (reg.test(emailField.value) == false)
            {
                $("#nonvalid1").css("display", "block");
                return false;
            } else {
                $("#nonvalid1").css("display", "none");
            }
        } else {
            $("#nonvalid1").css("display", "none");
        }
        return true;
    }
    function validatePass(passField) {
        //var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
        if (passField.value.length >= 1 && passField.value.length < 4) {

            $("#nonvalid2").css("display", "block");
            return false;

        } else {
            $("#nonvalid2").css("display", "none");
        }
        return true;
    }
</script>