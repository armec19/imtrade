/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Session;

import com.google.gson.Gson;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import maps.Destinateur;
import maps.DocObjet;
import maps.DocObjetSn;
import maps.Doctype;
import maps.Document;
import maps.Membre;
import maps.ModeLivraison;
import maps.ModeReglement;
import maps.Nature;
import maps.Objet;
import maps.ObjetType;
import maps.Produit;
import maps.Projet;
import maps.ProjetMembre;
import maps.Serialnumber;
import maps.Structure;
import module.ModelBean;

/**
 *
 * @author MARWA
 */
@MultipartConfig
public class Manager7 extends HttpServlet {

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

        if (table.equals("Produit")) {
            String type = request.getParameter("type");
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
                
               
                 String condition=new String(request.getParameter("cond").getBytes ("iso-8859-1"), "UTF-8");
                if (condition.equals("marque")) {
                   
                     String var=new String(request.getParameter("var").getBytes ("iso-8859-1"), "UTF-8");
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
                    
                    
                       String var=new String(request.getParameter("var").getBytes ("iso-8859-1"), "UTF-8");
                    l = ModelBean.GetContentTable("Produit", "WHERE type_produit='" + var + "'AND isDeleted=" + 0);

                }
                if (condition.equals("all")) {

                    l = ModelBean.GetContentTable("Produit", "WHERE isDeleted=" + 0);

                }

                request.setAttribute("produit", l);
                request.getServletContext().getRequestDispatcher("/Account/Model/CardProduct.jsp").forward(request, response);

            }
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
        String type="";

        String result = "suc";
        switch (table) {
            case "Produit":
             type = request.getParameter("type");
            if (type.equals("AddProduit")) {

                //objetSessionBean.addObjet();
//var variable = ["Name", "Designation", "Matricule", "Type", "Marque", "Modele", "Prix", "Structure", "Image"];
//produitSessionBean.addProduit(listObjet.get(listObjet.size()-1).getIdObjet());*/
             request.setCharacterEncoding("UTF-8");
               
                String name=new String(request.getParameter("Material").getBytes ("iso-8859-1"), "UTF-8");
               
              
               
                String des=new String(request.getParameter("Designation").getBytes ("iso-8859-1"), "UTF-8");
                
                String matr=new String(request.getParameter("Matricule").getBytes ("iso-8859-1"), "UTF-8");
             
                 String typeproduit=new String( request.getParameter("Type").getBytes ("iso-8859-1"), "UTF-8");
                
                 String marque=new String( request.getParameter("Marque").getBytes ("iso-8859-1"), "UTF-8");
             
                 String modele=new String(request.getParameter("Modele").getBytes ("iso-8859-1"), "UTF-8");
               
                 String str=new String(request.getParameter("Structure").getBytes ("iso-8859-1"), "UTF-8");
             

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
                    if (ModelBean.isFound("ObjetType", "WHERE nom_objet_type='" + typeproduit + "'")) {
                        ObjetType type_objet = (ObjetType) ModelBean.GetContentTable("ObjetType", "WHERE nom_objet_type='" + typeproduit + "'").get(0);
                        idtype_objet = type_objet.getIdObjetType();
                    } else {
                        ObjetType nobj = new ObjetType(typeproduit, 0);
                        ModelBean.AddLine1(nobj, "ObjetType");
                        List<ObjetType> l = ModelBean.GetContentTable("ObjetType", "");
                        idtype_objet = l.get(l.size() - 1).getIdObjetType();

                    }

                    Objet obj = new Objet(idtype_objet, name, 0, s.get(0).getIdStructure(), 0, 0, 0, 0, 0);
                    ModelBean.AddLine1(obj, "Objet");
                    List<Objet> listObjet = ModelBean.GetContentTable("Objet", "");
                    // public Produit(int idObjet, String matricule, String typeProduit, String marque, String modele, String designation, String nomProduit, String unite, double quantite, double utilise, double prix, String image, int isDeleted)
                    Produit p = new Produit(listObjet.get(listObjet.size() - 1).getIdObjet(), matr, typeproduit, marque, modele, des, name, "/", 0, 0, prix, savePath+ File.separator + fileName, 0);
                    ModelBean.AddLine1(p, "Produit");
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

                    new Gson().toJson(String.valueOf(List_Produit.get(List_Produit.size() - 1).getIdProduit() + 1), response.getWriter());

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
                produit.setImage(savePath+ File.separator + fileName);
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
                String name=new String(request.getParameter("Material").getBytes ("iso-8859-1"), "UTF-8");
               String desi=new String(request.getParameter("Designation").getBytes ("iso-8859-1"), "UTF-8");
                
                String matr=new String(request.getParameter("Matricule").getBytes ("iso-8859-1"), "UTF-8");
             
                 String type1=new String( request.getParameter("Type").getBytes ("iso-8859-1"), "UTF-8");
                
                 String marque=new String( request.getParameter("Marque").getBytes ("iso-8859-1"), "UTF-8");
             
                 String modele=new String(request.getParameter("Modele").getBytes ("iso-8859-1"), "UTF-8");
               
                 String str=new String(request.getParameter("Structure").getBytes ("iso-8859-1"), "UTF-8");
                
              
               
                
                
              
                
                
                
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

                        if (List_Produit.get(i).getNomProduit().equals(name)) {
                            result = "Nom est existe Deja";
                        }
                    }

                }
                if (result.equals("suc")) {
                    List<Structure> s = ModelBean.GetContentTable("Structure", "WHERE nom_structure='" + str + "'");

                    Objet obj = (Objet) ModelBean.GetContentTable("Objet", "WHERE id_objet=" + produit.getIdObjet()).get(0);
                    if (ModelBean.isFound("ObjetType", "WHERE nom_objet_type='" + type1 + "'")) {
                        ObjetType type_objet = (ObjetType) ModelBean.GetContentTable("ObjetType", "WHERE nom_objet_type='" + type1 + "'").get(0);
                        idtype_objet = type_objet.getIdObjetType();
                    } else {
                        ObjetType nobj = new ObjetType(type, 0);
                        ModelBean.AddLine1(nobj, "ObjetType");
                        List<ObjetType> l = ModelBean.GetContentTable("ObjetType", "");
                        idtype_objet = l.get(l.size() - 1).getIdObjetType();

                    }
                    obj.setTypeObjet(idtype_objet);
                    obj.setIdStructure(s.get(0).getIdStructure());
                    ModelBean.UpdateLine(obj, "Objet", String.valueOf(obj.getIdObjet()));
                    List<Objet> listobjet = ModelBean.GetContentTable("Objet", "");

                    produit.setDesignation(desi);
                    produit.setMarque(marque);
                    produit.setMatricule(matr);
                    produit.setModele(modele);
                    produit.setNomProduit(name);
                    produit.setIdObjet(listobjet.get(listobjet.size() - 1).getIdObjet());
                    produit.setTypeProduit(type1);
                    produit.setPrix(unite);
                    ModelBean.UpdateLine(produit, "Produit", String.valueOf(produit.getIdProduit()));

                }
                response.getWriter().print(result);
                return;

            }
            break;
            case "Projet":
                 type = request.getParameter("type");
                 if (type.equals("AddProjet")) {
                 
                     
                     

             
               
                String name=new String(request.getParameter("Nom").getBytes ("iso-8859-1"), "UTF-8");
               
              
               
                String name_structure=new String(request.getParameter("Structure").getBytes ("iso-8859-1"), "UTF-8");
                List<Projet> List_Projet = ModelBean.GetContentTable("Projet", "WHERE isDeleted=0");
                if(ModelBean.isFound("Projet","WHERE nom_projet='"+name+"' AND isDeleted=0 ")){
                    result="Cette est utilsé deja";
                    
                }else{
                    Structure structure=(Structure)ModelBean.GetContentTable("Structure", "WHERE nom_structure='"+name_structure+"'").get(0);
                    Projet projet=new Projet(structure.getIdStructure(),name,0);
                    ModelBean.AddLine1(projet,"Projet");
                    
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

                    new Gson().toJson(String.valueOf(List_Projet.get(List_Projet.size() - 1).getIdProjet()+ 1), response.getWriter());

                }
            }
                      if (type.equals("editProjet")) {
          
                
                
                
                
                int id = Integer.parseInt(request.getParameter("id"));
                String name=new String(request.getParameter("Nom").getBytes ("iso-8859-1"), "UTF-8");
                String name_structure=new String(request.getParameter("Structure").getBytes ("iso-8859-1"), "UTF-8");
                List<Projet> List_Projet = ModelBean.GetContentTable("Projet", "WHERE isDeleted=0");
                 
                for (int i = 0; i < List_Projet.size(); i++) {
                    if (!Objects.equals(List_Projet.get(i).getIdProjet(), id) && List_Projet.get(i).getIsDeleted() == 0) {
                        
                        if(List_Projet.get(i).getNomProjet().equals(name))
                            result="nom existe deja";
                        
                        
                    }
               
                }
                if(result.equals("suc")){
                     Structure structure=(Structure)ModelBean.GetContentTable("Structure", "WHERE nom_structure='"+name_structure+"'").get(0);
                    Projet Projet = (Projet)ModelBean.GetContentTable("Projet", "WHERE id_projet="+id).get(0);
                    Projet.setNomProjet(name);
                    Projet.setIdStructure(structure.getIdStructure());
                    ModelBean.UpdateLine(Projet,"Projet",String.valueOf(id));
                    
                }
              
               
                
                
    
                response.getWriter().print(result);
                return;

            }
                  if (type.equals("deleteProjet")) {

                int id = Integer.parseInt(request.getParameter("id"));
                Projet projet = (Projet) ModelBean.GetContentTable("Projet", "WHERE id_projet=" + id).get(0);
                
                ModelBean.DeleteLine(String.valueOf(id), "Projet");
             

            }     
                
                
                
                break;
                case "Structure":
                 type = request.getParameter("type");
                 if (type.equals("AddStructure")) {
                 
                     
                     

             
               
                String name=new String(request.getParameter("Nom_Structure").getBytes ("iso-8859-1"), "UTF-8");
                String code=new String(request.getParameter("Code").getBytes ("iso-8859-1"), "UTF-8");
              
               
              
                List<Structure> List_Structure = ModelBean.GetContentTable("Structure", "WHERE isDeleted=0");
                if(ModelBean.isFound("Structure","WHERE nom_structure='"+name+"' AND isDeleted=0")){
                    result="Cette Nom est utilsé deja";
                    
                }else{
                   
                    Structure newStructure=new Structure(name,code,0);
                    ModelBean.AddLine1(newStructure,"Structure");
                    
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

                    new Gson().toJson(String.valueOf(List_Structure.get(List_Structure.size() - 1).getIdStructure()+ 1), response.getWriter());

                }
            }
                      if (type.equals("editStructure")) {
          
                
                
                
                
                int id = Integer.parseInt(request.getParameter("id"));
                String name=new String(request.getParameter("Nom_Structure").getBytes ("iso-8859-1"), "UTF-8");
                String code=new String(request.getParameter("Code").getBytes ("iso-8859-1"), "UTF-8");
                List<Structure> List_Structure = ModelBean.GetContentTable("Structure", "WHERE isDeleted=0");
                 
                for (int i = 0; i < List_Structure.size(); i++) {
                    if (!Objects.equals(List_Structure.get(i).getIdStructure(), id) && List_Structure.get(i).getIsDeleted() == 0) {
                        
                        if(List_Structure.get(i).getNomStructure().equals(name))
                            result="nom existe deja";
                        
                        if(List_Structure.get(i).getCode().equals(code))
                            result="Code existe deja";
                        
                        
                    }
               
                }
                if(result.equals("suc")){
                    
                    Structure structure = (Structure)ModelBean.GetContentTable("Structure", "WHERE id_structure="+id).get(0);
                     structure.setCode(code);
                     structure.setNomStructure(name);
                    ModelBean.UpdateLine(structure,"Structure",String.valueOf(id));
                    
                }
              
               
                
                
    
                response.getWriter().print(result);
                return;

            }
                  if (type.equals("deleteStructure")) {

                int id = Integer.parseInt(request.getParameter("id"));
                ModelBean.DeleteLine(String.valueOf(id), "Structure");
             

            }     
                
                
                
                break;
                 case "ModeLivraison":
                 type = request.getParameter("type");
                 if (type.equals("AddModeLivraison")) {
                 
                String name=new String(request.getParameter("Mode_Livraison").getBytes ("iso-8859-1"), "UTF-8");
               
                if(ModelBean.isFound("ModeLivraison","WHERE nom_mode='"+name+"' AND isDeleted=0")){
                    result="Cette Model est utilsé deja";
                    
                }else{
                   
                   ModeLivraison ModeLivraison=new ModeLivraison(name,0);
                    ModelBean.AddLine1(ModeLivraison,"ModeLivraison");
                    
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

                    new Gson().toJson(String.valueOf(List_ModeLivraison.get(List_ModeLivraison.size() - 1).getIdModeL()+ 1), response.getWriter());

                }
            }
                      if (type.equals("editModeLivraison")) {
          
                
                
                
                
                int id = Integer.parseInt(request.getParameter("id"));
                String name=new String(request.getParameter("Mode_Livraison").getBytes ("iso-8859-1"), "UTF-8");
              
                List<ModeLivraison> List_ModeLivraison = ModelBean.GetContentTable("ModeLivraison", "WHERE isDeleted=0");
                 
                for (int i = 0; i < List_ModeLivraison.size(); i++) {
                    if (!Objects.equals(List_ModeLivraison.get(i).getIdModeL(), id) && List_ModeLivraison.get(i).getIsDeleted() == 0) {
                        
                        if(List_ModeLivraison.get(i).getNomMode().equals(name))
                            result="Model existe deja";
                       
                        
                        
                    }
               
                }
                if(result.equals("suc")){
                    
                     ModeLivraison modeLivre = (ModeLivraison)ModelBean.GetContentTable("ModeLivraison", "WHERE id_modeL="+id).get(0);
                     modeLivre.setNomMode(name);
                     ModelBean.UpdateLine(modeLivre,"ModeLivraison",String.valueOf(id));
                    
                }
              
               
                
                
    
                response.getWriter().print(result);
                return;

            }
                  if (type.equals("deleteModeLivraison")) {

                int id = Integer.parseInt(request.getParameter("id"));
                ModelBean.DeleteLine(String.valueOf(id), "ModeLivraison");
             

            }     
                
                
                
                break;
                case "ModeReglement":
                 type = request.getParameter("type");
                 if (type.equals("AddModeReglement")) {
                 
                String name=new String(request.getParameter("Mode_Reglement").getBytes ("iso-8859-1"), "UTF-8");
               
                if(ModelBean.isFound("ModeReglement","WHERE nom_mode='"+name+"' AND isDeleted=0")){
                    result="Cette Model est utilsé deja";
                    
                }else{
                   
                   ModeReglement mode_Reglement=new ModeReglement(name,0);
                    ModelBean.AddLine1(mode_Reglement,"ModeReglement");
                    
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

                    new Gson().toJson(String.valueOf(List_ModeReglement.get(List_ModeReglement.size() - 1).getIdModeR()+ 1), response.getWriter());

                }
            }
                      if (type.equals("editModeReglement")) {
          
                
                
                
                
                int id = Integer.parseInt(request.getParameter("id"));
                String name=new String(request.getParameter("Mode_Reglement").getBytes ("iso-8859-1"), "UTF-8");
              
                List<ModeReglement> List_ModeReglement = ModelBean.GetContentTable("ModeReglement", "WHERE isDeleted=0");
                 
                for (int i = 0; i < List_ModeReglement.size(); i++) {
                    if (!Objects.equals(List_ModeReglement.get(i).getIdModeR(), id) && List_ModeReglement.get(i).getIsDeleted() == 0) {
                        
                        if(List_ModeReglement.get(i).getNomMode().equals(name))
                            result="Model existe deja";
                       
                        
                        
                    }
               
                }
                if(result.equals("suc")){
                    
                     ModeReglement modeReglement = (ModeReglement)ModelBean.GetContentTable("ModeReglement", "WHERE id_modeR="+id).get(0);
                     modeReglement.setNomMode(name);
                     ModelBean.UpdateLine(modeReglement,"ModeReglement",String.valueOf(id));
                    
                }
              
               
                
                
    
                response.getWriter().print(result);
                return;

            }
                  if (type.equals("deleteModeReglement")) {

                int id = Integer.parseInt(request.getParameter("id"));
                ModelBean.DeleteLine(String.valueOf(id), "ModeReglement");
             

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
