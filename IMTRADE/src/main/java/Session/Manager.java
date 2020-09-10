/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Session;

import Classes.Model;
import com.google.gson.Gson;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import maps.DesignationNature;
import maps.Destinateur;
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
import maps.ObjetType;
import maps.Produit;
import maps.Projet;
import maps.ProjetMembre;
import maps.Serialnumber;
import maps.Structure;
import maps.Trace;
import maps.TypeAttachment;
import maps.TypeNature;
import maps.Utilisateur;
import module.ModelBean;

/**
 *
 * @author MARWA
 */
@MultipartConfig
public class Manager extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManagementProducts</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagementProducts at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String table = request.getParameter("table");
        switch (table) {
            case "Produit":
                String type = request.getParameter("type");

                if (type.equals("afficheTable")) {

                    request.setAttribute("tablemanage", table);
                    request.getServletContext().getRequestDispatcher("/Account/Model/tablemodal.jsp").forward(request, response);

                }
                if (type.equals("detailProduit")) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    request.setAttribute("id", id);
                    Produit produit = (Produit) ModelBean.GetContentTable("Produit", "WHERE id_produit=" + id).get(0);

                    Objet objet = (Objet) ModelBean.GetContentTable("Objet", "WHERE id_objet=" + produit.getIdObjet()).get(0);
                    request.setAttribute("produit", produit);
                    request.setAttribute("objet", objet);
                    List<Serialnumber> listserial = ModelBean.GetContentTable("Serialnumber", "WHERE isDeleted=" + 0);
                    List<Serialnumber> listSerialObject = new ArrayList<>();

                    List<DocObjetSn> listDocSn = new ArrayList<>();

                    List<Objet> listObjet = new ArrayList<>();
                    listObjet.add(objet);
                    while (ModelBean.isFound("Objet", "WHERE isDeleted=" + objet.getIdObjet())) {
                        objet = (Objet) ModelBean.GetContentTable("Objet", "WHERE isDeleted=" + objet.getIdObjet()).get(0);
                        listObjet.add(objet);

                    }

                    for (int i = 0; i < listserial.size(); i++) {
                        int repetition = 0;
                        listDocSn = ModelBean.GetContentTable("DocObjetSn", "WHERE id_sn=" + listserial.get(i).getIdSn() + " AND isDeleted=" + 0);
                        for (int j = 0; j < listDocSn.size(); j++) {
                            DocObjet docobjet = (DocObjet) ModelBean.GetContentTable(" DocObjet", "WHERE id_doc_objet=" + listDocSn.get(j).getIdDocObjet() + " AND isDeleted=" + 0).get(0);
                            for (int k = 0; k < listObjet.size(); k++) {
                                if (repetition == 0 && listObjet.get(k).getIdObjet() == docobjet.getIdObject()) {
                                    repetition++;
                                    listSerialObject.add(listserial.get(i));

                                }

                            }

                        }

                    }
                    request.setAttribute("serial", listSerialObject);
                    request.getServletContext().getRequestDispatcher("/Account/Model/DetailProduit.jsp").forward(request, response);

                }
                if (type.equals("cardProduit")) {
                    request.setCharacterEncoding("UTF-8");

                    List<Produit> l = new ArrayList<>();

                    String condition = new String(request.getParameter("cond").getBytes("iso-8859-1"), "UTF-8");
                    if (condition.equals("marque")) {

                        String var = new String(request.getParameter("var").getBytes("iso-8859-1"), "UTF-8");
                        l = ModelBean.GetContentTable("Produit", "WHERE marque='" + var + "'AND isDeleted=" + 0);

                    }
                    if (condition.equals("structure")) {

                        int id = Integer.parseInt(request.getParameter("var"));

                        Structure s = (Structure) ModelBean.GetContentTable("Structure", "WHERE id_structure=" + id + "AND isDeleted=" + 0).get(0);
                        List<Objet> l1 = new ArrayList<>();
                        Produit p2;
                        List<Objet> list_objet = ModelBean.GetContentTable("Objet", "WHERE isDeleted=" + 0);
                        for (int j = 0; j < list_objet.size(); j++) {
                            if (Objects.equals(list_objet.get(j).getIdStructure(), s.getIdStructure())) {
                                l1.add(list_objet.get(j));
                            }
                        }

                        for (int i = 0; i < l1.size(); i++) {
                            p2 = (Produit) ModelBean.GetContentTable("Produit", "WHERE id_objet=" + l1.get(i).getIdObjet()).get(0);
                            l.add(p2);

                        }

                    }
                    if (condition.equals("type")) {

                        String var = new String(request.getParameter("var").getBytes("iso-8859-1"), "UTF-8");
                        l = ModelBean.GetContentTable("Produit", "WHERE type_produit='" + var + "'AND isDeleted=" + 0);

                    }
                    if (condition.equals("all")) {

                        l = ModelBean.GetContentTable("Produit", "WHERE isDeleted=" + 0);

                    }

                    request.setAttribute("produit", l);
                    request.getServletContext().getRequestDispatcher("/Account/Model/CardProduct.jsp").forward(request, response);

                }
                break;
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String table = request.getParameter("table");
        String type = "";

        String result = "suc";
        switch (table) {
            case "Produit":
                type = request.getParameter("type");
                if (type.equals("AddProduit")) {

                    //objetSessionBean.addObjet();
//var variable = ["Name", "Designation", "Matricule", "Type", "Marque", "Modele", "Prix", "Structure", "Image"];
//produitSessionBean.addProduit(listObjet.get(listObjet.size()-1).getIdObjet());*/
                    request.setCharacterEncoding("UTF-8");

                    String name = new String(request.getParameter("Nom").getBytes("iso-8859-1"), "UTF-8");

                    String des = new String(request.getParameter("Designation").getBytes("iso-8859-1"), "UTF-8");

                    String matr = new String(request.getParameter("Matricule").getBytes("iso-8859-1"), "UTF-8");

                    String typeobjet = new String(request.getParameter("Type").getBytes("iso-8859-1"), "UTF-8");
                    String typeproduit = new String(request.getParameter("ProduitDe").getBytes("iso-8859-1"), "UTF-8");

                    String marque = new String(request.getParameter("Marque").getBytes("iso-8859-1"), "UTF-8");

                    String modele = new String(request.getParameter("Modele").getBytes("iso-8859-1"), "UTF-8");

                    String str = new String(request.getParameter("Structure").getBytes("iso-8859-1"), "UTF-8");

                    Double prix = Double.parseDouble(request.getParameter("Prix-unitaire"));
                    List<Produit> List_Produit = ModelBean.GetContentTable("Produit", "");

                    for (int i = 0; i < List_Produit.size(); i++) {

                        if (List_Produit.get(i).getNomProduit().equals(name)) {
                            result = "Cette Nom Utilisé Deja";
                        }

                        if (List_Produit.get(i).getDesignation().equals(des)) {
                            result = "Cette Designation Utilisé Deja";
                        }

                        if (List_Produit.get(i).getMatricule().equals(matr)) {
                            result = "Cette Matricule existe Deja";
                        }

                    }

                    response.setContentType("text/html;charset=UTF-8");
                    String fileName = null;
                    String appPath = request.getServletContext().getRealPath("");
                    String savePath = appPath + "\\webfiles\\images";
                    File fileDir = new File(savePath);
                    if (!fileDir.exists()) {
                        fileDir.mkdirs();
                    }
                    // name1=request.getPart("name");
                    int idtype_objet = 0;
                    Part part = request.getPart("file");
                    fileName = extractFileName(part);
                    InputStream is = part.getInputStream();
                    File f = new File(savePath + File.separator + fileName);
                    copyInputStreamToFile(is, f);
                    if (result.equals("suc")) {

                        List<Structure> s = ModelBean.GetContentTable("Structure", "WHERE nom_structure='" + str + "'");
                        if (ModelBean.isFound("ObjetType", "WHERE nom_objet_type='" + typeobjet + "'")) {
                            ObjetType type_objet = (ObjetType) ModelBean.GetContentTable("ObjetType", "WHERE nom_objet_type='" + typeobjet + "'").get(0);
                            idtype_objet = type_objet.getIdObjetType();
                        } else {
                            ObjetType nobj = new ObjetType(typeobjet, 0);
                            ModelBean.AddLine1(nobj, "ObjetType");
                            List<ObjetType> l = ModelBean.GetContentTable("ObjetType", "");
                            idtype_objet = l.get(l.size() - 1).getIdObjetType();

                        }

                        Objet obj = new Objet(idtype_objet, name, 0, s.get(0).getIdStructure(), 0, 0, 0, 0, 0);
                        ModelBean.AddLine1(obj, "Objet");
                        List<Objet> listObjet = ModelBean.GetContentTable("Objet", "");
                        // public Produit(int idObjet, String matricule, String typeProduit, String marque, String modele, String designation, String nomProduit, String unite, double quantite, double utilise, double prix, String image, int isDeleted)
                        Produit p = new Produit(listObjet.get(listObjet.size() - 1).getIdObjet(), matr, typeproduit, marque, modele, des, name, "/", 0, 0, prix, savePath + File.separator + fileName, 0);
                        ModelBean.AddLine1(p, "Produit");
                         
                            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"ajoute"+" "+table+" "+"N:"+p.getIdProduit());
                        ModelBean.AddLine1(trace,"Trace");
                        
                        
                        
                        
                    }
                    response.getWriter().print(result);
                    return;
                    // produitSessionBean.addProduit(listObjet.get(listObjet.size()-1).getIdObjet(), matr, type, marque, modele, des,name,savePath+File.separator+fileName);}

                }

                if (type.equals("GetLastIdProduit")) {
                    response.setContentType("application/json");
                    int last_id = 1;
                    List<Produit> List_Produit = ModelBean.GetContentTable("Produit", "");
                    if (List_Produit.isEmpty()) {

                        new Gson().toJson(String.valueOf(last_id), response.getWriter());

                    } else {

                        new Gson().toJson(String.valueOf(List_Produit.get(List_Produit.size() - 1).getIdProduit()), response.getWriter());

                    }
                }
                if (type.equals("listSerial")) {
                    response.setContentType("application/json");
                    int serial = Integer.parseInt(request.getParameter("serial"));
                    List<Serialnumber> List_Serial = ModelBean.GetContentTable("Serialnumber", "where id_sn=" + serial + "AND isDeleted<>-1");
                    Serialnumber serialnumber = List_Serial.get(0);
                    while (ModelBean.isFound("Serialnumber", "WHERE isDeleted=" + serialnumber.getIdSn())) {
                        serialnumber = (Serialnumber) ModelBean.GetContentTable("Serialnumber", "where isDeleted=" + serialnumber.getIdSn()).get(0);
                        List_Serial.add(serialnumber);

                    }
                    new Gson().toJson(List_Serial, response.getWriter());

                }
                if (type.equals("Serial")) {
                    response.setContentType("application/json");
                    int serial = Integer.parseInt(request.getParameter("serial"));
                    List<Serialnumber> List_Serial = ModelBean.GetContentTable("Serialnumber", "where id_sn=" + serial);

                    new Gson().toJson(List_Serial, response.getWriter());

                }
                if (type.equals("typedocument")) {
                    response.setContentType("application/json");
                    int serial = Integer.parseInt(request.getParameter("serial"));
                    List<DocObjetSn> List_DocObjetSn = ModelBean.GetContentTable("DocObjetSn", "where id_sn=" + serial);
                    DocObjet docobjet = (DocObjet) ModelBean.GetContentTable("DocObjet", "where id_doc_objet=" + List_DocObjetSn.get(0).getIdDocObjet()).get(0);
                    Document document = (Document) ModelBean.GetContentTable("Document", "where id_document=" + docobjet.getIdDocument()).get(0);
                    Doctype doctype = (Doctype) ModelBean.GetContentTable("Doctype", "where id_doctype=" + document.getIdType()).get(0);
                    new Gson().toJson(doctype.getNomDocument(), response.getWriter());

                }
                if (type.equals("getDistinateur")) {
                    response.setContentType("application/json");
                    int serial = Integer.parseInt(request.getParameter("serial"));
                    List<DocObjetSn> List_DocObjetSn = ModelBean.GetContentTable("DocObjetSn", "where id_sn=" + serial);
                    DocObjet docobjet = (DocObjet) ModelBean.GetContentTable("DocObjet", "where id_doc_objet=" + List_DocObjetSn.get(0).getIdDocObjet()).get(0);
                    Document document = (Document) ModelBean.GetContentTable("Document", "where id_document=" + docobjet.getIdDocument()).get(0);
                    Doctype doctype = (Doctype) ModelBean.GetContentTable("Doctype", "where id_doctype=" + document.getIdType()).get(0);
                    Destinateur destinateur = (Destinateur) ModelBean.GetContentTable("Destinateur", "where id_destinateur=" + document.getIdDestinataire()).get(0);
                    new Gson().toJson(destinateur, response.getWriter());

                }
                if (type.equals("getProjet")) {
                    response.setContentType("application/json");
                    int serial = Integer.parseInt(request.getParameter("serial"));
                    List<DocObjetSn> List_DocObjetSn = ModelBean.GetContentTable("DocObjetSn", "where id_sn=" + serial);
                    DocObjet docobjet = (DocObjet) ModelBean.GetContentTable("DocObjet", "where id_doc_objet=" + List_DocObjetSn.get(0).getIdDocObjet()).get(0);
                    Document document = (Document) ModelBean.GetContentTable("Document", "where id_document=" + docobjet.getIdDocument()).get(0);
                    Doctype doctype = (Doctype) ModelBean.GetContentTable("Doctype", "where id_doctype=" + document.getIdType()).get(0);
                    Projet projet = (Projet) ModelBean.GetContentTable("Projet", "where id_projet=" + document.getIdProjet()).get(0);
                    new Gson().toJson(projet, response.getWriter());

                }
                if (type.equals("getNature")) {
                    response.setContentType("application/json");
                    int serial = Integer.parseInt(request.getParameter("serial"));
                    List<DocObjetSn> List_DocObjetSn = ModelBean.GetContentTable("DocObjetSn", "where id_sn=" + serial);
                    DocObjet docobjet = (DocObjet) ModelBean.GetContentTable("DocObjet", "where id_doc_objet=" + List_DocObjetSn.get(0).getIdDocObjet()).get(0);
                    Document document = (Document) ModelBean.GetContentTable("Document", "where id_document=" + docobjet.getIdDocument()).get(0);
                    Doctype doctype = (Doctype) ModelBean.GetContentTable("Doctype", "where id_doctype=" + document.getIdType()).get(0);
                    Nature nature = (Nature) ModelBean.GetContentTable("Nature", "where id_nature=" + document.getIdNature()).get(0);
                    new Gson().toJson(nature, response.getWriter());

                }
                if (type.equals("getMembre")) {
                    response.setContentType("application/json");
                    int idprojet = Integer.parseInt(request.getParameter("idprojet"));
                    List<ProjetMembre> List_ProjetMembre = ModelBean.GetContentTable("ProjetMembre", "where id_projet=" + idprojet);
                    List<Membre> List_Membre = new ArrayList<>();
                    for (int j = 0; j < List_ProjetMembre.size(); j++) {
                        List_Membre.add((Membre) ModelBean.GetContentTable("Membre", "where id_membre=" + List_ProjetMembre.get(j).getIdPersonne()).get(0));
                    }

                    new Gson().toJson(List_Membre, response.getWriter());

                }

                if (type.equals("updateImage")) {
                    String id = request.getParameter("id");
                    //File img=(File) request.getPart("img");
                    response.setContentType("text/html;charset=UTF-8");
                    String fileName = null;

                    String appPath = request.getServletContext().getRealPath("");

                    String savePath = appPath + "\\webfiles\\images";
                    File fileDir = new File(savePath);
                    if (!fileDir.exists()) {
                        fileDir.mkdirs();
                    }

                    //String savePath = "C:\\xampp\\htdocs\\img";
                    // name1=request.getPart("name");
                    Part part = request.getPart("file");
                    fileName = extractFileName(part);
                    InputStream is = part.getInputStream();
                    File f = new File(savePath + File.separator + fileName);
                    copyInputStreamToFile(is, f);
                    Produit produit = (Produit) ModelBean.GetContentTable("Produit", "WHERE id_produit=" + Integer.parseInt(id)).get(0);
                    Objet objet = (Objet) ModelBean.GetContentTable("Objet", "WHERE id_objet=" + produit.getIdObjet()).get(0);
                    ModelBean.UpdateLine(objet, "Objet", String.valueOf(objet.getIdObjet()));

                    List<Objet> listobjet = ModelBean.GetContentTable("Objet", "");
                    produit.setImage(savePath + File.separator + fileName);
                    produit.setIdObjet(listobjet.get(listobjet.size() - 1).getIdObjet());
                    ModelBean.UpdateLine(produit, "Produit", String.valueOf(produit.getIdProduit()));
                    response.getWriter().print(savePath + File.separator + fileName);
                    return;

                }
                if (type.equals("deleteProduit")) {

                    int id = Integer.parseInt(request.getParameter("id"));
                    Produit produit = (Produit) ModelBean.GetContentTable("Produit", "WHERE id_produit=" + id).get(0);
                    int id_objet = produit.getIdObjet();
                    ModelBean.DeleteLine(String.valueOf(id), "Produit");
                    ModelBean.DeleteLine(String.valueOf(id_objet), "Objet");
                      DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"supprime "+" "+table+" "+"N:"+produit.getIdProduit());
                        ModelBean.AddLine1(trace,"Trace");

                }
                if (type.equals("detailproduit")) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    request.setAttribute("id", id);
                    Produit produit = (Produit) ModelBean.GetContentTable("Produit", "WHERE id_produit=" + id).get(0);

                    Objet objet = (Objet) ModelBean.GetContentTable("Objet", "WHERE id_objet=" + produit.getIdObjet()).get(0);
                    request.setAttribute("produit", produit);
                    request.setAttribute("objet", objet);

                    List<Serialnumber> listserial = ModelBean.GetContentTable("Serialnumber", "WHERE id_objet=" + produit.getIdObjet());
                    List<Serialnumber> listserial1 = new ArrayList<>();
                    /* if(objet.getIsDeleted()!=0&&objet.getIsDeleted()!=-1){
         for(int i=0;i<listserial.size();i++){
             if(listserial.get(i).getIsDeleted()==0)
                 listserial1.add(listserial.get(i));
             if(listserial.get(i).getIsDeleted()!=0&&listserial.get(i).getIsDeleted()!=-1)
                 listserial1.add((Serialnumber) ModelBean.GetContentTable("Serialnumber", "WHERE id_sn="+listserial.get(i).getIsDeleted()).get(0));
             
         }
         }*/
                    //if(objet.getIsDeleted()==0){
                    for (int i = 0; i < listserial.size(); i++) {
                        if (listserial.get(i).getIsDeleted() == 0) {
                            listserial1.add(listserial.get(i));
                        }
                        //if(listserial.get(i).getIsDeleted()!=0&&listserial.get(i).getIsDeleted()!=-1)
                        //listserial1.add((Serialnumber) ModelBean.GetContentTable("Serialnumber", "WHERE id_sn="+listserial.get(i).getIsDeleted()).get(0));

                    }
                    while (ModelBean.isFound("Objet", "WHERE isDeleted=" + objet.getIdObjet())) {
                        objet = (Objet) ModelBean.GetContentTable("Objet", "WHERE isDeleted=" + objet.getIdObjet()).get(0);
                        listserial = ModelBean.GetContentTable("Serialnumber", "WHERE id_objet=" + objet.getIdObjet());
                        for (int i = 0; i < listserial.size(); i++) {
                            if (listserial.get(i).getIsDeleted() == 0) {
                                listserial1.add(listserial.get(i));
                            }
                            //if(listserial.get(i).getIsDeleted()!=0&&listserial.get(i).getIsDeleted()!=-1)
                            // listserial1.add((Serialnumber) ModelBean.GetContentTable("Serialnumber", "WHERE id_sn="+listserial.get(i).getIsDeleted()).get(0));

                        }
                    }

                    // }
                    request.setAttribute("serial", listserial1);
                    request.setAttribute("serialall", ModelBean.GetContentTable("Serialnumber", "WHERE id_objet=" + produit.getIdObjet()));
                    request.setAttribute("projet", ModelBean.GetContentTable("Projet", ""));

                    /* request.setAttribute("list",produitSessionBean.findAll());
        request.setAttribute("listObjet",objetSessionBean.findAll());
       
       request.setAttribute("listtypeObjet",objet_TypeSessionBean.findAll());
        request.setAttribute("Structure",structureSessionBean.findAll());*/
                    request.getServletContext().getRequestDispatcher("/Account/Model/DetailProduit.jsp").forward(request, response);

                }
                if (type.equals("editProduit")) {

                    int id = Integer.parseInt(request.getParameter("id"));
                   
                    String desi = new String(request.getParameter("Designation").getBytes("iso-8859-1"), "UTF-8");

                    String matr = new String(request.getParameter("Matricule").getBytes("iso-8859-1"), "UTF-8");

                 

                    String marque = new String(request.getParameter("Marque").getBytes("iso-8859-1"), "UTF-8");

                    String modele = new String(request.getParameter("Modele").getBytes("iso-8859-1"), "UTF-8");

                    String str = new String(request.getParameter("Structure").getBytes("iso-8859-1"), "UTF-8");

                    Double unite = Double.parseDouble(request.getParameter("Prix-unitaire"));

                    int idtype_objet = 0;
                    Produit produit = (Produit) ModelBean.GetContentTable("Produit", "WHERE id_produit=" + id).get(0);
                    if (produit.getIsDeleted() != 0) {
                        while (produit.getIsDeleted() != 0) {
                            produit = (Produit) ModelBean.GetContentTable("Produit", "WHERE id_produit=" + produit.getIsDeleted()).get(0);

                        }
                    }

                    List<Produit> List_Produit = ModelBean.GetContentTable("Produit", "WHERE isDeleted=0");

                    for (int i = 0; i < List_Produit.size(); i++) {
                        if (!Objects.equals(List_Produit.get(i).getIdProduit(), produit.getIdProduit()) && List_Produit.get(i).getIsDeleted() == 0) {
                            if (List_Produit.get(i).getMatricule().equals(matr)) {
                                result = "Matricule est utilse Deja";
                            }

                            if (List_Produit.get(i).getDesignation().equals(desi)) {
                                result = "Designation est utilse Deja";
                            }

                         
                        }

                    }
                    if (result.equals("suc")) {
                        List<Structure> s = ModelBean.GetContentTable("Structure", "WHERE nom_structure='" + str + "'");

                        Objet obj = (Objet) ModelBean.GetContentTable("Objet", "WHERE id_objet=" + produit.getIdObjet()).get(0);
                       
                        obj.setTypeObjet(idtype_objet);
                        obj.setIdStructure(s.get(0).getIdStructure());
                        ModelBean.UpdateLine(obj, "Objet", String.valueOf(obj.getIdObjet()));
                        List<Objet> listobjet = ModelBean.GetContentTable("Objet", "");

                        produit.setDesignation(desi);
                        produit.setMarque(marque);
                        produit.setMatricule(matr);
                        produit.setModele(modele);
                        
                        produit.setIdObjet(listobjet.get(listobjet.size() - 1).getIdObjet());
                        
                        produit.setPrix(unite);
                        ModelBean.UpdateLine(produit, "Produit", String.valueOf(produit.getIdProduit()));
                       DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"mise a jour "+" "+table+" "+"N:"+produit.getIdProduit());
                        ModelBean.AddLine1(trace,"Trace");

                    }
                    response.getWriter().print(result);
                    return;

                }
                break;
            case "Projet":
                type = request.getParameter("type");
                if (type.equals("AddProjet")) {

                    String name = new String(request.getParameter("Nom").getBytes("iso-8859-1"), "UTF-8");

                    String name_structure = new String(request.getParameter("Structure").getBytes("iso-8859-1"), "UTF-8");
                    List<Projet> List_Projet = ModelBean.GetContentTable("Projet", "WHERE isDeleted=0");
                    if (ModelBean.isFound("Projet", "WHERE nom_projet='" + name + "' AND isDeleted=0 ")) {
                        result = "Cette est utilsé deja";

                    } else {
                        Structure structure = (Structure) ModelBean.GetContentTable("Structure", "WHERE nom_structure='" + name_structure + "'").get(0);
                        Projet projet = new Projet(structure.getIdStructure(), name, 0);
                        ModelBean.AddLine1(projet, "Projet");
                        
                          DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"ajoute"+" "+table+" "+"N:"+projet.getIdProjet());
                        ModelBean.AddLine1(trace,"Trace");

                    }

                    response.getWriter().print(result);
                    return;
                    // produitSessionBean.addProduit(listObjet.get(listObjet.size()-1).getIdObjet(), matr, type, marque, modele, des,name,savePath+File.separator+fileName);}

                }
                if (type.equals("GetLastIdProjet")) {
                    response.setContentType("application/json");
                    int last_id = 1;
                    List<Projet> List_Projet = ModelBean.GetContentTable("Projet", "");
                    if (List_Projet.isEmpty()) {

                        new Gson().toJson(String.valueOf(last_id), response.getWriter());

                    } else {

                        new Gson().toJson(String.valueOf(List_Projet.get(List_Projet.size() - 1).getIdProjet()), response.getWriter());

                    }
                }
                if (type.equals("editProjet")) {

                    int id = Integer.parseInt(request.getParameter("id"));
                    String name = new String(request.getParameter("Nom").getBytes("iso-8859-1"), "UTF-8");
                    String name_structure = new String(request.getParameter("Structure").getBytes("iso-8859-1"), "UTF-8");
                    List<Projet> List_Projet = ModelBean.GetContentTable("Projet", "WHERE isDeleted=0");

                    for (int i = 0; i < List_Projet.size(); i++) {
                        if (!Objects.equals(List_Projet.get(i).getIdProjet(), id) && List_Projet.get(i).getIsDeleted() == 0) {

                            if (List_Projet.get(i).getNomProjet().equals(name)) {
                                result = "nom existe deja";
                            }

                        }

                    }
                    if (result.equals("suc")) {
                        Structure structure = (Structure) ModelBean.GetContentTable("Structure", "WHERE nom_structure='" + name_structure + "'").get(0);
                        Projet projet = (Projet) ModelBean.GetContentTable("Projet", "WHERE id_projet=" + id).get(0);
                        projet.setNomProjet(name);
                        projet.setIdStructure(structure.getIdStructure());
                        ModelBean.UpdateLine(projet, "Projet", String.valueOf(id));
                        
                            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"mise a jour"+" "+table+" "+"N:"+projet.getIdProjet());
                        ModelBean.AddLine1(trace,"Trace");

                    }

                    response.getWriter().print(result);
                    return;

                }
                if (type.equals("deleteProjet")) {

                    int id = Integer.parseInt(request.getParameter("id"));
                    Projet projet = (Projet) ModelBean.GetContentTable("Projet", "WHERE id_projet=" + id).get(0);

                    ModelBean.DeleteLine(String.valueOf(id), "Projet");
                    
                    
                        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"supprime"+" "+table+" "+"N:"+projet.getIdProjet());
                        ModelBean.AddLine1(trace,"Trace");

                }

                break;
            case "Structure":
                type = request.getParameter("type");
                if (type.equals("AddStructure")) {

                    String name = new String(request.getParameter("Nom_Structure").getBytes("iso-8859-1"), "UTF-8");
                    String code = new String(request.getParameter("Code").getBytes("iso-8859-1"), "UTF-8");

                    List<Structure> List_Structure = ModelBean.GetContentTable("Structure", "WHERE isDeleted=0");
                    if (ModelBean.isFound("Structure", "WHERE nom_structure='" + name + "' AND isDeleted=0")) {
                        result = "Cette Nom est utilsé deja";

                    } else {

                        Structure newStructure = new Structure(name, code, 0);
                        ModelBean.AddLine1(newStructure, "Structure");
                        
                            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"ajoute"+" "+table+" "+"N:"+newStructure.getIdStructure());
                        ModelBean.AddLine1(trace,"Trace");

                    }

                    response.getWriter().print(result);
                    return;
                    // produitSessionBean.addProduit(listObjet.get(listObjet.size()-1).getIdObjet(), matr, type, marque, modele, des,name,savePath+File.separator+fileName);}

                }
                if (type.equals("GetLastIdStructure")) {
                    response.setContentType("application/json");
                    int last_id = 1;
                    List<Structure> List_Structure = ModelBean.GetContentTable("Structure", "");
                    if (List_Structure.isEmpty()) {

                        new Gson().toJson(String.valueOf(last_id), response.getWriter());

                    } else {

                        new Gson().toJson(String.valueOf(List_Structure.get(List_Structure.size() - 1).getIdStructure()), response.getWriter());

                    }
                }
                if (type.equals("editStructure")) {

                    int id = Integer.parseInt(request.getParameter("id"));
                    String name = new String(request.getParameter("Nom_Structure").getBytes("iso-8859-1"), "UTF-8");
                    String code = new String(request.getParameter("Code").getBytes("iso-8859-1"), "UTF-8");
                    List<Structure> List_Structure = ModelBean.GetContentTable("Structure", "WHERE isDeleted=0");

                    for (int i = 0; i < List_Structure.size(); i++) {
                        if (!Objects.equals(List_Structure.get(i).getIdStructure(), id) && List_Structure.get(i).getIsDeleted() == 0) {

                            if (List_Structure.get(i).getNomStructure().equals(name)) {
                                result = "nom existe deja";
                            }

                            if (List_Structure.get(i).getCode().equals(code)) {
                                result = "Code existe deja";
                            }

                        }

                    }
                    if (result.equals("suc")) {

                        Structure structure = (Structure) ModelBean.GetContentTable("Structure", "WHERE id_structure=" + id).get(0);
                        structure.setCode(code);
                        structure.setNomStructure(name);
                        ModelBean.UpdateLine(structure, "Structure", String.valueOf(id));
                        
                            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"mise a jour"+" "+table+" "+"N:"+structure.getIdStructure());
                        ModelBean.AddLine1(trace,"Trace");

                    }

                    response.getWriter().print(result);
                    return;

                }
                if (type.equals("deleteStructure")) {

                    int id = Integer.parseInt(request.getParameter("id"));
                    ModelBean.DeleteLine(String.valueOf(id), "Structure");
                    
                              DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"supprime"+" "+table+" "+"N:"+id);
                        ModelBean.AddLine1(trace,"Trace");
                    

                }

                break;
            case "ModeLivraison":
                type = request.getParameter("type");
                if (type.equals("AddModeLivraison")) {

                    String name = new String(request.getParameter("Mode_Livraison").getBytes("iso-8859-1"), "UTF-8");

                    if (ModelBean.isFound("ModeLivraison", "WHERE nom_mode='" + name + "' AND isDeleted=0")) {
                        result = "Cette Model est utilsé deja";

                    } else {

                        ModeLivraison ModeLivraison = new ModeLivraison(name, 0);
                        ModelBean.AddLine1(ModeLivraison, "ModeLivraison");
                        
                                  DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"ajoute"+" "+table+" "+"N:"+ModeLivraison.getIdModeL());
                        ModelBean.AddLine1(trace,"Trace");

                    }

                    response.getWriter().print(result);
                    return;
                    // produitSessionBean.addProduit(listObjet.get(listObjet.size()-1).getIdObjet(), matr, type, marque, modele, des,name,savePath+File.separator+fileName);}

                }
                if (type.equals("GetLastIdModeLivraison")) {
                    response.setContentType("application/json");
                    int last_id = 1;
                    List<ModeLivraison> List_ModeLivraison = ModelBean.GetContentTable("ModeLivraison", "");
                    if (List_ModeLivraison.isEmpty()) {

                        new Gson().toJson(String.valueOf(last_id), response.getWriter());

                    } else {

                        new Gson().toJson(String.valueOf(List_ModeLivraison.get(List_ModeLivraison.size() - 1).getIdModeL()), response.getWriter());

                    }
                }
                if (type.equals("editModeLivraison")) {

                    int id = Integer.parseInt(request.getParameter("id"));
                    String name = new String(request.getParameter("Mode_Livraison").getBytes("iso-8859-1"), "UTF-8");

                    List<ModeLivraison> List_ModeLivraison = ModelBean.GetContentTable("ModeLivraison", "WHERE isDeleted=0");

                    for (int i = 0; i < List_ModeLivraison.size(); i++) {
                        if (!Objects.equals(List_ModeLivraison.get(i).getIdModeL(), id) && List_ModeLivraison.get(i).getIsDeleted() == 0) {

                            if (List_ModeLivraison.get(i).getNomMode().equals(name)) {
                                result = "Model existe deja";
                            }

                        }

                    }
                    if (result.equals("suc")) {

                        ModeLivraison modeLivre = (ModeLivraison) ModelBean.GetContentTable("ModeLivraison", "WHERE id_modeL=" + id).get(0);
                        modeLivre.setNomMode(name);
                        ModelBean.UpdateLine(modeLivre, "ModeLivraison", String.valueOf(id));
                        
                        
                                  DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"mise a jour"+" "+table+" "+"N:"+modeLivre.getIdModeL());
                        ModelBean.AddLine1(trace,"Trace");

                    }

                    response.getWriter().print(result);
                    return;

                }
                if (type.equals("deleteModeLivraison")) {

                    int id = Integer.parseInt(request.getParameter("id"));
                    ModelBean.DeleteLine(String.valueOf(id), "ModeLivraison");
                    
                    
                    
                                  DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"supprime"+" "+table+" "+"N:"+id);
                        ModelBean.AddLine1(trace,"Trace");

                }

                break;
            case "ModeReglement":
                type = request.getParameter("type");
                if (type.equals("AddModeReglement")) {

                    String name = new String(request.getParameter("Mode_Reglement").getBytes("iso-8859-1"), "UTF-8");

                    if (ModelBean.isFound("ModeReglement", "WHERE nom_mode='" + name + "' AND isDeleted=0")) {
                        result = "Cette Model est utilsé deja";

                    } else {

                        ModeReglement mode_Reglement = new ModeReglement(name, 0);
                        ModelBean.AddLine1(mode_Reglement, "ModeReglement");
                        
                        
                                  DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"ajoute"+" "+table+" "+"N:"+mode_Reglement.getIdModeR());
                        ModelBean.AddLine1(trace,"Trace");

                    }

                    response.getWriter().print(result);
                    return;
                    // produitSessionBean.addProduit(listObjet.get(listObjet.size()-1).getIdObjet(), matr, type, marque, modele, des,name,savePath+File.separator+fileName);}

                }
                if (type.equals("GetLastIdModeReglement")) {
                    response.setContentType("application/json");
                    int last_id = 1;
                    List<ModeReglement> List_ModeReglement = ModelBean.GetContentTable("ModeReglement", "");
                    if (List_ModeReglement.isEmpty()) {

                        new Gson().toJson(String.valueOf(last_id), response.getWriter());

                    } else {

                        new Gson().toJson(String.valueOf(List_ModeReglement.get(List_ModeReglement.size() - 1).getIdModeR() + 1), response.getWriter());

                    }
                }
                if (type.equals("editModeReglement")) {

                    int id = Integer.parseInt(request.getParameter("id"));
                    String name = new String(request.getParameter("Mode_Reglement").getBytes("iso-8859-1"), "UTF-8");

                    List<ModeReglement> List_ModeReglement = ModelBean.GetContentTable("ModeReglement", "WHERE isDeleted=0");

                    for (int i = 0; i < List_ModeReglement.size(); i++) {
                        if (!Objects.equals(List_ModeReglement.get(i).getIdModeR(), id) && List_ModeReglement.get(i).getIsDeleted() == 0) {

                            if (List_ModeReglement.get(i).getNomMode().equals(name)) {
                                result = "Model existe deja";
                            }

                        }

                    }
                    if (result.equals("suc")) {

                        ModeReglement modeReglement = (ModeReglement) ModelBean.GetContentTable("ModeReglement", "WHERE id_modeR=" + id).get(0);
                        modeReglement.setNomMode(name);
                        ModelBean.UpdateLine(modeReglement, "ModeReglement", String.valueOf(id));
                        
                                      DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"mise a jour"+" "+table+" "+"N:"+modeReglement.getIdModeR());
                        ModelBean.AddLine1(trace,"Trace");
                        
                        

                    }

                    response.getWriter().print(result);
                    return;

                }
                if (type.equals("deleteModeReglement")) {

                    int id = Integer.parseInt(request.getParameter("id"));
                    ModelBean.DeleteLine(String.valueOf(id), "ModeReglement");
                    
                                  DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"supprime"+" "+table+" "+"N:"+id);
                        ModelBean.AddLine1(trace,"Trace");

                }

                break;
            case "Utilisateur":
                type = request.getParameter("type");
                if (type.equals("AddUtilisateur")) {

                    String username = new String(request.getParameter("UserName").getBytes("iso-8859-1"), "UTF-8");
                    String email = new String(request.getParameter("Email").getBytes("iso-8859-1"), "UTF-8");
                    String password = new String(request.getParameter("Password").getBytes("iso-8859-1"), "UTF-8");
                    String Structure = new String(request.getParameter("Structure").getBytes("iso-8859-1"), "UTF-8");
                    String role = new String(request.getParameter("Role").getBytes("iso-8859-1"), "UTF-8");
                    
                    if (ModelBean.isFound("Utilisateur", "WHERE username='" + username + "' AND isDeleted=0")) {
                        result = "UserName est utilsé deja";

                    } else {
                         if (ModelBean.isFound("Membre", "WHERE email='" + email + "' AND isDeleted=0")) {
                             result="Cette Utilisateur n'est pas Un membre dans l'entreprise";
                             
                         }
                        

                    }
                    if(result.equals("suc")){
                        Membre membre=(Membre) ModelBean.GetContentTable("Membre", "WHERE email='" +email+"'").get(0);
                        Structure str=(Structure) ModelBean.GetContentTable("Structure", "WHERE nom_structure='" +Structure+"'").get(0);
                       // public Utilisateur(int idMembre, String username, String password, String hash, int idStructure,String role, int isActive, int isDeleted) {
                        Utilisateur user=new Utilisateur(membre.getIdMembre(),username,password,Model.gethash(password),str.getIdStructure(),role,1,0);
                        ModelBean.AddLine1(user,"Utilisateur");
                        
                                DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"ajoute"+" "+table+" "+"N:"+user.getIdUtilisateur());
                        ModelBean.AddLine1(trace,"Trace");
                        
                    }

                    response.getWriter().print(result);
                    return;
                    // produitSessionBean.addProduit(listObjet.get(listObjet.size()-1).getIdObjet(), matr, type, marque, modele, des,name,savePath+File.separator+fileName);}

                }
                if (type.equals("GetLastIdUtilisateur")) {
                    response.setContentType("application/json");
                    int last_id = 1;
                    List<Utilisateur> List_Utilisateur = ModelBean.GetContentTable("Utilisateur", "");
                    if (List_Utilisateur.isEmpty()) {

                        new Gson().toJson(String.valueOf(last_id), response.getWriter());

                    } else {

                        new Gson().toJson(String.valueOf(List_Utilisateur.get(List_Utilisateur.size() - 1).getIdUtilisateur()), response.getWriter());

                    }
                }
                if (type.equals("editUtilisateur")) {

                    int id = Integer.parseInt(request.getParameter("id"));
                     String username = new String(request.getParameter("UserName").getBytes("iso-8859-1"), "UTF-8");
                   
                    String password = new String(request.getParameter("Password").getBytes("iso-8859-1"), "UTF-8");
                    String Structure = new String(request.getParameter("Structure").getBytes("iso-8859-1"), "UTF-8");
                    String role = new String(request.getParameter("Role").getBytes("iso-8859-1"), "UTF-8");
                    String etat = new String(request.getParameter("Etat").getBytes("iso-8859-1"), "UTF-8");

                    List<Utilisateur> List_Utilisateur = ModelBean.GetContentTable("Utilisateur", "WHERE isDeleted=0");

                    for (int i = 0; i < List_Utilisateur.size(); i++) {
                        if (!Objects.equals(List_Utilisateur.get(i).getIdUtilisateur(), id) && List_Utilisateur.get(i).getIsDeleted() == 0) {

                            if (List_Utilisateur.get(i).getUsername().equals(username)) {
                                result = "UserName existe deja";
                            }

                        }

                    }
                    if (result.equals("suc")) {
                        Structure str=(Structure) ModelBean.GetContentTable("Structure", "WHERE nom_structure='" +Structure+"'").get(0);
                        Utilisateur user = (Utilisateur) ModelBean.GetContentTable("Utilisateur", "WHERE id_utilisateur =" + id).get(0);
                       user.setUsername(username);
                       user.setPassword(password);
                       user.setHash(Model.gethash(password));
                       user.setIdStructure(str.getIdStructure());
                       user.setRole(role);
                       if(etat.equals("Active"))
                           user.setIsActive(1);
                       else
                          user.setIsActive(0); 
                        ModelBean.UpdateLine(user, "Utilisateur", String.valueOf(id));
                        
                                    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"mise a jour"+" "+table+" "+"N:"+user.getIdUtilisateur());
                        ModelBean.AddLine1(trace,"Trace");

                    }

                    response.getWriter().print(result);
                    return;

                }
                if (type.equals("deleteUtilisateur")) {

                    int id = Integer.parseInt(request.getParameter("id"));
                    ModelBean.DeleteLine(String.valueOf(id), "Utilisateur");
                    
                                DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"supprime"+" "+table+" "+"N:"+id);
                        ModelBean.AddLine1(trace,"Trace");

                }

                break;
            case "Membre":
                type = request.getParameter("type");
                if (type.equals("AddMembre")) {

                    String name = new String(request.getParameter("Nom").getBytes("iso-8859-1"), "UTF-8");
                    String prenom = new String(request.getParameter("Prenom").getBytes("iso-8859-1"), "UTF-8");
                    String email = new String(request.getParameter("Email").getBytes("iso-8859-1"), "UTF-8");
                    String name_structure = new String(request.getParameter("Structure").getBytes("iso-8859-1"), "UTF-8");
                    List<Membre> List_Membre = ModelBean.GetContentTable("Membre", "WHERE isDeleted=0");
                    if (ModelBean.isFound("Membre", "WHERE (nom='" + name + "' AND prenom='" + prenom + "') AND isDeleted=0 ")) {

                        result = "Cette Membre  est existe deja";

                    }

                    if (ModelBean.isFound("Membre", "WHERE nom='" + email + "' AND isDeleted=0 ")) {

                        result = "Cette Email  est utilisé deja";

                    }

                    if (result.equals("suc")) {
                        Structure structure = (Structure) ModelBean.GetContentTable("Structure", "WHERE nom_structure='" + name_structure + "'").get(0);
                        Membre membre = new Membre(structure.getIdStructure(), name, prenom, email, 0);
                        ModelBean.AddLine1(membre, "Membre");
                        
                                  DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"ajoute"+" "+table+" "+"N:"+membre.getIdMembre());
                        ModelBean.AddLine1(trace,"Trace");

                    }

                    response.getWriter().print(result);
                    return;
                    // produitSessionBean.addProduit(listObjet.get(listObjet.size()-1).getIdObjet(), matr, type, marque, modele, des,name,savePath+File.separator+fileName);}

                }
                if (type.equals("GetLastIdMembre")) {
                    response.setContentType("application/json");
                    int last_id = 1;
                    List<Membre> List_Membre = ModelBean.GetContentTable("Membre", "");
                    if (List_Membre.isEmpty()) {

                        new Gson().toJson(String.valueOf(last_id), response.getWriter());

                    } else {

                        new Gson().toJson(String.valueOf(List_Membre.get(List_Membre.size() - 1).getIdMembre()), response.getWriter());

                    }
                }
                if (type.equals("editMembre")) {

                    int id = Integer.parseInt(request.getParameter("id"));
                    String name = new String(request.getParameter("Nom").getBytes("iso-8859-1"), "UTF-8");
                    String prenom = new String(request.getParameter("Prenom").getBytes("iso-8859-1"), "UTF-8");
                    String email = new String(request.getParameter("Email").getBytes("iso-8859-1"), "UTF-8");
                    String name_structure = new String(request.getParameter("Structure").getBytes("iso-8859-1"), "UTF-8");
                    List<Membre> List_Membre = ModelBean.GetContentTable("Membre", "WHERE isDeleted=0");

                    for (int i = 0; i < List_Membre.size(); i++) {
                        if (!Objects.equals(List_Membre.get(i).getIdMembre(), id) && List_Membre.get(i).getIsDeleted() == 0) {

                            if (List_Membre.get(i).getNom().equals(name) && List_Membre.get(i).getPrenom().equals(prenom)) {
                                result = "Membre existe deja";
                            }
                            if (List_Membre.get(i).getEmail().equals(email)) {
                                result = "Email est utilisé deja";
                            }

                        }

                    }
                    if (result.equals("suc")) {
                        Structure structure = (Structure) ModelBean.GetContentTable("Structure", "WHERE nom_structure='" + name_structure + "'").get(0);
                        Membre membre = (Membre) ModelBean.GetContentTable("Membre", "WHERE id_membre=" + id).get(0);
                        membre.setNom(name);
                        membre.setPrenom(prenom);
                        membre.setEmail(email);
                        membre.setIdStructure(structure.getIdStructure());
                        ModelBean.UpdateLine(membre, "Membre", String.valueOf(id));
                        
                                  DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"mise a jour"+" "+table+" "+"N:"+membre.getIdMembre());
                        ModelBean.AddLine1(trace,"Trace");

                    }

                    response.getWriter().print(result);
                    return;

                }
                if (type.equals("deleteMembre")) {

                    int id = Integer.parseInt(request.getParameter("id"));
                    Membre membre = (Membre) ModelBean.GetContentTable("Membre", "WHERE id_membre=" + id).get(0);

                    ModelBean.DeleteLine(String.valueOf(id), "Membre");
                    
                              DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"supprime"+" "+table+" "+"N:"+id);
                        ModelBean.AddLine1(trace,"Trace");

                }

                break;
            case "Notification":
                type = request.getParameter("type");
                if (type.equals("AddNotification")) {

                    String name = new String(request.getParameter("Nom_Notfication").getBytes("iso-8859-1"), "UTF-8");
                    String mode = new String(request.getParameter("Mode").getBytes("iso-8859-1"), "UTF-8");
                    String destination = new String(request.getParameter("Utilisateur").getBytes("iso-8859-1"), "UTF-8");
                    String evenement = new String(request.getParameter("Evenement").getBytes("iso-8859-1"), "UTF-8");
                    String date = new String(request.getParameter("Date_Evenement").getBytes("iso-8859-1"), "UTF-8");
                    String rappel = new String(request.getParameter("Rappel").getBytes("iso-8859-1"), "UTF-8");
                    List<Notification> List_Notification = ModelBean.GetContentTable("Notification", "WHERE isDeleted=0");
                    if (ModelBean.isFound("Notification", "WHERE (nom_notification='" + name + "' AND date_evenement='" + date + "') AND isDeleted=0 ")) {

                        result = "Notification existe deja";

                    } else {
                           if(mode.equals("All")){
                               
                               if (!ModelBean.isFound("Structure", "WHERE (nom_structure='" + destination + "' AND isDeleted=0 ")) {
                                   result = "Structure introuvable";
                                   
                                   
                               }
                               
                               
                           }else{
                                if (!ModelBean.isFound("Utilisateur", "WHERE (username='" + destination + "' AND isDeleted=0 ")) {
                                   result = "Utilisateur introuvable";
                                   
                                   
                               } 
                               
                               
                           }
                      

                    }
                    
                    if(result.equals("suc")){
                        int idDestination=0;
                        if(mode.equals("All")){
                             Structure structure = (Structure) ModelBean.GetContentTable("Structure", "WHERE nom_structure='" + destination + "'").get(0);
                             idDestination=structure.getIdStructure();
                            
                        }else{
                            Utilisateur user = (Utilisateur) ModelBean.GetContentTable("Utilisateur", "WHERE username='" + destination + "'").get(0); 
                            
                        }
                        
                        
                       Notification notification = new Notification(name,idDestination, mode, evenement, date, rappel, 0);
                        ModelBean.AddLine1(notification, "Notification");
                        
                        
                                  DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"ajoute"+" "+table+" "+"N:"+notification.getIdNotification());
                        ModelBean.AddLine1(trace,"Trace");

                        
                    }

                    response.getWriter().print(result);
                    return;
                    // produitSessionBean.addProduit(listObjet.get(listObjet.size()-1).getIdObjet(), matr, type, marque, modele, des,name,savePath+File.separator+fileName);}

                }
                if (type.equals("GetLastIdNotification")) {
                    response.setContentType("application/json");
                    int last_id = 1;
                    List<Notification> List_Notification = ModelBean.GetContentTable("Notification", "");
                    if (List_Notification.isEmpty()) {

                        new Gson().toJson(String.valueOf(last_id), response.getWriter());

                    } else {

                        new Gson().toJson(String.valueOf(List_Notification.get(List_Notification.size() - 1).getIdNotification()), response.getWriter());

                    }
                }
                if (type.equals("editNotification")) {

                    int id = Integer.parseInt(request.getParameter("id"));
                    String name = new String(request.getParameter("Nom_Notfication").getBytes("iso-8859-1"), "UTF-8");
                       String mode = new String(request.getParameter("Mode").getBytes("iso-8859-1"), "UTF-8");
                    String destination = new String(request.getParameter("Utilisateur").getBytes("iso-8859-1"), "UTF-8");
                    String evenement = new String(request.getParameter("Evenement").getBytes("iso-8859-1"), "UTF-8");
                    String date = new String(request.getParameter("Date_Evenement").getBytes("iso-8859-1"), "UTF-8");
                    String rappel = new String(request.getParameter("Rappel").getBytes("iso-8859-1"), "UTF-8");;
                    List<Notification> List_Notification = ModelBean.GetContentTable("Notification", "WHERE isDeleted=0");

                    for (int i = 0; i < List_Notification.size(); i++) {
                        if (!Objects.equals(List_Notification.get(i).getIdNotification(), id) && List_Notification.get(i).getIsDeleted() == 0) {

                            if (ModelBean.isFound("Notification", "WHERE (nom_notification='" + name + "' AND date_evenement='" + date + "') AND isDeleted=0 ")) {

                                result = "Notification existe deja";

                            }

                        }
                    }
                    
                        if(mode.equals("All")){
                               
                               if (!ModelBean.isFound("Structure", "WHERE (nom_structure='" + destination + "' AND isDeleted=0 ")) {
                                   result = "Structure introuvable";
                                   
                                   
                               }
                               
                               
                           }else{
                                if (!ModelBean.isFound("Utilisateur", "WHERE (username='" + destination + "' AND isDeleted=0 ")) {
                                   result = "Utilisateur introuvable";
                                   
                                   
                               } 
                               
                               
                           }
                    
                    if (result.equals("suc")) {
                        int idDestination=0;
                         if(mode.equals("All")){
                             Structure structure = (Structure) ModelBean.GetContentTable("Structure", "WHERE nom_structure='" + destination + "'").get(0);
                             idDestination=structure.getIdStructure();
                            
                        }else{
                            Utilisateur user = (Utilisateur) ModelBean.GetContentTable("Utilisateur", "WHERE username='" + destination + "'").get(0); 
                            
                        }
                        
                        Notification notification = (Notification) ModelBean.GetContentTable("Notification", "WHERE id_notification=" + id).get(0);
                        notification.setNomNotification(name);
                         notification.setIdUtilisateur(idDestination);
                        notification.setMode(mode);
                        notification.setEvenement(evenement);
                        notification.setDateEvenement(date);
                        notification.setRappel(rappel);
                        ModelBean.UpdateLine(notification, "Notification ", String.valueOf(id));
                        
                                    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"mise a jour"+" "+table+" "+"N:"+notification.getIdNotification());
                        ModelBean.AddLine1(trace,"Trace");
                        

                    }

                    response.getWriter().print(result);
                    return;

                }

                if (type.equals("deleteNotification")) {

                    int id = Integer.parseInt(request.getParameter("id"));
                    Notification notification = (Notification) ModelBean.GetContentTable("Notification", "WHERE id_notification=" + id).get(0);

                    ModelBean.DeleteLine(String.valueOf(id), "Notification");
                    
                    
                                DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"supprime"+" "+table+" "+"N:"+id);
                        ModelBean.AddLine1(trace,"Trace");

                }

                break;
            case "TypeDocument":
                type = request.getParameter("type");
                if (type.equals("AddTypeDocument")) {

                    String name = new String(request.getParameter("Nom_Document").getBytes("iso-8859-1"), "UTF-8");
                    String abbrev = new String(request.getParameter("Abbreviation").getBytes("iso-8859-1"), "UTF-8");

                    List<Doctype> List_Doctype = ModelBean.GetContentTable("Doctype", "WHERE isDeleted=0");
                    if (ModelBean.isFound("Doctype", "WHERE (nom_document='" + name + "' OR abbrev='" + abbrev + "') AND isDeleted=0 ")) {

                        result = "Cette Nom OU Codage est utilisé deja";

                    } else {

                        Doctype doctype = new Doctype(name, abbrev, 0);
                        ModelBean.AddLine1(doctype, "Doctype");
                        
                                    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"ajoute"+" "+table+" "+"N:"+doctype.getIdDoctype());
                        ModelBean.AddLine1(trace,"Trace");

                    }

                    response.getWriter().print(result);
                    return;
                    // produitSessionBean.addProduit(listObjet.get(listObjet.size()-1).getIdObjet(), matr, type, marque, modele, des,name,savePath+File.separator+fileName);}

                }
                if (type.equals("GetLastIdTypeDocument")) {
                    response.setContentType("application/json");
                    int last_id = 1;
                    List<Doctype> List_Doctype = ModelBean.GetContentTable("Doctype", "");
                    if (List_Doctype.isEmpty()) {

                        new Gson().toJson(String.valueOf(last_id), response.getWriter());

                    } else {

                        new Gson().toJson(String.valueOf(List_Doctype.get(List_Doctype.size() - 1).getIdDoctype()), response.getWriter());

                    }
                }
                if (type.equals("editTypeDocument")) {

                    int id = Integer.parseInt(request.getParameter("id"));
                    String name = new String(request.getParameter("Nom_Document").getBytes("iso-8859-1"), "UTF-8");
                    String abbrev = new String(request.getParameter("Abbreviation").getBytes("iso-8859-1"), "UTF-8");

                    List<Doctype> List_Doctype = ModelBean.GetContentTable("Doctype", "WHERE isDeleted=0");

                    for (int i = 0; i < List_Doctype.size(); i++) {
                        if (!Objects.equals(List_Doctype.get(i).getIdDoctype(), id) && List_Doctype.get(i).getIsDeleted() == 0) {

                            if (ModelBean.isFound("Doctype", "WHERE (nom_document='" + name + "' OR abbrev='" + abbrev + "') AND isDeleted=0 ")) {

                                result = "Cette Nom OU Codage est utilisé deja";

                            }

                        }
                    }
                    if (result.equals("suc")) {

                        Doctype doctype = (Doctype) ModelBean.GetContentTable("Doctype", "WHERE id_doctype=" + id).get(0);
                        doctype.setNomDocument(name);
                        doctype.setAbbrev(abbrev);
                        ModelBean.UpdateLine(doctype, "Doctype", String.valueOf(id));
                        
                                     DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"mise a jour"+" "+table+" "+"N:"+doctype.getIdDoctype());
                        ModelBean.AddLine1(trace,"Trace");
                        
                        
                       

                    }

                    response.getWriter().print(result);
                    return;

                }

                if (type.equals("deleteTypeDocument")) {

                    int id = Integer.parseInt(request.getParameter("id"));

                    ModelBean.DeleteLine(String.valueOf(id), "Doctype");
                    
                                 DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"supprime"+" "+table+" "+"N:"+id);
                        ModelBean.AddLine1(trace,"Trace");

                }

                break;
            case "Destinateur":
                type = request.getParameter("type");
                if (type.equals("AddDestinateur")) {
                    // variable<%=tablename%> = ["Nom_Destinateur", "Type_Destinateur","Email_Destinateur","Phone_Destinateur","Fax_Destinateur","Addresse","Registre_Commerce","N_Agrement","NIF","Article_I","Structure"];

                    String name_dest = new String(request.getParameter("Nom_Destinateur").getBytes("iso-8859-1"), "UTF-8");
                    String type_dest = new String(request.getParameter("Type_Destinateur").getBytes("iso-8859-1"), "UTF-8");
                    String email_dest = new String(request.getParameter("Email_Destinateur").getBytes("iso-8859-1"), "UTF-8");
                    String phone_dest = new String(request.getParameter("Phone_Destinateur").getBytes("iso-8859-1"), "UTF-8");
                    String fax_dest = new String(request.getParameter("Fax_Destinateur").getBytes("iso-8859-1"), "UTF-8");
                    String address_dest = new String(request.getParameter("Addresse").getBytes("iso-8859-1"), "UTF-8");
                    String registre_dest = new String(request.getParameter("Registre_Commerce").getBytes("iso-8859-1"), "UTF-8");
                    String agrement_dest = new String(request.getParameter("N_Agrement").getBytes("iso-8859-1"), "UTF-8");
                    String nif_dest = new String(request.getParameter("NIF").getBytes("iso-8859-1"), "UTF-8");
                    String article_dest = new String(request.getParameter("Article_I").getBytes("iso-8859-1"), "UTF-8");
                    String structure_dest = new String(request.getParameter("Structure").getBytes("iso-8859-1"), "UTF-8");
                    List<Destinateur> List_Destinateur = ModelBean.GetContentTable("Destinateur", "WHERE isDeleted=0");
                    if (ModelBean.isFound("Destinateur", "WHERE (nom_destinateur='" + name_dest + "' OR registre_commerce='" + registre_dest + "'OR N_agrement='" + agrement_dest + "') AND isDeleted=0 ")) {

                        result = "Cette Nom OU RegistreCommerce ou N Agrement est existe deja";

                    } else {
                        Structure structure = (Structure) ModelBean.GetContentTable("Structure", "WHERE nom_structure='" + structure_dest + "'").get(0);
                        Destinateur destinateur = new Destinateur(structure.getIdStructure(), type_dest, name_dest, phone_dest, fax_dest, email_dest, address_dest, registre_dest, agrement_dest, nif_dest, article_dest, 0);
                        ModelBean.AddLine1(destinateur, "Destinateur");
                        
                        
                                     DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"ajoute"+" "+table+" "+"N:"+destinateur.getIdDestinateur());
                        ModelBean.AddLine1(trace,"Trace");

                    }

                    response.getWriter().print(result);
                    return;
                    // produitSessionBean.addProduit(listObjet.get(listObjet.size()-1).getIdObjet(), matr, type, marque, modele, des,name,savePath+File.separator+fileName);}

                }
                if (type.equals("GetLastIdDestinateur")) {
                    response.setContentType("application/json");
                    int last_id = 1;
                    List<Destinateur> List_Destinateur = ModelBean.GetContentTable("Destinateur", "");
                    if (List_Destinateur.isEmpty()) {

                        new Gson().toJson(String.valueOf(last_id), response.getWriter());

                    } else {

                        new Gson().toJson(String.valueOf(List_Destinateur.get(List_Destinateur.size() - 1).getIdDestinateur()), response.getWriter());

                    }
                }
                if (type.equals("editDestinateur")) {

                    int id = Integer.parseInt(request.getParameter("id"));
                    String name_dest = new String(request.getParameter("Nom_Destinateur").getBytes("iso-8859-1"), "UTF-8");
                    String type_dest = new String(request.getParameter("Type_Destinateur").getBytes("iso-8859-1"), "UTF-8");
                    String email_dest = new String(request.getParameter("Email_Destinateur").getBytes("iso-8859-1"), "UTF-8");
                    String phone_dest = new String(request.getParameter("Phone_Destinateur").getBytes("iso-8859-1"), "UTF-8");
                    String fax_dest = new String(request.getParameter("Fax_Destinateur").getBytes("iso-8859-1"), "UTF-8");
                    String address_dest = new String(request.getParameter("Addresse").getBytes("iso-8859-1"), "UTF-8");
                    String registre_dest = new String(request.getParameter("Registre_Commerce").getBytes("iso-8859-1"), "UTF-8");
                    String agrement_dest = new String(request.getParameter("N_Agrement").getBytes("iso-8859-1"), "UTF-8");
                    String nif_dest = new String(request.getParameter("NIF").getBytes("iso-8859-1"), "UTF-8");
                    String article_dest = new String(request.getParameter("Article_I").getBytes("iso-8859-1"), "UTF-8");
                    String structure_dest = new String(request.getParameter("Structure").getBytes("iso-8859-1"), "UTF-8");

                    List<Destinateur> List_Destinateur = ModelBean.GetContentTable("Destinateur", "WHERE isDeleted=0");

                    for (int i = 0; i < List_Destinateur.size(); i++) {
                        if (!Objects.equals(List_Destinateur.get(i).getIdDestinateur(), id) && List_Destinateur.get(i).getIsDeleted() == 0) {

                            if (List_Destinateur.get(i).getNomDestinateur().equals(name_dest) && List_Destinateur.get(i).getRegistreCommerce().equals(registre_dest)) {
                                result = "Nom ou Registre de Commerce est existe deja";
                            }
                            if (List_Destinateur.get(i).getNAgrement().equals(agrement_dest)) {
                                result = "Aggrement est utilisé deja";
                            }

                        }
                    }
                    if (result.equals("suc")) {
                        Structure structure = (Structure) ModelBean.GetContentTable("Structure", "WHERE nom_structure='" + structure_dest + "'").get(0);
                        Destinateur destinateur = (Destinateur) ModelBean.GetContentTable("Destinateur", "WHERE id_destinateur=" + id).get(0);
                        destinateur.setNomDestinateur(name_dest);
                        destinateur.setTypeDestinateur(type_dest);
                        destinateur.setEmailDestinateur(email_dest);
                        destinateur.setPhoneDestinateur(phone_dest);
                        destinateur.setFaxDestinateur(fax_dest);
                        destinateur.setAdrDestinateur(address_dest);
                        destinateur.setRegistreCommerce(registre_dest);
                        destinateur.setNAgrement(agrement_dest);
                        destinateur.setNif(nif_dest);
                        destinateur.setArticleI(article_dest);
                        destinateur.setIdStructure(structure.getIdStructure());
                        ModelBean.UpdateLine(destinateur, "Destinateur", String.valueOf(id));
                        
                        
                                     DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"mise a jour"+" "+table+" "+"N:"+destinateur.getIdDestinateur());
                        ModelBean.AddLine1(trace,"Trace");

                    }

                    response.getWriter().print(result);
                    return;

                }

                if (type.equals("deleteDestinateur")) {

                    int id = Integer.parseInt(request.getParameter("id"));

                    ModelBean.DeleteLine(String.valueOf(id), "Destinateur");
                    
                    
                                 DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"supprime"+" "+table+" "+"N:"+id);
                        ModelBean.AddLine1(trace,"Trace");

                }

                break;
            case "Nature":
                type = request.getParameter("type");
                if (type.equals("AddNature")) {

                    String name_nature = new String(request.getParameter("Nom_Nature").getBytes("iso-8859-1"), "UTF-8");
                   
                    String projet_nature = new String(request.getParameter("Projet").getBytes("iso-8859-1"), "UTF-8");
                   

                    List<Nature> List_Nature = ModelBean.GetContentTable("Nature", "WHERE isDeleted=0");
                    if (ModelBean.isFound("Nature", "WHERE nom_nature='" + name_nature + "' AND isDeleted=0 ")) {

                        result = "Cette Nature est existe deja";

                    } else {
                        if (!ModelBean.isFound("Projet", "WHERE nom_projet='" + projet_nature + "' AND isDeleted=0 ")) {
                            result = "Cette Projet n'existe pas";

                        }

                    }
                    if (result.equals("suc")) {
                        Projet projet = (Projet) ModelBean.GetContentTable("Projet", "WHERE nom_projet='" + projet_nature + "'").get(0);
                        Nature nature = new Nature(projet.getIdProjet(), name_nature, 0);
                        ModelBean.AddLine1(nature, "Nature");
                        
                        
                                     DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"ajoute"+" "+table+" "+"N:"+nature.getIdNature());
                        ModelBean.AddLine1(trace,"Trace");
                   
                    }

                    response.getWriter().print(result);
                    return;
                    // produitSessionBean.addProduit(listObjet.get(listObjet.size()-1).getIdObjet(), matr, type, marque, modele, des,name,savePath+File.separator+fileName);}

                }
                if (type.equals("GetLastIdNature")) {
                    response.setContentType("application/json");
                    int last_id = 1;
                    List<Nature> List_Nature = ModelBean.GetContentTable("Nature", "");
                    if (List_Nature.isEmpty()) {

                        new Gson().toJson(String.valueOf(last_id), response.getWriter());

                    } else {

                        new Gson().toJson(String.valueOf(List_Nature.get(List_Nature.size() - 1).getIdNature()), response.getWriter());

                    }
                }
                if (type.equals("editNature")) {

                    int id = Integer.parseInt(request.getParameter("id"));
                    String name_nature = new String(request.getParameter("Nom_Nature").getBytes("iso-8859-1"), "UTF-8");
                   
                    String projet_nature = new String(request.getParameter("Projet").getBytes("iso-8859-1"), "UTF-8");
                   

                    List<Nature> List_Nature = ModelBean.GetContentTable("Nature", "WHERE isDeleted=0");

                    for (int i = 0; i < List_Nature.size(); i++) {
                        if (!Objects.equals(List_Nature.get(i).getIdNature(), id) && List_Nature.get(i).getIsDeleted() == 0) {

                            if (List_Nature.get(i).getNomNature().equals(name_nature)) {
                                result = "Nom  existe deja";
                            }

                        }
                    }
                     if (!ModelBean.isFound("Projet", "WHERE nom_projet='" + projet_nature + "' AND isDeleted=0 ")) {
                            result = "Cette Projet n'existe pas";

                        }
                    
                    if (result.equals("suc")) {
                        Nature nature = (Nature) ModelBean.GetContentTable("Nature", "WHERE id_nature=" + id).get(0);
                       Projet projet=(Projet) ModelBean.GetContentTable("Projet", "WHERE nom_projet='"+projet_nature+"'").get(0);

                        nature.setNomNature(name_nature);
                        nature.setIdProjet(projet.getIdProjet());
                        ModelBean.UpdateLine(nature, "Nature", String.valueOf(id));
                        
                        
                                     DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"mise a jour"+" "+table+" "+"N:"+nature.getIdNature());
                        ModelBean.AddLine1(trace,"Trace");

                      

                    }

                    response.getWriter().print(result);
                    return;

                }

                if (type.equals("deleteNature")) {

                    int id = Integer.parseInt(request.getParameter("id"));

                    ModelBean.DeleteLine(String.valueOf(id), "Nature");
                    
                                 DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"supprime"+" "+table+" "+"N:"+id);
                        ModelBean.AddLine1(trace,"Trace");

       

                }

                break;
                case "TypeNature":
                type = request.getParameter("type");
                if (type.equals("AddTypeNature")) {

                    String name_nature = new String(request.getParameter("Nom_Nature").getBytes("iso-8859-1"), "UTF-8");
                   
                    String type_nature = new String(request.getParameter("Type_Nature").getBytes("iso-8859-1"), "UTF-8");
                   

                   
                    if (ModelBean.isFound("Nature", "WHERE nom_nature='" + name_nature + "' AND isDeleted=0 ")) {

                        result = "Cette Nature est existe deja";

                    } 
                    if (result.equals("suc")) {
                        Nature nature = (Nature) ModelBean.GetContentTable("Nature", "WHERE nom_naturet='" + name_nature + "'").get(0);
                        TypeNature typenature = new TypeNature(nature.getIdNature(), type_nature, 0);
                        ModelBean.AddLine1(typenature, " TypeNature");
                        
                                     DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"ajoute"+" "+table+" "+"N:"+typenature.getIdType());
                        ModelBean.AddLine1(trace,"Trace");
                   
                    }

                    response.getWriter().print(result);
                    return;
                    // produitSessionBean.addProduit(listObjet.get(listObjet.size()-1).getIdObjet(), matr, type, marque, modele, des,name,savePath+File.separator+fileName);}

                }
                if (type.equals("GetLastIdTypeNature")) {
                    response.setContentType("application/json");
                    int last_id = 1;
                    List<TypeNature> List_TypeNature = ModelBean.GetContentTable("TypeNature", "");
                    if (List_TypeNature.isEmpty()) {

                        new Gson().toJson(String.valueOf(last_id), response.getWriter());

                    } else {

                        new Gson().toJson(String.valueOf(List_TypeNature.get(List_TypeNature.size() - 1).getIdType()), response.getWriter());

                    }
                }
                if (type.equals("editTypeNature")) {

                    int id = Integer.parseInt(request.getParameter("id"));
                    String name_nature = new String(request.getParameter("Nom_Nature").getBytes("iso-8859-1"), "UTF-8");
                   
                    String type_nature = new String(request.getParameter("Type_Nature").getBytes("iso-8859-1"), "UTF-8");
                   

                    List<TypeNature> List_TypeNature = ModelBean.GetContentTable("TypeNature", "WHERE isDeleted=0");

                    if (ModelBean.isFound("Nature", "WHERE nom_nature='" + name_nature + "' AND isDeleted=0 ")) {

                        result = "Cette Nature est existe deja";

                    } 
             
                    
                    if (result.equals("suc")) {
                       
                       Nature nature = (Nature) ModelBean.GetContentTable("Nature", "WHERE nom_naturet='" + name_nature + "'").get(0);
                       TypeNature typenature = (TypeNature) ModelBean.GetContentTable("TypeNature", "WHERE id_type=" + id).get(0);
                       typenature.setIdNature(nature.getIdNature());
                       typenature.setNomType(type_nature);
                        ModelBean.UpdateLine(typenature, "TypeNature", String.valueOf(id));
                        
                                     DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"mise a jour"+" "+table+" "+"N:"+typenature.getIdType());
                        ModelBean.AddLine1(trace,"Trace");

                      

                    }

                    response.getWriter().print(result);
                    return;

                }

                if (type.equals("deleteTypeNature")) {

                    int id = Integer.parseInt(request.getParameter("id"));

                    ModelBean.DeleteLine(String.valueOf(id),"TypeNature");
                    
                    
                                 DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"supprime"+" "+table+" "+"N:"+id);
                        ModelBean.AddLine1(trace,"Trace");

       

                }

                break;
                 case "DesignationNature":
                type = request.getParameter("type");
                if (type.equals("AddDesignationNature")) {

                    String name_nature = new String(request.getParameter("Nom_Nature").getBytes("iso-8859-1"), "UTF-8");
                   
                    String des_nature = new String(request.getParameter("Designation_Nature").getBytes("iso-8859-1"), "UTF-8");
                   

                   
                    if (ModelBean.isFound("Nature", "WHERE nom_nature='" + name_nature + "' AND isDeleted=0 ")) {

                        result = "Cette Nature est existe deja";

                    } 
                    if (result.equals("suc")) {
                        Nature nature = (Nature) ModelBean.GetContentTable("Nature", "WHERE nom_naturet='" + name_nature + "'").get(0);
                        DesignationNature desnature = new DesignationNature(nature.getIdNature(), des_nature, 0);
                        ModelBean.AddLine1(desnature, "DesignationNature");
                        
                                     DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"ajoute"+" "+table+" "+"N:"+desnature.getIdDes());
                        ModelBean.AddLine1(trace,"Trace");
                   
                    }

                    response.getWriter().print(result);
                    return;
                    // produitSessionBean.addProduit(listObjet.get(listObjet.size()-1).getIdObjet(), matr, type, marque, modele, des,name,savePath+File.separator+fileName);}

                }
                if (type.equals("GetLastIdDesignationNature")) {
                    response.setContentType("application/json");
                    int last_id = 1;
                    List<DesignationNature> List_DesignationNature = ModelBean.GetContentTable("DesignationNature", "");
                    if (List_DesignationNature.isEmpty()) {

                        new Gson().toJson(String.valueOf(last_id), response.getWriter());

                    } else {

                        new Gson().toJson(String.valueOf(List_DesignationNature.get(List_DesignationNature.size() - 1).getIdDes()), response.getWriter());

                    }
                }
                if (type.equals("editDesignationNature")) {

                    int id = Integer.parseInt(request.getParameter("id"));
                    String name_nature = new String(request.getParameter("Nom_Nature").getBytes("iso-8859-1"), "UTF-8");
                   
                    String des_nature = new String(request.getParameter("Designation_Nature").getBytes("iso-8859-1"), "UTF-8");
                   

                    List<DesignationNature> List_DesignationNature = ModelBean.GetContentTable("DesignationNature", "WHERE isDeleted=0");

                    if (ModelBean.isFound("Nature", "WHERE nom_nature='" + name_nature + "' AND isDeleted=0 ")) {

                        result = "Cette Nature est existe deja";

                    } 
             
                    
                    if (result.equals("suc")) {
                       
                       Nature nature = (Nature) ModelBean.GetContentTable("Nature", "WHERE nom_naturet='" + name_nature + "'").get(0);
                      DesignationNature desnature = (DesignationNature) ModelBean.GetContentTable("DesignationNature", "WHERE id_des=" + id).get(0);
                       desnature.setIdNature(nature.getIdNature());
                       desnature.setNomDes(des_nature);
                        ModelBean.UpdateLine(desnature, "DesignationNature", String.valueOf(id));
                        
                                          DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"mise a jour"+" "+table+" "+"N:"+desnature.getIdDes());
                        ModelBean.AddLine1(trace,"Trace");
                        
                        

                      

                    }

                    response.getWriter().print(result);
                    return;

                }

                if (type.equals("deleteDesignationNature")) {

                    int id = Integer.parseInt(request.getParameter("id"));

                    ModelBean.DeleteLine(String.valueOf(id),"DesignationNature");
                    
                    
                                      DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"supprime"+" "+table+" "+"N:"+id);
                        ModelBean.AddLine1(trace,"Trace");

       

                }

                break;
                 case "TypeAttachment":
                type = request.getParameter("type");
                if (type.equals("AddTypeAttachment")) {
//["Nom_Attachment","Situation_Attachment","Structure","Projet","Nom_Nature","Designation","Type"];
                   
                   
                   
String              name_attachment = new String(request.getParameter("Nom_Attachment").getBytes("iso-8859-1"), "UTF-8");
                    String ty_attachment = new String(request.getParameter("Type_Attachment").getBytes("iso-8859-1"), "UTF-8");
                    String situation_attachment = new String(request.getParameter("Situation_Attachment").getBytes("iso-8859-1"), "UTF-8");
                    String structure = new String(request.getParameter("Structure").getBytes("iso-8859-1"), "UTF-8");
                    String projet = new String(request.getParameter("Projet").getBytes("iso-8859-1"), "UTF-8");
                    String name_nature = new String(request.getParameter("Nom_Nature").getBytes("iso-8859-1"), "UTF-8");
                    String des_nature = new String(request.getParameter("Designation").getBytes("iso-8859-1"), "UTF-8");
                    String type_nature = new String(request.getParameter("Type").getBytes("iso-8859-1"), "UTF-8");
                   
                   if(!projet.equals("")&&!projet.equals("/")&&!projet.equals("0")){
                         if (!ModelBean.isFound("Projet", "WHERE nom_projet='" + projet + "' AND isDeleted=0 ")) {

                        result = "Projet introuvable";

                    } 
                  }
                      if(!name_nature.equals("")&&!name_nature.equals("/")&&!name_nature.equals("0")){
                         if (!ModelBean.isFound("Nature", "WHERE nom_nature='" + name_nature + "' AND isDeleted=0 ")) {

                        result = "Nature introuvable";

                    } 
                  }
                         if(!des_nature.equals("")&&!des_nature.equals("/")&&!des_nature.equals("0")){
                         if (!ModelBean.isFound("DesignationNature", "WHERE nom_des='" + des_nature + "' AND isDeleted=0 ")) {

                        result = "Designation introuvable";

                    } 
                  }
                            if(!type_nature.equals("")&&!type_nature.equals("/")&&!type_nature.equals("0")){
                         if (!ModelBean.isFound("TypeNature", "WHERE nom_type='" + type_nature + "' AND isDeleted=0 ")) {

                        result = "Type introuvable";

                    } 
                  }

                   
                  
                    
                    
                    if (result.equals("suc")) {
                           
                        Structure str=(Structure)ModelBean.GetContentTable(" Structure", "WHERE nom_structure='" + structure + "'").get(0);
                        int idnature = 0,idprojet = 0,iddes = 0,idtype=0; 
                        
                        if(!name_nature.equals("")&&!name_nature.equals("")){
                           Nature nature=(Nature)ModelBean.GetContentTable("Nature", "WHERE nom_nature='" + name_nature + "'").get(0);  
                            idnature=nature.getIdNature();
                        }
                         if(!projet.equals("")&&!projet.equals("")){
                           Projet pro=(Projet)ModelBean.GetContentTable("Projet", "WHERE nom_projet='" + projet + "'").get(0);  
                            idprojet=pro.getIdProjet();
                        }
                         
                           if(!des_nature.equals("")&&!des_nature.equals("")){
                           DesignationNature des=(DesignationNature)ModelBean.GetContentTable("DesignationNature", "WHERE nom_des='" + des_nature + "'").get(0);  
                            iddes=des.getIdDes();
                        }
                           
                              if(!type_nature.equals("")&&!type_nature.equals("/")&&!type_nature.equals("0")){
                           TypeNature typen=(TypeNature)ModelBean.GetContentTable("TypeNature", "WHERE nom_type='" + type_nature + "'").get(0);  
                            idtype=typen.getIdType();
                        }
                           
                       TypeAttachment typeAttachment=new TypeAttachment(ty_attachment,name_attachment,situation_attachment,str.getIdStructure(),idprojet,idnature,iddes,idtype,0);
                        ModelBean.AddLine1(typeAttachment, "TypeAttachment");
                        
                                          DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"ajoute"+" "+table+" "+"N:"+typeAttachment.getIdTypeAttachment());
                        ModelBean.AddLine1(trace,"Trace");
                   
                    }

                    response.getWriter().print(result);
                    return;
                    // produitSessionBean.addProduit(listObjet.get(listObjet.size()-1).getIdObjet(), matr, type, marque, modele, des,name,savePath+File.separator+fileName);}

                }
                if (type.equals("GetLastIdTypeAttachment")) {
                    response.setContentType("application/json");
                    int last_id = 1;
                    List<TypeAttachment> List_TypeAttachment = ModelBean.GetContentTable("TypeAttachment", "");
                    if (List_TypeAttachment.isEmpty()) {

                        new Gson().toJson(String.valueOf(last_id), response.getWriter());

                    } else {

                        new Gson().toJson(String.valueOf(List_TypeAttachment.get( List_TypeAttachment.size() - 1).getIdTypeAttachment()), response.getWriter());

                    }
                }
                if (type.equals("editTypeAttachment")) {

                    int id = Integer.parseInt(request.getParameter("id"));
                    String ty_attachment = new String(request.getParameter("Type_Attachment").getBytes("iso-8859-1"), "UTF-8");
                   String name_attachment = new String(request.getParameter("Nom_Attachment").getBytes("iso-8859-1"), "UTF-8");
                    String situation_attachment = new String(request.getParameter("Situation_Attachment").getBytes("iso-8859-1"), "UTF-8");
                    String structure = new String(request.getParameter("Structure").getBytes("iso-8859-1"), "UTF-8");
                    String projet = new String(request.getParameter("Projet").getBytes("iso-8859-1"), "UTF-8");
                    String name_nature = new String(request.getParameter("Nom_Nature").getBytes("iso-8859-1"), "UTF-8");
                    String des_nature = new String(request.getParameter("Designation").getBytes("iso-8859-1"), "UTF-8");
                    String type_nature = new String(request.getParameter("Type").getBytes("iso-8859-1"), "UTF-8");
                   
                   if(!projet.equals("")&&!projet.equals("/")&&!projet.equals("0")){
                         if (!ModelBean.isFound("Projet", "WHERE nom_projet='" + projet + "' AND isDeleted=0 ")) {

                        result = "Projet introuvable";

                    } 
                  }
                      if(!name_nature.equals("")&&!name_nature.equals("/")&&!name_nature.equals("0")){
                         if (!ModelBean.isFound("Nature", "WHERE nom_nature='" + name_nature + "' AND isDeleted=0 ")) {

                        result = "Nature introuvable";

                    } 
                  }
                         if(!des_nature.equals("")&&!des_nature.equals("/")&&!des_nature.equals("0")){
                         if (!ModelBean.isFound("DesignationNature", "WHERE nom_des='" + des_nature + "' AND isDeleted=0 ")) {

                        result = "Designation introuvable";

                    } 
                  }
                            if(!type_nature.equals("")&&!type_nature.equals("/")&&!type_nature.equals("0")){
                         if (!ModelBean.isFound("TypeNature", "WHERE nom_type='" + type_nature + "' AND isDeleted=0 ")) {

                        result = "Type introuvable";

                    } 
                  }
             
                    
                    if (result.equals("suc")) {
                           Structure str=(Structure)ModelBean.GetContentTable(" Structure", "WHERE nom_structure='" + structure + "'").get(0);
                        int idnature = 0,idprojet = 0,iddes = 0,idtype=0; 
                        
                        if(!name_nature.equals("")&&!name_nature.equals("/")&&!name_nature.equals("0")){
                           Nature nature=(Nature)ModelBean.GetContentTable("Nature", "WHERE nom_nature='" + name_nature + "'").get(0);  
                            idnature=nature.getIdNature();
                        }
                         if(!projet.equals("")&&!projet.equals("/")&&!projet.equals("0")){
                           Projet pro=(Projet)ModelBean.GetContentTable("Projet", "WHERE nom_projet='" + projet + "'").get(0);  
                            idprojet=pro.getIdProjet();
                        }
                         
                           if(!des_nature.equals("")&&!des_nature.equals("/")&&!des_nature.equals("0")){
                           DesignationNature des=(DesignationNature)ModelBean.GetContentTable("DesignationNature", "WHERE nom_des='" + des_nature + "'").get(0);  
                            iddes=des.getIdDes();
                        }
                           
                              if(!type_nature.equals("")&&!type_nature.equals("/")&&!type_nature.equals("0")){
                           TypeNature typen=(TypeNature)ModelBean.GetContentTable("TypeNature", "WHERE nom_type='" + type_nature + "'").get(0);  
                            idtype=typen.getIdType();
                        }
                          
                  TypeAttachment typeattach = (TypeAttachment) ModelBean.GetContentTable("TypeAttachment", "WHERE id_type_attachment=" + id).get(0);
                      typeattach.setIdDesignation(iddes);
                      typeattach.setTypeAttachment(ty_attachment);
                      typeattach.setIdNature(idnature);
                      typeattach.setIdProjet(idprojet);
                      typeattach.setIdType(idtype);
                      typeattach.setIdStructure(str.getIdStructure());
                      typeattach.setNomAttachment(name_attachment);
                      typeattach.setSituationAttachment(situation_attachment);
                      ModelBean.UpdateLine(typeattach, "TypeAttachment", String.valueOf(id));
                      
                      
                                         DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"mise a jour"+" "+table+" "+"N:"+typeattach.getIdTypeAttachment());
                        ModelBean.AddLine1(trace,"Trace");

                    }

                    response.getWriter().print(result);
                    return;

                }

                if (type.equals("deleteTypeAttachment")) {

                    int id = Integer.parseInt(request.getParameter("id"));

                    ModelBean.DeleteLine(String.valueOf(id),"TypeAttachment");
                    
                    
                                       DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"supprime"+" "+table+" "+"N:"+id);
                        ModelBean.AddLine1(trace,"Trace");
            
       

                }

                break;
                 case "Articel":
                type = request.getParameter("type");
                if (type.equals("Add"+table)) {

                    //objetSessionBean.addObjet();
//var variable = ["Name", "Designation", "Matricule", "Type", "Marque", "Modele", "Prix", "Structure", "Image"];
//produitSessionBean.addProduit(listObjet.get(listObjet.size()-1).getIdObjet());*/
                    request.setCharacterEncoding("UTF-8");

                    String name = new String(request.getParameter("Nom").getBytes("iso-8859-1"), "UTF-8");

                    String des = new String(request.getParameter("Designation").getBytes("iso-8859-1"), "UTF-8");

                    String matr = new String(request.getParameter("Matricule").getBytes("iso-8859-1"), "UTF-8");

                    String typeobjet = new String(request.getParameter("Type").getBytes("iso-8859-1"), "UTF-8");
                    String typeproduit = new String(request.getParameter("ProduitDe").getBytes("iso-8859-1"), "UTF-8");

                    String marque = new String(request.getParameter("Marque").getBytes("iso-8859-1"), "UTF-8");

                    String modele = new String(request.getParameter("Modele").getBytes("iso-8859-1"), "UTF-8");

                    String str = new String(request.getParameter("Structure").getBytes("iso-8859-1"), "UTF-8");

                    Double prix = Double.parseDouble(request.getParameter("Prix-unitaire"));
                    List<Produit> List_Produit = ModelBean.GetContentTable("Produit", "");

                    for (int i = 0; i < List_Produit.size(); i++) {

                        if (List_Produit.get(i).getNomProduit().equals(name)) {
                            result = "Cette Nom Utilisé Deja";
                        }

                        if (List_Produit.get(i).getDesignation().equals(des)) {
                            result = "Cette Designation Utilisé Deja";
                        }

                        if (List_Produit.get(i).getMatricule().equals(matr)) {
                            result = "Cette Matricule existe Deja";
                        }

                    }

                    response.setContentType("text/html;charset=UTF-8");
                    String fileName = null;
                    String appPath = request.getServletContext().getRealPath("");
                    String savePath = appPath + "\\webfiles\\images";
                    File fileDir = new File(savePath);
                    if (!fileDir.exists()) {
                        fileDir.mkdirs();
                    }
                    // name1=request.getPart("name");
                    int idtype_objet = 0;
                    Part part = request.getPart("file");
                    fileName = extractFileName(part);
                    InputStream is = part.getInputStream();
                    File f = new File(savePath + File.separator + fileName);
                    copyInputStreamToFile(is, f);
                    if (result.equals("suc")) {

                        List<Structure> s = ModelBean.GetContentTable("Structure", "WHERE nom_structure='" + str + "'");
                        if (ModelBean.isFound("ObjetType", "WHERE nom_objet_type='" + typeobjet + "'")) {
                            ObjetType type_objet = (ObjetType) ModelBean.GetContentTable("ObjetType", "WHERE nom_objet_type='" + typeobjet + "'").get(0);
                            idtype_objet = type_objet.getIdObjetType();
                        } else {
                            ObjetType nobj = new ObjetType(typeobjet, 0);
                            ModelBean.AddLine1(nobj, "ObjetType");
                            List<ObjetType> l = ModelBean.GetContentTable("ObjetType", "");
                            idtype_objet = l.get(l.size() - 1).getIdObjetType();

                        }

                        Objet obj = new Objet(idtype_objet, name, 0, s.get(0).getIdStructure(), 0, 0, 0, 0, 0);
                        ModelBean.AddLine1(obj, "Objet");
                        List<Objet> listObjet = ModelBean.GetContentTable("Objet", "");
                        // public Produit(int idObjet, String matricule, String typeProduit, String marque, String modele, String designation, String nomProduit, String unite, double quantite, double utilise, double prix, String image, int isDeleted)
                        Produit p = new Produit(listObjet.get(listObjet.size() - 1).getIdObjet(), matr, typeproduit, marque, modele, des, name, "/", 0, 0, prix, savePath + File.separator + fileName, 0);
                        ModelBean.AddLine1(p, "Produit");
                        
                                           DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"ajoute"+" "+table+" "+"N:"+p.getIdProduit());
                        ModelBean.AddLine1(trace,"Trace");
                    }
                    response.getWriter().print(result);
                    return;
                    // produitSessionBean.addProduit(listObjet.get(listObjet.size()-1).getIdObjet(), matr, type, marque, modele, des,name,savePath+File.separator+fileName);}

                }

                if (type.equals("GetLastId"+table)) {
                    response.setContentType("application/json");
                    int last_id = 1;
                    List<Produit> List_Produit = ModelBean.GetContentTable("Produit", "");
                    if (List_Produit.isEmpty()) {

                        new Gson().toJson(String.valueOf(last_id), response.getWriter());

                    } else {

                        new Gson().toJson(String.valueOf(List_Produit.get(List_Produit.size() - 1).getIdProduit()), response.getWriter());

                    }
                }
                if (type.equals("listSerial")) {
                    response.setContentType("application/json");
                    int serial = Integer.parseInt(request.getParameter("serial"));
                    List<Serialnumber> List_Serial = ModelBean.GetContentTable("Serialnumber", "where id_sn=" + serial + "AND isDeleted<>-1");
                    Serialnumber serialnumber = List_Serial.get(0);
                    while (ModelBean.isFound("Serialnumber", "WHERE isDeleted=" + serialnumber.getIdSn())) {
                        serialnumber = (Serialnumber) ModelBean.GetContentTable("Serialnumber", "where isDeleted=" + serialnumber.getIdSn()).get(0);
                        List_Serial.add(serialnumber);

                    }
                    new Gson().toJson(List_Serial, response.getWriter());

                }
                if (type.equals("Serial")) {
                    response.setContentType("application/json");
                    int serial = Integer.parseInt(request.getParameter("serial"));
                    List<Serialnumber> List_Serial = ModelBean.GetContentTable("Serialnumber", "where id_sn=" + serial);

                    new Gson().toJson(List_Serial, response.getWriter());

                }
                if (type.equals("typedocument")) {
                    response.setContentType("application/json");
                    int serial = Integer.parseInt(request.getParameter("serial"));
                    List<DocObjetSn> List_DocObjetSn = ModelBean.GetContentTable("DocObjetSn", "where id_sn=" + serial);
                    DocObjet docobjet = (DocObjet) ModelBean.GetContentTable("DocObjet", "where id_doc_objet=" + List_DocObjetSn.get(0).getIdDocObjet()).get(0);
                    Document document = (Document) ModelBean.GetContentTable("Document", "where id_document=" + docobjet.getIdDocument()).get(0);
                    Doctype doctype = (Doctype) ModelBean.GetContentTable("Doctype", "where id_doctype=" + document.getIdType()).get(0);
                    new Gson().toJson(doctype.getNomDocument(), response.getWriter());

                }
                if (type.equals("getDistinateur")) {
                    response.setContentType("application/json");
                    int serial = Integer.parseInt(request.getParameter("serial"));
                    List<DocObjetSn> List_DocObjetSn = ModelBean.GetContentTable("DocObjetSn", "where id_sn=" + serial);
                    DocObjet docobjet = (DocObjet) ModelBean.GetContentTable("DocObjet", "where id_doc_objet=" + List_DocObjetSn.get(0).getIdDocObjet()).get(0);
                    Document document = (Document) ModelBean.GetContentTable("Document", "where id_document=" + docobjet.getIdDocument()).get(0);
                    Doctype doctype = (Doctype) ModelBean.GetContentTable("Doctype", "where id_doctype=" + document.getIdType()).get(0);
                    Destinateur destinateur = (Destinateur) ModelBean.GetContentTable("Destinateur", "where id_destinateur=" + document.getIdDestinataire()).get(0);
                    new Gson().toJson(destinateur, response.getWriter());

                }
                if (type.equals("getProjet")) {
                    response.setContentType("application/json");
                    int serial = Integer.parseInt(request.getParameter("serial"));
                    List<DocObjetSn> List_DocObjetSn = ModelBean.GetContentTable("DocObjetSn", "where id_sn=" + serial);
                    DocObjet docobjet = (DocObjet) ModelBean.GetContentTable("DocObjet", "where id_doc_objet=" + List_DocObjetSn.get(0).getIdDocObjet()).get(0);
                    Document document = (Document) ModelBean.GetContentTable("Document", "where id_document=" + docobjet.getIdDocument()).get(0);
                    Doctype doctype = (Doctype) ModelBean.GetContentTable("Doctype", "where id_doctype=" + document.getIdType()).get(0);
                    Projet projet = (Projet) ModelBean.GetContentTable("Projet", "where id_projet=" + document.getIdProjet()).get(0);
                    new Gson().toJson(projet, response.getWriter());

                }
                if (type.equals("getNature")) {
                    response.setContentType("application/json");
                    int serial = Integer.parseInt(request.getParameter("serial"));
                    List<DocObjetSn> List_DocObjetSn = ModelBean.GetContentTable("DocObjetSn", "where id_sn=" + serial);
                    DocObjet docobjet = (DocObjet) ModelBean.GetContentTable("DocObjet", "where id_doc_objet=" + List_DocObjetSn.get(0).getIdDocObjet()).get(0);
                    Document document = (Document) ModelBean.GetContentTable("Document", "where id_document=" + docobjet.getIdDocument()).get(0);
                    Doctype doctype = (Doctype) ModelBean.GetContentTable("Doctype", "where id_doctype=" + document.getIdType()).get(0);
                    Nature nature = (Nature) ModelBean.GetContentTable("Nature", "where id_nature=" + document.getIdNature()).get(0);
                    new Gson().toJson(nature, response.getWriter());

                }
                if (type.equals("getMembre")) {
                    response.setContentType("application/json");
                    int idprojet = Integer.parseInt(request.getParameter("idprojet"));
                    List<ProjetMembre> List_ProjetMembre = ModelBean.GetContentTable("ProjetMembre", "where id_projet=" + idprojet);
                    List<Membre> List_Membre = new ArrayList<>();
                    for (int j = 0; j < List_ProjetMembre.size(); j++) {
                        List_Membre.add((Membre) ModelBean.GetContentTable("Membre", "where id_membre=" + List_ProjetMembre.get(j).getIdPersonne()).get(0));
                    }

                    new Gson().toJson(List_Membre, response.getWriter());

                }

                if (type.equals("updateImage")) {
                    String id = request.getParameter("id");
                    //File img=(File) request.getPart("img");
                    response.setContentType("text/html;charset=UTF-8");
                    String fileName = null;

                    String appPath = request.getServletContext().getRealPath("");

                    String savePath = appPath + "\\webfiles\\images";
                    File fileDir = new File(savePath);
                    if (!fileDir.exists()) {
                        fileDir.mkdirs();
                    }

                    //String savePath = "C:\\xampp\\htdocs\\img";
                    // name1=request.getPart("name");
                    Part part = request.getPart("file");
                    fileName = extractFileName(part);
                    InputStream is = part.getInputStream();
                    File f = new File(savePath + File.separator + fileName);
                    copyInputStreamToFile(is, f);
                    Produit produit = (Produit) ModelBean.GetContentTable("Produit", "WHERE id_produit=" + Integer.parseInt(id)).get(0);
                    Objet objet = (Objet) ModelBean.GetContentTable("Objet", "WHERE id_objet=" + produit.getIdObjet()).get(0);
                    ModelBean.UpdateLine(objet, "Objet", String.valueOf(objet.getIdObjet()));

                    List<Objet> listobjet = ModelBean.GetContentTable("Objet", "");
                    produit.setImage(savePath + File.separator + fileName);
                    produit.setIdObjet(listobjet.get(listobjet.size() - 1).getIdObjet());
                    ModelBean.UpdateLine(produit, "Produit", String.valueOf(produit.getIdProduit()));
                    response.getWriter().print(savePath + File.separator + fileName);
                    return;

                }
                if (type.equals("delete"+table)) {

                    int id = Integer.parseInt(request.getParameter("id"));
                    Produit produit = (Produit) ModelBean.GetContentTable("Produit", "WHERE id_produit=" + id).get(0);
                    int id_objet = produit.getIdObjet();
                    ModelBean.DeleteLine(String.valueOf(id), "Produit");
                    ModelBean.DeleteLine(String.valueOf(id_objet), "Objet");
                    
                    
                                       DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"supprime"+" "+table+" "+"N:"+id);
                        ModelBean.AddLine1(trace,"Trace");

                }
                if (type.equals("detailproduit")) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    request.setAttribute("id", id);
                    Produit produit = (Produit) ModelBean.GetContentTable("Produit", "WHERE id_produit=" + id).get(0);

                    Objet objet = (Objet) ModelBean.GetContentTable("Objet", "WHERE id_objet=" + produit.getIdObjet()).get(0);
                    request.setAttribute("produit", produit);
                    request.setAttribute("objet", objet);

                    List<Serialnumber> listserial = ModelBean.GetContentTable("Serialnumber", "WHERE id_objet=" + produit.getIdObjet());
                    List<Serialnumber> listserial1 = new ArrayList<>();
                    /* if(objet.getIsDeleted()!=0&&objet.getIsDeleted()!=-1){
         for(int i=0;i<listserial.size();i++){
             if(listserial.get(i).getIsDeleted()==0)
                 listserial1.add(listserial.get(i));
             if(listserial.get(i).getIsDeleted()!=0&&listserial.get(i).getIsDeleted()!=-1)
                 listserial1.add((Serialnumber) ModelBean.GetContentTable("Serialnumber", "WHERE id_sn="+listserial.get(i).getIsDeleted()).get(0));
             
         }
         }*/
                    //if(objet.getIsDeleted()==0){
                    for (int i = 0; i < listserial.size(); i++) {
                        if (listserial.get(i).getIsDeleted() == 0) {
                            listserial1.add(listserial.get(i));
                        }
                        //if(listserial.get(i).getIsDeleted()!=0&&listserial.get(i).getIsDeleted()!=-1)
                        //listserial1.add((Serialnumber) ModelBean.GetContentTable("Serialnumber", "WHERE id_sn="+listserial.get(i).getIsDeleted()).get(0));

                    }
                    while (ModelBean.isFound("Objet", "WHERE isDeleted=" + objet.getIdObjet())) {
                        objet = (Objet) ModelBean.GetContentTable("Objet", "WHERE isDeleted=" + objet.getIdObjet()).get(0);
                        listserial = ModelBean.GetContentTable("Serialnumber", "WHERE id_objet=" + objet.getIdObjet());
                        for (int i = 0; i < listserial.size(); i++) {
                            if (listserial.get(i).getIsDeleted() == 0) {
                                listserial1.add(listserial.get(i));
                            }
                            //if(listserial.get(i).getIsDeleted()!=0&&listserial.get(i).getIsDeleted()!=-1)
                            // listserial1.add((Serialnumber) ModelBean.GetContentTable("Serialnumber", "WHERE id_sn="+listserial.get(i).getIsDeleted()).get(0));

                        }
                    }

                    // }
                    request.setAttribute("serial", listserial1);
                    request.setAttribute("serialall", ModelBean.GetContentTable("Serialnumber", "WHERE id_objet=" + produit.getIdObjet()));
                    request.setAttribute("projet", ModelBean.GetContentTable("Projet", ""));

                    /* request.setAttribute("list",produitSessionBean.findAll());
        request.setAttribute("listObjet",objetSessionBean.findAll());
       
       request.setAttribute("listtypeObjet",objet_TypeSessionBean.findAll());
        request.setAttribute("Structure",structureSessionBean.findAll());*/
                    request.getServletContext().getRequestDispatcher("/Account/Model/DetailProduit.jsp").forward(request, response);

                }
                if (type.equals("edit"+table)) {

                    int id = Integer.parseInt(request.getParameter("id"));
                  
                    String desi = new String(request.getParameter("Designation").getBytes("iso-8859-1"), "UTF-8");

                    String matr = new String(request.getParameter("Matricule").getBytes("iso-8859-1"), "UTF-8");

                 

                    String marque = new String(request.getParameter("Marque").getBytes("iso-8859-1"), "UTF-8");

                    String modele = new String(request.getParameter("Modele").getBytes("iso-8859-1"), "UTF-8");

                    String str = new String(request.getParameter("Structure").getBytes("iso-8859-1"), "UTF-8");

                    Double unite = Double.parseDouble(request.getParameter("Prix-unitaire"));

                    int idtype_objet = 0;
                    Produit produit = (Produit) ModelBean.GetContentTable("Produit", "WHERE id_produit=" + id).get(0);
                    if (produit.getIsDeleted() != 0) {
                        while (produit.getIsDeleted() != 0) {
                            produit = (Produit) ModelBean.GetContentTable("Produit", "WHERE id_produit=" + produit.getIsDeleted()).get(0);

                        }
                    }

                    List<Produit> List_Produit = ModelBean.GetContentTable("Produit", "WHERE isDeleted=0");

                    for (int i = 0; i < List_Produit.size(); i++) {
                        if (!Objects.equals(List_Produit.get(i).getIdProduit(), produit.getIdProduit()) && List_Produit.get(i).getIsDeleted() == 0) {
                            if (List_Produit.get(i).getMatricule().equals(matr)) {
                                result = "Matricule est utilse Deja";
                            }

                            if (List_Produit.get(i).getDesignation().equals(desi)) {
                                result = "Designation est utilse Deja";
                            }

                          
                        }

                    }
                    if (result.equals("suc")) {
                        List<Structure> s = ModelBean.GetContentTable("Structure", "WHERE nom_structure='" + str + "'");

                        Objet obj = (Objet) ModelBean.GetContentTable("Objet", "WHERE id_objet=" + produit.getIdObjet()).get(0);
                     
                        obj.setTypeObjet(idtype_objet);
                        obj.setIdStructure(s.get(0).getIdStructure());
                        ModelBean.UpdateLine(obj, "Objet", String.valueOf(obj.getIdObjet()));
                        List<Objet> listobjet = ModelBean.GetContentTable("Objet", "");

                        produit.setDesignation(desi);
                        produit.setMarque(marque);
                        produit.setMatricule(matr);
                        produit.setModele(modele);
                        
                        produit.setIdObjet(listobjet.get(listobjet.size() - 1).getIdObjet());
                        
                        produit.setPrix(unite);
                        ModelBean.UpdateLine(produit, "Produit", String.valueOf(produit.getIdProduit()));
                        
                        
                                           DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
                            LocalDateTime now = LocalDateTime.now();  
                             
                        
                        int iduser= Integer.parseInt(request.getParameter("idUtilisateur"));
                        Trace trace=new Trace(iduser,dtf.format(now),"mise a jour"+" "+table+" "+"N:"+produit.getIdProduit());
                        ModelBean.AddLine1(trace,"Trace");

                    }
                    response.getWriter().print(result);
                    return;

                }
                break;

        }

    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }

    private void copyInputStreamToFile(InputStream in, File file) {
        try {
            OutputStream out = new FileOutputStream(file);
            byte[] buf = new byte[1024 * 1024 * 10];
            int len;
            while ((len = in.read(buf)) > 0) {
                out.write(buf, 0, len);
            }
            out.flush();
            out.close();
            in.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
