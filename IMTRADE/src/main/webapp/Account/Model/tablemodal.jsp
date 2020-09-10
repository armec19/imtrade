<%@page import="maps.TypeAttachment"%>
<%@page import="maps.TypeNature"%>
<%@page import="maps.DesignationNature"%>
<%@page import="maps.Nature"%>
<%@page import="maps.Destinateur"%>
<%@page import="maps.Doctype"%>
<%@page import="maps.Notification"%>
<%@page import="maps.ModeReglement"%>
<%@page import="maps.ModeLivraison"%>
<%@page import="maps.Projet"%>
<%@page import="maps.ObjetType"%>
<%@page import="java.util.HashMap"%>
<%@page import="maps.Membre"%>
<%@page import="maps.Utilisateur"%>
<%@page import="maps.Objet"%>
<%@page import="maps.Structure"%>
<%@page import="module.ModelBean"%>
<%@page import="maps.Produit"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>

<script src="../assets/node_modules/jquery/jquery-3.2.1.min.js"></script>



<%

    String tablename = (String) request.getAttribute("tablemanage");

    Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur");

    String manage = "VOIR%%ÉDITER%%EFFACER";
    String[] listmanage = manage.split("%%");
    String attributs = "";
    String attributsTotal;
    String attributsFiltrage; 
    String attributsEdit;
    String attributsinput;
    String attributsinputFiltrage;
    String attributsinputEdit; 
    String[] attributsTotalUtilsable = null;
    String[] attributsEditUtilsable = null;
     String[] attributsFiltrageUtilsable = null;
    String[] Type_Input = null;
    String[] Type_Input_Edit = null;
     String[] Type_Input_Filtrage = null;
    String AutreAttributs = "";
    String[] listeatt = null;
    String[] listAutre = null;
    int rowTable = 0;
    String[] listVariable = null;
    String[] listVariableAutre = null;
    HashMap<String, String[]> Select = new HashMap<String, String[]>();

    if(tablename.equals("Produit")){
            attributs = "manage%%N°%%Nom%%Marque%%Modele%%Quantité%%Prix unitaire%%Structure%%ProduitDe";
    attributsTotal = "Nom%%Designation%%Matricule%%Type%%ProduitDe%%Marque%%Modele%%Prix-unitaire%%Structure%%Image"; 
    attributsFiltrage = "Nom%%Designation%%Matricule%%Type%%ProduitDe%%Marque%%Modele%%Structure"; 
    attributsEdit = "Designation%%Matricule%%Marque%%Modele%%Prix-unitaire%%Structure";
     attributsinput = "text%%text%%text%%text%%ProduitDe%%text%%text%%number%%Structure%%file";
     attributsinputFiltrage = "text%%text%%text%%text%%ProduitDe%%text%%text%%Structure";
     attributsinputEdit = "text%%text%%text%%text%%number%%Structure"; 
      Type_Input = attributsinput.split("%%");
      Type_Input_Edit = attributsinputEdit.split("%%");
      Type_Input_Filtrage = attributsinputFiltrage.split("%%");
      attributs = attributs.replaceAll(" ", "-"); 
         
     attributsTotalUtilsable = attributsTotal.split("%%");
     attributsFiltrageUtilsable = attributsFiltrage.split("%%");  
       attributsEditUtilsable = attributsEdit.split("%%");
      AutreAttributs = "Type%%Matricule%%Designation";
      listeatt = attributs.split("%%");
   
    listAutre = AutreAttributs.split("%%");
     List<Structure> structure = ModelBean.GetContentTable("Structure", "where isDeleted=" + 0);
    List<Produit> listProduit = ModelBean.GetContentTable("Produit", "where isDeleted=" + 0);
     rowTable = listProduit.size();
       listVariable = new String[(listeatt.length-1) * rowTable];
     listVariableAutre = new String[listAutre.length * rowTable];
     
        String structure1 = "s";
      
    for (int i = 0; i < listProduit.size(); i++) {
        
        Objet objet1 = (Objet) ModelBean.GetContentTable("Objet", "where id_objet=" + listProduit.get(i).getIdObjet()).get(0);

        for (int k = 0; k < structure.size(); k++) {
            if (objet1.getIdStructure() == structure.get(k).getIdStructure()) {
                structure1 = structure.get(k).getNomStructure();
            }
            

        }
  
       
        
        listVariable[i + ((listeatt.length - 2) * i)] = String.valueOf(listProduit.get(i).getIdProduit());
        listVariable[i + 1 + ((listeatt.length - 2) * i)] = listProduit.get(i).getNomProduit();
        listVariable[i + 2 + ((listeatt.length - 2) * i)] = listProduit.get(i).getMarque();
        listVariable[i + 3 + ((listeatt.length - 2) * i)] = listProduit.get(i).getModele(); 
        listVariable[i + 4 + ((listeatt.length - 2) * i)] = String.valueOf(listProduit.get(i).getQuantite());
        listVariable[i + 5 + ((listeatt.length - 2) * i)] = String.valueOf(listProduit.get(i).getPrix());
        listVariable[i + 6 + ((listeatt.length - 2) * i)] = structure1;
        listVariable[i + 7 + ((listeatt.length - 2) * i)] = listProduit.get(i).getTypeProduit();
        ObjetType objettype=(ObjetType)ModelBean.GetContentTable("ObjetType", "where id_objet_type=" +objet1.getTypeObjet()).get(0);
        listVariableAutre[i + ((listAutre.length - 1) * i)] =objettype.getNomObjetType();
        listVariableAutre[i + 1 + ((listAutre.length - 1) * i)] = listProduit.get(i).getMatricule();
        listVariableAutre[i + 2 + ((listAutre.length - 1) * i)] = listProduit.get(i).getDesignation();
    }
    
    String[] list_Type_Produit = new String[2];
       list_Type_Produit[0]="STOCK"; 
       list_Type_Produit[1]="FONCTION"; 
    
    String[] list_structure = new String[structure.size()];
    for (int str = 0; str < structure.size(); str++) {
        list_structure[str] = structure.get(str).getNomStructure();

    }

  
    Select.put("Structure", list_structure);
     Select.put("ProduitDe", list_Type_Produit);
    
     }

     if(tablename.equals("Article")){
           attributs = "manage%%N°%%Nom%%Marque%%Modele%%Quantité%%Prix unitaire%%Structure%%ProduitDe";
    attributsTotal = "Nom%%Designation%%Matricule%%Type%%ProduitDe%%Marque%%Modele%%Prix-unitaire%%Structure%%Image";
    attributsFiltrage = "Nom%%Designation%%Matricule%%Type%%ProduitDe%%Marque%%Modele%%Structure";
    attributsEdit = "Designation%%Matricule%%Marque%%Modele%%Prix-unitaire%%Structure";
     attributsinput = "text%%text%%text%%text%%ProduitDe%%text%%text%%number%%Structure%%file";
     attributsinputFiltrage = "text%%text%%text%%text%%ProduitDe%%text%%text%%Structure"; 
     attributsinputEdit = "text%%text%%text%%text%%number%%Structure"; 
      Type_Input = attributsinput.split("%%");
      Type_Input_Edit = attributsinputEdit.split("%%");
      Type_Input_Filtrage = attributsinputFiltrage.split("%%");
      attributs = attributs.replaceAll(" ", "-"); 
         
     attributsTotalUtilsable = attributsTotal.split("%%");
     attributsFiltrageUtilsable = attributsFiltrage.split("%%"); 
       attributsEditUtilsable = attributsEdit.split("%%"); 
      AutreAttributs = "Type%%Matricule%%Designation";
      listeatt = attributs.split("%%");
   
    listAutre = AutreAttributs.split("%%");
     List<Structure> structure = ModelBean.GetContentTable("Structure", "where isDeleted=" + 0);
    List<Produit> listProduit = ModelBean.GetContentTable("Produit", "where isDeleted=" + 0);
     List<Produit> listProduitAll = ModelBean.GetContentTable("Produit", "where isDeleted=" + 0);
     
     
           String[]list_structure = new String[structure.size()];
    for (int str = 0; str < structure.size(); str++) {
        list_structure[str] = structure.get(str).getNomStructure();

    }
    
       if(!utilisateur.getRole().equals("role1")){  
         
           
                 listProduit.removeAll(listProduit);
                 
         
          for(int j=0;j<listProduitAll.size();j++){
              Objet objet=(Objet)ModelBean.GetContentTable("Objet", "where id_objet="+ listProduitAll.get(j).getIdObjet()+"  AND isDeleted=" + 0).get(0); 
          
              if(objet.getIdStructure()==utilisateur.getIdStructure())
              listProduit.add(listProduitAll.get(j));
         
          
          }
                 
                 
                 
                 
                 
             }
    
    
    
    
     rowTable = listProduit.size();
       listVariable = new String[(listeatt.length-1) * rowTable];
     listVariableAutre = new String[listAutre.length * rowTable];
     
        String structure1 = "s";
      
    for (int i = 0; i < listProduit.size(); i++) {
        
        Objet objet1 = (Objet) ModelBean.GetContentTable("Objet", "where id_objet=" + listProduit.get(i).getIdObjet()).get(0);

        for (int k = 0; k < structure.size(); k++) {
            if (objet1.getIdStructure() == structure.get(k).getIdStructure()) {
                structure1 = structure.get(k).getNomStructure();
            }
            

        }
  
       
        
        listVariable[i + ((listeatt.length - 2) * i)] = String.valueOf(listProduit.get(i).getIdProduit());
        listVariable[i + 1 + ((listeatt.length - 2) * i)] = listProduit.get(i).getNomProduit();
        listVariable[i + 2 + ((listeatt.length - 2) * i)] = listProduit.get(i).getMarque();
        listVariable[i + 3 + ((listeatt.length - 2) * i)] = listProduit.get(i).getModele(); 
        listVariable[i + 4 + ((listeatt.length - 2) * i)] = String.valueOf(listProduit.get(i).getQuantite());
        listVariable[i + 5 + ((listeatt.length - 2) * i)] = String.valueOf(listProduit.get(i).getPrix());
        listVariable[i + 6 + ((listeatt.length - 2) * i)] = structure1;
        listVariable[i + 7 + ((listeatt.length - 2) * i)] = listProduit.get(i).getTypeProduit();
        ObjetType objettype=(ObjetType)ModelBean.GetContentTable("ObjetType", "where id_objet_type=" +objet1.getTypeObjet()).get(0);
        listVariableAutre[i + ((listAutre.length - 1) * i)] =objettype.getNomObjetType();
        listVariableAutre[i + 1 + ((listAutre.length - 1) * i)] = listProduit.get(i).getMatricule();
        listVariableAutre[i + 2 + ((listAutre.length - 1) * i)] = listProduit.get(i).getDesignation();
    }
    
    String[] list_Type_Produit = new String[2];
       list_Type_Produit[0]="STOCK"; 
       list_Type_Produit[1]="FONCTION"; 
     if(!utilisateur.getRole().equals("role1")){  
           list_structure = new String[1];
           list_structure[0]=structure1; 
         
     }
   

  
    Select.put("Structure", list_structure);
     Select.put("ProduitDe", list_Type_Produit);
    
     }

    if (tablename.equals("Projet")) {

        attributs = "manage%%N°%%Nom%%Structure";
        attributsTotal = "Nom%%Structure";
        attributsFiltrage = "Nom%%Structure";
        attributsEdit = "Nom%%Structure";
        attributsinput = "text%%Structure";
         attributsinputFiltrage = "text%%Structure";
        attributsinputEdit = "text%%Structure";
        Type_Input = attributsinput.split("%%");
        Type_Input_Edit = attributsinputEdit.split("%%");
        Type_Input_Filtrage = attributsinputFiltrage.split("%%");

        AutreAttributs = "%%";
        attributsTotalUtilsable = attributsTotal.split("%%");
        attributsEditUtilsable = attributsEdit.split("%%");
        attributsFiltrageUtilsable = attributsFiltrage.split("%%");
        listeatt = attributs.split("%%");
        listAutre = AutreAttributs.split("%%");
        List<Projet> listProjet;

        List<Structure> structure = ModelBean.GetContentTable("Structure", "where isDeleted=" + 0);
        if (utilisateur.getRole().equals("role1")) {

            listProjet = ModelBean.GetContentTable("Projet", "where isDeleted=" + 0);

            String[] list_structure = new String[structure.size()];
            for (int str = 0; str < structure.size(); str++) {
                list_structure[str] = structure.get(str).getNomStructure();

            }

            Select.put("Structure", list_structure);

        } else {
            listProjet = ModelBean.GetContentTable("Projet", "where id_structure=" + utilisateur.getIdStructure() + " AND isDeleted=" + 0);

            String[] list_STR = new String[1];
            Structure structure1 = (Structure) ModelBean.GetContentTable("Structure", "where  id_structure=" + utilisateur.getIdStructure()).get(0);

            list_STR[0] = structure1.getNomStructure();

            Select.put("Structure", list_STR);

        }

        rowTable = listProjet.size();
        listVariable = new String[(listeatt.length - 1) * rowTable];

        String structure1 = "s";

        for (int i = 0; i < listProjet.size(); i++) {

            Structure str = (Structure) ModelBean.GetContentTable("Structure", "where id_structure=" + listProjet.get(i).getIdStructure()).get(0);

            structure1 = str.getNomStructure();

            listVariable[i + ((listeatt.length - 2) * i)] = String.valueOf(listProjet.get(i).getIdProjet());
            listVariable[i + 1 + ((listeatt.length - 2) * i)] = listProjet.get(i).getNomProjet();
            listVariable[i + 2 + ((listeatt.length - 2) * i)] = structure1;

        }

    }
    if (tablename.equals("Structure")) {

        attributs = "manage%%N°%%Nom_Structure%%Code";
        attributsTotal = "Nom_Structure%%Code";
        attributsFiltrage = "Nom_Structure%%Code";
        attributsEdit = "Nom_Structure%%Code";
        attributsinput = "text%%text";
        attributsinputFiltrage = "text%%text";
        attributsinputEdit = "text%%text";
        Type_Input = attributsinput.split("%%");
        Type_Input_Edit = attributsinputEdit.split("%%");
        Type_Input_Filtrage = attributsinputFiltrage.split("%%");
        AutreAttributs = "%%";
        attributsTotalUtilsable = attributsTotal.split("%%"); 
        attributsEditUtilsable = attributsEdit.split("%%");
        attributsFiltrageUtilsable = attributsFiltrage.split("%%");
        listeatt = attributs.split("%%");
        listAutre = AutreAttributs.split("%%");

        List<Structure> listStructure = ModelBean.GetContentTable("Structure", "where isDeleted=" + 0);
        rowTable = listStructure.size();
        listVariable = new String[(listeatt.length - 1) * rowTable];

        String structure1 = "s";

        for (int i = 0; i < listStructure.size(); i++) {

            listVariable[i + ((listeatt.length - 2) * i)] = String.valueOf(listStructure.get(i).getIdStructure());
            listVariable[i + 1 + ((listeatt.length - 2) * i)] = listStructure.get(i).getNomStructure();
            listVariable[i + 2 + ((listeatt.length - 2) * i)] = listStructure.get(i).getCode();

        }

    }
    if (tablename.equals("ModeLivraison")) {

        attributs = "manage%%N°%%Mode_Livraison";
        attributsTotal = "Mode_Livraison";
         attributsFiltrage = "Mode_Livraison";
        attributsEdit = "Mode_Livraison";
        attributsinput = "text";
         attributsinputFiltrage = "text";
        attributsinputEdit = "text";
        Type_Input = attributsinput.split("%%");
        Type_Input_Edit = attributsinputEdit.split("%%");
        Type_Input_Filtrage = attributsinputFiltrage.split("%%");

        AutreAttributs = "%%";
        attributsTotalUtilsable = attributsTotal.split("%%");
        attributsEditUtilsable = attributsEdit.split("%%");
        attributsFiltrageUtilsable = attributsFiltrage.split("%%");

        listeatt = attributs.split("%%");
        listAutre = AutreAttributs.split("%%");

        List<ModeLivraison> listModeLivraison = ModelBean.GetContentTable("ModeLivraison", "where isDeleted=" + 0);
        rowTable = listModeLivraison.size();
        listVariable = new String[(listeatt.length - 1) * rowTable];

        String structure1 = "s";

        for (int i = 0; i < listModeLivraison.size(); i++) {

            listVariable[i + ((listeatt.length - 2) * i)] = String.valueOf(listModeLivraison.get(i).getIdModeL());
            listVariable[i + 1 + ((listeatt.length - 2) * i)] = listModeLivraison.get(i).getNomMode();

        }

    }
    if (tablename.equals("ModeReglement")) {

        attributs = "manage%%N°%%Mode_Reglement";
        attributsTotal = "Mode_Reglement";
        attributsFiltrage = "Mode_Reglement"; 
        attributsEdit = "Mode_Reglement";
        attributsinput = "text";
        attributsinputFiltrage = "text";
        attributsinputEdit = "text";
        Type_Input = attributsinput.split("%%");
        Type_Input_Edit = attributsinputEdit.split("%%");
        Type_Input_Filtrage = attributsinputFiltrage.split("%%");

        AutreAttributs = "%%";
        attributsTotalUtilsable = attributsTotal.split("%%");
        attributsEditUtilsable = attributsEdit.split("%%");
        attributsFiltrageUtilsable = attributsFiltrage.split("%%");

        listeatt = attributs.split("%%");
        listAutre = AutreAttributs.split("%%");

        List<ModeReglement> listModeReglement = ModelBean.GetContentTable("ModeReglement", "where isDeleted=" + 0);
        rowTable = listModeReglement.size();
        listVariable = new String[(listeatt.length - 1) * rowTable];

        String structure1 = "s";

        for (int i = 0; i < listModeReglement.size(); i++) {

            listVariable[i + ((listeatt.length - 2) * i)] = String.valueOf(listModeReglement.get(i).getIdModeR());
            listVariable[i + 1 + ((listeatt.length - 2) * i)] = listModeReglement.get(i).getNomMode();

        }

    }
    if (tablename.equals("Utilisateur")) {

        attributs = "manage%%N°%%UserName%%Email%%Structure%%Role%%Etat";
        attributsTotal = "UserName%%Email%%Password%%Structure%%Role";
        attributsFiltrage = "UserName%%Email%%Structure%%Role";
        attributsEdit = "UserName%%Password%%Structure%%Role%%Etat";
        attributsinput = "text%%email%%password%%Structure%%text";
        attributsinputFiltrage = "text%%email%%Structure%%text";
        attributsinputEdit = "text%%text%%Structure%%text%%Etat";
        Type_Input = attributsinput.split("%%");
        Type_Input_Edit = attributsinputEdit.split("%%");
        Type_Input_Filtrage = attributsinputFiltrage.split("%%");

        AutreAttributs = "Password";
        attributsTotalUtilsable = attributsTotal.split("%%");
        attributsEditUtilsable = attributsEdit.split("%%");
        attributsFiltrageUtilsable = attributsFiltrage.split("%%");

        listeatt = attributs.split("%%");
        listAutre = AutreAttributs.split("%%");

        List<Utilisateur> listUtilisateur = ModelBean.GetContentTable("Utilisateur", "where isDeleted=" + 0);
        rowTable = listUtilisateur.size();
        listVariable = new String[(listeatt.length - 1) * rowTable];
        listVariableAutre = new String[listAutre.length * rowTable];
        // Structure str=new Structure();
        //  Membre memb=new Membre();
        String etat = "Active";

        for (int i = 0; i < listUtilisateur.size(); i++) {
            Structure str = (Structure) ModelBean.GetContentTable("Structure", "where id_structure=" + listUtilisateur.get(i).getIdStructure()).get(0);
            Membre memb = (Membre) ModelBean.GetContentTable("Membre", "where id_membre =" + listUtilisateur.get(i).getIdMembre()).get(0);
            if (listUtilisateur.get(i).getIsActive() == 0) {
                etat = "Desactive";
            }

            listVariable[i + ((listeatt.length - 2) * i)] = String.valueOf(listUtilisateur.get(i).getIdUtilisateur());
            listVariable[i + 1 + ((listeatt.length - 2) * i)] = listUtilisateur.get(i).getUsername();

            listVariable[i + 2 + ((listeatt.length - 2) * i)] = memb.getEmail();
            listVariable[i + 3 + ((listeatt.length - 2) * i)] = str.getNomStructure();
            listVariable[i + 4 + ((listeatt.length - 2) * i)] = listUtilisateur.get(i).getRole();
            listVariable[i + 5 + ((listeatt.length - 2) * i)] = etat;
            listVariableAutre[i + ((listAutre.length - 1) * i)] = listUtilisateur.get(i).getPassword();

        }
        String[] list_etat = new String[2];
        list_etat[0] = "Active";
        list_etat[1] = "Desactive";

        List<Structure> structure = ModelBean.GetContentTable("Structure", "where isDeleted=" + 0);
        String[] list_structure = new String[structure.size()];
        for (int str = 0; str < structure.size(); str++) {
            list_structure[str] = structure.get(str).getNomStructure();

        }

        Select.put("Etat", list_etat);
        Select.put("Structure", list_structure);

    }
    if (tablename.equals("Membre")) {

        attributs = "manage%%N°%%Nom%%Prenom%%Email%%Structure";
        attributsTotal = "Nom%%Prenom%%Email%%Structure";
        attributsFiltrage = "Nom%%Prenom%%Email%%Structure"; 
        attributsEdit = "Nom%%Prenom%%Email%%Structure";
        attributsinput = "text%%text%%email%%Structure";
        attributsinputFiltrage = "text%%text%%email%%Structure";
        attributsinputEdit = "text%%text%%email%%Structure";
        Type_Input = attributsinput.split("%%");
        Type_Input_Edit = attributsinputEdit.split("%%");
        Type_Input_Filtrage = attributsinputFiltrage.split("%%");

        AutreAttributs = "%%";
        attributsTotalUtilsable = attributsTotal.split("%%");
        attributsEditUtilsable = attributsEdit.split("%%");
        attributsFiltrageUtilsable = attributsFiltrage.split("%%");

        listeatt = attributs.split("%%");
        listAutre = AutreAttributs.split("%%");

        List<Membre> listMembre;

        if (utilisateur.getRole().equals("role1")) {

            listMembre = ModelBean.GetContentTable("Membre", "where isDeleted=" + 0);

            List<Structure> structure = ModelBean.GetContentTable("Structure", "where isDeleted=" + 0);
            String[] list_structure = new String[structure.size()];
            for (int str = 0; str < structure.size(); str++) {
                list_structure[str] = structure.get(str).getNomStructure();

            }

            Select.put("Structure", list_structure);

        } else {
            listMembre = ModelBean.GetContentTable("Membre", "where id_structure=" + utilisateur.getIdStructure() + " AND isDeleted=" + 0);

            String[] list_STR = new String[1];
            Structure structure = (Structure) ModelBean.GetContentTable("Structure", "where  id_structure=" + utilisateur.getIdStructure()).get(0);

            list_STR[0] = structure.getNomStructure();

            Select.put("Structure", list_STR);

        }

        rowTable = listMembre.size();
        listVariable = new String[(listeatt.length - 1) * rowTable];
        listVariableAutre = new String[listAutre.length * rowTable];
        // Structure str=new Structure();
        //  Membre memb=new Membre();

        for (int i = 0; i < listMembre.size(); i++) {
            Structure str = (Structure) ModelBean.GetContentTable("Structure", "where id_structure=" + listMembre.get(i).getIdStructure()).get(0);

            listVariable[i + ((listeatt.length - 2) * i)] = String.valueOf(listMembre.get(i).getIdMembre());
            listVariable[i + 1 + ((listeatt.length - 2) * i)] = listMembre.get(i).getNom();
            listVariable[i + 2 + ((listeatt.length - 2) * i)] = listMembre.get(i).getPrenom();
            listVariable[i + 3 + ((listeatt.length - 2) * i)] = listMembre.get(i).getEmail();
            listVariable[i + 4 + ((listeatt.length - 2) * i)] = str.getNomStructure();

        }

    }
    if (tablename.equals("Notification")) {

        attributs = "manage%%N°%%Nom_Notfication%%Utilisateur%%Evenement%%Date_Evenement%%Rappel";
        attributsTotal = "Nom_Notfication%%Utilisateur%%Mode%%Evenement%%Date_Evenement%%Rappel";
         attributsFiltrage = "Nom_Notfication%%Utilisateur%%Evenement%%Date_Evenement"; 
        attributsEdit = "Nom_Notfication%%Utilisateur%%Mode%%Evenement%%Date_Evenement%%Rappel";
        attributsinput = "text%%text%%Mode%%text%%date%%text";
        attributsinputFiltrage = "text%%text%%text%%date";
        attributsinputEdit = "text%%text%%Mode%%text%%date%%text";
        Type_Input = attributsinput.split("%%");
        Type_Input_Edit = attributsinputEdit.split("%%");
        Type_Input_Filtrage = attributsinputFiltrage.split("%%");

        AutreAttributs = "Mode";
        attributsTotalUtilsable = attributsTotal.split("%%");
        attributsEditUtilsable = attributsEdit.split("%%");
        attributsFiltrageUtilsable = attributsFiltrage.split("%%");

        listeatt = attributs.split("%%");
        listAutre = AutreAttributs.split("%%");
        List<Notification> listNotification;

        if (utilisateur.getRole().equals("role1")) {

            listNotification = ModelBean.GetContentTable("Notification", "where isDeleted=" + 0);

        } else {

            listNotification = ModelBean.GetContentTable("Notification", "where((mode='All' AND id_utilisateur=" + utilisateur.getIdStructure() + ") OR(mode='One' AND id_utilisateur=" + utilisateur.getIdUtilisateur() + "))AND isDeleted=" + 0);

        }

        rowTable = listNotification.size();
        listVariable = new String[(listeatt.length - 1) * rowTable];
        listVariableAutre = new String[listAutre.length * rowTable];
        // Structure str=new Structure();
        //  Membre memb=new Membre();

        for (int i = 0; i < listNotification.size(); i++) {
            String mode = listNotification.get(i).getMode();

            listVariable[i + ((listeatt.length - 2) * i)] = String.valueOf(listNotification.get(i).getIdNotification());
            listVariable[i + 1 + ((listeatt.length - 2) * i)] = listNotification.get(i).getNomNotification();

            if (mode.equals("All")) {
                Structure str = (Structure) ModelBean.GetContentTable("Structure", "where id_structure=" + listNotification.get(i).getIdUtilisateur()).get(0);
                listVariable[i + 2 + ((listeatt.length - 2) * i)] = str.getNomStructure();
            } else {
                Utilisateur user = (Utilisateur) ModelBean.GetContentTable("Utilisateur", "where id_utilisateur=" + listNotification.get(i).getIdUtilisateur()).get(0);
                listVariable[i + 2 + ((listeatt.length - 2) * i)] = user.getUsername();

            }

            listVariable[i + 3 + ((listeatt.length - 2) * i)] = listNotification.get(i).getEvenement();
            listVariable[i + 4 + ((listeatt.length - 2) * i)] = listNotification.get(i).getDateEvenement();
            listVariable[i + 5 + ((listeatt.length - 2) * i)] = listNotification.get(i).getRappel();
            listVariableAutre[i + ((listAutre.length - 1) * i)] = mode;

        }

        String[] list_Mode = new String[2];
        list_Mode[0] = "All";
        list_Mode[1] = "One";

        Select.put("Mode", list_Mode);

    }
    if (tablename.equals("TypeDocument")) {

        attributs = "manage%%N°%%Nom_Document%%Abbreviation";
        attributsTotal = "Nom_Document%%Abbreviation";
        attributsFiltrage = "Nom_Document%%Abbreviation";
        attributsEdit = "Nom_Document%%Abbreviation";
        attributsinput = "text%%text";
        attributsinputFiltrage = "text%%text";
        attributsinputEdit = "text%%text";
        Type_Input = attributsinput.split("%%");
        Type_Input_Edit = attributsinputEdit.split("%%");
        Type_Input_Filtrage= attributsinputFiltrage.split("%%");

        AutreAttributs = "%%";
        attributsTotalUtilsable = attributsTotal.split("%%");
        attributsEditUtilsable = attributsEdit.split("%%");
        attributsFiltrageUtilsable = attributsFiltrage.split("%%");

        listeatt = attributs.split("%%");
        listAutre = AutreAttributs.split("%%");

        List<Doctype> listDoctype = ModelBean.GetContentTable("Doctype ", "where isDeleted=" + 0);
        rowTable = listDoctype.size();
        listVariable = new String[(listeatt.length - 1) * rowTable];
        listVariableAutre = new String[listAutre.length * rowTable];
        // Structure str=new Structure();
        //  Membre memb=new Membre();

        for (int i = 0; i < listDoctype.size(); i++) {

            listVariable[i + ((listeatt.length - 2) * i)] = String.valueOf(listDoctype.get(i).getIdDoctype());
            listVariable[i + 1 + ((listeatt.length - 2) * i)] = listDoctype.get(i).getNomDocument();
            listVariable[i + 2 + ((listeatt.length - 2) * i)] = listDoctype.get(i).getAbbrev();

        }

    }

    if (tablename.equals("Destinateur")) {

        attributs = "manage%%N°%%Nom_Destinateur%%Type_Destinateur%%Email_Destinateur%%Phone_Destinateur%%Registre_Commerce%%N_Agrement%%Structure";
        attributsTotal = "Nom_Destinateur%%Type_Destinateur%%Email_Destinateur%%Phone_Destinateur%%Fax_Destinateur%%Addresse%%Registre_Commerce%%N_Agrement%%NIF%%Article_I%%Structure";
        attributsFiltrage = "Nom_Destinateur%%Type_Destinateur%%Email_Destinateur%%Phone_Destinateur%%Fax_Destinateur%%Addresse%%Registre_Commerce%%N_Agrement%%NIF%%Article_I%%Structure"; 
        attributsEdit = "Nom_Destinateur%%Type_Destinateur%%Email_Destinateur%%Phone_Destinateur%%Fax_Destinateur%%Addresse%%Registre_Commerce%%N_Agrement%%NIF%%Article_I%%Structure";
        attributsinput = "text%%text%%email%%text%%text%%text%%text%%text%%text%%text%%Structure";
        attributsinputEdit = "text%%text%%email%%text%%text%%text%%text%%text%%text%%text%%Structure";
        attributsinputFiltrage = "text%%text%%email%%text%%text%%text%%text%%text%%text%%text%%Structure";
        Type_Input = attributsinput.split("%%");
        Type_Input_Edit = attributsinputEdit.split("%%");
        Type_Input_Filtrage = attributsinputFiltrage.split("%%");

        AutreAttributs = "Fax_Destinateur%%Addresse%%NIF%%Article_I";
        attributsTotalUtilsable = attributsTotal.split("%%");
        attributsEditUtilsable = attributsEdit.split("%%");
        attributsFiltrageUtilsable = attributsFiltrage.split("%%");

        listeatt = attributs.split("%%");
        listAutre = AutreAttributs.split("%%");
        List<Destinateur> listDestinateur;

        if (utilisateur.getRole().equals("role1")) {

            listDestinateur = ModelBean.GetContentTable("Destinateur", "where isDeleted=" + 0);

            List<Structure> structure = ModelBean.GetContentTable("Structure", "where isDeleted=" + 0);
            String[] list_structure = new String[structure.size()];
            for (int str = 0; str < structure.size(); str++) {
                list_structure[str] = structure.get(str).getNomStructure();

            }

            Select.put("Structure", list_structure);

        } else {
            listDestinateur = ModelBean.GetContentTable("Destinateur", "where id_structure=" + utilisateur.getIdStructure() + " AND isDeleted=" + 0);

            String[] list_STR = new String[1];
            Structure structure = (Structure) ModelBean.GetContentTable("Structure", "where  id_structure=" + utilisateur.getIdStructure()).get(0);

            list_STR[0] = structure.getNomStructure();

            Select.put("Structure", list_STR);

        }

        rowTable = listDestinateur.size();
        listVariable = new String[(listeatt.length - 1) * rowTable];
        listVariableAutre = new String[listAutre.length * rowTable];
        // Structure str=new Structure();
        //  Membre memb=new Membre();

        for (int i = 0; i < listDestinateur.size(); i++) {
            Structure str = (Structure) ModelBean.GetContentTable("Structure", "where id_structure=" + listDestinateur.get(i).getIdStructure()).get(0);
            // attributs = "manage%%N°%%Nom_Destinateur%%Type_Destinateur%%Email_Destinateur%%Phone_Destinateur%%Registre_Commerce%%N_Agrement%%Structure";

            listVariable[i + ((listeatt.length - 2) * i)] = String.valueOf(listDestinateur.get(i).getIdDestinateur());
            listVariable[i + 1 + ((listeatt.length - 2) * i)] = listDestinateur.get(i).getNomDestinateur();
            listVariable[i + 2 + ((listeatt.length - 2) * i)] = listDestinateur.get(i).getTypeDestinateur();
            listVariable[i + 3 + ((listeatt.length - 2) * i)] = listDestinateur.get(i).getEmailDestinateur();
            listVariable[i + 4 + ((listeatt.length - 2) * i)] = listDestinateur.get(i).getPhoneDestinateur();
            listVariable[i + 5 + ((listeatt.length - 2) * i)] = listDestinateur.get(i).getRegistreCommerce();
            listVariable[i + 6 + ((listeatt.length - 2) * i)] = listDestinateur.get(i).getNAgrement();
            listVariable[i + 7 + ((listeatt.length - 2) * i)] = str.getNomStructure();
            listVariableAutre[i + ((listAutre.length - 1) * i)] = listDestinateur.get(i).getFaxDestinateur();
            listVariableAutre[i + 1 + ((listAutre.length - 1) * i)] = listDestinateur.get(i).getAdrDestinateur();
            listVariableAutre[i + 2 + ((listAutre.length - 1) * i)] = listDestinateur.get(i).getNif();
            listVariableAutre[i + 3 + ((listAutre.length - 1) * i)] = listDestinateur.get(i).getArticleI();
        }

    }
    if (tablename.equals("Nature")) {

        attributs = "manage%%N°%%Nom_Nature%%Projet";
        attributsTotal = "Nom_Nature%%Projet";
         attributsFiltrage = "Nom_Nature%%Projet"; 
        attributsEdit = "Nom_Nature%%Projet";
        attributsinput = "text%%text";
        attributsinputEdit = "text%%text";
        attributsinputFiltrage = "text%%text";
        Type_Input = attributsinput.split("%%");
        Type_Input_Edit = attributsinputEdit.split("%%");
        Type_Input_Filtrage = attributsinputFiltrage.split("%%"); 

        AutreAttributs = "%%";
        attributsTotalUtilsable = attributsTotal.split("%%");
        attributsEditUtilsable = attributsEdit.split("%%");
        attributsFiltrageUtilsable = attributsFiltrage.split("%%");

        listeatt = attributs.split("%%");
        listAutre = AutreAttributs.split("%%");
        List<Nature> listNature = ModelBean.GetContentTable("Nature", "where isDeleted=" + 0);
        List<Nature> listNatureAll = ModelBean.GetContentTable("Nature", "where isDeleted=" + 0);

        /* if(utilisateur.getRole().equals("role1")){
          
         listNature= ModelBean.GetContentTable("Nature", "where isDeleted=" + 0); 
          
      }else{
          
          listNature=new ArrayList<>();
          for(int j=0;j<listNatureAll.size();j++){
              Projet pro=(Projet)ModelBean.GetContentTable("Projet", "where id_projet="+ listNatureAll.get(j).getIdProjet()+"  AND isDeleted=" + 0).get(0); 
          
              
              listNature.add(listNatureAll.get(j));
         
          
          }
      }*/
        if (!utilisateur.getRole().equals("role1")) {
            listNature.removeAll(listNature);

            for (int j = 0; j < listNatureAll.size(); j++) {
                Projet pro = (Projet) ModelBean.GetContentTable("Projet", "where id_projet=" + listNatureAll.get(j).getIdProjet() + "  AND isDeleted=" + 0).get(0);

                if (pro.getIdStructure() == utilisateur.getIdStructure()) {
                    listNature.add(listNatureAll.get(j));
                }

            }

        }

        rowTable = listNature.size();
        listVariable = new String[(listeatt.length - 1) * rowTable];
        listVariableAutre = new String[listAutre.length * rowTable];
        // Structure str=new Structure();
        //  Membre memb=new Membre();

        for (int i = 0; i < listNature.size(); i++) {

            Projet projet = (Projet) ModelBean.GetContentTable("Projet", "where id_projet=" + listNature.get(i).getIdProjet()).get(0);

            listVariable[i + ((listeatt.length - 2) * i)] = String.valueOf(listNature.get(i).getIdNature());
            listVariable[i + 1 + ((listeatt.length - 2) * i)] = listNature.get(i).getNomNature();
            listVariable[i + 2 + ((listeatt.length - 2) * i)] = projet.getNomProjet();

        }

    }

    if (tablename.equals("TypeNature")) {

        attributs = "manage%%N°%%Nom_Nature%%Type_Nature";
        attributsTotal = "Nom_Nature%%Type_Nature";
        attributsFiltrage = "Nom_Nature%%Type_Nature"; 
        attributsEdit = "Nom_Nature%%Type_Nature";
        attributsinput = "text%%text";
        attributsinputEdit = "text%%text";
        attributsinputFiltrage = "text%%text";
        Type_Input = attributsinput.split("%%");
        Type_Input_Edit = attributsinputEdit.split("%%");
        Type_Input_Filtrage = attributsinputFiltrage.split("%%");

        AutreAttributs = "%%";
        attributsTotalUtilsable = attributsTotal.split("%%");
        attributsEditUtilsable = attributsEdit.split("%%");
         attributsFiltrageUtilsable = attributsFiltrage.split("%%");

        listeatt = attributs.split("%%");
        listAutre = AutreAttributs.split("%%");

        List<TypeNature> listTypeNature = ModelBean.GetContentTable("TypeNature", "where isDeleted=" + 0);

        List<TypeNature> listTypeNatureAll = ModelBean.GetContentTable("TypeNature", "where isDeleted=" + 0);

        /* if(utilisateur.getRole().equals("role1")){
          
         listNature= ModelBean.GetContentTable("Nature", "where isDeleted=" + 0); 
          
      }else{
          
          listNature=new ArrayList<>();
          for(int j=0;j<listNatureAll.size();j++){
              Projet pro=(Projet)ModelBean.GetContentTable("Projet", "where id_projet="+ listNatureAll.get(j).getIdProjet()+"  AND isDeleted=" + 0).get(0); 
          
              
              listNature.add(listNatureAll.get(j));
         
          
          }
      }*/
        if (!utilisateur.getRole().equals("role1")) {
            listTypeNature.removeAll(listTypeNature);

            for (int j = 0; j < listTypeNatureAll.size(); j++) {
                Nature nature = (Nature) ModelBean.GetContentTable("Nature", "where id_nature=" + listTypeNatureAll.get(j).getIdNature() + "  AND isDeleted=" + 0).get(0);
                Projet pro = (Projet) ModelBean.GetContentTable("Projet", "where id_projet=" + nature.getIdProjet() + "  AND isDeleted=" + 0).get(0);
                if (pro.getIdStructure() == utilisateur.getIdStructure()) {
                    listTypeNature.add(listTypeNatureAll.get(j));
                }

            }

        }

        rowTable = listTypeNature.size();
        listVariable = new String[(listeatt.length - 1) * rowTable];
        listVariableAutre = new String[listAutre.length * rowTable];
        // Structure str=new Structure();
        //  Membre memb=new Membre();

        for (int i = 0; i < listTypeNature.size(); i++) {

            Nature nature = (Nature) ModelBean.GetContentTable("Nature", "where id_nature=" + listTypeNature.get(i).getIdNature()).get(0);

            listVariable[i + ((listeatt.length - 2) * i)] = String.valueOf(listTypeNature.get(i).getIdType());
            listVariable[i + 1 + ((listeatt.length - 2) * i)] = nature.getNomNature();
            listVariable[i + 2 + ((listeatt.length - 2) * i)] = listTypeNature.get(i).getNomType();

        }

    }

    if (tablename.equals("DesignationNature")) {

        attributs = "manage%%N°%%Nom_Nature%%Designation_Nature";
        attributsTotal = "Nom_Nature%%Designation_Nature";
        attributsFiltrage = "Nom_Nature%%Designation_Nature"; 
        attributsEdit = "Nom_Nature%%Designation_Nature";
        attributsinput = "text%%text";
        attributsinputEdit = "text%%text";
        attributsinputFiltrage  = "text%%text";
        Type_Input = attributsinput.split("%%");
        Type_Input_Edit = attributsinputEdit.split("%%");
        Type_Input_Filtrage = attributsinputFiltrage.split("%%");

        AutreAttributs = "%%";
        attributsTotalUtilsable = attributsTotal.split("%%");
        attributsEditUtilsable = attributsEdit.split("%%");
        attributsFiltrageUtilsable = attributsFiltrage.split("%%");

        listeatt = attributs.split("%%");
        listAutre = AutreAttributs.split("%%");

        List<DesignationNature> listDesNature = ModelBean.GetContentTable("DesignationNature", "where isDeleted=" + 0);

        List<DesignationNature> listDesNatureAll = ModelBean.GetContentTable("DesignationNature", "where isDeleted=" + 0);

        if (!utilisateur.getRole().equals("role1")) {
            listDesNature.removeAll(listDesNature);

            for (int j = 0; j < listDesNatureAll.size(); j++) {
                Nature nature = (Nature) ModelBean.GetContentTable("Nature", "where id_nature=" + listDesNatureAll.get(j).getIdNature() + "  AND isDeleted=" + 0).get(0);
                Projet pro = (Projet) ModelBean.GetContentTable("Projet", "where id_projet=" + nature.getIdProjet() + "  AND isDeleted=" + 0).get(0);
                if (pro.getIdStructure() == utilisateur.getIdStructure()) {
                    listDesNature.add(listDesNatureAll.get(j));
                }

            }

        }

        rowTable = listDesNature.size();
        listVariable = new String[(listeatt.length - 1) * rowTable];
        listVariableAutre = new String[listAutre.length * rowTable];
        // Structure str=new Structure();
        //  Membre memb=new Membre();

        for (int i = 0; i < listDesNature.size(); i++) {

            Nature nature = (Nature) ModelBean.GetContentTable("Nature", "where id_nature=" + listDesNature.get(i).getIdNature()).get(0);

            listVariable[i + ((listeatt.length - 2) * i)] = String.valueOf(listDesNature.get(i).getIdDes());
            listVariable[i + 1 + ((listeatt.length - 2) * i)] = nature.getNomNature();
            listVariable[i + 2 + ((listeatt.length - 2) * i)] = listDesNature.get(i).getNomDes();

        }

    }
    if (tablename.equals("TypeAttachment")) {

        attributs = "manage%%N°%%Nom_Attachment%%Type_Attachment%%Situation_Attachment%%Structure%%Projet%%Nom_Nature%%Designation%%Type";
        attributsTotal = "Nom_Attachment%%Type_Attachment%%Situation_Attachment%%Structure%%Projet%%Nom_Nature%%Designation%%Type";
        attributsFiltrage = "Nom_Attachment%%Type_Attachment%%Situation_Attachment%%Structure%%Projet%%Nom_Nature%%Designation%%Type";
        attributsEdit = "Nom_Attachment%%Type_Attachment%%Situation_Attachment%%Structure%%Projet%%Nom_Nature%%Designation%%Type";
        attributsinput = "text%%Type_Attachment%%text%%Structure%%text%%text%%text%%text";
        attributsinputEdit = "text%%Type_Attachment%%text%%Structure%%text%%text%%text%%text";
        attributsinputFiltrage = "text%%Type_Attachment%%text%%Structure%%text%%text%%text%%text";
        Type_Input = attributsinput.split("%%");
        Type_Input_Edit = attributsinputEdit.split("%%");
        Type_Input_Filtrage = attributsinputFiltrage.split("%%");

        AutreAttributs = "%%";
        attributsTotalUtilsable = attributsTotal.split("%%");
        attributsEditUtilsable = attributsEdit.split("%%");
        attributsFiltrageUtilsable = attributsFiltrage.split("%%");

        listeatt = attributs.split("%%");
        listAutre = AutreAttributs.split("%%");
        List<TypeAttachment> listTypeAttachment;
        List<Structure> structureAll = ModelBean.GetContentTable("Structure", "where isDeleted=" + 0);
                String[]list_structure = new String[structureAll.size()]; 
    for (int str = 0; str < structureAll.size(); str++) { 
        list_structure[str] = structureAll.get(str).getNomStructure(); 

    }

        if (utilisateur.getRole().equals("role1")) {

            listTypeAttachment = ModelBean.GetContentTable("TypeAttachment", "where isDeleted=" + 0);

            
            

            Select.put("Structure", list_structure);

        } else {
            listTypeAttachment = ModelBean.GetContentTable("TypeAttachment", "where id_structure=" + utilisateur.getIdStructure() + " AND isDeleted=" + 0);

            list_structure = new String[1];
            Structure structure = (Structure) ModelBean.GetContentTable("Structure", "where  id_structure=" + utilisateur.getIdStructure()).get(0);

             list_structure [0] = structure.getNomStructure(); 

            Select.put("Structure", list_structure );

        }

        rowTable = listTypeAttachment.size();
        listVariable = new String[(listeatt.length - 1) * rowTable];
        listVariableAutre = new String[listAutre.length * rowTable];
        // Structure str=new Structure();
        //  Membre memb=new Membre();

        for (int i = 0; i < listTypeAttachment.size(); i++) {
            Structure str = (Structure) ModelBean.GetContentTable("Structure", "where id_structure=" + listTypeAttachment.get(i).getIdStructure()).get(0);

            listVariable[i + ((listeatt.length - 2) * i)] = String.valueOf(listTypeAttachment.get(i).getIdTypeAttachment());
            listVariable[i + 1 + ((listeatt.length - 2) * i)] = listTypeAttachment.get(i).getNomAttachment();
            listVariable[i + 2 + ((listeatt.length - 2) * i)] = listTypeAttachment.get(i).getTypeAttachment();
            listVariable[i + 3 + ((listeatt.length - 2) * i)] = listTypeAttachment.get(i).getSituationAttachment();
            listVariable[i + 4 + ((listeatt.length - 2) * i)] = str.getNomStructure();
            if (listTypeAttachment.get(i).getIdProjet() == 0) {

                listVariable[i + 5 + ((listeatt.length - 2) * i)] = "/";

            } else {
                Projet projet = (Projet) ModelBean.GetContentTable("Projet", "where id_projet=" + listTypeAttachment.get(i).getIdProjet()).get(0);
                listVariable[i + 5 + ((listeatt.length - 2) * i)] = projet.getNomProjet();
            }

            if (listTypeAttachment.get(i).getIdNature() == 0) {

                listVariable[i + 6 + ((listeatt.length - 2) * i)] = "/";

            } else {
                Nature nature = (Nature) ModelBean.GetContentTable("Nature", "where id_nature=" + listTypeAttachment.get(i).getIdNature()).get(0);
                listVariable[i + 6 + ((listeatt.length - 2) * i)] = nature.getNomNature();
            }

            if (listTypeAttachment.get(i).getIdDesignation() == 0) {

                listVariable[i + 7 + ((listeatt.length - 2) * i)] = "/";

            } else {
                DesignationNature desnature = (DesignationNature) ModelBean.GetContentTable("DesignationNature", "where id_des=" + listTypeAttachment.get(i).getIdDesignation()).get(0);
                listVariable[i + 7 + ((listeatt.length - 2) * i)] = desnature.getNomDes();
            }

            if (listTypeAttachment.get(i).getIdType() == 0) {

                listVariable[i + 8 + ((listeatt.length - 2) * i)] = "/";

            } else {
                TypeNature typenature = (TypeNature) ModelBean.GetContentTable("TypeNature", "where id_type=" + listTypeAttachment.get(i).getIdType()).get(0);
                listVariable[i + 8 + ((listeatt.length - 2) * i)] = typenature.getNomType(); 
            }

        }
    
        String[] list_Type_Attachment = new String[3];
        list_Type_Attachment[0] = "Creation"; 
        list_Type_Attachment[1] = "Confirmation"; 
        list_Type_Attachment[2] = "Creation-Confirmation";
        
        
   

       

        Select.put("Structure", list_structure);
        Select.put("Type_Attachment", list_Type_Attachment);

    }


%>
<script>
    var types = [""];
    var type;
    var emails = [""];
    var email;

    var projets = [""];
    var projet;

    var types_nature = [""];
    var type_nature;

    var natures = [""];
    var nature;

    var roles = [""];
    var role;

    var situations_attachment = [""];
    var situation_attachment;

    var designations_nature = [""];
    var designation_nature;

    var utilisateurs_notification = [""];
    var utilisateur_notification;


    var types_destinateur = [""];
    var type_destinateur;



    <%          List<ObjetType> Obj_type = ModelBean.GetContentTable("ObjetType", "where isDeleted=" + 0);

        for (int i = 0; i < Obj_type.size(); i++) {
    %>
    type = "<%=Obj_type.get(i).getNomObjetType()%>";
    if (!types.includes(type))
        types.push(type);




    <% }%>


    <%
        List<Membre> list_membre = ModelBean.GetContentTable("Membre", "where isDeleted=" + 0);

        for (int i = 0; i < list_membre.size(); i++) {
    %>
    email = "<%=list_membre.get(i).getEmail()%>";
    emails.push(email);


    <% }%>

    <%
        List<Projet> list_projet = ModelBean.GetContentTable("Projet", "where isDeleted=" + 0);

        for (int i = 0; i < list_projet.size(); i++) {
    %>
    <%
        if (utilisateur.getRole().equals("role1")) {%>
    projet = "<%=list_projet.get(i).getNomProjet()%>";
    projets.push(projet);

    <% } else {
        Projet p = list_projet.get(i);
        if (utilisateur.getIdStructure() == p.getIdStructure()) {%>
    projet = "<%=p.getNomProjet()%>";
    projets.push(projet);


    <%
                }
            }
        }%>





    <%
        List<TypeNature> list_TypeNature = ModelBean.GetContentTable("TypeNature", "where isDeleted=" + 0);

        for (int i = 0; i < list_TypeNature.size(); i++) {
    %>
    <%
        if (utilisateur.getRole().equals("role1")) {%>
    type_nature = "<%=list_TypeNature.get(i).getNomType()%>";
    types_nature.push(type_nature);

    <% } else {
        Nature nature = (Nature) ModelBean.GetContentTable("Nature", "where id_nature=" + list_TypeNature.get(i).getIdNature()).get(0);
        Projet p = (Projet) ModelBean.GetContentTable("Projet", "where id_projet=" + nature.getIdProjet()).get(0);
        if (utilisateur.getIdStructure() == p.getIdStructure()) {%>
    type_nature = "<%=list_TypeNature.get(i).getNomType()%>";
    types_nature.push(type_nature);


    <%
                }
            }
        }%>




    <%
        List<Utilisateur> list_Utilisateur = ModelBean.GetContentTable("Utilisateur", "where isDeleted=" + 0);

        for (int i = 0; i < list_Utilisateur.size(); i++) {
    %>
    role = "<%=list_Utilisateur.get(i).getRole()%>";

    if (!roles.includes(role))
        roles.push(role);


    <% }%>







    <%
        List<Nature> list_Nature = ModelBean.GetContentTable("Nature", "where isDeleted=" + 0);

        for (int i = 0; i < list_Nature.size(); i++) {
    %>
    <%
        if (utilisateur.getRole().equals("role1")) {%>
    nature = "<%=list_Nature.get(i).getNomNature()%>";
    natures.push(nature);

    <% } else {
        Projet p = (Projet) ModelBean.GetContentTable("Projet", "where id_projet=" + list_Nature.get(i).getIdProjet()).get(0);
        if (utilisateur.getIdStructure() == p.getIdStructure()) {%>
    nature = "<%=list_Nature.get(i).getNomNature()%>";
    natures.push(nature);


    <%
                }
            }
        }%>

    <%
        List<TypeAttachment> list_TypeAttachment = ModelBean.GetContentTable("TypeAttachment", "where isDeleted=" + 0);

        for (int i = 0; i < list_TypeAttachment.size(); i++) {
    %>
    situation_attachment = "<%=list_TypeAttachment.get(i).getSituationAttachment()%>";
    if (!situations_attachment.includes(situation_attachment))
        situations_attachment.push(situation_attachment);


    <% }%>






    <%
        List<DesignationNature> list_DesignationNature = ModelBean.GetContentTable("DesignationNature", "where isDeleted=" + 0);

        for (int i = 0; i < list_DesignationNature.size(); i++) {
    %>
    <%
        if (utilisateur.getRole().equals("role1")) {%>
    designation_nature = "<%=list_DesignationNature.get(i).getNomDes()%>";
    designations_nature.push(designation_nature);

    <% } else {
        Nature nature = (Nature) ModelBean.GetContentTable("Nature", "where id_nature=" + list_DesignationNature.get(i).getIdNature()).get(0);
        Projet p = (Projet) ModelBean.GetContentTable("Projet", "where id_projet=" + nature.getIdProjet()).get(0);
        if (utilisateur.getIdStructure() == p.getIdStructure()) {%>
    designation_nature = "<%=list_DesignationNature.get(i).getNomDes()%>";
    designations_nature.push(designation_nature);


    <%
                }
            }
        }%>


    <%
        List<Utilisateur> list_Utilisateur_Notification = ModelBean.GetContentTable("Utilisateur", "where isDeleted=" + 0);

        for (int i = 0; i < list_Utilisateur_Notification.size(); i++) {
    %>
    utilisateur_notification = "<%=list_Utilisateur_Notification.get(i).getUsername()%>";
    utilisateurs_notification.push(utilisateur_notification);


    <% }%>

    <%
        List<Structure> list_Structure_Notification = ModelBean.GetContentTable("Structure", "where isDeleted=" + 0);

        for (int i = 0; i < list_Structure_Notification.size(); i++) {
    %>
    utilisateur_notification = "<%=list_Structure_Notification.get(i).getNomStructure()%>";
    utilisateurs_notification.push(utilisateur_notification);


    <% }%>

    <%
        List<Destinateur> list_Destinateur = ModelBean.GetContentTable("Destinateur", "where isDeleted=" + 0);

        for (int i = 0; i < list_Destinateur.size(); i++) {
    %>
    type_destinateur = "<%=list_Destinateur.get(i).getTypeDestinateur()%>";
    if (!types_destinateur.includes(type_destinateur))
        types_destinateur.push(type_destinateur);


    <% }%>





</script>

<style>
    .form-group {
        position: relative;

    }

    .form-group input,.form-group select {
        box-sizing: border-box;
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        border: 1px solid #C2C2C2;
        box-shadow: 1px 1px 4px #EBEBEB;
        -moz-box-shadow: 1px 1px 4px #EBEBEB;
        -webkit-box-shadow: 1px 1px 4px #EBEBEB;
        border-radius: 3px;
        -webkit-border-radius: 3px;
        -moz-border-radius: 3px;
        padding: 7px;
        outline: none;

    }
    .form-group input:focus ,.form-group select:focus{
        border: 1px solid #0C0;
    }





    .autocomplete-items {
        position: absolute;
        border: 1px solid #d4d4d4;
        border-bottom: none;
        border-top: none;
        z-index: 99;
        /*position the autocomplete items to be the same width as the container:*/
        top: 100%;
        left: 0;
        right: 0;
    }

    .autocomplete-items div {
        padding: 10px;
        cursor: pointer;
        background-color: #fff; 
        border-bottom: 1px solid #d4d4d4; 
    }

    /*when hovering an item:*/
    .autocomplete-items div:hover {
        background-color: #e9e9e9; 
    }

    /*when navigating through the items using the arrow keys:*/
    .autocomplete-active {
        background-color: DodgerBlue !important; 
        color: #ffffff; 
    }

</style>

<div id="container2">



</div>


<div class="con" id="con">
    <div class="mdl-card__actions mdl-card--border">
        <div id="mdl-table" class="col-md-12 card material-table">
            <div class="col-md-12" style="padding: 10px 5px;">
                <div class="row">

                    <a class="col-md-4 text-left" href="javascript:void(0);">
                        <span class="table-title">
                            Table de <%=tablename%>
                        </span>
                    </a>

                    <div class="col-md-2 text-left "></div>   

                    <div class="col-md-2 text-left"> 
                        <div class="hidden deleterow-<%=tablename%>"> 
                            <label style=" color: #f15353;" class="delete-toggle btn-flat nopadding mdl-button mdl-js-button mdl-button--icon" for="sample6">
                                <i class="material-icons">delete</i>
                            </label>
                            <span style=" color: #f15353;    font-size: 12px;">0 elements</span>
                        </div> 
                    </div>
                    <div class="col-md-1 text-right"> 
                        <label style="color: #03a9f3;" class="add-toggle btn-flat nopadding mdl-button mdl-js-button mdl-button--icon" data-toggle="collapse" href="#collapseadd<%=tablename%>" aria-expanded="false" aria-controls="collapseExample">
                            <i class="material-icons" id="addp">add_circle_outline</i>
                        </label>
                    </div>    
                    <div class="col-md-1 text-right"> 
                        <label style="color: #03a9f3;" class="search-toggle btn-flat nopadding mdl-button mdl-js-button mdl-button--icon"  data-toggle="collapse" href="#collapseExample2" aria-expanded="false" aria-controls="collapseExample">
                            <i class="material-icons">search</i>
                        </label>
                    </div> 
                    <div class="col-md-1 text-right"> 
                        <label style="color: #03a9f3;" class="column-toggle btn-flat nopadding mdl-button mdl-js-button mdl-button--icon" data-toggle="collapse" href="#collapsecolumn" aria-expanded="false" aria-controls="collapsecolumn">
                            <i class="material-icons">visibility</i>
                        </label>
                    </div> 
                    <div class="col-md-1 text-right"> 
                        <label style="color: #03a9f3;" class="filter-toggle btn-flat nopadding mdl-button mdl-js-button mdl-button--icon" data-toggle="collapse" href="#collapseFiltrage<%=tablename%>" aria-expanded="false" aria-controls="collapseExample">
                            <i class="material-icons">filter_list</i>
                        </label>
                    </div> 

                    <!--                <div class="col-md-1 text-center"> 
                                        <label style="color: #03a9f3;" class="add-toggle btn-flat nopadding mdl-button mdl-js-button mdl-button--icon">
                                            <i class="material-icons">add</i>
                                        </label>
                                    </div> -->

                    <!--                <a href="#" class="search-toggle waves-effect btn-flat nopadding col-md-offset-1 col-md-1 text-right"><i class="material-icons">search</i></a>
                                    <a href="#filter_column" class="column-toggle waves-effect btn-flat nopadding col-md-offset-1 col-md-1 text-right"><i class="material-icons">visibility</i></a>
                                    <a href="#avanced_search" class="filter-toggle waves-effect btn-flat nopadding col-md-offset-1 col-md-1 text-right"><i class="material-icons">filter_list</i></a>
                                    <a href="#add_users" class="add-toggle waves-effect btn-flat nopadding col-md-offset-1 col-md-1 text-right"><i class="material-icons">add</i></a>-->

                </div>    
            </div>



            <div class="col-lg-12">
                <div class="collapse" id="collapsecolumn">
                    <div class="card card-body">
                        <div class="container-fluit row">

                            <% for (int idx = 0; idx < listeatt.length; idx++) {
                                    String elem = listeatt[idx];


                            %>
                            <div class="col-md-3">
                                <input type="checkbox" checked id="check-<%=tablename%>-<%= elem%>">
                                <label for="check-<%=tablename%>-<%= elem%>"><%= elem%></label>
                            </div>
                            <%                        }
                            %>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-12">
                <div class="collapse" id="collapseFiltrage<%=tablename%>">
                    <div class="card card-body">
                        
                         <form class="row" id="#corrd">
                                  
                                <% for (int in = 0; in < attributsFiltrageUtilsable.length; in++) {

                                    String eleme = attributsFiltrageUtilsable[in];
                                    String typeinput = Type_Input_Filtrage[in];

                                    if (!typeinput.equals("text") && !typeinput.equals("date") && !typeinput.equals("number") && !typeinput.equals("file") && !typeinput.equals("password") && !typeinput.equals("email")) {


                            %>
                            <div class="form-group col-md-3">
                                <label for="<%=attributsFiltrageUtilsable[in]%>"><%=attributsFiltrageUtilsable[in]%></label>


                                <select id="<%=attributsFiltrageUtilsable[in]%>-<%=tablename%>" class="form-control" name="<%=attributsFiltrageUtilsable[in]%>">


                                    <% for (int i = 0; i < (Select.get(attributsFiltrageUtilsable[in])).length; i++) {%>  
                                    <option> 

                                        <%= (Select.get(attributsFiltrageUtilsable[in]))[i]%>
                                    </option>
                                    <% }%>
                                </select>
                            </div>

                            <%     } else {%>
                            <div class="form-group col-md-3">
                                <label><%=eleme%></label>
                                <input type="<%=typeinput%>" class="form-control" id="<%=eleme%>-<%=tablename%>" required>
                            </div>

                            <%

                                    }
                                }

                            %>
                                 


                                </form>


                    </div>
                </div>
            </div>   
            <div class="col-lg-12">
                <div class="collapse" id="collapseExample5">
                    <div class="card card-body">


                    </div>
                </div>
            </div>   

            <div class="col-lg-12">
                <div class="collapse" id="collapseadd<%=tablename%>">
                    <div class="card card-body">
                        <div class="modal-body">  
                           
                            <% for (int in = 0; in < attributsTotalUtilsable.length; in++) {

                                    String eleme = attributsTotalUtilsable[in];
                                    String typeinput = Type_Input[in];

                                    if (!typeinput.equals("text") && !typeinput.equals("date") && !typeinput.equals("number") && !typeinput.equals("file") && !typeinput.equals("password") && !typeinput.equals("email")) {


                            %>
                            <div class="form-group">
                                <label for="<%=attributsTotalUtilsable[in]%>"><%=attributsTotalUtilsable[in]%></label>


                                <select id="<%=attributsTotalUtilsable[in]%>-<%=tablename%>" class="form-control" name="<%=attributsTotalUtilsable[in]%>">


                                    <% for (int i = 0; i < (Select.get(attributsTotalUtilsable[in])).length; i++) {%>  
                                    <option> 

                                        <%= (Select.get(attributsTotalUtilsable[in]))[i]%>
                                    </option>
                                    <% }%>
                                </select>
                            </div>

                            <%     } else {%>
                            <div class="form-group">
                                <label><%=eleme%></label>
                                <input type="<%=typeinput%>" class="form-control" id="<%=eleme%>-<%=tablename%>" required>
                            </div>

                            <%

                                    }
                                }

                            %>

                        </div>
                        <div class="modal-footer">
                            <div class="col-lg-2 col-md-4">
                                <button type="button" class="btn waves-effect waves-light btn-block btn-success add" id="add-<%=tablename%>">Add</button>
                            </div>

                        </div>

                    </div>
                </div>
            </div>            


            <table id="table<%=tablename%>" class=" mdl-data-table mdl-js-data-table /*mdl-data-table--selectable*/ mdl-shadow--2dp /*scroll-sidebar*/ col-md-12">
                <style>
                    table{
                        text-align: left;
                    }    

                    #table<%=tablename%>{
                        width: 100%;
                        max-width: 100%;
                        empty-cells: show;
                        border-collapse: collapse;
                        border: 0;
                        padding: 0;
                        text-align: left;
                    }
                    .is-focused{
                        border: none;
                    }
                    .mdl-data-table td .mdl-data-table__select {
                        vertical-align: top;
                        position: relative;
                        left: 0px;
                    }
                    .mdl-data-table th .mdl-data-table__select {
                        vertical-align: top;
                        position: relative;
                        bottom: 0px; 
                        left: 0px; 
                    }
                    /*.toggle{
                         cursor: pointer;
                        color: #383A3F;
                         display: block;
                        margin-bottom: 10px;
                         font-size: 1.2em;
                    }*/



                </style>
                <thead>
                    <tr>
                        <th > 
                            <%--                            <label class="toggle">
                                                            <input class="toggle__input" type="checkbox" id="selectAll<%=tablename%>">
                                                            <span class="toggle__label">

                                </span>
                            </label>--%>
                            <label class="mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect mdl-data-table__select" for="selectAll<%=tablename%>">
                                <input type="checkbox" class="mdl-checkbox__input" id="selectAll<%=tablename%>">
                            </label>    

                        </th>

                        <th class="sort text-center column sortable fixed-column last-fixed-column text-xs-left col-<%=tablename%>-manage justify-content-center" data-sort="btndrow" style="width: 20px;">#</th>
                            <% for (int idx = 1; idx < listeatt.length; idx++) {
                                    String elem = listeatt[idx];
                            %>
                        <th class="text-left sort col-<%=tablename%>-<%= elem%> justify-content-center" data-sort="<%= elem%>"><%= elem%></th>

                        <%                        }
                        %>

                    </tr>
                </thead>
                <tbody class="list">


                    <% for (int i = 0; i < rowTable; i++) {%>

                    <tr class="ligne"  >

                        <td id="<%= listVariable[i + ((listeatt.length - 2) * i)]%>">  
                            <%// System.out.println(listVariable[i + ((listeatt.length - 2) * i)]);%>
                            <label class="toggle" for="selectone<%=tablename%>">
                                <input class="toggle__input" type="checkbox" id="selectone<%=tablename%>">
                                <span class="toggle__label">
                                </span>
                            </label>
                        </td>
                        <%--
                        <td class="rowcheck-<%=tablename%>-<%=i%> " id="<%= listVariable[i + ((listeatt.length - 1) * i)]%>">  
                            <label class="mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect mdl-data-table__select" for="selectone-<%=tablename%>-<%=i%>">
                                <input type="checkbox" id="selectone-<%=tablename%>-<%=i%>" class="mdl-checkbox__input">
                            </label>
                        </td>
                        --%>
                        <td class="btndraw text-center fixed-column row-<%=tablename%>-manage justify-content-center" id="<%= listVariable[i + ((listeatt.length - 2) * i)]%>">
                            <div class="btn-group">
                                <button type="button" class="btn btn-outline-info waves-effect waves-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="fas fa-cogs"></i>
                                    <span class="caret"></span>
                                </button>
                                <div class="dropdown-menu">
                                    <% for (int idm = 0; idm < listmanage.length; idm++) {
                                            String elemM = listmanage[idm];
                                    %>
                                    <!--<h6 class="dropdown-header">Dropdown header</h6>-->
                                    <a class="dropdown-item text-info" id="manage<%=tablename%>" ><%= elemM%></a>

                                    <%                        }
                                    %>
                                </div>
                            </div>
                        </td>
                        <td class="text-left row-<%=tablename%>-<%=listeatt[1]%>" id="ligne-<%=i%>"><%= i + 1%></td>

                        <% for (int idt = 2; idt < listeatt.length; idt++) {
                                String elem1 = listVariable[idt - 1 + ((listeatt.length - 1) * i)];
                              


                        %>

                        <td class="text-left row-<%=tablename%>-<%=listeatt[idt]%>" id="<%= listVariable[i + ((listeatt.length - 2) * i)]%>"><%= elem1%></td>

                        <%                        }
                        %>

                        <% for (int n = 0; n < listAutre.length; n++) {
                                String elem2 = listVariableAutre[n + ((listAutre.length) * i)];
                                

                        %>
                <input type="hidden" id="row-<%=tablename%>-<%=listAutre[n]%>" value="<%= elem2%>">


                <% }%>

                </tr>

                <% }%>


                </tbody>
            </table>



        </div>




    </div>
    <style> 
        .modal1 {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            padding-top: 100px; /* Location of the box */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }
        .modal1 .modal-body, .modal1 .modal-footer {
            padding: 20px 30px;
        }
        .modal1 .modal-footer {
            background: #fff;
            border-radius: 0 0 1px 1px;
        }
        .modal1 .modal-title {
            display: inline-block;
            color:#ffffff;
            font-size: 2rem;
            font-family: 'Slabo 27px', serif;
            font-weight: 100;
            margin: 0;
            border-radius: 1px;


        }
        .modal1 .form-control {
            border-radius: 1px;
            box-shadow: none;
            border-color: #dddddd;
        }
        .modal1 textarea.form-control {
            resize: vertical;
        }
        .modal1 .btn {
            border-radius: 1px;
            min-width: 100px;
        } 
        .modal1 label {
            font-weight: normal;
            font-size: 20px;
        } 
        .modal1 input,.modal1 select {
            font-weight: normal;
            font-size: 17px;
        } 


        /* Modal Content */
        .modal-content1 {
            background-color: #fefefe;
            border-radius: 1px;
            margin-left: 380px;


            width: 50%;
            height: auto;

        }

        /* The Close Button */
        .close {
            color: #aaaaaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: #000;
            text-decoration: none;
            cursor: pointer;
        }

    </style> 


    <div id="edit<%=tablename%>" class="modal1">

        <!-- Modal content -->
        <div class="modal-content1">
            <div class="modal-header" style="background-color:white;border-radius: 40px;">      
                <h4 class="modal-title text-info" style="font-size: x-large;font-family: 'Poppins', sans-serif;">Edit <%=tablename%></h4>
                <button type="button" id="closeedit" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>

            <div class="modal-body">  
                <% for (int in = 0; in < attributsEditUtilsable.length; in++) {

                        String eleme = attributsEditUtilsable[in];
                        String typeinput = Type_Input_Edit[in];
                        if (!typeinput.equals("text") && !typeinput.equals("date") && !typeinput.equals("text") && !typeinput.equals("number") && !typeinput.equals("file") && !typeinput.equals("password") && !typeinput.equals("email")) {


                %>
                <div class="form-group">
                    <label for="<%=attributsEditUtilsable[in]%>"><%=attributsEditUtilsable[in]%></label>


                    <select id="<%=attributsEditUtilsable[in]%>-<%=tablename%>" class="form-control" name="<%=attributsEditUtilsable[in]%>">


                        <% for (int i = 0; i < (Select.get(attributsEditUtilsable[in])).length; i++) {%>  
                        <option> 

                            <%= (Select.get(attributsEditUtilsable[in]))[i]%>
                        </option>
                        <% }%>
                    </select>
                </div>

                <%     } else {%>
                <div class="form-group">
                    <label><%=eleme%></label>
                    <input type="<%=typeinput%>" class="form-control" id="<%=eleme%>-<%=tablename%>" required>
                </div>

                <%

                        }
                    }

                %>



                <input type="hidden" class="id-<%=tablename%>" value="">
                <input type="hidden" class="line-<%=tablename%>" value="">
            </div>
            <div class="modal-footer">
                <input type="button" class="btn btn-outline-danger  " id="closeedit" data-dismiss="modal" value="Cancel">
                <input type="button" class="btn btn-outline-success  edit<%=tablename%>" value="Edit">
            </div>
        </div>

    </div>


    <div class="modal" id="Voir<%=tablename%>" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" style="display: none;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="myLargeModalLabel"><%=tablename%></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                </div>




                <!-- Nav tabs -->
                <ul class="nav nav-tabs customtab" role="tablist">
                    <li class="nav-item"> <a class="nav-link active" data-toggle="tab" href="#general" role="tab"><span class="hidden-sm-up"></span> <span class="hidden-xs-down">General</span></a> </li>

                </ul>
                <!-- Tab panes -->
                <div class="tab-content">
                    <div class="tab-pane active" id="general" role="tabpanel">
                        <div class="p-20">

                            <% for (int idt = 2; idt < listeatt.length; idt++) {


                            %>

                            <div class="row">
                                <div class="col-md-5">
                                    <h4><%=listeatt[idt]%>:</h4>

                                </div> 
                                <div class="col-md-6">
                                    <h4 style="color:#f46a4e;" class="<%=listeatt[idt]%>"></h4>

                                </div> 
                            </div>

                            <%                        }
                            %>

                            <% for (int n = 0; n < listAutre.length; n++) {


                            %>
                            <div class="row">
                                <div class="col-md-5">
                                    <h4><%=listAutre[n]%>:</h4> 

                                </div> 
                                <div class="col-md-6">
                                    <h4 style="color:#f46a4e;" class="<%=listAutre[n]%>"></h4>

                                </div> 
                            </div>



                            <% }%>






                        </div>
                    </div>


                </div>


                <div class="modal-footer">
                    <button type="button" class="btn btn-danger waves-effect text-left" data-dismiss="modal">Close</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->



</div>



<!-- slimscrollbar scrollbar JavaScript -->


<script>
    function autocomplete(inp, arr) {
        /*the autocomplete function takes two arguments,
         the text field element and an array of possible autocompleted values:*/
        var currentFocus;
        /*execute a function when someone writes in the text field:*/
        inp.addEventListener("input", function (e) {
            var a, b, i, val = this.value;
            /*close any already open lists of autocompleted values*/
            closeAllLists();
            if (!val) {
                return false;
            }
            currentFocus = -1;
            /*create a DIV element that will contain the items (values):*/
            a = document.createElement("DIV");
            a.setAttribute("id", this.id + "autocomplete-list");
            a.setAttribute("class", "autocomplete-items");
            /*append the DIV element as a child of the autocomplete container:*/
            this.parentNode.appendChild(a);
            /*for each item in the array...*/
            for (i = 0; i < arr.length; i++) {
                /*check if the item starts with the same letters as the text field value:*/
                if (arr[i].substr(0, val.length).toUpperCase() == val.toUpperCase()) {
                    /*create a DIV element for each matching element:*/
                    b = document.createElement("DIV");
                    /*make the matching letters bold:*/
                    b.innerHTML = "<strong>" + arr[i].substr(0, val.length) + "</strong>";
                    b.innerHTML += arr[i].substr(val.length);
                    /*insert a input field that will hold the current array item's value:*/
                    b.innerHTML += "<input type='hidden' value='" + arr[i] + "'>";
                    /*execute a function when someone clicks on the item value (DIV element):*/
                    b.addEventListener("click", function (e) {
                        /*insert the value for the autocomplete text field:*/
                        inp.value = this.getElementsByTagName("input")[0].value;
                        /*close the list of autocompleted values,
                         (or any other open lists of autocompleted values:*/
                        closeAllLists();
                    });
                    a.appendChild(b);
                }
            }
        });
        /*execute a function presses a key on the keyboard:*/
        inp.addEventListener("keydown", function (e) {
            var x = document.getElementById(this.id + "autocomplete-list");
            if (x)
                x = x.getElementsByTagName("div");
            if (e.keyCode == 40) {
                /*If the arrow DOWN key is pressed,
                 increase the currentFocus variable:*/
                currentFocus++;
                /*and and make the current item more visible:*/
                addActive(x);
            } else if (e.keyCode == 38) { //up
                /*If the arrow UP key is pressed,
                 decrease the currentFocus variable:*/
                currentFocus--;
                /*and and make the current item more visible:*/
                addActive(x);
            } else if (e.keyCode == 13) {
                /*If the ENTER key is pressed, prevent the form from being submitted,*/
                e.preventDefault();
                if (currentFocus > -1) {
                    /*and simulate a click on the "active" item:*/
                    if (x)
                        x[currentFocus].click();
                }
            }
        });
        function addActive(x) {
            /*a function to classify an item as "active":*/
            if (!x)
                return false;
            /*start by removing the "active" class on all items:*/
            removeActive(x);
            if (currentFocus >= x.length)
                currentFocus = 0;
            if (currentFocus < 0)
                currentFocus = (x.length - 1);
            /*add class "autocomplete-active":*/
            x[currentFocus].classList.add("autocomplete-active");
        }
        function removeActive(x) {
            /*a function to remove the "active" class from all autocomplete items:*/
            for (var i = 0; i < x.length; i++) {
                x[i].classList.remove("autocomplete-active");
            }
        }
        function closeAllLists(elmnt) {
            /*close all autocomplete lists in the document,
             except the one passed as an argument:*/
            var x = document.getElementsByClassName("autocomplete-items");
            for (var i = 0; i < x.length; i++) {
                if (elmnt != x[i] && elmnt != inp) {
                    x[i].parentNode.removeChild(x[i]);
                }
            }
        }
        /*execute a function when someone clicks in the document:*/
        document.addEventListener("click", function (e) {
            closeAllLists(e.target);
        });
    }

    /*An array containing all the country names in the world:*/

    /*initiate the autocomplete function on the "myInput" element, and pass along the countries array as possible autocomplete values:*/




</script> 



<script>
    var checkbox<%=tablename%>;

    <%
        String role = utilisateur.getRole();%>
    var tablename = "<%=tablename%>";
    var tablename1 = "<%=tablename%>";
    var tablename2<%=tablename%> = "<%=tablename%>";
    var variable<%=tablename%>, variableTable<%=tablename%>, variableTableAutre<%=tablename%>, variableEdit<%=tablename%>, variableEditGet<%=tablename%>;
    switch (tablename2<%=tablename%>) {
        case "Produit":
                  autocomplete(document.getElementById("collapseadd<%=tablename%>").querySelector("#Type-<%=tablename%>"),types);
            
      
    //All variable of Table 
     variable<%=tablename%> = ["Nom", "Designation", "Matricule","Type","ProduitDe", "Marque", "Modele", "Prix-unitaire", "Structure", "Image"];
    // GET Variable from modal EDIT
     variableEditGet<%=tablename%> = ["Designation", "Matricule","Marque", "Modele", "Prix-unitaire", "Structure"];
    // Variables Afficher dans la Table
     variableTable<%=tablename%> = ["Nom", "Marque", "Modele", "Quantité", "Prix-unitaire", "Structure","ProduitDe"];
    // Variables Hidden dans La table
     variableTableAutre<%=tablename%> = ["Type", "Matricule", "Designation"];
    //Variables modifiable dans table et qui sont affichés
     variableEdit<%=tablename%> = ["Marque", "Modele", "Prix-unitaire", "Structure"];

            break;
        case "Projet":

            variable<%=tablename%> = ["Nom", "Structure"];
            variableEditGet<%=tablename%> = ["Nom", "Structure"];
            variableTable<%=tablename%> = ["Nom", "Structure"];
            variableTableAutre<%=tablename%> = [];
            variableEdit<%=tablename%> = ["Nom", "Structure"];
            break;
        case "Article":
                  autocomplete(document.getElementById("collapseadd<%=tablename%>").querySelector("#Type-<%=tablename%>"),types);
           
      
    //All variable of Table 
     variable<%=tablename%> = ["Nom", "Designation", "Matricule", "Type","ProduitDe", "Marque", "Modele", "Prix-unitaire", "Structure", "Image"];
    // GET Variable from modal EDIT
     variableEditGet<%=tablename%> = ["Designation", "Matricule", "Marque", "Modele", "Prix-unitaire", "Structure"];
    // Variables Afficher dans la Table
     variableTable<%=tablename%> = ["Nom", "Marque", "Modele", "Quantité", "Prix-unitaire", "Structure","ProduitDe"];
    // Variables Hidden dans La table
     variableTableAutre<%=tablename%> = ["Type", "Matricule", "Designation"];
    //Variables modifiable dans table et qui sont affichés
     variableEdit<%=tablename%> = ["Marque", "Modele", "Prix-unitaire", "Structure"];
            break;


        case "Structure":

            variable<%=tablename%> = ["Nom_Structure", "Code"];
            variableEditGet<%=tablename%> = ["Nom_Structure", "Code"];
            variableTable<%=tablename%> = ["Nom_Structure", "Code"];
            variableTableAutre<%=tablename%> = [];
            variableEdit<%=tablename%> = ["Nom_Structure", "Code"];
            break;
        case "ModeLivraison":

            variable<%=tablename%> = ["Mode_Livraison"];
            variableEditGet<%=tablename%> = ["Mode_Livraison"];
            variableTable<%=tablename%> = ["Mode_Livraison"];
            variableTableAutre<%=tablename%> = [];
            variableEdit<%=tablename%> = ["Mode_Livraison"];
            break;
        case "ModeReglement":

            variable<%=tablename%> = ["Mode_Reglement"];
            variableEditGet<%=tablename%> = ["Mode_Reglement"];
            variableTable<%=tablename%> = ["Mode_Reglement"];
            variableTableAutre<%=tablename%> = [];
            variableEdit<%=tablename%> = ["Mode_Reglement"];
            break;
        case "Utilisateur":
            autocomplete(document.getElementById("collapseaddUtilisateur").querySelector("#Email-Utilisateur"), emails);
            autocomplete(document.getElementById("collapseaddUtilisateur").querySelector("#Role-Utilisateur"), roles);
            autocomplete(document.getElementById("editUtilisateur").querySelector("#Role-Utilisateur"), roles);
            //All variable of Table 
            variable<%=tablename%> = ["UserName", "Email", "Password", "Structure", "Role"];
            // GET Variable from modal EDIT

            variableEditGet<%=tablename%> = ["UserName", "Password", "Structure", "Role", "Etat"];
            // Variables Afficher dans la Table

            variableTable<%=tablename%> = ["UserName", "Email", "Structure", "Role", "Etat"];
            // Variables Hidden dans La table
            variableTableAutre<%=tablename%> = ["Password"];
            //Variables modifiable dans table et qui sont affichés
            variableEdit<%=tablename%> = ["UserName", "Structure", "Role", "Etat"];

            break;
        case "Membre":


            //All variable of Table 
            variable<%=tablename%> = ["Nom", "Prenom", "Email", "Structure"];
            // GET Variable from modal EDIT

            variableEditGet<%=tablename%> = ["Nom", "Prenom", "Email", "Structure"];
            // Variables Afficher dans la Table

            variableTable<%=tablename%> = ["Nom", "Prenom", "Email", "Structure"];
            // Variables Hidden dans La table
            variableTableAutre<%=tablename%> = [];
            //Variables modifiable dans table et qui sont affichés
            variableEdit<%=tablename%> = ["Nom", "Prenom", "Email", "Structure"];

            break;
        case "Notification":

            autocomplete(document.getElementById("collapseaddNotification").querySelector("#Utilisateur-Notification"), utilisateurs_notification);
            autocomplete(document.getElementById("editNotification").querySelector("#Utilisateur-Notification"), utilisateurs_notification);
            //All variable of Table 
            variable<%=tablename%> = ["Nom_Notfication", "Utilisateur", "Mode", "Evenement", "Date_Evenement", "Rappel"];
            // GET Variable from modal EDIT

            variableEditGet<%=tablename%> = ["Nom_Notfication", "Utilisateur", "Mode", "Evenement", "Date_Evenement", "Rappel"];
            // Variables Afficher dans la Table

            variableTable<%=tablename%> = ["Nom_Notfication", "Utilisateur", "Evenement", "Date_Evenement", "Rappel"];
            // Variables Hidden dans La table
            variableTableAutre<%=tablename%> = ["Mode"];
            //Variables modifiable dans table et qui sont affichés
            variableEdit<%=tablename%> = ["Nom_Notfication", "Utilisateur", "Evenement", "Date_Evenement", "Rappel"];

            break;
        case "TypeDocument":


            //All variable of Table 
            variable<%=tablename%> = ["Nom_Document", "Abbreviation"];
            // GET Variable from modal EDIT

            variableEditGet<%=tablename%> = ["Nom_Document", "Abbreviation"];
            // Variables Afficher dans la Table

            variableTable<%=tablename%> = ["Nom_Document", "Abbreviation"];
            // Variables Hidden dans La table
            variableTableAutre<%=tablename%> = [];
            //Variables modifiable dans table et qui sont affichés
            variableEdit<%=tablename%> = ["Nom_Document", "Abbreviation"];

            break;
        case "Destinateur":


            autocomplete(document.getElementById("collapseaddDestinateur").querySelector("#Type_Destinateur-Destinateur"), types_destinateur);
            autocomplete(document.getElementById("editDestinateur").querySelector("#Type_Destinateur-Destinateur"), types_destinateur);
            //All variable of Table 
            variable<%=tablename%> = ["Nom_Destinateur", "Type_Destinateur", "Email_Destinateur", "Phone_Destinateur", "Fax_Destinateur", "Addresse", "Registre_Commerce", "N_Agrement", "NIF", "Article_I", "Structure"];
            // GET Variable from modal EDIT

            variableEditGet<%=tablename%> = ["Nom_Destinateur", "Type_Destinateur", "Email_Destinateur", "Phone_Destinateur", "Fax_Destinateur", "Addresse", "Registre_Commerce", "N_Agrement", "NIF", "Article_I", "Structure"];
            // Variables Afficher dans la Table

            variableTable<%=tablename%> = ["Nom_Destinateur", "Type_Destinateur", "Email_Destinateur", "Phone_Destinateur", "Registre_Commerce", "N_Agrement", "Structure"];
            // Variables Hidden dans La table
            variableTableAutre<%=tablename%> = ["Fax_Destinateur", "Addresse", "NIF", "Article_I"];
            //Variables modifiable dans table et qui sont affichés
            variableEdit<%=tablename%> = ["Nom_Destinateur", "Type_Destinateur", "Email_Destinateur", "Phone_Destinateur", "Registre_Commerce", "N_Agrement", "Structure"];

            break;

        case "Nature":




            autocomplete(document.getElementById("editNature").querySelector("#Projet-Nature"), projets);
            autocomplete(document.getElementById("collapseaddNature").querySelector("#Projet-Nature"), projets);

            //All variable of Table 
            variable<%=tablename%> = ["Nom_Nature", "Projet"];
            // GET Variable from modal EDIT

            variableEditGet<%=tablename%> = ["Nom_Nature", "Projet"];
            // Variables Afficher dans la Table

            variableTable<%=tablename%> = ["Nom_Nature", "Projet"];
            // Variables Hidden dans La table
            variableTableAutre<%=tablename%> = [];
            //Variables modifiable dans table et qui sont affichés
            variableEdit<%=tablename%> = ["Nom_Nature", "Projet"];

            break;




        case "TypeNature":
            autocomplete(document.getElementById("collapseaddTypeNature").querySelector("#Nom_Nature-TypeNature"), natures);
            autocomplete(document.getElementById("editTypeNature").querySelector("#Nom_Nature-TypeNature"), natures);

            //All variable of Table 
            variable<%=tablename%> = ["Nom_Nature", "Type_Nature"];
            // GET Variable from modal EDIT

            variableEditGet<%=tablename%> = ["Nom_Nature", "Type_Nature"];
            // Variables Afficher dans la Table

            variableTable<%=tablename%> = ["Nom_Nature", "Type_Nature"];
            // Variables Hidden dans La table
            variableTableAutre<%=tablename%> = [];
            //Variables modifiable dans table et qui sont affichés
            variableEdit<%=tablename%> = ["Nom_Nature", "Type_Nature"];

            break;


        case "DesignationNature":

            autocomplete(document.getElementById("collapseaddDesignationNature").querySelector("#Nom_Nature-DesignationNature"), natures);
            autocomplete(document.getElementById("editDesignationNature").querySelector("#Nom_Nature-DesignationNature"), natures);
            //All variable of Table 
            variable<%=tablename%> = ["Nom_Nature", "Designation_Nature"];
            // GET Variable from modal EDIT

            variableEditGet<%=tablename%> = ["Nom_Nature", "Designation_Nature"];
            // Variables Afficher dans la Table

            variableTable<%=tablename%> = ["Nom_Nature", "Designation_Nature"];
            // Variables Hidden dans La table
            variableTableAutre<%=tablename%> = [];
            //Variables modifiable dans table et qui sont affichés
            variableEdit<%=tablename%> = ["Nom_Nature", "Designation_Nature"];

            break;

        case "TypeAttachment":
            autocomplete(document.getElementById("editTypeAttachment").querySelector("#Projet-TypeAttachment"), projets);
            autocomplete(document.getElementById("collapseaddTypeAttachment").querySelector("#Projet-TypeAttachment"), projets);

            autocomplete(document.getElementById("editTypeAttachment").querySelector("#Situation_Attachment-TypeAttachment"), situations_attachment);
            autocomplete(document.getElementById("collapseaddTypeAttachment").querySelector("#Situation_Attachment-TypeAttachment"), situations_attachment);

            autocomplete(document.getElementById("editTypeAttachment").querySelector("#Designation-TypeAttachment"), designations_nature);
            autocomplete(document.getElementById("collapseaddTypeAttachment").querySelector("#Designation-TypeAttachment"), designations_nature);

            autocomplete(document.getElementById("editTypeAttachment").querySelector("#Type-TypeAttachment"), types_nature);
            autocomplete(document.getElementById("collapseaddTypeAttachment").querySelector("#Type-TypeAttachment"), types_nature);


            autocomplete(document.getElementById("collapseaddTypeAttachment").querySelector("#Nom_Nature-TypeAttachment"), natures);
            autocomplete(document.getElementById("editTypeAttachment").querySelector("#Nom_Nature-TypeAttachment"), natures);
            //All variable of Table 
            variable<%=tablename%> = ["Nom_Attachment", "Type_Attachment", "Situation_Attachment", "Structure", "Projet", "Nom_Nature", "Designation", "Type"];
            // GET Variable from modal EDIT

            variableEditGet<%=tablename%> = ["Nom_Attachment", "Type_Attachment", "Situation_Attachment", "Structure", "Projet", "Nom_Nature", "Designation", "Type"];
            // Variables Afficher dans la Table

            variableTable<%=tablename%> = ["Nom_Attachment", "Type_Attachment", "Situation_Attachment", "Structure", "Projet", "Nom_Nature", "Designation", "Type"];
            // Variables Hidden dans La table
            variableTableAutre<%=tablename%> = [];
            //Variables modifiable dans table et qui sont affichés
            variableEdit<%=tablename%> = ["Nom_Attachment", "Type_Attachment", "Situation_Attachment", "Structure", "Projet", "Nom_Nature", "Designation", "Type"];

            break;
    }






    $(document).on("click", ".detail-" + tablename, function () {

        $("#con").hide();
        var id = $(this).attr("id");

        $('#container2').load('/IMTRADE/Manager?id=' + id + '&type=' + 'detail' + tablename + '&table=' + tablename);

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





    var modal<%=tablename%> = document.getElementById("edit" + tablename1);
    $(document).on("click", "#closeedit", function () {

        modal<%=tablename%>.style.display = "none";
    });
    $(document).on("click", "#mode" + tablename1, function () {

        switch ($(this).text()) {
            case "Mode1":


                var id = $(this).parents("td").attr("id");

                //$('#body_content').load('DocIMTrade/Archive.jsp');


                break;
            case "Mode2":

                $('#body_content').load('/IMTRADE/Manager?table=' + tablename1 + '&type=cardProduit' + '&cond=all');


                break;
        }

    });




    $(document).on("click", "#manage" + tablename2<%=tablename%>, function () {
        switch ($(this).text()) {
            case "VOIR":
                var va;

                for (i = 0; i < variableTable<%=tablename%>.length; i++) {
                    va = $(this).parents("tr").find(".row-" + tablename2<%=tablename%> + "-" + variableTable<%=tablename%>[i]).text();

                    $("#Voir" + tablename2<%=tablename%>).find("#general ." + variableTable<%=tablename%>[i]).text(va);


                }


                for (i = 0; i < variableTableAutre<%=tablename%>.length; i++) {
                    va = $(this).parents("tr").find("#row-" + tablename2<%=tablename%> + "-" + variableTableAutre<%=tablename%>[i]).val();
                    $("#Voir" + tablename2<%=tablename%>).find("#general ." + variableTableAutre<%=tablename%>[i]).text(va);



                }
                if (tablename2<%=tablename%> === "Produit") {

                    $("#con").hide();
                    var id = $(this).parents("td").attr("id");
                    //alert(id);
                    $('#container2').load('/IMTRADE/Manager?id=' + id + '&type=' + 'detail' + tablename2<%=tablename%> + '&table=' + tablename2<%=tablename%>);

                } else {

                    $('#Voir' + tablename2<%=tablename%>).modal();



                    /*jQuery.noConflict(); 
                     $('#fafa').modal('show'); */

                }






                break;
            case "ÉDITER":

                var v1;
                for (i = 0; i < variableEdit<%=tablename%>.length; i++) {
                    v1 = $(this).parents("tr").find(".row-" + tablename2<%=tablename%> + "-" + variableEdit<%=tablename%>[i]).text();
             

                    $('#edit' + tablename2<%=tablename%>).find('#' + variableEdit<%=tablename%>[i] + '-' + tablename2<%=tablename%>).val(v1);

                }
                for (i = 0; i < variableTableAutre<%=tablename%>.length; i++) {
                    v1 = $(this).parents("tr").find("#row-" + tablename2<%=tablename%> + "-" + variableTableAutre<%=tablename%>[i]).val();

                    $('#edit' + tablename2<%=tablename%>).find('#' + variableTableAutre<%=tablename%>[i] + '-' + tablename2<%=tablename%>).val(v1);

                }


                $('#edit' + tablename2<%=tablename%>).find('.id-' + tablename2<%=tablename%>).val($(this).parents("tr").find(".row-" + tablename2<%=tablename%> + "-" + variableTable<%=tablename%>[0]).attr("id"));
                $('#edit' + tablename2<%=tablename%>).find('.line-' + tablename2<%=tablename%>).val($(this).parents("tr").find(".row-" + tablename2<%=tablename%> + "-N°").attr("id"));
                var d = $('#edit' + tablename2<%=tablename%>).find('.id-' + tablename2<%=tablename%>).val();
            
                var k = $('#edit' + tablename2<%=tablename%>).find('.line-' + tablename2<%=tablename%>).val();
                //alert($(this).parents("tr").attr("id"));
               
                modal<%=tablename%>.style.display = "block";
                break;

            case "EFFACER":


                Swal.fire({
                    title: 'Are you sure?',
                    text: "voulez-vous supprimer!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    cancelButtonText: 'Annuler',
                    confirmButtonText: 'Supprimer!'
                }).then((result) => {
                    if (result.value) {


                        //alert(f.index());


                        var id = $(this).parents("td").attr("id");
                        
                        //alert(id);
                        //alert('mouadh');
                        $.ajax({
                            url: '/IMTRADE/Manager',
                            type: 'POST',
                            data: {
                                'id': id,
                                'type': 'delete' + tablename2<%=tablename%>,
                                'table': tablename2<%=tablename%>,
                                'idUtilisateur': <%=utilisateur.getIdUtilisateur()%>,
                            },
                            success: function (response) {


                            }
                        });



                        var table = $("#table" + tablename2<%=tablename%>).DataTable();

                        table.row($(this).parents('tr')).remove().draw();

                        Swal.fire(
                                'Deleted!',
                                'Votre ' + tablename2<%=tablename%> + ' a ete supprime.',
                                'success'
                                )
                    }
                })

                break;
        }



    });












    var countcheck<%=tablename%> = 0;
    checkbox<%=tablename%> = $('#table<%=tablename%> tbody input[type="checkbox"]');
    $("#selectAll" + tablename2<%=tablename%>).click(function ()
    {
        var table = $("#table" + tablename2<%=tablename%>).DataTable();
        checkbox<%=tablename%> = $('#table<%=tablename%> tbody input[type="checkbox"]');

        _isChecked = $(this).parents("label").hasClass("is-checked");
        if (_isChecked === false) {
            $(this).parents("label").addClass("is-checked");
            table = $("#table" + tablename2<%=tablename%>).DataTable();
            var rows = table.rows({'search': 'applied'}).nodes();
            // Check/uncheck checkboxes for all rows in the table
            $('input[type="checkbox"]', rows).prop('checked', this.checked);
            $('input[type="checkbox"]', rows).parents("label").addClass("is-checked");

            // checkbox<%=tablename%>.each(function (index, element) { 


            //$(this).prop("checked",true);
            //$(this).parents("label").addClass("is-checked");
            // });
            //$('table input[type="checkbox"]').prop("checked",true);
            table = $("#table" + tablename2<%=tablename%>).DataTable();
            var index = table.column(0).data().length;
            $(".deleterow-" + tablename2<%=tablename%>).find("span").text(index + " " + "elements");
    <%if (role.equals("role1")) {%>
            $('.deleterow-' + tablename2<%=tablename%>).removeClass('hidden');
    <% }%>

            countcheck<%=tablename%> = index;
        } else {

            $(this).parents("label").removeClass("is-checked");
            table = $("#table" + tablename2<%=tablename%>).DataTable();
            rows = table.rows({'search': 'applied'}).nodes();
            $('input[type="checkbox"]', rows).prop('checked', false);
            $('input[type="checkbox"]', rows).parents("label").removeClass("is-checked");



            $(".deleterow-" + tablename2<%=tablename%>).find("span").text(0 + " " + "elements");
            $('.deleterow-' + tablename2<%=tablename%>).addClass('hidden');
            countcheck<%=tablename%> = 0;
        }

    });
    $(document).on("click", "#selectone" + tablename2<%=tablename%>, function () {

        var er;
        var count = 0;
        if ($(this).parents("label").hasClass("is-checked")) {
            $(this).parents("label").removeClass("is-checked");

            countcheck<%=tablename%>--;



        } else {
            // var er=$(".delete"+tablename).find("span").text();


            $(this).parents("label").addClass("is-checked");

            countcheck<%=tablename%>++;

        }
        if (countcheck<%=tablename%> === 0)
            $('.deleterow-' + tablename2<%=tablename%>).addClass('hidden');
        else
    <%if (role.equals("role1")) {%>
        $('.deleterow-' + tablename2<%=tablename%>).removeClass('hidden');
    <% }%>


        $(".deleterow-" + tablename2<%=tablename%>).find("span").text(countcheck<%=tablename%> + " " + "elements");


    });




    $(document).on("click", ".deleterow-" + tablename2<%=tablename%>, function () {
        Swal.fire({
            title: 'Are you sure?',
            text: "voulez-vous supprimer!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            cancelButtonText: 'Annuler',
            confirmButtonText: 'Supprimer!'
        }).then((result) => {
            if (result.value) {


                //alert(f.index());
                checkbox<%=tablename%>.each(function (index, element) {
                    if ($(this).parents("label").hasClass("is-checked")) {

                        var id = $(this).parents("td").attr("id");


                        $.ajax({
                            url: '/IMTRADE/Manager',
                            type: 'POST',
                            data: {
                                'id': id,
                                'type': 'delete' + tablename2<%=tablename%>,
                                'table': tablename2<%=tablename%>,
                                'idUtilisateur':<%=utilisateur.getIdUtilisateur()%>,
                            },
                            success: function (response) {


                            }
                        });

                        //console.log(tr);

                        var table = $("#table" + tablename2<%=tablename%>).DataTable();
                        //$(this).parents("td").parents("tr").find(".row-"+tablename+"-isDeleted").html('-1');
                        table.row($(this).parents('tr')).remove().draw();

                    }

                    Swal.fire(
                            'Deleted!',
                            'Votre ' + tablename2<%=tablename%> + ' a ete supprime.',
                            'success'
                            )

                    countcheck<%=tablename%> = 0;
                    $('.deleterow-' + tablename2<%=tablename%>).addClass('hidden');
                });
            }
        })





    });

    $(document).on("click", ".add", function () {





        var _textfield1;
        var fd = new FormData();
        for (i = 0; i < variable<%=tablename%>.length; i++) {

            if (variable<%=tablename%>[i] === "Image") {

                fd.append('file', $('#' + variable<%=tablename%>[i] + '-' + tablename2<%=tablename%>)[0].files[0]);


            } else {
                _textfield1 = $("#" + variable<%=tablename%>[i] + "-" + tablename2<%=tablename%>).val();
                alert(_textfield1);
                fd.append(variable<%=tablename%>[i], _textfield1);


            }


        }

        fd.append('type', 'Add' + tablename2<%=tablename%>);
        fd.append('table', tablename2<%=tablename%>);
        fd.append('idUtilisateur', <%=utilisateur.getIdUtilisateur()%>);
        $.ajax({
            url: '/IMTRADE/Manager',
            type: 'POST',
            enctype: "multipart/form-data",

            data: fd,

            processData: false,
            contentType: false,
            success: function (response) {
                alert("response" + response);
                if (response === "suc") {

                    var t1 = "GetLastId" + tablename2<%=tablename%>;



                    $.ajax({
                        url: "/IMTRADE/Manager",
                        type: "Post",

                        data: {'type': t1, 'table': tablename2<%=tablename%>},

                        dataType: "json",
                        success: function (response) {

                            var t = response;
                            var table = $("#table" + tablename2<%=tablename%>).DataTable();
                            var index = table.column(0).data().length + 1;
                            var index1 = index - 1;
                            alert(t);



                            var html1 = '<tr id="ligne' + index1 + '"  class="ligne">';
                            html1 += '<td id="selectone' + t + '"><label class="toggle"><input class="toggle__input" type="checkbox"><span class="toggle__label"></span></label></td>\n\
                          <td class="btndraw text-center fixed-column row-' + tablename2<%=tablename%> + '-manage justify-content-center" id="' + t + '"> <div class="btn-group"> <button type="button" class="btn btn-outline-info waves-effect waves-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-cogs"></i><span class="caret"></span> </button><div class="dropdown-menu"> <a class="dropdown-item text-info" id="manage' + tablename2<%=tablename%> + '" >VOIR</a> <a class="dropdown-item text-info" id="manage' + tablename2<%=tablename%> + '">ÉDITER</a><a class="dropdown-item text-info" id="manage' + tablename2<%=tablename%> + '">EFFACER</a>  </div> </div></td>\n\
                          <td class="text-left row-' + tablename2<%=tablename%> + '-N°" id="ligne' + index1 + '">' + index + '</td>';
                            alert(html1);
                            for (i = 0; i < variableTable<%=tablename%>.length; i++) {
                                if (variableTable<%=tablename%>[i] === "Quantité") {

                                    html1 += '<td class="text-left row-' + tablename2<%=tablename%> + '-' + variableTable<%=tablename%>[i] + '" id="' + t + '">0.0</td>';
                                } else {

                                    _textfield1 = $("#" + variableTable<%=tablename%>[i] + "-" + tablename2<%=tablename%>).val();

                                    html1 += '<td class="text-left row-' + tablename2<%=tablename%> + '-' + variableTable<%=tablename%>[i] + '" id="' + t + '">' + _textfield1 + '</td>';
                                }
                            }


                            for (i = 0; i < variableTableAutre<%=tablename%>.length; i++) {
                                _textfield1 = $("#" + variableTableAutre<%=tablename%>[i] + "-" + tablename2<%=tablename%>).val();
                                html1 += '<input type="hidden" id="row-' + tablename2<%=tablename%> + '-' + variableTableAutre<%=tablename%>[i] + '" value="' + _textfield1 + '">';
                            }
                            html1 += '</tr>';

                            //var html='<tr><td> <span class="custom-checkbox"> <input type="checkbox"name="options[]" class="mdl-checkbox" value="1"> <label > </label> </span> </td> <td >'+_textfield1+'</td>  <td >'+_textfield2+'</td> <td >'+_textfield5+'</td> <td >'+_textfield6+'</td> <td >'+_textfield7+'</td>  <td><a href="#" class="view" title="View" data-toggle="tooltip"><i class="material-icons">&#xE417;</i></a> <a href="#" class="edit" title="Edit" data-toggle="tooltip"><i class="material-icons">&#xE254;</i></a><a href="#" class="delete" title="Delete" data-toggle="tooltip"><i class="material-icons">&#xE872;</i></a> </td> </tr>';
                            // $("#table"+tablename+" "+"tbody").append(html1);

                            var dataTable = $("#table" + tablename2<%=tablename%>).dataTable().api();
                            tr = document.createElement("tr");
                            tr.innerHTML = html1;
                            dataTable.row.add(tr);
                            dataTable.draw();

                            for (i = 0; i < variable<%=tablename%>.length; i++) {


                                $('#collapseadd' + tablename2<%=tablename%>).find('#' + variable<%=tablename%>[i] + '-' + tablename2<%=tablename%>).val('');

                            }


                        }
                    });

                    Swal.fire(
                            'bien!',
                            'Ajoute Un nouveaux ' + tablename2<%=tablename%> + '!',
                            'success'
                            )




                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: response,

                    })
                }
            }
        });




    });


    $(document).on("click", ".edit" + tablename2<%=tablename%>, function () {



        var return_first;
        function callback(response) {
            return_first = response;

        }
        var fd = new FormData();
        var v1;
        for (i = 0; i < variableEditGet<%=tablename%>.length; i++) {
            v1 = $('#edit' + tablename2<%=tablename%>).find('#' + variableEditGet<%=tablename%>[i] + '-' + tablename2<%=tablename%>).val();
            alert(variableEditGet<%=tablename%>[i]);
            alert(v1);
            fd.append(variableEditGet<%=tablename%>[i], v1);

        }

        fd.append('type', 'edit' + tablename2<%=tablename%>);
        var id = $('#edit' + tablename2<%=tablename%>).find('.id-' + tablename2<%=tablename%>).val();
        fd.append('idUtilisateur', <%=utilisateur.getIdUtilisateur()%>);
        alert(id);
        fd.append('id', id);
        fd.append('table', tablename2<%=tablename%>);
        $.ajax({
            url: '/IMTRADE/Manager',
            type: 'POST',
            enctype: "multipart/form-data",
            data: fd,

            processData: false,
            contentType: false,
            success: function (response) {
                if (response == "suc") {

                    callback(response);
                    var newvar;
                    var line = $('#edit' + tablename2<%=tablename%>).find('.line-' + tablename2<%=tablename%>).val();
                    alert("line" + line);
                    for (i = 0; i < variableEdit<%=tablename%>.length; i++) {


                        newvar = $('#edit' + tablename2<%=tablename%>).find('#' + variableEdit<%=tablename%>[i] + '-' + tablename2<%=tablename%>).val();


                        $('#' + line).parents("tr").find(".row-" + tablename2<%=tablename%> + "-" + variableEdit<%=tablename%>[i]).text(newvar);
                    }

                    for (i = 0; i < variableTableAutre<%=tablename%>.length; i++) {
                        newvar = $('#edit' + tablename2<%=tablename%>).find('#' + variableTableAutre<%=tablename%>[i] + '-' + tablename2<%=tablename%>).val();


                        $('#' + line).parents("tr").find("#row-" + tablename2<%=tablename%> + "-" + variableTableAutre<%=tablename%>[i]).val(newvar);



                    }



                    Swal.fire(
                            'bien!',
                            'Votre' + tablename2<%=tablename%> + 'a ete mis a jour!',
                            'success'
                            )


                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: response,

                    })
                }
            }
        });




    });









</script>

<script>

    <% String[] attribut = attributs.split("%%");%>
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




    <%if (role.equals("role3")) {%>
        table.column(1).visible(false);

        $('#check-<%=tablename%>-manage').hide();

        $('#modeStock').hide();

    <% }%>

    <%if (role.equals("role2")) {%>

        $("a:contains(ÉDITER)").hide();
        $("a:contains(EFFACER)").hide();



    <% }%>
    <%if (!role.equals("role1") && !role.equals("Magasinier")) {%>

        $("i:contains(add_circle_outline)").hide();




    <% }%>
    <%if (role.equals("role1")) {%>








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




