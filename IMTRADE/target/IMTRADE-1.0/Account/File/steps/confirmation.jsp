<%@page import="maps.Doctype"%>
<%@page import="maps.Document"%>
<%@page import="maps.TemplateDocument"%>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src='https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<%
    TemplateDocument templateDocument = null;
    Document document = null;
    if (session.getAttribute("TemplateDocument") != null) {
        templateDocument = (TemplateDocument) session.getAttribute("TemplateDocument");
        document = (Document) session.getAttribute("docimtrade");

    }
    if (session.getAttribute("docimtrade") != null) {
        document = (Document) session.getAttribute("docimtrade");

    }
    Doctype doctype = (Doctype) session.getAttribute("Doctype");
%>

<style>
    .ui-progressbar2 {
        position: relative;

        position: relative;
        width: 100%;

        border-radius: 0px;
        border: solid 1px #93d2ff;

        -webkit-border-radius: 3px;
        -moz-border-radius: 3px;
        border-radius: 3px;
    }
    .progress-label2 {
        position: absolute;
        color:#368;
        font-size: 10px;
        left: 1%;
        font-weight: bold;
        text-shadow: 1px 1px 0 #fff;
    }
    .ui-progressbar-value {
        width: 0px;
        background-color: #09f;
        transition: width 2s;
        -webkit-border-radius: 3px;
        -moz-border-radius: 3px;
        border-radius: 3px;
        background-image: -webkit-linear-gradient(left, #09f 95%, #fff 105%, #fff 105%);
        height: 110%;
    }
</style>
<h3>
    Confirmation
</h3>
<fieldset> 
    <h3 class='h33' style='text-align:center;display: block;'>Les attachements de confirmation</h3>
    <div class="container" style="width: 125%;margin-left: -80px;padding: 0px;">
        <main id="table" style="width:100%;height: 300px;overflow-y: auto;margin-right: 23px;">
            <table class="table" id="tab_logic2">
                <thead>
                    <tr style="background: rgb(51, 122, 183);color:white;">
                        <th class="col-md-6 th text-center">Lien</th>
                        <th class="col-md-1 th text-center">Type</th>
                        <th class="col-md-4 th text-center">Document</th>
                        <th class="col-md-1 th text-center">#</th>
                    </tr>
                </thead>
                <tbody>
                    <tr id="progress2-tr" style="display:none;">
                        <td class="static">
                            <div class="col-lg-12" style="color:#368;padding-left: 0px;display: block;">
                                <div id="progressbar2" style="height: 20px;">
                                    <div class="progress-label progress-label2"></div>    
                                </div>
                                <h6 id="filename2" style="margin: 5px;"></h6>
                            </div>
                        </td>
                        <td class="static"></td>
                        <td class="static"></td>
                        <td class="static"></td>
                    </tr>
                    <%
                        if (session.getAttribute("docimtrade") != null) {
                            if (!document.getDocumentEtat().equals("confirmed")) {
                    %>
                    <tr id='tab_logic2addr0' class="tab_logic2first-tr" style="/* background: #ebfde5;green:#ebfde5/blue:#f0f8ff/red:#fff0f0 */">

                        <td class="static">

                            <div class="row it" style="margin-bottom: -30px;margin-top: -5px;">
                                <div id="uploader">
                                    <div class="row uploadDoc">

                                        <div class="col-lg-11">
                                            <div class="docErr">Veuillez uploader un fichier valide</div>
                                            <div class="fileUpload btn btn-orange">
                                                <img id="svgupload2" src="https://image.flaticon.com/icons/svg/136/136549.svg" class="icon">
                                                <span class="uploadname_2" id="uploadname_2">Choisir nouveau document</span>

                                                <input type="hidden" name="typefileinput" id="typefileinput" />
                                                <input type="hidden" name="documentinput" id="documentinput" />
                                                <input type="hidden" name="namefileinput" id="namefileinput" />
                                                <input type="file" class="upload upfile2" id="upfile2" name="upfile2" accept="application/pdf" onchange="readURL(this);" />
                                                <input type="hidden" name="fileform" id="fileform" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </td>
                        <td class="static">
<!--                            <div class="list" style="width: 100%">
                                <div class="wrapper typo" style="margin-top: 20px;">

                                    <span class="placeholder2" id='typefile2'>Type</span>
                                    <ul class="list__ul2" style="    top: 20px;width: 100%; overflow-y: auto;height: 150px;">
                                        <li><a href="">Locale</a></li>
                                        <li><a href="">Externe</a></li>
                                    </ul>
                                </div>
                            </div>-->
                            <label id="typefile2" for="confirmationcheck">Locale</label>
                            <input type="checkbox" id="confirmationcheck" class="js-switch" data-color="#00bcd4" data-size="small" />

                            <!--                                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" autofocus type="text" name='type'    placeholder='type' class="effect-4 text-left type">-->

                        </td>
                        <td id="the-basics" class="static">


                            <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;display: none;" autofocus type="text" name='attach2' id='attach2' placeholder="Nom d'attachment" class="effect-4 text-left attach2 typeahead61">
                            <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" autofocus type="text" name='attach2' id='attach2' placeholder="Nom d'attachment" class="effect-4 text-left attach2 typeahead62">
                            <!--                                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" autofocus type="text" name='product' placeholder='produit' class="effect-4 text-left product">-->
                        </td>

                        <!--                        <td class="static">
                        
                                                    <div class="list" style="width: 100%">
                                                        <div class="wrapper typo" style="margin-top: 20px;">
                        
                                                            <span class="placeholder3" id='document2'>Document</span>
                                                            <ul class="list__ul3" style="top: 20px;width: 100%; overflow-y: auto;height: 150px;">
                                                                <li><a href="">fiche d'analyse</a></li>
                                                                <li><a href="">fiche 2</a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                        
                                                                                                        <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" autofocus type="text" name='product' placeholder='produit' class="effect-4 text-left product">
                                                </td>-->

                        <td class="static"><button type="button" style="margin-top: 10px;border-radius: 20px;" class="button green2"><i class="glyphicon glyphicon-plus" style="font-size: 25px;font-weight: bold;"></i></button></td>

                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr id='tab_logic2addr0' class="tab_logic2first-tr" style="/* background: #ebfde5;green:#ebfde5/blue:#f0f8ff/red:#fff0f0 */">

                        <td class="static">

                            <div class="row it" style="margin-bottom: -30px;margin-top: -5px;">
                                <div id="uploader">
                                    <div class="row uploadDoc">

                                        <div class="col-lg-11">
                                            <div class="docErr">Veuillez uploader un fichier valide</div>
                                            <div class="fileUpload btn btn-orange">
                                                <img id="svgupload2" src="https://image.flaticon.com/icons/svg/136/136549.svg" class="icon">
                                                <span class="uploadname_2" id="uploadname_2">Choisir nouveau document</span>

                                                <input type="hidden" name="typefileinput" id="typefileinput" />
                                                <input type="hidden" name="documentinput" id="documentinput" />
                                                <input type="hidden" name="namefileinput" id="namefileinput" />
                                                <input type="file" class="upload upfile2" id="upfile2" name="upfile2" accept="application/pdf" onchange="readURL(this);" />
                                                <input type="hidden" name="fileform" id="fileform" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </td>
                        <td class="static">
                            <!--                            <div class="list" style="width: 100%">
                                                            <div class="wrapper typo" style="margin-top: 20px;">
                            
                                                                <span class="placeholder2" id='typefile2'>Type</span>
                                                                <ul class="list__ul2" style="    top: 20px;width: 100%; overflow-y: auto;height: 150px;">
                                                                    <li><a href="">Locale</a></li>
                                                                    <li><a href="">Externe</a></li>
                                                                </ul>
                                                            </div>
                                                        </div>-->
                            <label id="typefile2" for="confirmationcheck">Locale</label>
                            <input type="checkbox" id="confirmationcheck" class="js-switch" data-color="#00bcd4" data-size="small" />

                        </td>
                        <td id="the-basics" class="static">


                            <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;display: none;" autofocus type="text" name='attach2' id='attach2' placeholder="Nom d'attachment" class="effect-4 text-left attach2 typeahead61">
                            <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" autofocus type="text" name='attach2' id='attach2' placeholder="Nom d'attachment" class="effect-4 text-left attach2 typeahead62">

                            <!--                                                    <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" autofocus type="text" name='product' placeholder='produit' class="effect-4 text-left product">-->
                        </td>

                        <!--                        <td class="static">
                        
                                                    <div class="list" style="width: 100%">
                                                        <div class="wrapper typo" style="margin-top: 20px;">
                        
                                                            <span class="placeholder3" id='document2'>Document</span>
                                                            <ul class="list__ul3" style="top: 20px;width: 100%; overflow-y: auto;height: 150px;">
                                                                <li><a href="">fiche d'analyse</a></li>
                                                                <li><a href="">fiche 2</a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                        
                                                                                                        <input style="font-size: 13px;padding: 0px;background: #00000000;border-color: transparent;" autofocus type="text" name='product' placeholder='produit' class="effect-4 text-left product">
                                                </td>-->

                        <td class="static"><button type="button" style="margin-top: 10px;border-radius: 20px;" class="button green2"><i class="glyphicon glyphicon-plus" style="font-size: 25px;font-weight: bold;"></i></button></td>

                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <div class="alert">
                <h2>Erreur !</h2>
                <p id="texterrorupload2">Veuillez remplir tous les champs et soumettre à nouveau le formulaire.</p>

                <input type="button" style="width: auto;margin-bottom: 10px;" value="Retour" class="btn btn-danger center-block button remove"> 

            </div>
        </main>
    </div> 

</fieldset>
