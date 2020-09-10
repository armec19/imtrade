var fileTypes = ['pdf', 'docx', 'rtf', 'jpg', 'jpeg', 'png', 'txt'];  //acceptable file types
function readURL(input) {
    if (input.files && input.files[0]) {
        var extension = input.files[0].name.split('.').pop().toLowerCase(), //file extension from input file
                isSuccess = fileTypes.indexOf(extension) > -1;  //is extension in acceptable types

        if (isSuccess) { //yes
            var reader = new FileReader();
            reader.onload = function (e) {
                if (extension == 'pdf') {
                    $(input).closest('.fileUpload').find(".icon").attr('src', 'https://image.flaticon.com/icons/svg/179/179483.svg');
                } else if (extension == 'docx') {
                    $(input).closest('.fileUpload').find(".icon").attr('src', 'https://image.flaticon.com/icons/svg/281/281760.svg');
                } else if (extension == 'rtf') {
                    $(input).closest('.fileUpload').find(".icon").attr('src', 'https://image.flaticon.com/icons/svg/136/136539.svg');
                } else if (extension == 'png') {
                    $(input).closest('.fileUpload').find(".icon").attr('src', 'https://image.flaticon.com/icons/svg/136/136523.svg');
                } else if (extension == 'jpg' || extension == 'jpeg') {
                    $(input).closest('.fileUpload').find(".icon").attr('src', 'https://image.flaticon.com/icons/svg/136/136524.svg');
                } else if (extension == 'txt') {
                    $(input).closest('.fileUpload').find(".icon").attr('src', 'https://image.flaticon.com/icons/svg/136/136538.svg');
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
    $(".btn-new").on('click', function () {

        $(".btn-new").on('click', function () {
            $("#uploader").append(
                    '<link rel="stylesheet" href="../../css/chosen/bootstrap-chosen.css">' +
                    '<link rel="stylesheet" href="../../css/chosen/bootstrap-chosen.css">' +
                    '<script src="../../css/autocomplet/jquery.auto-complete.js"/>' +
                    '<div class="row uploadDoc"><div class="col-sm-3"><div class="docErr">Please upload valid file</div><div class="fileUpload btn btn-orange"> <img src="https://image.flaticon.com/icons/svg/136/136549.svg" class="icon"><span class="upl" id="upload">Upload document</span><input type="file" class="upload up" id="up" onchange="readURL(this);" /></div></div> <div class="col-lg-3" style="margin-top: 20px;"><select style="width:100%;margin-bottom: 10px;" data-placeholder="Selectionner un type de fichier" placeholder="Selectionner un type de fichier" class="chosen-select" tabindex="-1"><option></option><option value="Local">Local</option><option value="Externe">Externe</option></select></div> <form onsubmit="$(\'.nomfichierinput\').blur();return false;"> <div class="col-lg-5" style="margin-top: 20px;"><input type="text" class="form-control nomfichierinput nomfichier"  id="nomfichierinput" name="" placeholder="Nom de fichier"></div></form><div class="col-lg-1"><a class="btn-check"><i class="fa fa-times"></i></a></div></div>' +
                    '<script src="../../js/chosen/chosen.jquery.js" />' +
                    '<script src="../../js/chosen/chosen-active.js" />');

        });
    });

    $(document).on("click", "a.btn-check", function () {
        if ($(".uploadDoc").length > 1) {
            $(this).closest(".uploadDoc").remove();
        } else {
            alert("Vous devez uploader au moins un document.");
        }
    });
});