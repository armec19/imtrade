var tablename = "Produit";


var tablename = "Produit";





$(document).on("click", "#cons", function () {

    /* alert("ddddd");
     $("#container2").html('');
     $("#con").show();*/
    $.ajax({
        url: '/IMTRADE/SelectFile',
        method: "POST",
        data: {
            type: "selectpage",
            page: "Stock/Consult.jsp"
        },
        success: function (data) {
            window.open('index.jsp', '_self');
        }
    });



});

$(document).on("click", "#s1", function () {


    var id = $(this).parents("tr").attr("id");
    $("#dtBasicExample > tbody").html("");




    $.ajax({
        url: "/IMTRADE/Manager",
        type: "Post",
        data: {"serial": id, "type": "listSerial", "table": tablename},
        dataType: "json",
        success: function (response) {


            var index = 0;
            var html;
            var table = $('#dtBasicExample').DataTable({

                "lengthMenu": [5, 10, 25, 50, 75, 100],

                "language": {
                    "sProcessing": "Traitement en cours...",
                    "sSearch": "Rechercher&nbsp;:",
                    "sLengthMenu": "Afficher _MENU_ &eacute;l&eacute;ments",
                    "sInfo": "Affichage de l'&eacute;lement _START_ &agrave; _END_ sur _TOTAL_ &eacute;l&eacute;ments",
                    "sInfoEmpty": "Affichage de l'&eacute;lement 0 &agrave; 0 sur 0 &eacute;l&eacute;ments",
                    "sInfoFiltered": "(filtr&eacute; de _MAX_ &eacute;l&eacute;ments au total)",
                    "sInfoPostFix": "",
                    "sLoadingRecords": "Chargement en cours...",
                    "sZeroRecords": "Aucun &eacute;l&eacute;ment &agrave; afficher",
                    "sEmptyTable": "Aucune donn&eacute;e disponible dans le tableau",
                    "oPaginate": {
                        "sFirst": "Premier",
                        "sPrevious": "Pr&eacute;c&eacute;dent",
                        "sNext": "Suivant",
                        "sLast": "Dernier"
                    },
                    "oAria": {
                        "sSortAscending": ": activer pour trier la colonne par ordre croissant",
                        "sSortDescending": ": activer pour trier la colonne par ordre d&eacute;croissant"
                    }
                }
            });

            table
                    .clear()
                    .draw();
            var dataTable = $("#dtBasicExample").dataTable();
            var table = $("#dtBasicExample").DataTable();
            for (var k = 0; k < response.length; k++) {

                index = table.column(0).data().length + 1;

                html = '<tr> <td>' + index + '</td><td>' + response[k].etatSn + '</td>  <td>' + response[k].dateRevenu + '</td> </tr>';
                dataTable = $("#dtBasicExample").dataTable().api();
                tr = document.createElement("tr");
                tr.innerHTML = html;
                dataTable.row.add(tr);
                dataTable.draw();

            }
        }
    });

    $('#historique').modal();
    // modal5.style.display = "block";

});


'use strict';

$(function () {

    $('.search-input input').blur(function () {

        if ($(this).val()) {
            $(this)
                    .find('~ label, ~ span:nth-of-type(n+3)')
                    .addClass('not-empty');
        } else {
            $(this)
                    .find('~ label, ~ span:nth-of-type(n+3)')
                    .removeClass('not-empty');
        }
    });

    $('.search-input input ~ span:nth-of-type(4)').click(function () {
        $('.search-input input').val('');
        $('.search-input input')
                .find('~ label, ~ span:nth-of-type(n+3)')
                .removeClass('not-empty');
    });

    console.log('Hello from console!');

});

$(document).on("click", "#filtrage" + tablename, function () {
    var type = $(this).find("b").text();

    switch ($(this).attr("title")) {
        case "TYPE":
            $('#body_content').load('/IMTRADE/Manager?table=' + tablename + '&type=cardProduit' + '&cond=type' + '&var=' + type);
            break;

        case "MARQUE":
            $('#body_content').load('/IMTRADE/Manager?table=' + tablename + '&type=cardProduit' + '&cond=marque' + '&var=' + type);

            break;

        case "STRUCTURE":
            var id = $(this).find("b").attr("id");
            //alert(id);
            $('#body_content').load('/IMTRADE/Manager?table=' + tablename + '&type=cardProduit' + '&cond=structure' + '&var=' + id);

            break;

    }




});







$(document).on("click", ".imgp", function () {


    $('#updateImage').modal();


});


$(document).on("click", ".voir-serial", function () {
    var typedocument;
    var id_projet;
    var id = $(this).parents("tr").attr("id");


    //modal5.style.display = "block";

    $.ajax({
        url: "/IMTRADE/Manager",
        type: "Post",
        data: {"serial": id, "type": "Serial", "table": tablename},
        dataType: "json",
        success: function (response) {

            $("#detailProduit").find("#general .serial").text(response[0].sn);
            $("#detailProduit").find("#general .etat").text(response[0].etatSn);
            $("#detailProduit").find("#general .date").text(response[0].dateRevenu);
        }
    });

    $.ajax({
        url: "/IMTRADE/Manager",
        type: "Post",
        data: {"serial": id, "type": "typedocument", "table": tablename},
        dataType: "json",
        success: function (response) {


            $("#detailProduit").find("#general .typedocument").text(response);
        }
    });

    $.ajax({
        url: "/IMTRADE/Manager",
        type: "Post",
        data: {"serial": id, "type": "getDistinateur", "table": tablename},
        dataType: "json",
        success: function (response) {


            $("#detailProduit").find("#destinateur .nom_destinateur").text(response.nomDestinateur);
            $("#detailProduit").find("#destinateur .type_destinateur").text(response.typeDestinateur);
            $("#detailProduit").find("#destinateur .phone_destinateur").text(response.phoneDestinateur);
            $("#detailProduit").find("#destinateur .email_destinateur").text(response.emailDestinateur);
            $("#detailProduit").find("#destinateur .registre_commerce").text(response.registreCommerce);
            $("#detailProduit").find("#destinateur .n_argument").text(response.NAgrement);
        }
    });

    $.ajax({
        url: "/IMTRADE/Manager",
        type: "Post",
        data: {"serial": id, "type": "getProjet", "table": tablename},
        dataType: "json",
        success: function (response) {

            id_projet = response.idProjet;
            $("#detailProduit").find("#projet .nom_projet").text(response.nomProjet);

        }
    });

    $.ajax({
        url: "/IMTRADE/Manager",
        type: "Post",
        data: {"serial": id, "type": "getNature", "table": tablename},
        dataType: "json",
        success: function (response) {


            $("#detailProduit").find("#projet .nature").text(response.nomNature);

        }
    });
    $.ajax({
        url: "/IMTRADE/Manager",
        type: "Post",
        data: {"idprojet": id_projet, "type": "getMembre", "table": tablename},
        dataType: "json",
        success: function (response) {
            var li;
            for (var i = 0; i < response.length; i++) {
                li = '<li>' + response[i].nom + '' + response[i].prenom + '</li>';
                $("#detailProduit").find("#projet .membre").append(li);
            }



        }
    });

    ;




    $('#detailProduit').modal();

});





$(document).on("click", ".save3", function () {
    //alert('dandi');
    var fd = new FormData();
    var img = $(this).parents('.modal').find('#image2')[0].files[0];
    fd.append('file', img);

    var _textfield1 = $(this).parents('.modal').find("#id1").attr('value');

    //alert(_textfield1);
    fd.append('id', _textfield1);
    fd.append('type', 'updateImage');
    fd.append('table', tablename);
    $.ajax({
        url: '/IMTRADE/Manager',
        type: 'POST',
        enctype: "multipart/form-data",
        data: fd,

        processData: false,
        contentType: false,
        success: function (response) {




            $(".imgp").find("img").attr("src", response);
        }
    });




});





var options = {
    valueNames: ['index', 's1', 'e1', 'd1']
}
, documentTable = new List('myTable1', options)
        ;


$($('th.sort')[0]).trigger('click', function () {
    console.log('clicked');
});

$('input.search').on('keyup', function (e) {
    if (e.keyCode === 27) {
        $(e.currentTarget).val('');
        documentTable.search('');
    }
});
