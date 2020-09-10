<%@page import="maps.Utilisateur"%>
<%
    String attributs = "manage%%N°%%Material%%Marque%%Modele%%Quantité%%Prix unitaire%%Structure";
    attributs = attributs.replaceAll(" ", "-");
    String[] attribut = attributs.split("%%");
    String tablename = "Produit";

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script>
    $(function () {
        var att = new Array();
        att = '<%=attributs%>'.split("%%");
        $('#table<%=tablename%>').DataTable({

            'columnDefs': [
                {
                    'targets': 0,
                    'checkboxes': {
                        'selectRow': true
                    }
                }
            ],
            'select': {
                'style': 'multi'
            },
            "lengthMenu": [5, 10, 25, 50, 75, 100],
            scrollCollapse: true,
            scrollX: true,
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
            },
            dom: 'Bfrtip',
            buttons: ['copy', 'csv', 'excel', 'pdf', 'print']


        });
        var table = $('#table<%=tablename%>').DataTable();
        //table.column(2)


        $('.buttons-copy, .buttons-csv, .buttons-print, .buttons-pdf, .buttons-excel').addClass('btn btn-outline-info waves-effect waves-light');
        $('.dt-buttons').addClass('col-md-5 text-right');
        $('.buttons-copy, .buttons-csv, .buttons-print, .buttons-pdf, .buttons-excel').removeClass('dt-button');
        $('#table<%=tablename%>_wrapper').removeClass('container-fluid');
        $('#table<%=tablename%>_filter').addClass('col-md-7 text-left');
        $('#table<%=tablename%>_filter>label').css('width', '100%');
        $('.dataTables_paginate').css('display', 'inline-block');
        $('.dataTables_info').addClass('col-md-6 text-left');
        $('.dataTables_paginate').addClass('col-md-6 text-right');
        $('#table<%=tablename%>_filter>label>input').css('width', '100%');
       
        
        <%    Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur");      
              String role=utilisateur.getRole();%>
                      
              <%if(role.equals("role3")){%>
                    table.column(1).visible(false);
                    
                  $('#check-<%=tablename%>-manage').hide();
                
                   $('#modeStock').hide();
                  
                                       <% }%>
                                           
                   <%if(role.equals("role2")){%>
                       
                       $("a:contains(ÉDITER)").hide();
                       $("a:contains(EFFACER)").hide();
                       
                       
                       
                       <% }%>
                            <%if(!role.equals("role1")&&!role.equals("Magasinier")){%> 
                       
                       $("i:contains(add_circle_outline)").hide();
                       
                       
                       
                       
                       <% }%>
                           <%if(role.equals("role1")){%> 
        
                                 
                               
                               
                                    
                                  
                                   
                                     
                                 <% }%>
                                     
                                     
                                     
        
    <%
        for (int i = 0; i < attribut.length; i++) {
    %>


        //alert(att[i]);
        $('#check-<%=tablename%>-<%= attribut[i]%>').change(function ()
        {

            if ($(this).is(':checked')) {
                table.column(parseInt('<%=i + 1%>')).visible(true);
            } else {
                table.column(parseInt('<%=i + 1%>')).visible(false);
            }
            //$('#table').DataTable().ajax.reload();
        });
    <%
        }
    %>

    }
    );
    

</script>
