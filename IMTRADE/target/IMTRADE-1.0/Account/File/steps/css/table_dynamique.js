$(document).ready(function () {
    //modal SN
    var qtesn = 0;
    $("#qtesn").val(qtesn);
    function remove_SN() {
        qtesn = parseInt($("#qtesn").val());
        $(".red_SN").click(function () {

            var sn = $(this).parent().siblings(":nth-child(1)").text();

            $(this).closest("tr").remove();

            //delete line

            $.ajax({
                url: '/IMTRADE/Content',
                method: "POST",
                data: {
                    SN: sn,
                    Ftype: "delete"
                },
                success: function (data) {
                    qtesn -= 1;
                    $('#qtesn').val(qtesn);
                }
            });



        });

    }

    remove_SN();

    $(document).on("change", "#auto-add", function () {
        if ($('#auto-add').is(':checked')) {
            $('.green_SN').hide();
        } else {
            $('.green_SN').show();
        }
    });
    /***NOT USED***/
    var snval = "";
    var sn = "";
    var etat = 0;
    var millisecondsToWait = 100;

    function countsn() {
        etat++;
        snval = snval + $("#sn").val();
        $("#sn").val("");
        if (etat == 5) {
            $("#sn").val(sn);

            /*
             alert(sn.split("-").length());
             if(sn.split("-").length()){
             
             }
             */
            insertsn();
            snval = "";
            etat = 0;
        } else {
            setTimeout(countsn, millisecondsToWait);
        }
    }
    /***NOT USED***/

    $("#sn").on("change", function () {

        //alert($("#sn").val());
        if ($('.green_SN').css("display") == "none" && $("#sn").val().length > 0) {

            //$("#sn").val();
            //countsn();
            
            qtesn = parseInt($("#qtesn").val());
            if ($("#sn").val() == "") {

                $("#texterror_SN").text("Veuillez remplir tous les champs et soumettre à nouveau le formulaire.");
                $(".alert_SN").addClass("active");
                $(".remove_SN").click(function () {
                    $(".alert_SN").removeClass("active");
                });

            } else {

                var table = $("table#tab_logic_SN tbody");

                var sn = $("#sn").val();

                var table = $("table#tab_logic_SN tbody");
                var exist = 0;
                table.find('tr').each(function (i, el) {
                    var $tds = $(this).find('td'),
                            sni = $tds.eq(0).text();
                    if (sni == sn) {
                        exist++;
                    }
                });
                if (exist == 1) {

                    $("#texterror_SN").text(sn + " est existé déjà");
                    $(".alert_SN").addClass("active");
                    $(".remove_SN").click(function () {
                        $(".alert_SN").removeClass("active");
                    });

                } else {


                    $(".tab_logic_SNfirst-tr").after('<tr style="font-size: 13px;"><td class="text-left " style="padding-top: 15px;">'
                            + sn + '</td>'
                            + '<td class="static"><span class="button red_SN" style="border-radius: 20px;"><i class="glyphicon glyphicon-minus" style="font-size: 25px;font-weight: bold;"></i></span></td>');

                    remove_SN();

                    $.ajax({
                        url: '/IMTRADE/Content',
                        method: "POST",
                        data: {
                            SN: sn,
                            Ftype: "Add"
                        },
                        success: function (data) {
                            qtesn += 1;
                            $('#qtesn').val(qtesn);
                        }
                    });

                    $("#sn").val("");
                    exist = 0;

                }

            }
        }
    });
   




    $(".green_SN").click(function (event) {
        qtesn = parseInt($("#qtesn").val());
        event.preventDefault();
        if ($("#sn").val() == "") {

            $("#texterror_SN").text("Veuillez remplir tous les champs et soumettre à nouveau le formulaire.");
            $(".alert_SN").addClass("active");
            $(".remove_SN").click(function () {
                $(".alert_SN").removeClass("active");
            });

        } else {

            var table = $("table#tab_logic_SN tbody");

            var sn = $("#sn").val();


            var table = $("table#tab_logic_SN tbody");
            var exist = 0;
            table.find('tr').each(function (i, el) {
                var $tds = $(this).find('td'),
                        sni = $tds.eq(0).text();
                if (sni == sn) {
                    exist++;
                }

            });



            if (exist == 1) {

                $("#texterror_SN").text(sn + " est existé déjà");
                $(".alert_SN").addClass("active");
                $(".remove_SN").click(function () {
                    $(".alert_SN").removeClass("active");
                });

            } else {


                $(".tab_logic_SNfirst-tr").after('<tr style="font-size: 13px;"><td class="text-left " style="padding-top: 15px;">'
                        + sn + '</td>'
                        + '<td class="static"><span class="button red_SN" style="border-radius: 20px;"><i class="glyphicon glyphicon-minus" style="font-size: 25px;font-weight: bold;"></i></span></td>');


                remove_SN();


                $('#qtesn').val(qtesn);
                $.ajax({
                    url: '/IMTRADE/Content',
                    method: "POST",
                    data: {
                        SN: sn,
                        Ftype: "Add"
                    },
                    success: function (data) {
                        //$('#contentx').html(data);
                        qtesn += 1;
                    }
                });

                $("#sn").val("");
                exist = 0;

            }

        }
    });



    //fin modal sn

    //debut da bc fac offre...
    
    function remove() {

        $(".red").click(function () {

            var type = $(this).parent().siblings(":nth-child(1)").text();
            var prod = $(this).parent().siblings(":nth-child(2)").text();

            $(this).closest("tr").remove();
            calc_total();
//delete line
            $.ajax({
                url: '/IMTRADE/Content',
                method: "POST",
                data: {
                    typee: type,
                    product: prod,
                    typeT: "delete"
                },
                success: function (data) {
                    //$('#contentx').html(data);
                }
            });

            $.ajax({
                url: '/IMTRADE/Content',
                method: "POST",
                data: {
                    pourcent: $("#tax").val(),
                    tva: $("#tax_amount").val(),
                    pourcentr: $("#remise").val(),
                    remise: $("#remise_amount").val(),
                    totalht: $("#sub_total").val(),
                    totalttc: $("#total_amount").val(),
                    ouvert: $("#total_amount").val(),
                    montant: $("#total_amount").val(),
                    typeT: "tax"
                },
                success: function (data) {
                    $('#contentx').html(data);
                }
            });

        });
    }

    remove();
    $(".green").click(function (event) {

        event.preventDefault();
        if ($("#typearticle").val() == "" || $("#productarticle").val() == "" || $("#qtyarticle").val() == "" || $("#pricearticle").val() == "" || $("#totalarticle").val() == "") {

            $("#texterror").text("Veuillez remplir tous les champs et soumettre à nouveau le formulaire.");
            $(".alert").addClass("active");
            $(".remove").click(function () {
                $(".alert").removeClass("active");
            });

        } else {

            var table = $("table#tab_logic tbody");

            var type = $("#typearticle").val();
            var product = $("#productarticle").val();
            var qty = $("#qtyarticle").val();


            var price = parseInt($("#pricearticle").val());
            price = price.toFixed(2);
            $("#pricearticle").val(price);


            var total = parseInt($("#totalarticle").val());
            total = total.toFixed(2);
            $("#totalarticle").val(total);


            var table = $("table#tab_logic tbody");
            var exist = 0;
            table.find('tr').each(function (i, el) {
                var $tds = $(this).find('td'),
                        typei = $tds.eq(0).text(),
                        producti = $tds.eq(1).text();
                //Quantity = $tds.eq(2).text();

                if (typei == type && producti == product) {
                    exist++;
                }
                // do something with productId, product, Quantity
            });

            if (exist == 1) {

                $("#texterror").text(product + " est existé déjà");
                $(".alert").addClass("active");
                $(".remove").click(function () {
                    $(".alert").removeClass("active");
                });

            } else {


                $(".tab_logicfirst-tr").after('<tr style="font-size: 13px;"><td class="text-left " style="padding-top: 15px;">'
                        + type + '</td><td class="text-left" style="padding-top: 15px;">'
                        + product + '</td><td class="text-center " style="padding-top: 15px;">'
                        + qty + '</td><td class="text-right " style="padding-top: 15px;">' + price
                        + '</td><td class="text-right total1" style="padding-top: 15px;">' + total + '</td>'
                        + '<td class="static"><span class="button red" style="border-radius: 20px;"><i class="glyphicon glyphicon-minus" style="font-size: 25px;font-weight: bold;"></i></span></td>');

                remove();
                calc_total();

                $.ajax({
                    url: '/IMTRADE/Content',
                    method: "POST",
                    data: {
                        pourcent: $("#tax").val(),
                        tva: $("#tax_amount").val(),
                        pourcentr: $("#remise").val(),
                        remise: $("#remise_amount").val(),
                        totalht: $("#sub_total").val(),
                        totalttc: $("#total_amount").val(),
                        ouvert: $("#total_amount").val(),
                        montant: $("#total_amount").val(),
                        typee: type,
                        product: product,
                        qty: qty,
                        price: price,
                        total: total,
                        typeT: "ligne"
                    },
                    success: function (data) {
                        $('#contentx').html(data);
                    }
                });
                $("#typearticle").val("");
                $("#productarticle").val("");
                $("#qtyarticle").val("");
                $("#pricearticle").val("");
                $("#totalarticle").val("");
                exist = 0;

            }

        }
    });
    //fin da bc fac offre...
    //debut bons...
    
    
    
    //fin bons...

    //debut calcule
    $('#tab_logic tbody').on('keyup change', function () {
        calc();
    });
    $('#tax_amount').on('keyup change', function () {
//      tax montant non fonctionner///////////
        calc_total2();
        $.ajax({
            url: '/IMTRADE/Content',
            method: "POST",
            data: {
                pourcent: $("#tax").val(),
                tva: $("#tax_amount").val(),
                pourcentr: $("#remise").val(),
                remise: $("#remise_amount").val(),
                totalht: $("#sub_total").val(),
                totalttc: $("#total_amount").val(),
                ouvert: $("#total_amount").val(),
                montant: $("#total_amount").val(),
                typeT: "tax"
            },
            success: function (data) {
                $('#contentx').html(data);
            }
        });
    });
    $('#remise_amount').on('keyup change', function () {
//tax montant non fonctionner///////////////////////////////////////////////        
        calc_total2();
        $.ajax({
            url: '/IMTRADE/Content',
            method: "POST",
            data: {
                pourcent: $("#tax").val(),
                tva: $("#tax_amount").val(),
                pourcentr: $("#remise").val(),
                remise: $("#remise_amount").val(),
                totalht: $("#sub_total").val(),
                totalttc: $("#total_amount").val(),
                ouvert: $("#total_amount").val(),
                montant: $("#total_amount").val(),
                typeT: "tax"
            },
            success: function (data) {
                $('#contentx').html(data);
            }
        });
    });


    $('#tax').on('keyup change', function () {
        calc_total();
        $.ajax({
            url: '/IMTRADE/Content',
            method: "POST",
            data: {
                pourcent: $("#tax").val(),
                tva: $("#tax_amount").val(),
                pourcentr: $("#remise").val(),
                remise: $("#remise_amount").val(),
                totalht: $("#sub_total").val(),
                totalttc: $("#total_amount").val(),
                ouvert: $("#total_amount").val(),
                montant: $("#total_amount").val(),
                typeT: "tax"
            },
            success: function (data) {

                $('#contentx').html(data);
            }
        });
    });
    $("#modeR").bind("change paste keyup", function () {
    //$('#timbre_amount').on('keyup change', function () {
    if($("#modeR").val()=="espèce" && $("#cond2").is(':checked')){
        calc_total3();
        $.ajax({
            url: '/IMTRADE/Content',
            method: "POST",
            data: {
                pourcent: $("#tax").val(),
                tva: $("#tax_amount").val(),
                pourcentr: $("#remise").val(),
                remise: $("#remise_amount").val(),
                totalht: $("#sub_total").val(),
                totalttc: $("#total_amount").val(),
                ouvert: $("#total_amount").val(),
                montant: $("#total_amount").val(),
                timbre:$("#timbre_amount").val(),
                typeT: "timbre"
            },
            success: function (data) {
                $('#contentx').html(data);
            }
        });
    }
        
    });
    $('#remise').on('keyup change', function () {
        calc_total();
        $.ajax({
            url: '/IMTRADE/Content',
            method: "POST",
            data: {
                pourcent: $("#tax").val(),
                tva: $("#tax_amount").val(),
                pourcentr: $("#remise").val(),
                remise: $("#remise_amount").val(),
                totalht: $("#sub_total").val(),
                totalttc: $("#total_amount").val(),
                ouvert: $("#total_amount").val(),
                montant: $("#total_amount").val(),
                typeT: "tax"
            },
            success: function (data) {
                $('#contentx').html(data);
            }
        });
    });

    $(".input-effect input").val("");

    $(".input-effect input").focusout(function () {
        if ($(this).val() != "") {
            $(this).addClass("has-content");
        } else {
            $(this).removeClass("has-content");
        }
    });


    function calc()
    {
        $('#tab_logic tbody tr').each(function (i, element) {
            var html = $(this).html();
            if (html != '')
            {
                var qty = $(this).find('.qty').val();
                var price = $(this).find('.price').val();
                $(this).find('.total').val(qty * price);
                //calc_total();
            }
        });
    }

    function calc_total()
    {
        total = 0;
        $('.total1').each(function () {
            total += parseInt($(this).text());
        });

        $('#sub_total').val(total.toFixed(2));
        var tax_sum = total / 100 * $('#tax').val();
        $('#tax_amount').val(tax_sum.toFixed(2));

        $('#total_amount').val((tax_sum + total).toFixed(2));
        $('#total').val((tax_sum + total).toFixed(2));

        var remise_sum = total / 100 * $('#remise').val();
        $('#remise_amount').val(remise_sum.toFixed(2));
        $('#total_amount').val((tax_sum + total - remise_sum).toFixed(2));

        $('#total').val((tax_sum + total - remise_sum).toFixed(2));
    }

    function calc_total2()
    {
        total = 0;
        $('.total1').each(function () {
            total += parseInt($(this).text());
        });

        $('#sub_total').val(total.toFixed(2));

        var tax_sum = $('#tax_amount').val() / total * 100;
        $('#tax').val(tax_sum.toFixed(2));
        $('#total_amount').val(parseInt($('#tax_amount').val()) + total);
        $('#total').val(parseInt($('#tax_amount').val()) + total);

        var remise_sum = $('#remise_amount').val() / total * 100;
        $('#remise').val(remise_sum.toFixed(2));
        var timbre_sum= $('#sub_total').val() /100;
        $('#total_amount').val((parseInt($('#tax_amount').val()) +total - parseInt($('#remise_amount').val())).toFixed(2));
        
        $('#total').val((parseInt($('#tax_amount').val()) + total - parseInt($('#remise_amount').val())).toFixed(2));

    }

    function calc_total3()
    {
        var timbre_sum= $('#sub_total').val() /100;
        $('#timbre_amount').val(timbre_sum.toFixed(2));
        $('#total_amount').val((parseInt($('#total_amount').val()) + timbre_sum).toFixed(2));
        
        $('#total').val((parseInt($('#total').val()) +timbre_sum).toFixed(2));

    }

    //fin calcule
    
    
    
    
    

});