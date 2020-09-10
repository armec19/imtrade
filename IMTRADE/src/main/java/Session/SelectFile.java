/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Session;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import maps.DesignationNature;
import maps.Destinateur;
import maps.DocObjet;
import maps.DocObjetSn;
import maps.Objet;
import maps.Doctype;
import maps.Document;
import maps.Membre;
import maps.Nature;
import maps.Objet;
import maps.Projet;
import maps.Structure;
import maps.TemplateDocument;
import maps.TypeNature;
import maps.Utilisateur;
import module.ModelBean;

/**
 *
 * @author Mechri
 */
public class SelectFile extends HttpServlet {

    final HashMap<String, String> hashMap = new HashMap<>();

    void creation() {

        hashMap.put("num", "--");
        hashMap.put("dated", "--/--/----");
        hashMap.put("datef", "");
        hashMap.put("projet", "");
        hashMap.put("nature", "");
        hashMap.put("type", "");
        hashMap.put("designation", "");
        hashMap.put("demandeur", "");
        hashMap.put("%t", "");
        hashMap.put("tva", "");
        hashMap.put("%r", "");
        hashMap.put("remise", "");
        hashMap.put("timbre", "");
        hashMap.put("totalht", "");
        hashMap.put("totalttc", "");
        hashMap.put("ouvert", "");
        hashMap.put("montant", "");
        hashMap.put("destinateur", "Doit à:");
        hashMap.put("destinateurid", "");
        hashMap.put("adr", "");
        hashMap.put("email", "");
        hashMap.put("fax", "");
        hashMap.put("phone", "");
        hashMap.put("rc", "");
        hashMap.put("agrr", "");
        hashMap.put("nif", "");
        hashMap.put("ai", "");

        hashMap.put("docpath", "");

        //hashMap.put("Ref", "DA/564/ITNE/20");
        hashMap.put("Ref", "");

        hashMap.put("qrcode", "");

        hashMap.put("cond1", "non");
        hashMap.put("cond2", "non");
        hashMap.put("cond3", "non");
        hashMap.put("cond4", "non");
        hashMap.put("cond5", "non");
        session.setAttribute("hashMap", hashMap);
        session.setAttribute("ListObject", new ArrayList<String[]>());

    }
    HttpSession session = null;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        session = request.getSession();
        creation();
        PrintWriter out = response.getWriter();
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur");
        //System.out.println(request.getRequestURI());

        if (request.getRequestURI().equals("/IMTRADE/Account/index.jsp")) {
            //if (session.getAttribute("type").equals("listtemplate")) {
            session.setAttribute("type", "listtemplate");
            if (session.getAttribute("type").equals("listtemplate")) {
                session.setAttribute("doctype", (ArrayList<Doctype>) ModelBean.GetContentTable("Doctype", "where isDeleted=0 order by nomDocument"));
                HashMap<String, ArrayList<String>> templates = new HashMap<>();
                ArrayList<String> t = new ArrayList<>();

                List<Document> document = (List<Document>) ModelBean.GetContentTable("Document", "where isDeleted=0 and idStructure=" + utilisateur.getIdStructure());

                templates.clear();

                for (int i = 0; i < document.size(); i++) {

                    t.clear();
                    Document get = document.get(i);

                    if (!((List<TemplateDocument>) ModelBean.GetContentTable("TemplateDocument", "where isDeleted=0 and idDocument=" + get.getIdDocument())).isEmpty() && !((List<Doctype>) ModelBean.GetContentTable("Doctype", "where isdeleted=0 and idDoctype=" + get.getIdTypeDoc())).isEmpty()) {
                        Doctype doctype = ((List<Doctype>) ModelBean.GetContentTable("Doctype", "where isdeleted=0 and idDoctype=" + get.getIdTypeDoc())).get(0);
                        TemplateDocument templateDocument = ((List<TemplateDocument>) ModelBean.GetContentTable("TemplateDocument", "where isDeleted=0 and idDocument=" + get.getIdDocument())).get(0);

                        if (templates.containsKey(doctype.getNomDocument())) {
                            //existing template type
                            ArrayList<String> tx = templates.get(doctype.getNomDocument());
                            tx.add(templateDocument.getIdTemplate() + "%%" + templateDocument.getNomTemplate());
                        } else {
                            //new template type
                            ArrayList<String> tx = new ArrayList<>();
                            tx.add(templateDocument.getIdTemplate() + "%%" + templateDocument.getNomTemplate());
                            templates.put(doctype.getNomDocument(), tx);
                        }

                    }
                }

                //System.out.println(templates.size());
                session.setAttribute("templates", templates);
            }
        }
        if (request.getRequestURI().equals("/IMTRADE/SelectFile") && !request.getMethod().equals("GET")) {
            try {

                if (request.getParameter("type") != null) {
                    if (request.getParameter("type").equals("selectfile")) {
                        session.setAttribute("New", "true");
                        String doc = (String) request.getParameter("idfile");
                        String doctype = doc.split("-")[0];
                        int docnum = Integer.parseInt(doc.split("-")[1]);
                        //System.out.println(docnum);
                        session.setAttribute(doc, out);

                        session.setAttribute("pagename", doctype);
                        session.setAttribute("Numtemplate", docnum);

                        //Document
                        session.setAttribute("docimtrade", null);
                        session.setAttribute("TemplateDocument", null);
                        session.setAttribute("Doctype", null);
                        session.setAttribute("Destinateurselected", null);
                        session.setAttribute("doccontents", null);
                        session.setAttribute("docsncontents", null);
                        //session.setAttribute("docObjet", null);
                        session.setAttribute("Nature", null);
                        session.setAttribute("TypeNature", null);
                        session.setAttribute("DesignationNature", null);
                        session.setAttribute("Destinateurselected", null);
                        session.setAttribute("Projet", null);
                        session.setAttribute("listenature", null);
                        session.setAttribute("listetype", null);
                        session.setAttribute("listedesignation", null);
                        
                        
                        Structure structure = (Structure) session.getAttribute("Structure");
                        List<Projet> projet = (List<Projet>) ModelBean.GetContentTable("Projet", "where isdeleted=0 and idStructure=" + structure.getIdStructure());
                        session.setAttribute("listeprojet", projet);
                        List<Destinateur> destinateur = (List<Destinateur>) ModelBean.GetContentTable("Destinateur", "where isdeleted=0 and idStructure=" + structure.getIdStructure());
                        session.setAttribute("listedestinateur", destinateur);

                        if (docnum > 0) {
                            session.setAttribute("New", "false");
                            //HashMap<String, String> docparams = new HashMap<>();
                            ArrayList<Objet> doccontents = new ArrayList<>();
                            ArrayList<DocObjetSn> docsncontents = new ArrayList<>();

                            TemplateDocument templateDocument1 = ((List<TemplateDocument>) ModelBean.GetContentTable("TemplateDocument", "where idTemplate=" + docnum)).get(0);
                            Document document1 = ((List<Document>) ModelBean.GetContentTable("Document", "where isDeleted=0 and idDocument=" + templateDocument1.getIdDocument())).get(0);
                            Doctype doctype1 = ((List<Doctype>) ModelBean.GetContentTable("Doctype", "where isdeleted=0 and idDoctype=" + document1.getIdTypeDoc())).get(0);

                            if (!((List<DocObjet>) ModelBean.GetContentTable("DocObjet", "where isdeleted=0 and idDocument=" + document1.getIdDocument())).isEmpty()) {
                                List<DocObjet> docObjet = (List<DocObjet>) ModelBean.GetContentTable("DocObjet", "where isdeleted=0 and idDocument=" + document1.getIdDocument());
                                //ListObject
                                session.setAttribute("docObjet", docObjet);

                                for (int i = 0; i < docObjet.size(); i++) {
                                    DocObjet get = docObjet.get(i);

                                    Objet objet1 = ((List<Objet>) ModelBean.GetContentTable("Objet", "where isdeleted=0 and idObjet=" + get.getIdObject())).get(0);
                                    doccontents.add(objet1);
                                    //System.out.println(((List<DocObjetSn>) ModelBean.GetContentTable("DocObjetSn", "where isdeleted=0 and idDocObjet=" + get.getIdDocObjet())).size());
                                    List<DocObjetSn> docObjetSn = (List<DocObjetSn>) ModelBean.GetContentTable("DocObjetSn", "where isdeleted=0 and idDocObjet=" + get.getIdDocObjet());
                                    if (!docObjetSn.isEmpty()) {
                                        docsncontents.addAll(docObjetSn);
                                    }
                                    //session.setAttribute("Destinateur", destinateur1);
                                    /*if(doccontents.contains(objet1.getTypeObjet()+" "+objet1.getNomObjet()+" "+objet1.getPu())){                                        
                                        doccontents.add(objet1.getTypeObjet()+" "+objet1.getNomObjet()+" "+objet1.getPu());
                                    }*/
                                }

                            }

                            if (!((List<Destinateur>) ModelBean.GetContentTable("Destinateur", "where isdeleted=0 and idDestinateur=" + document1.getIdDestinataire())).isEmpty()) {
                                Destinateur destinateur1 = ((List<Destinateur>) ModelBean.GetContentTable("Destinateur", "where isdeleted=0 and idDestinateur=" + document1.getIdDestinataire())).get(0);
                                //session.setAttribute("Destinateur", destinateur1);
                                session.setAttribute("Destinateurselected", destinateur1);
                                System.out.println("oui");
                            } else {
                                System.out.println("non");
                            }
                            if (!((List<Projet>) ModelBean.GetContentTable("Projet", "where isdeleted=0 and idProjet=" + document1.getIdProjet())).isEmpty()) {
                                Projet projet1 = (((List<Projet>) ModelBean.GetContentTable("Projet", "where isdeleted=0 and idProjet=" + document1.getIdProjet()))).get(0);
                                //docparams.put("prjnom", projet1.getNomProjet());
                                session.setAttribute("Projet", projet1);

                                List<Nature> nature = (List<Nature>) ModelBean.GetContentTable("Nature", "where isdeleted=0 and idProjet=" + projet1.getIdProjet());
                                List<TypeNature> type1 = new ArrayList<>();
                                List<DesignationNature> designation1 = new ArrayList<>();
                                for (int i = 0; i < nature.size(); i++) {
                                    Nature get = nature.get(i);
                                    type1.addAll((List<TypeNature>) ModelBean.GetContentTable("TypeNature", "where isdeleted=0 and idNature=" + get.getIdNature()));
                                    designation1.addAll((List<DesignationNature>) ModelBean.GetContentTable("DesignationNature", "where isdeleted=0 and idNature=" + get.getIdNature()));
                                }

                                session.setAttribute("listenature", nature);
                                session.setAttribute("listetype", type1);
                                session.setAttribute("listedesignation", designation1);

                            }

                            if (!((List<Nature>) ModelBean.GetContentTable("Nature", "where isdeleted=0 and idNature=" + document1.getIdNature())).isEmpty()) {
                                Nature nature1 = (((List<Nature>) ModelBean.GetContentTable("Nature", "where isdeleted=0 and idNature=" + document1.getIdNature()))).get(0);
                                //docparams.put("naturenom", nature1.getNomNature());
                                session.setAttribute("Nature", nature1);

                            }

                            if (!((List<TypeNature>) ModelBean.GetContentTable("TypeNature", "where isdeleted=0 and idType=" + document1.getIdNature())).isEmpty()) {
                                TypeNature type1 = (((List<TypeNature>) ModelBean.GetContentTable("TypeNature", "where isdeleted=0 and idType=" + document1.getIdType()))).get(0);
                                //docparams.put("typenom", type1.getNomType());
                                session.setAttribute("TypeNature", type1);
                            }

                            if (!((List<DesignationNature>) ModelBean.GetContentTable("DesignationNature", "where isdeleted=0 and idDes=" + document1.getIdNature())).isEmpty()) {
                                DesignationNature designation1 = (((List<DesignationNature>) ModelBean.GetContentTable("DesignationNature", "where isdeleted=0 and idDes=" + document1.getIdDesignation()))).get(0);
                                //docparams.put("designationnom", designation1.getNomDes());
                                session.setAttribute("DesignationNature", designation1);
                            }

                            session.setAttribute("TemplateDocument", templateDocument1);
                            session.setAttribute("Doctype", doctype1);
                            //session.setAttribute("docparams", docparams);
                            session.setAttribute("docsncontents", docsncontents);
                            session.setAttribute("doccontents", doccontents);
                            session.setAttribute("docimtrade", document1);
                            //System.out.println(document1.getCommentaire());
                            //System.out.println(templateDocument.getNomTemplate());
                        } else {
                            Doctype doctype1 = ((List<Doctype>) ModelBean.GetContentTable("Doctype", "where isdeleted=0 and abbrev='" + doctype + "'")).get(0);
                            session.setAttribute("Doctype", doctype1);
                            /*Document ocu=(Document)ModelBean.Latest("Document","idDocument");
                            session.setAttribute("newcode", ocu);*/
                        }
                    }
                    if (request.getParameter("type").equals("selectpage")) {
                        session.setAttribute("Selectedpage", request.getParameter("page"));
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
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
        processRequest(request, response);
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
        processRequest(request, response);
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
