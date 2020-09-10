<%@page import="maps.Doctype"%>

<script>
    $(document).ready(function () {
        //modal SN
        var qtesn = 0;
        //$("#qtesn").val(qtesn);
        //countsn();

        function countsn() {
            var existc = -1;
            var tablec = $("table#tab_logic_SN tbody");
            tablec.find('tr').each(function (i, el) {
                var $tds = $(this).find('td'),
                        typei = $tds.eq(0).text(),
                        producti = $tds.eq(1).text();

                var idd = $(this).find('td').closest('tr').attr('id');

                existc++;
            });
            $("#qtesn").val(existc);
            $("#qtymodal").val(existc);
            $("#qtesn").val($("#qtymodal").val());
        }

        function remove_SN() {
            qtesn = parseInt($("#qtesn").val());
            $(".red_SN").click(function () {

                var sn = $(this).parent().siblings(":nth-child(1)").text();

                $(this).closest("tr").remove();

                //delete line

                var product = $("#productarticle").val();
                $.ajax({
                    url: '/IMTRADE/Content',
                    method: "POST",
                    data: {
                        product: product,
                        SN: sn,
                        Ftype: "delete"
                    },
                    success: function (data) {
                        //qtesn -= 1;
                        countsn();
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

        function count_sn() {
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


                        $(".tab_logic_SNfirst-tr").after('<tr style="font-size: 13px;border-top: 1px solid #daeaf1;"><td class="text-left " style="padding-top: 15px;">'
                                + sn + '</td>'
                                + '<td class="static"><span class="button red_SN" style="border-radius: 20px;"><i class="glyphicon glyphicon-minus" style="font-size: 25px;font-weight: bold;"></i></span></td>');

                        remove_SN();
                        var product = $("#productarticle").val();
                        $.ajax({
                            url: '/IMTRADE/Content',
                            method: "POST",
                            data: {
                                product: product,
                                SN: sn,
                                Ftype: "Add"
                            },
                            success: function (data) {
                                //qtesn += 1;
                                if (data == "true") {
                                    $(".tab_logic_SNfirst-tr").after('<tr style="font-size: 13px;border-top: 1px solid #daeaf1;"><td class="text-left " style="padding-top: 15px;">'
                                            + sn + '</td>'
                                            + '<td class="static"><span class="button red_SN" style="border-radius: 20px;"><i class="glyphicon glyphicon-minus" style="font-size: 25px;font-weight: bold;"></i></span></td>');
                                    remove_SN();
                                } else {
                                    $("#texterror_SN").text(sn+ " " + data);
                                    $(".alert_SN").addClass("active");
                                    $(".remove_SN").click(function () {
                                        $(".alert_SN").removeClass("active");
                                    });
                                }
                                $("#sn").val("");
                                exist = 0;
                                $('#qtesn').val(qtesn);
                                countsn();
                            }
                        });



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





                    $('#qtesn').val(qtesn);
                    var product = $("#productarticle").val();
                    $.ajax({
                        url: '/IMTRADE/Content',
                        method: "POST",
                        data: {
                            product: product,
                            SN: sn,
                            Ftype: "Add"
                        },
                        success: function (data) {
                            //alert(data);
                            if (data == "true") {
                                $(".tab_logic_SNfirst-tr").after('<tr style="font-size: 13px;border-top: 1px solid #daeaf1;"><td class="text-left " style="padding-top: 15px;">'
                                        + sn + '</td>'
                                        + '<td class="static"><span class="button red_SN" style="border-radius: 20px;"><i class="glyphicon glyphicon-minus" style="font-size: 25px;font-weight: bold;"></i></span></td>');
                                remove_SN();
                            } else {
                                $("#texterror_SN").text(sn + " " + data);
                                $(".alert_SN").addClass("active");
                                $(".remove_SN").click(function () {
                                    $(".alert_SN").removeClass("active");
                                });
                            }
                            countsn();
                        }
                    });

                    $("#sn").val("");
                    exist = 0;

                }

            }
        });



        //fin modal sn

        //debut bc fac offre...
        function remove_bc() {

            $(".red_bc").click(function () {

                var type = $(this).parent().siblings(":nth-child(1)").text();
                var prod = $(this).parent().siblings(":nth-child(2)").text();

                $(this).closest("tr").remove();
                calc_total();

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
        $(".green_bc").click(function (event) {

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
                var umcond = $("#umcondarticle").val();

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
                            + product + '</td><td class="text-left " style="padding-top: 15px;">'
                            + umcond + '</td><td class="text-center " style="padding-top: 15px;">'
                            + qty + '</td><td class="text-right " style="padding-top: 15px;">' + price
                            + '</td><td class="text-right total1" style="padding-top: 15px;">' + total + '</td>'
                            + '<td class="static"><span class="button red_bc" style="border-radius: 20px;"><i class="glyphicon glyphicon-minus" style="font-size: 25px;font-weight: bold;"></i></span></td>');

                    remove_bc();
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
                            umcond: umcond,
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
                    $("#umcondarticle").val("");
                    $("#pricearticle").val("");
                    $("#totalarticle").val("");
                    exist = 0;

                }

            }
        });
        //fin bc fac offre...
        
        //debut da...

        function remove() {

            $(".red").click(function () {

                var type = $(this).parent().siblings(":nth-child(1)").text();
                var prod = $(this).parent().siblings(":nth-child(2)").text();

                $(this).closest("tr").remove();
                calc_total();

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
        //fin da ..
        

        //debut bons...
        function removesn() {

            $(".redsn").click(function () {

                var type = $(this).parent().siblings(":nth-child(1)").text();
                var prod = $(this).parent().siblings(":nth-child(2)").text();

                $(this).closest("tr").remove();
                //calc_total();
//delete line
                $.ajax({
                    url: '/IMTRADE/Content',
                    method: "POST",
                    data: {
                        typee: type,
                        product: prod,
                        typesn: "deletesn"
                    },
                    success: function (data) {
                        $('#contentx').html(data);
                    }
                });
            });
        }

        removesn();

        $(".greensn").click(function (event) {
//configurer greenSN 
            event.preventDefault();
            if ($("#typearticle").val() == "" || $("#productarticle").val() == "" || $("#qtymodal").val() == "0" || $("#UM").val() == "" || $("#Cond").val() == "") {

                $("#texterror").text("Veuillez remplir tous les champs et soumettre à nouveau le formulaire.");
                $(".alert").addClass("active");
                $(".remove").click(function () {
                    $(".alert").removeClass("active");
                });

            } else {

                var table = $("table#tab_logicsn tbody");
                var type = $("#typearticle").val();
                var product = $("#productarticle").val();
                var qty = parseFloat($("#qtymodal").val());

                var um = $("#UM").val();
                var cond = $("#Cond").val();
                /*qty = qty.toFixed(2);
                 $("#qty").val(qty);*/

                var table = $("table#tab_logicsn tbody");
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


                    $(".tab_logicsnfirst-tr").after('<tr style="font-size: 13px;"><td class="text-left " style="padding-top: 15px;">'
                            + type + '</td><td class="text-left" style="padding-top: 15px;">'
                            + product + '</td><td class="text-center " style="padding-top: 15px;">'
                            + qty + '</td><td class="text-right " style="padding-top: 15px;">' + um
                            + '</td><td class="text-right total1" style="padding-top: 15px;">' + cond + '</td>'
                            + '<td class="static"><span class="button redsn" style="border-radius: 20px;"><i class="glyphicon glyphicon-minus" style="font-size: 25px;font-weight: bold;"></i></span></td>');

                    remove();


                    $.ajax({
                        url: '/IMTRADE/Content',
                        method: "POST",
                        data: {
                            typee: type,
                            product: product,
                            qty: qty,
                            um: um,
                            cond: cond,
                            typesn: "addsn"
                        },
                        success: function (data) {
                            var tablec = $("table#tab_logic_SN tbody");
                            var existc = 1;
                            tablec.find('tr').each(function (i, el) {
                                var $tds = $(this).find('td'),
                                        typei = $tds.eq(0).text(),
                                        producti = $tds.eq(1).text();

                                var idd = $(this).find('td').closest('tr').attr('id');
                                if (idd != "tab_logic_SNaddr0") {
                                    $(this).find('td').closest('tr').remove();
                                }
                                existc++;
                            });
                            $("#typearticle").val("");
                            $("#productarticle").val("");
                            $("#qtymodal").val("0");
                            $("#um").val("/");
                            $("#cond").val("/");
                            $("#qtesn").val("");
                            exist = 0;

                            $('#contentx').html(data);
                        }
                    });


                }

            }
        });

        //fin bons...

        //debut calcule

        /*$('#qtesn').on('change', function () {
         $("#qtymodal").val($('#qtesn').val());
         });*/

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
            calc_total();
            //calc_total2();
            if ($("#modeR").val() == "espèce" && $("#cond2").is(':checked')) {

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
                        timbre: $("#timbre_amount").val(),
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
//changer %
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
            var timbre_sum = 0;
            $("#timbre_amount").val(0);
            if ($("#modeR").val() == "espèce" && $("#cond2").is(':checked')) {
                timbre_sum = $('#sub_total').val() / 100;
                $('#timbre_amount').val(timbre_sum.toFixed(2));
            }

            $('#total_amount').val((timbre_sum + tax_sum + total - remise_sum).toFixed(2));

            $('#total').val((timbre_sum + tax_sum + total - remise_sum).toFixed(2));
        }
//changer valeur
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
            var timbre_sum = 0;
            $("#timbre_amount").val(0);
            if ($("#modeR").val() == "espèce" && $("#cond2").is(':checked')) {
                timbre_sum = $('#sub_total').val() / 100;
                $('#timbre_amount').val(timbre_sum.toFixed(2));
            }

            $('#total_amount').val((timbre_sum + parseInt($('#tax_amount').val()) + total - parseInt($('#remise_amount').val())).toFixed(2));

            $('#total').val((timbre_sum + parseInt($('#tax_amount').val()) + total - parseInt($('#remise_amount').val())).toFixed(2));

        }

        /*function calc_total3()
         {
         //calc_total();
         calc_total2();
         
         
         $('#total_amount').val((parseInt($('#total_amount').val()) + timbre_sum).toFixed(2));
         
         $('#total').val((parseInt($('#total').val()) + timbre_sum).toFixed(2));
         
         
         }*/

        //fin calcule










        function progress_ap() {
            var pval = 0;
            var pcontent = 0;
            var ptotal = 0;
            var progressbar2 = $("#progressbar2"), progressLabel2 = $(".progress-label2");

            progressbar2.progressbar({
                value: false,
                change: function () {
                    progressLabel2.text(pval + " % " + pcontent + " sur " + ptotal);
                },
                complete: function () {
                    progressLabel2.text("Complete!");
                    $("#filename2").text("");
                    $("#progress2-tr").css("display", "none");

                }
            });

            progress2();

            function progress2() {
                $.ajax({
                    url: '/IMTRADE/Ajouterdocument',
                    contentType: 'application/json; charset=utf-8',
                    method: "GET",
                    data: {
                        pval2: pval
                    },
                    success: function (response_av) {

                        var res = response_av.split("%", 3);

                        pval = parseInt(res[0]);
                        ptotal = res[1];
                        pcontent = res[2];

                    },
                    error: function (errorThrown) {
                        //alert("not success :" + errorThrown);
                    }
                });

                progressbar2.progressbar("value", parseInt(pval));
                var val = parseInt(pval);

                if (val < 100) {
                    setTimeout(progress2, 500);
                }

            }


        }


        function progress_av() {

            var pval = 0;
            var pcontent = 0;
            var ptotal = 0;
            var progressbar = $("#progressbar1"), progressLabel = $(".progress-label1");
            //alert("ok1");

            progressbar.progressbar({
                value: false,
                change: function () {
                    //alert("ok2");
                    progressLabel.text(pval + " % " + pcontent + " sur " + ptotal);
                    //alert("ok3");
                },
                complete: function () {
                    progressLabel.text("Complete!");
                    $("#filename1").text("");
                    $("#progress1-tr").css("display", "none");
                    //progressbar.progressbar("value", parseInt(pval));
                    //progressLabel.text("0 % 0 sur 0");
                }
            });

            //alert("ok4");
            progress();

            function progress() {
                $.ajax({
                    url: '/IMTRADE/Ajouterdocument',
                    contentType: 'application/json; charset=utf-8',
                    method: "GET",
                    data: {
                        pval1: pval
                    },
                    success: function (response_av) {
                        //alert(response_av);

                        //pval = parseInt(response_av);
                        //alert(response_av);

                        var res = response_av.split("%", 3);

                        pval = parseInt(res[0]);
                        ptotal = res[1];
                        pcontent = res[2];

                    },
                    error: function (errorThrown) {
                        //alert("not success :" + errorThrown);
                    }
                });
                //pval = pval + 5;
                progressbar.progressbar("value", parseInt(pval));
                var val = parseInt(pval);
                //alert(val);
                if (val < 100) {
                    setTimeout(progress, 500);
                }

            }

        }

        //***att_av
        var tmppath = "";
        var fileTypes = ['pdf'];  //acceptable file types
        function readURL(input) {
            if (input.files && input.files[0]) {
                var extension = input.files[0].name.split('.').pop().toLowerCase(), //file extension from input file
                        isSuccess = fileTypes.indexOf(extension) > -1;  //is extension in acceptable types

                if (isSuccess) { //yes
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        if (extension == 'pdf') {
                            $(input).closest('.fileUpload').find(".icon").attr('src', 'https://image.flaticon.com/icons/svg/179/179483.svg');
                        } else {
                            //console.log('here=>'+$(input).closest('.uploadDoc').length);
                            $(input).closest('.uploadDoc').find(".docErr").slideUp('slow');
                        }
                    }

                    reader.readAsDataURL(input.files[0]);
                } else {
                    //console.log('here=>'+$(input).closest('.uploadDoc').find(".docErr").length);
                    $(input).closest('.uploadDoc').find(".docErr").fadeIn();
                    setTimeout(function () {
                        $('.docErr').fadeOut('slow');
                    }, 3000);
                }
            }
        }



        function remove1() {
            $(".red1").click(function () {

                var type = $(this).parent().siblings(":nth-child(1)").text();
                var doc = $(this).parent().siblings(":nth-child(2)").text();

                $(this).closest("tr").remove();
                calc_total();
                //delete line
                $.ajax({
                    url: '/IMTRADE/Content',

                    data: {
                        typef: type,
                        document: doc,
                        fileform: "deletetype1"
                    },
                    success: function (data) {
                        //$('#contentx').html(data);
                        $('#contentx').html(data);
                    }
                });


            });
        }

        function remove2() {
            $(".red2").click(function () {

                var type = $(this).parent().siblings(":nth-child(1)").text();
                var doc = $(this).parent().siblings(":nth-child(2)").text();

                $(this).closest("tr").remove();
                calc_total();
                //delete line
                $.ajax({
                    url: '/IMTRADE/Content',
                    //                url: '../../VersServlet.jsp',
                    data: {
                        typef: type,
                        document: doc,
                        fileform: "deletetype2"
                    },
                    success: function (data) {
                        //$('#contentx').html(data);
                        $('#contentx').html(data);
                    }
                });


            });
        }

        remove1();
        remove2();

    <%
        for (int i = 1; i < 3; i++) {
    %>

        $(document).on('change', '.upfile<%=i%>', function () {
            var id = $(this).attr('id'); /* gets the filepath and filename from the input */
            var profilePicValue = $(this).val();
            var fileNameStart = profilePicValue.lastIndexOf('\\'); /* finds the end of the filepath */
            profilePicValue = profilePicValue.substr(fileNameStart + 1); /* isolates the filename */
            //alert(profilePicValue);
            //var profilePicLabelText = $(".upl"); /* finds the label text */
            if (profilePicValue != '') {
                //console.log($(this).closest('.fileUpload').find('.upl').length);
                $(this).closest('.fileUpload').find('.uploadname_<%=i%>').html(profilePicValue); /* changes the label text */
            }
        });
        $('#upfile<%=i%>').change(function () {
            var filename = $('#upfile<%=i%>').val();
            //$('#select_file').val(filename);
        });
var attach="";
('#creationcheck').on('change', function (ev) {
        $('.typeahead52').val("");
        $('.typeahead51').val("");
        if ($('#creationcheck').is(':checked')) {
            $('#typefile1').text("Externe");
            $('.typeahead52').css("display", "none");
            $('.typeahead51').css("display", "block");
            attach="1";
        } else {
            $('#typefile1').text("Locale");
            $('.typeahead52').css("display", "block");
            $('.typeahead51').css("display", "none");
            attach="2";
        }
    });

    $('#confirmationcheck').on('change', function (ev) {
        $('.typeahead62').val("");
        $('.typeahead61').val("");
        if ($('#confirmationcheck').is(':checked')) {
            $('#typefile2').text("Externe");
            $('.typeahead62').css("display", "none");
            $('.typeahead61').css("display", "block");
            
        } else {
            $('#typefile2').text("Locale");
            $('.typeahead62').css("display", "block");
            $('.typeahead61').css("display", "none");
            
        }
    });






        $(".green<%=i%>").click(function (event) {
            event.preventDefault();

            if ($("#attach"+attach+"<%=i%>").val() == "" || $("#uploadname_<%=i%>").text() == "Choisir nouveau document") {

                $("#texterrorupload<%=i%>").text("Veuillez remplir tous les champs et soumettre à nouveau le formulaire.");
                $(".alert").addClass("active");
                $(".remove").click(function () {
                    $(".alert").removeClass("active");
                });

            } else {
                //alert($("#uploadname_").text());

                var type = $("#typefile<%=i%>").text();
                var doc = $("#attach<%=i%>").val();
                var doc = $("#attach<%=i%>").val();
                $("#filename<%=i%>").text(doc);
                $("#type<%=i%>").text(type);
                $("#documentnom<%=i%>").text(doc);
                //progress_before();
                //var file = tmppath;
                var filename = $("#uploadname_<%=i%>").text();

                var table = $("#tab_logic<%=i%> tbody");
                var exist = 0;
                table.find('tr').each(function (i, el) {
                    var $tds = $(this).find('td'),
                            typrei = $tds.eq(0).text(),
                            doci = $tds.eq(1).text();
                    var filei = $tds.eq(2).html();

                    if (doci == type && filei == doc) {
                        exist++;
                    }
                    // do something with productId, product, Quantity
                });

                if (exist == 1) {
                    $("#texterror").text(doc + " est existé déjà");
                    $(".alert").addClass("active");
                    $(".remove").click(function () {
                        $(".alert").removeClass("active");
                    });
                } else {

                    var ii = parseInt(<%=i%>);
                    //alert(ii);
                    $("#progress<%=i%>-tr").css("display", "contents");
                    if (ii == 1) {
                        progress_av();
                    }

                    if (ii == 2) {
                        progress_ap();
                    }

                    var type = $("#typefile<%=i%>").text();
                    var doc = $("#attach<%=i%>").val();
                    $("#tab_logic<%=i%>addr0").hide();
                    $("#progress<%=i%>-tr").show();
                    var file = tmppath;
                    var filename = $("#uploadname_<%=i%>").text();

                    $("#typefileinput").val(type);
                    $("#documentinput").val(doc);
                    $("#namefileinput").val(filename);
                    $("#fileform").val("Addtype<%=i%>");

                    var form = $('#signup-form')[0];

                    var datas = new FormData(form);


                    $.ajax({
                        url: '/IMTRADE/Content',
                        type: $("#signup-form").attr('method'),
                        data: datas,
                        contentType: false,
                        cache: false,
                        processData: false,
                        success: function (data) {

                            $(".tab_logic<%=i%>first-tr").after(
                                    '<tr style="font-size: 13px;border-top: 1px solid #daeaf1;">'
                                    + '<td class="text-left" style="padding-top: 15px;">' + filename + '</td>'
                                    + '<td class="text-left" style="padding-top: 15px;">' + type + '</td>'
                                    + '<td class="text-left" style="padding-top: 15px;">' + doc + '</td>'
                                    + '<td class="static"><span class="button red<%=i%>" style="border-radius: 20px;"><i class="glyphicon glyphicon-minus" style="font-size: 25px;font-weight: bold;"></i></span></td>'
                                    + '</tr>');

                            remove1();
                            remove2();

                           
                            $("#attach<%=i%>").val("");
                            $("#uploadname_<%=i%>").text("Choisir nouveau document");
                            $("#svgupload<%=i%>").attr("src", "https://image.flaticon.com/icons/svg/136/136549.svg");
                            $("#progress<%=i%>-tr").hide();
                            $("#tab_logic<%=i%>addr0").show();
                        }
                    });

                }
                exist = 0;
            }
        });

    <%
        }
    %>






        $(".input-effect input").val("");

        $(".input-effect input").focusout(function () {
            if ($(this).val() != "") {
                $(this).addClass("has-content");
            } else {
                $(this).removeClass("has-content");
            }
        });

        $("#validiteo").bind("change paste keyup", function () {
            if ($("#cond5").is(':checked')) {
                $.ajax({
                    url: '/IMTRADE/Content',
                    method: "POST",
                    data: {
                        param: $("#validiteo").val(),
                        condition: "cond5"
                    },
                    success: function (data) {
                        $('#contentx').html(data);
                    }
                });
            }
        });
        $("#delaisl").bind("change paste keyup", function () {
            if ($("#cond4").is(':checked')) {
                $.ajax({
                    url: '/IMTRADE/Content',
                    method: "POST",
                    data: {
                        param: $("#delaisl").val(),
                        condition: "cond4"
                    },
                    success: function (data) {
                        $('#contentx').html(data);
                    }
                });
            }
        });
        $("#modeL").bind("change paste keyup", function () {
            if ($("#cond3").is(':checked')) {
                $.ajax({
                    url: '/IMTRADE/Content',
                    method: "POST",
                    data: {
                        param: $("#modeL").val(),
                        condition: "cond3"
                    },
                    success: function (data) {
                        $('#contentx').html(data);
                    }
                });
            }
        });
        $("#modeR").bind("change paste keyup", function () {
            if ($("#cond2").is(':checked')) {
                $.ajax({
                    url: '/IMTRADE/Content',
                    method: "POST",
                    data: {
                        param: $("#modeR").val(),
                        condition: "cond2"
                    },
                    success: function (data) {
                        $('#contentx').html(data);
                    }
                });
            }
        });


        $("#cond5").on("change", function () {
            if ($("#cond5").is(':checked') && $("#validiteo").val().length > 0) {
                $.ajax({
                    url: '/IMTRADE/Content',
                    method: "POST",
                    data: {
                        param: $("#validiteo").val(),
                        condition: "cond5"
                    },
                    success: function (data) {
                        $('#contentx').html(data);
                    }
                });
            } else {
                $.ajax({
                    url: '/IMTRADE/Content',
                    method: "POST",
                    data: {
                        param: "non",
                        condition: "cond5"
                    },
                    success: function (data) {
                        $('#contentx').html(data);
                    }
                });
            }
        });
        $("#cond4").on("change", function () {
            if ($("#cond4").is(':checked') && $("#delaisl").val().length > 0) {
                $.ajax({
                    url: '/IMTRADE/Content',
                    method: "POST",
                    data: {
                        param: $("#delaisl").val(),
                        condition: "cond4"
                    },
                    success: function (data) {
                        $('#contentx').html(data);
                    }
                });
            } else {
                $.ajax({
                    url: '/IMTRADE/Content',
                    method: "POST",
                    data: {
                        param: "non",
                        condition: "cond4"
                    },
                    success: function (data) {
                        $('#contentx').html(data);
                    }
                });
            }
        });

        $("#cond3").on("change", function () {
            if ($("#cond3").is(':checked') && $("#modeL").val().length > 0) {
                $.ajax({
                    url: '/IMTRADE/Content',
                    method: "POST",
                    data: {
                        param: $("#modeL").val(),
                        condition: "cond3"
                    },
                    success: function (data) {
                        $('#contentx').html(data);
                    }
                });
            } else {
                $.ajax({
                    url: '/IMTRADE/Content',
                    method: "POST",
                    data: {
                        param: "non",
                        condition: "cond3"
                    },
                    success: function (data) {
                        $('#contentx').html(data);
                    }
                });
            }
        });
        $("#cond2").on("change", function () {

            if ($("#cond2").is(':checked') && $("#modeR").val().length > 0) {
                $.ajax({
                    url: '/IMTRADE/Content',
                    method: "POST",
                    data: {
                        param: $("#modeR").val(),
                        condition: "cond2"
                    },
                    success: function (data) {
                        $('#contentx').html(data);
                    }
                });
            } else {
                $("#modeR").val("");
                $("#timbre_amount").val("");
                calc_total();
                $.ajax({
                    url: '/IMTRADE/Content',
                    method: "POST",
                    data: {
                        param: "non",
                        condition: "cond2",
                        timbre: ""
                    },
                    success: function (data) {
                        $('#contentx').html(data);
                    }
                });
            }

        });
        $("#cond1").on("change", function () {
            if ($("#cond1").is(':checked')) {
                //alert("oui");
                $.ajax({
                    url: '/IMTRADE/Content',
                    method: "POST",
                    data: {
                        param: "oui",
                        condition: "cond1"
                    },
                    success: function (data) {
                        $('#contentx').html(data);
                    }
                });
            } else {
                //alert("non");
                $.ajax({
                    url: '/IMTRADE/Content',
                    method: "POST",
                    data: {
                        param: "non",
                        condition: "cond1"
                    },
                    success: function (data) {
                        $('#contentx').html(data);
                    }
                });
            }
        });




            });

</script>