/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package module;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import maps.Attachment;
import maps.Contact;
import maps.Cv;
import maps.DesignationNature;
import maps.Destinateur;
import maps.DocAttach;
import maps.DocNotif;
import maps.DocObjet;
import maps.DocObjetSn;
import maps.Doctype;
import maps.Document;
import maps.Membre;
import maps.ModeLivraison;
import maps.ModeReglement;
import maps.Nature;
import maps.Notification;
import maps.Objet;
import maps.Produit;
import maps.Projet;
import maps.ProjetMembre;
import maps.Serialnumber;
import maps.Structure;
import maps.StructureDetails;
import maps.TemplateDocument;
import maps.Trace;
import maps.TypeAttachment;
import maps.TypeNature;
import maps.Utilisateur;
import maps.VarObjet;
import org.hibernate.Query;
import org.hibernate.Session;
import util.HibernateUtil;

/**
 *
 * @author Mechri
 */
public class ModelBean {

    public static Object Latest(String table, String id) {
        Session session = null;
        HibernateUtil hb = new HibernateUtil();
        session = hb.getSessionFactory().openSession();
        session.beginTransaction();
        Query query = session.createQuery("from " + table + " where " + id + "=(select max(" + id + ") from " + table + ")");
        List al = query.list();
        session.getTransaction().commit();
        session.close();
        return al.get(0);
    }

    public static List GetContentTable(String table, String where) {
        Session session = null;
        HibernateUtil hb = new HibernateUtil();
        session = hb.getSessionFactory().openSession();
        session.beginTransaction();
        Query query = session.createQuery("from " + table + " " + where);
        List al = query.list();
        session.getTransaction().commit();
        session.close();
        return al;
    }

    /*
    public static HashMap GetList(String tablename){
        List table=GetContentTable(tablename,"where isDelete=0");
        
        HashMap<String,List> datatable=new HashMap<>();
        datatable.put("data", table);
        datatable.put("data", table);
        
        
        return null;
    }
     */
    public static boolean Testexist(String table, String function, String types, String atts, String vals) {
        String[] tabtypes = types.split("%%");
        String[] tabatts = atts.split("%%");
        String[] tabvals = vals.split("%%");
        String where = "";
        if (tabvals.length > 0) {
            where = "where ";
        }
        String f = function;
        function = "";
        for (int i = 0; i < tabtypes.length; i++) {
            String tabtype = tabtypes[i];
            String tabatt = tabatts[i];
            String tabval = tabvals[i];
            where = where + function + " ";
            if (tabtype.equals("String")) {
                where = where + tabatt + "='" + tabval + "' ";
            } else {
                where = where + tabatt + "=" + tabval + " ";
            }
            function = f;
        }
        System.out.println(where);
        return isFound(table, where);
    }

    /*public static boolean AddLine(Object object) {
        Object relation = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        ///
        session.save(relation);
        session.getTransaction().commit();
        session.close();

        return true;
    }*/
    public static boolean AddLine1(Object object, String table) {
        Object relation = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        /*isFound*/
        switch (table) {

            case "Structure":
                session.save(object);
                session.getTransaction().commit();
                session.close();
                break;

            case "ObjetType":
                session.save(object);
                session.getTransaction().commit();
                session.close();

                break;

            case "TemplateDocument":

                break;

            case "TypeNature":
                 session.save(object);
                session.getTransaction().commit();
                session.close();
                break;
            case "VarObject":

                break;
            case "Projet":
                 session.save(object);
                session.getTransaction().commit();
                session.close();
                break;
            case "Doctype":
                session.save(object);
                session.getTransaction().commit();
                session.close();

                break;
            case "Document":

                break;
            case "ProjetMembre":

                break;
            case "Serialnumber":
                Serialnumber p1 = (Serialnumber) object;
                if (!isFound(table, "where sn='" + p1.getSn() + "'")) {

                    session.save(object);
                    session.getTransaction().commit();
                    session.close();

                }

                break;
            case "Membre":
                session.save(object);
                session.getTransaction().commit();
                session.close();

                break;
            case "ModeReglement":
                   session.save(object);
                session.getTransaction().commit();
                session.close();
                break;
                 case "ModeLivraison":
                session.save(object);
                session.getTransaction().commit();
                session.close();
         
                     break;
            case "Nature":
                 session.save(object);
                session.getTransaction().commit();
                session.close();
                break;
            case "Notification":
                session.save(object);
                session.getTransaction().commit();
                session.close();

                break;
            case "Objet":
                session.save(object);
                session.getTransaction().commit();
                session.close();

                break;
            case "Produit":
                Produit p = (Produit) object;
                if (!isFound(table, "where nom_produit='" + p.getNomProduit() + "'")) {
                    if (!isFound(table, "where designation='" + p.getDesignation() + "'")) {
                        if (!isFound(table, "where matricule='" + p.getMatricule() + "'")) {

                            session.save(object);
                            session.getTransaction().commit();
                            session.close();

                        }
                    }
                }
                break;
            case "DocAttach":

                break;
            case "DocNotif":

                break;
            case "DocObject":

                break;
            case "Destinateur":
                session.save(object);
                session.getTransaction().commit();
                session.close();

                break;

            case "Utilisateur":
                session.save(object);
                session.getTransaction().commit();
                session.close();

                break;

            case "Attachment":
                  session.save(object);
                session.getTransaction().commit();
                session.close();
                break;
                
                  case "TypeAttachment":
                  session.save(object);
                session.getTransaction().commit();
                session.close();
                break;

            case "Contact":
                 session.save(object);
                session.getTransaction().commit();
                session.close();

                break;
            case "Cv":

                break;
            case "DesignationNature":
                 session.save(object);
                session.getTransaction().commit();
                session.close();
                break;
            case "StructureDetais":
                session.save(object);
                session.getTransaction().commit();
                session.close();

                break;    
        }

        return true;
    }
    
    
    
    
            

    public static boolean UpdateLine(Object relation, String table, String id) {
        //Object relation = null;
        Session session = null;
        HibernateUtil hb = new HibernateUtil();
        session = hb.getSessionFactory().openSession();
        session.beginTransaction();
        Query query = null;
        List al = null;

//        query = session.createQuery("from " + table + " where " + id + "=" + items.get(0) + " " + where);
        switch (table) {

            case "Structure":

                Structure structure1 = (Structure) session.get(Structure.class, Integer.parseInt(id));
                Structure structure2 = (Structure) relation;

                if (structure1.getCode().equals(structure2.getCode()) && structure1.getNomStructure().equals(structure2.getNomStructure())) {
                    session.close();
                    return false;
                }

                session.save(structure2);
                session.getTransaction().commit();
                session.beginTransaction();
                Structure s = (Structure) Latest("Structure", "idStructure");
                structure1.setIsDeleted(s.getIdStructure());
                session.update(structure1);
                session.getTransaction().commit();

                break;

            case "TemplateDocument":
                TemplateDocument templateDocument = (TemplateDocument) session.get(TemplateDocument.class, Integer.parseInt(id));
                TemplateDocument templateDocument2 = (TemplateDocument) relation;

                if (templateDocument.getIdDocument() == templateDocument2.getIdDocument() && templateDocument.getNomTemplate().equals(templateDocument2.getNomTemplate())) {
                    session.close();
                    return false;
                }
                session.save(templateDocument2);
                session.getTransaction().commit();
                session.beginTransaction();
                TemplateDocument t = (TemplateDocument) Latest("TemplateDocument", "idTemplate");
                templateDocument.setIsDeleted(t.getIdTemplate());
                session.update(templateDocument);
                session.getTransaction().commit();

                break;

            case "TypeNature":
                TypeNature typeNature = (TypeNature) session.get(TypeNature.class, Integer.parseInt(id));
                TypeNature typeNature1 = (TypeNature) relation;

                if (typeNature.getNomType().equals(typeNature1.getNomType())) {
                    session.close();
                    return false;
                }

                session.save(typeNature1);
                session.getTransaction().commit();
                session.beginTransaction();
                TypeNature tn = (TypeNature) Latest("TypeNature", "idType");
                typeNature.setIsDeleted(tn.getIdType());
                session.update(typeNature);
                session.getTransaction().commit();

                break;
            case "VarObject":
                VarObjet varObject = (VarObjet) session.get(VarObjet.class, Integer.parseInt(id));
                VarObjet varObject1 = (VarObjet) relation;

                if (varObject.getNomVarObjet().equals(varObject1.getNomVarObjet()) && varObject.getValeurVarObjet().equals(varObject1.getValeurVarObjet())) {
                    session.close();
                    return false;
                }

                session.save(varObject1);
                session.getTransaction().commit();
                session.beginTransaction();
                VarObjet vo = (VarObjet) Latest("VarObjet", "idVarObjet");
                varObject.setIsDeleted(vo.getIdVarObjet());
                session.update(varObject1);
                session.getTransaction().commit();

                break;
            case "Projet":
                Projet projet = (Projet) session.get(Projet.class, Integer.parseInt(id));
                Projet projet1 = (Projet) relation;

                if (projet.getNomProjet().equals(projet1.getNomProjet()) && projet.getIdStructure() == projet1.getIdStructure()) {
                    session.close();
                    return false;
                }
                session.save(projet1);
                session.getTransaction().commit();
                session.beginTransaction();
                Projet p = (Projet) Latest("Projet", "idProjet");
                projet.setIsDeleted(p.getIdProjet());
                session.update(projet);
                session.getTransaction().commit();

                break;
            case "Doctype":
                Doctype doctype = (Doctype) session.get(Doctype.class, Integer.parseInt(id));
                Doctype doctype1 = (Doctype) relation;

                if (doctype.getAbbrev().equals(doctype1.getAbbrev()) && doctype.getNomDocument().equals(doctype1.getNomDocument())) {
                    session.close();
                    return false;
                }

                session.save(doctype);
                session.getTransaction().commit();
                session.beginTransaction();

                Doctype dt = (Doctype) Latest("Doctype", "idDoctype");
                doctype.setIsDeleted(dt.getIdDoctype());
                session.update(doctype);
                session.getTransaction().commit();

                break;
            case "Document":
                Document document = (Document) session.get(Document.class, Integer.parseInt(id));
                Document document1 = (Document) relation;

                session.save(document1);
                session.getTransaction().commit();
                session.beginTransaction();
                Document d = (Document) Latest("Document", "idDocument");
                document.setIsDeleted(d.getIdDocument());
                session.update(document);
                session.getTransaction().commit();

                break;
            case "ProjetMembre":
                ProjetMembre projetMembre = (ProjetMembre) session.get(ProjetMembre.class, Integer.parseInt(id));
                ProjetMembre projetMembre1 = (ProjetMembre) relation;

                session.save(projetMembre1);
                session.getTransaction().commit();
                session.beginTransaction();
                ProjetMembre pm = (ProjetMembre) Latest("ProjetMembre", "idStructure");
                projetMembre.setIsDeleted(pm.getIdProjetMembre());
                session.update(projetMembre);
                session.getTransaction().commit();

                break;
            case "Serialnmber":
                Serialnumber serialnumber = (Serialnumber) session.get(Serialnumber.class, Integer.parseInt(id));
                Serialnumber serialnumber1 = (Serialnumber) relation;

                session.save(serialnumber1);
                session.getTransaction().commit();
                session.beginTransaction();
                Serialnumber sn = (Serialnumber) Latest("Serialnumber", "idSn");
                serialnumber.setIsDeleted(sn.getIdSn());
                session.update(serialnumber);
                session.getTransaction().commit();

                break;
            case "Membre":
                Membre membre = (Membre) session.get(Membre.class, Integer.parseInt(id));
                Membre membre1 = (Membre) relation;

                session.save(membre1);
                session.getTransaction().commit();
                session.beginTransaction();
                Membre m = (Membre) Latest("Membre", "idMembre");
                membre.setIsDeleted(m.getIdMembre());
                session.update(membre);
                session.getTransaction().commit();

                break;
            case "ModeReglement":
                ModeReglement modeReglement = (ModeReglement) session.get(ModeReglement.class, Integer.parseInt(id));
                ModeReglement modeReglement1 = (ModeReglement) relation;

                session.save(modeReglement1);
                session.getTransaction().commit();
                session.beginTransaction();
                ModeReglement mr = (ModeReglement) Latest("ModeReglement", "idModeR");
                modeReglement.setIsDeleted(mr.getIdModeR());
                session.update(modeReglement);
                session.getTransaction().commit();

                break;
            case "ModeLivraison":
                ModeLivraison modeLivraison = (ModeLivraison) session.get(ModeLivraison.class, Integer.parseInt(id));
                ModeLivraison modeLivraison1 = (ModeLivraison) relation;

                session.save(modeLivraison1);
                session.getTransaction().commit();
                session.beginTransaction();
                ModeLivraison ml = (ModeLivraison) Latest("ModeLivraison", "idModeL");
                modeLivraison.setIsDeleted(ml.getIdModeL());
                session.update(modeLivraison);
                session.getTransaction().commit();

                break;
            case "Nature":
                Nature nature = (Nature) session.get(Nature.class, Integer.parseInt(id));
                Nature nature1 = (Nature) relation;

                session.save(nature1);
                session.getTransaction().commit();
                session.beginTransaction();
                Nature n = (Nature) Latest("Nature", "idNature");
                nature.setIsDeleted(n.getIdNature());
                session.update(nature);
                session.getTransaction().commit();

                break;
            case "Notification":
                Notification notification = (Notification) session.get(Notification.class, Integer.parseInt(id));
                Notification notification1 = (Notification) relation;

                session.save(notification1);
                session.getTransaction().commit();
                session.beginTransaction();
                Notification nt = (Notification) Latest("Notification", "idNotification");
                notification.setIsDeleted(nt.getIdNotification());
                session.update(notification);
                session.getTransaction().commit();

                break;
            case "Objet":
                Objet objet = (Objet) session.get(Objet.class, Integer.parseInt(id));
                Objet objet1 = (Objet) relation;

                session.save(objet1);
                session.getTransaction().commit();
                session.beginTransaction();
                Objet o = (Objet) Latest("Objet", "idObjet");
                objet.setIsDeleted(o.getIdObjet());
                session.update(objet);
                session.getTransaction().commit();

                break;
            case "Produit":
                Produit produit = (Produit) session.get(Produit.class, Integer.parseInt(id));
                Produit produit1 = (Produit) relation;

                session.save(produit1);
                session.getTransaction().commit();
                session.beginTransaction();
                Produit pr = (Produit) Latest("Produit", "idProduit");
                produit.setIsDeleted(pr.getIdProduit());
                session.update(produit);
                session.getTransaction().commit();

                break;
            case "DocAttach":
                DocAttach docAttach = (DocAttach) session.get(DocAttach.class, Integer.parseInt(id));
                DocAttach docAttach1 = (DocAttach) relation;

                session.save(docAttach1);
                session.getTransaction().commit();
                session.beginTransaction();
                DocAttach da = (DocAttach) Latest("DocAttach", "idAttach");
                docAttach.setIsDeleted(da.getIdAttach());
                session.update(docAttach);
                session.getTransaction().commit();

                break;
            case "DocNotif":
                DocNotif docNotif = (DocNotif) session.get(DocNotif.class, Integer.parseInt(id));
                DocNotif docNotif1 = (DocNotif) relation;

                session.save(docNotif1);
                session.getTransaction().commit();
                session.beginTransaction();
                DocNotif dn = (DocNotif) Latest("DocNotif", "idDocNotif");
                docNotif.setIsDeleted(dn.getIdDocNotif());
                session.update(docNotif);
                session.getTransaction().commit();

                break;
            case "DocObjet":
                DocObjet docObject = (DocObjet) session.get(DocObjet.class, Integer.parseInt(id));
                DocObjet docObject1 = (DocObjet) relation;

                session.save(docObject1);
                session.getTransaction().commit();
                session.beginTransaction();
                DocObjet dob = (DocObjet) Latest("DocObject", "idDocObjet");
                docObject.setIsDeleted(dob.getIdDocObjet());
                session.update(docObject);
                session.getTransaction().commit();

                break;
            case "Destinateur":
                Destinateur destinateur = (Destinateur) session.get(Destinateur.class, Integer.parseInt(id));
                Destinateur destinateur1 = (Destinateur) relation;

                session.save(destinateur1);
                session.getTransaction().commit();
                session.beginTransaction();
                Destinateur f = (Destinateur) Latest("Destinateur", "idDestinateur");
                destinateur.setIsDeleted(f.getIdDestinateur());
                session.update(destinateur);
                session.getTransaction().commit();

                break;

            case "Utilisateur":

                Utilisateur utilisateur = (Utilisateur) session.get(Utilisateur.class, Integer.parseInt(id));
                Utilisateur utilisateur1 = (Utilisateur) relation;

                session.save(utilisateur1);
                session.getTransaction().commit();
                session.beginTransaction();
                Utilisateur u = (Utilisateur) Latest("Utilisateur", "idUtilisateur");
                utilisateur.setIsDeleted(u.getIdUtilisateur());
                session.update(utilisateur);
                session.getTransaction().commit();

                break;

            case "Attachment":
                Attachment attachment = (Attachment) session.get(Attachment.class, Integer.parseInt(id));
                Attachment attachment1 = (Attachment) relation;

                session.save(attachment1);
                session.getTransaction().commit();
                session.beginTransaction();
                Attachment a = (Attachment) Latest("Attachment", "idAttach");
                attachment.setIsDeleted(a.getIdAttach());
                session.update(attachment);
                session.getTransaction().commit();

                break;
            case "StructureDetails":
                StructureDetails structureDetails = (StructureDetails) session.get(StructureDetails.class, Integer.parseInt(id));
                StructureDetails structureDetails1 = (StructureDetails) relation;

                session.save(structureDetails1);
                session.getTransaction().commit();
                session.beginTransaction();
                StructureDetails sd = (StructureDetails) Latest("StructureDetails", "idStructureDetais");
                structureDetails.setIsDeleted(sd.getIdStructureDetais());
                session.update(structureDetails);
                session.getTransaction().commit();

                break;
            case "TypeAttachment":
                TypeAttachment typeAttachment = (TypeAttachment) session.get(TypeAttachment.class, Integer.parseInt(id));
                TypeAttachment typeAttachment1 = (TypeAttachment) relation;

                session.save(typeAttachment1);
                session.getTransaction().commit();
                session.beginTransaction();
                TypeAttachment ta = (TypeAttachment) Latest("TypeAttachment", "idTypeAttachment");
                typeAttachment.setIsDeleted(ta.getIdTypeAttachment());
                session.update(typeAttachment);
                session.getTransaction().commit();

            case "Contact":
                Contact contact = (Contact) session.get(Contact.class, Integer.parseInt(id));
                Contact contact1 = (Contact) relation;

                session.save(contact1);
                session.getTransaction().commit();
                session.beginTransaction();
                Contact cn = (Contact) Latest("Contact", "idContact");
                contact.setIsDeleted(cn.getIdContact());
                session.update(contact);
                session.getTransaction().commit();

                break;
            case "Cv":
                Cv cv = (Cv) session.get(Cv.class, Integer.parseInt(id));
                Cv cv1 = (Cv) relation;

                session.save(cv1);
                session.getTransaction().commit();
                session.beginTransaction();
                Cv cvv = (Cv) Latest("Cv", "idCv");
                cv.setIsDeleted(cvv.getIdCv());
                session.update(cv);
                session.getTransaction().commit();

                break;
            case "DesignationNature":
                DesignationNature designationNature = (DesignationNature) session.get(DesignationNature.class, Integer.parseInt(id));
                DesignationNature designationNature1 = (DesignationNature) relation;

                session.save(designationNature1);
                session.getTransaction().commit();
                session.beginTransaction();
                DesignationNature den = (DesignationNature) Latest("DesignationNature", "idDes");
                designationNature.setIsDeleted(den.getIdDes());
                session.update(designationNature);
                session.getTransaction().commit();

                break;

            case "DocObjetSn":
                DocObjetSn docObjetSn = (DocObjetSn) session.get(DocObjetSn.class, Integer.parseInt(id));
                DocObjetSn docObjetSn1 = (DocObjetSn) relation;
                session.save(docObjetSn1);
                session.getTransaction().commit();
                session.beginTransaction();
                DocObjetSn dos = (DocObjetSn) Latest("DocObjetSn", "idDocObjetSn");
                docObjetSn.setIsDeleted(dos.getIdDocObjetSn());
                session.update(docObjetSn);
                session.getTransaction().commit();
                break;

        }

        //session.save(relation);
        //session.getTransaction().commit();
        session.close();
        return true;
    }

    public static boolean DeleteLine(String id, String table) {
        Object relation = null;
        Session session = null;
        HibernateUtil hb = new HibernateUtil();
        session = hb.getSessionFactory().openSession();
        session.beginTransaction();
        Query query = null;
        List al = null;

        switch (table) {

            //Structure-Utilisateur/Membre
            //Attachment-Client-Contact-
            //Cv-DesignationNature-DocAttach-DocNotif-DocObject
            //Fournisseur-ModeReglement-Nature-Notification-Objet-Produit-Projet-Doctype-Document
            //ProjetMembre-Serialnmber-TemplateDocument-Trace-TypeNature-VarObject
            case "StructureDetails":
                StructureDetails structureDetails = (StructureDetails) session.get(StructureDetails.class, Integer.parseInt(id));
                structureDetails.setIsDeleted(-1);
                relation = structureDetails;
                break;
            case "TemplateDocument":
                TemplateDocument templateDocument = (TemplateDocument) session.get(TemplateDocument.class, Integer.parseInt(id));
                templateDocument.setIsDeleted(-1);
                relation = templateDocument;
                break;
            case "TypeNature":
                TypeNature typeNature = (TypeNature) session.get(TypeNature.class, Integer.parseInt(id));
                typeNature.setIsDeleted(-1);
                relation = typeNature;
                break;
            case "VarObject":
                VarObjet varObject = (VarObjet) session.get(VarObjet.class, Integer.parseInt(id));
                varObject.setIsDeleted(-1);
                relation = varObject;
                break;
            case "Projet":
                Projet projet = (Projet) session.get(Projet.class, Integer.parseInt(id));
                projet.setIsDeleted(-1);
                relation = projet;
                break;
            case "Doctype":
                Doctype doctype = (Doctype) session.get(Doctype.class, Integer.parseInt(id));
                doctype.setIsDeleted(-1);
                relation = doctype;
                break;
            case "Document":
                Document document = (Document) session.get(Document.class, Integer.parseInt(id));
                document.setIsDeleted(-1);
                relation = document;
                break;
            case "ProjetMembre":
                ProjetMembre projetMembre = (ProjetMembre) session.get(ProjetMembre.class, Integer.parseInt(id));
                projetMembre.setIsDeleted(-1);
                relation = projetMembre;
                break;
            case "Serialnmber":
                Serialnumber serialnumber = (Serialnumber) session.get(Serialnumber.class, Integer.parseInt(id));
                serialnumber.setIsDeleted(-1);
                relation = serialnumber;
                break;
            case "Membre":
                Membre membre = (Membre) session.get(Membre.class, Integer.parseInt(id));
                membre.setIsDeleted(-1);
                relation = membre;
                break;
            case "ModeReglement":
                ModeReglement modeReglement = (ModeReglement) session.get(ModeReglement.class, Integer.parseInt(id));
                modeReglement.setIsDeleted(-1);
                relation = modeReglement;
                break;
            case "ModeLivraison":
                ModeLivraison modeLivraison = (ModeLivraison) session.get(ModeLivraison.class, Integer.parseInt(id));
                modeLivraison.setIsDeleted(-1);
                relation = modeLivraison;
                break;
            case "Nature":
                Nature nature = (Nature) session.get(Nature.class, Integer.parseInt(id));
                nature.setIsDeleted(-1);
                relation = nature;
                break;
            case "Notification":
                Notification notification = (Notification) session.get(Notification.class, Integer.parseInt(id));
                notification.setIsDeleted(-1);
                relation = notification;
                break;
            case "Objet":
                Objet objet = (Objet) session.get(Objet.class, Integer.parseInt(id));
                objet.setIsDeleted(-1);
                relation = objet;
                break;
            case "Produit":
                Produit produit = (Produit) session.get(Produit.class, Integer.parseInt(id));
                produit.setIsDeleted(-1);
                relation = produit;
                break;
            case "DocAttach":
                DocAttach docAttach = (DocAttach) session.get(DocAttach.class, Integer.parseInt(id));
                docAttach.setIsDeleted(-1);
                relation = docAttach;
                break;
            case "DocNotif":
                DocNotif docNotif = (DocNotif) session.get(DocNotif.class, Integer.parseInt(id));
                docNotif.setIsDeleted(-1);
                relation = docNotif;
                break;
            case "DocObject":
                DocObjet docObject = (DocObjet) session.get(DocObjet.class, Integer.parseInt(id));
                docObject.setIsDeleted(-1);
                relation = docObject;
                break;
            case "Destinateur":
                Destinateur destinateur = (Destinateur) session.get(Destinateur.class, Integer.parseInt(id));
                destinateur.setIsDeleted(-1);
                relation = destinateur;
                break;
            case "Structure":
                Structure structure = (Structure) session.get(Structure.class, Integer.parseInt(id));
                structure.setIsDeleted(-1);
                relation = structure;
                break;
            case "Utilisateur":
                Utilisateur utilisateur = (Utilisateur) session.get(Utilisateur.class, Integer.parseInt(id));
                utilisateur.setIsDeleted(-1);
                relation = utilisateur;
                break;
            case "Attachment":
                Attachment attachment = (Attachment) session.get(Attachment.class, Integer.parseInt(id));
                attachment.setIsDeleted(-1);
                relation = attachment;
                break;
            case "TypeAttachment":
                TypeAttachment typeAttachment = (TypeAttachment) session.get(TypeAttachment.class, Integer.parseInt(id));
                typeAttachment.setIsDeleted(-1);
                relation = typeAttachment;
            case "Contact":
                Contact contact = (Contact) session.get(Contact.class, Integer.parseInt(id));
                contact.setIsDeleted(-1);
                relation = contact;
                break;
            case "Cv":
                Cv cv = (Cv) session.get(Cv.class, Integer.parseInt(id));
                cv.setIsDeleted(-1);
                relation = cv;
                break;
            case "DesignationNature":
                DesignationNature designationNature = (DesignationNature) session.get(DesignationNature.class, Integer.parseInt(id));
                designationNature.setIsDeleted(-1);
                relation = designationNature;
                break;
            case "DocObjetSn":
                DocObjetSn docObjetSn = (DocObjetSn) session.get(DocObjetSn.class, Integer.parseInt(id));
                docObjetSn.setIsDeleted(-1);
                relation = docObjetSn;
                break;
        }

        session.update(relation);
        session.getTransaction().commit();
        session.close();
        return true;
    }

    public static boolean isFound(String table, String where) {

        Session session = null;
        HibernateUtil hb = new HibernateUtil();
        session = hb.getSessionFactory().openSession();
        session.beginTransaction();
        Query query = session.createQuery("from " + table + " " + where);

        List list = query.list();

        session.close();
        if (list.size() == 0) {
            return false;
        }

        //Structure s = new Structure(5, "aaaa", "a", 0);
        return true;

    }

    public static int getCount(String table, String where) {
        Session session = null;
        HibernateUtil hb = new HibernateUtil();
        session = hb.getSessionFactory().openSession();
        session.beginTransaction();
        Query query = session.createQuery("from " + table + " " + where);

        List list = query.list();

        session.close();

        //Structure s = new Structure(5, "aaaa", "a", 0);
        return list.size();
    }

    public static void main(String[] args) {
        //System.out.println(Testexist("Doctype", "and", "Integer%%String%%String", "idDoctype%%nomDocument%%abbrev","2%%Bon de commande%%BC"));
        /*Session session = null;
        HibernateUtil hb = new HibernateUtil();
        session = hb.getSessionFactory().openSession();
        session.beginTransaction();
        Query query = session.createQuery("from Utilisateur");

        List list = query.list();
        System.out.println(list.size());
        session.close();*/
        
    }

    /*
    public static void main(String[] args) {
        ModelBean mb = new ModelBean();
        //Structure s2 = new Structure(1, "amar", "amar2", 0);
        
        //System.out.println(mb.isFound("", ""));
        System.out.println(((List<TemplateDocument>)mb.GetContentTable("TemplateDocument", "where idTemplate=1")).get(0).getNomTemplate());
        /* System.out.println(((Structure) mb.Latest("Structure", "idStructure")).getIdStructure() + 1);
        ArrayList<String> items = new ArrayList<>();
        items.add("5");
        items.add("aaaa");
        items.add("a");

        System.out.println(mb.AddLine(items, "Structure", "where (idStructure=" + items.get(0) + " or nomStructure='" + items.get(1) + "' or code='" + items.get(2) + "') and isDeleted=0"));
     */
 /*Structure s = new Structure(1, "admar", "amdar2", 0);
        Structure s2 = new Structure(1, "amar", "amar2", 0);
        System.out.println(mb.UpdateLine(s2, "Structure","9"));
        //System.out.println(s.getCode().equals(s2.getCode()));
    }*/
}
