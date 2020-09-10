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
            }, 9000);
        }
    }
}

$(document).ready(function () {
    $('.nomfichierinput').autoComplete({
        minChars: 1,
        source: function (term, suggest) {
            term = term.toLowerCase();
            var choices = ['Service1', 'Service2', 'Service3', 'Service4'];
            var suggestions = [];
            for (i = 0; i < choices.length; i++)
                if (~choices[i].toLowerCase().indexOf(term))
                    suggestions.push(choices[i]);
            suggest(suggestions);
        }
    });
    $(document).on('change', '.up', function () {
        var id = $(this).attr('id'); /* gets the filepath and filename from the input */
        var profilePicValue = $(this).val();
        var fileNameStart = profilePicValue.lastIndexOf('\\'); /* finds the end of the filepath */
        profilePicValue = profilePicValue.substr(fileNameStart + 1).substring(0, 20); /* isolates the filename */
        //var profilePicLabelText = $(".upl"); /* finds the label text */
        if (profilePicValue != '') {
            //console.log($(this).closest('.fileUpload').find('.upl').length);
            $(this).closest('.fileUpload').find('.upl').html(profilePicValue); /* changes the label text */
        }
    });



    $(document).on("click", "a.btn-check", function () {
        if ($(".uploadDoc").length > 1) {
            $(this).closest(".uploadDoc").remove();
        } else {
            alert("Vous devez uploader au moins un document.");
        }
    });
});
$(document).ready(function () {
    function remove() {
        $(".red1").click(function () {

            var type = $(this).parent().siblings(":nth-child(1)").text();
            var doc = $(this).parent().siblings(":nth-child(2)").text();

            $(this).closest("tr").remove();
            calc_total();
            //delete line
            $.ajax({
                url: '/IMTRADE/Content',
                method:"POST",
//                url: '../../VersServlet.jsp',
                data: {
                    typef: type,
                    document: doc,
                    fileform: "delete"
                },
                success: function (data) {
                    //$('#contentx').html(data);
                    $('#contentx').html(data);
                }
            });


        });
    }

    remove();
    $('#up').change(function () {
        var filename = $('#up').val();
        $('#select_file').val(filename);
    });
    $(".green1").click(function (event) {
        event.preventDefault();

        var type = $("#typefile").text();
        var doc = $("#document").text();
        var file = tmppath;
        var filename = $("#upload").text();
        if ($("#typefile").text() == "Type" || $("#document").text() == "Document" || $("#upload").val() == "Choisir nouveau document") {
          
            $("#texterrorupload").text("Veuillez remplir tous les champs et soumettre à nouveau le formulaire.");
            $(".alert").addClass("active");
            $(".remove").click(function () {
                $(".alert").removeClass("active");
            });
          
        } else {

            var table = $("#tab_logic1 tbody");
            var exist = 0;
            table.find('tr').each(function (i, el) {
                var $tds = $(this).find('td'),
                        typrei = $tds.eq(0).text(),
                        doci = $tds.eq(1).text();
                filei = $tds.eq(2).html();
   
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
                var type = $("#typefile").text();
                var doc = $("#document").text();
                var file = tmppath;

                var filename = $("#upload").text();

                $("#typefileinput").val(type);
                $("#documentinput").val(doc);
                $("#namefileinput").val(filename);
                $("#fileform").val("Add");
               
                var form = $('#signup-form')[0];

                var datas = new FormData(form);

           
                $.ajax({
                    url: '/IMTRADE/Content',
//                    url:  '../../VersServlet.jsp',
                    method:"POST",
                    type: $("#signup-form").attr('method'),
                    data: datas,
                    contentType: false,
                    cache: false,
                    processData: false,
                    success: function (data) {
                        $(".first-tr").after(
                                '<tr style="font-size: 13px;">'
                                + '<td class="text-left" style="padding-top: 15px;">' + filename + '</td>'
                                + '<td class="text-left" style="padding-top: 15px;">' + type + '</td>'
                                + '<td class="text-left" style="padding-top: 15px;">' + doc + '</td>'
                                + '<td class="static"><span class="button red1" style="border-radius: 20px;"><i class="glyphicon glyphicon-minus" style="font-size: 25px;font-weight: bold;"></i></span></td>'
                                + '</tr>');

                        remove();
                        $("#typefile").text("Type");
                        $("#document").text("Document");
                        $("#upload").text("Choisir nouveau document");
                        $("#svgupload").attr("src", "https://image.flaticon.com/icons/svg/136/136549.svg");

                    }
                });

            }
            exist = 0;
        }
    });
    var tmppath = "";

    $(".input-effect input").val("");

    $(".input-effect input").focusout(function () {
        if ($(this).val() != "") {
            $(this).addClass("has-content");
        } else {
            $(this).removeClass("has-content");
        }
    });

});