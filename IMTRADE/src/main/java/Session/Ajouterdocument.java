package Session;

import Classes.FileUpload;

import static Session.Content.progression_av;
import static Session.Content.progression_ap;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.time.LocalDateTime;
import java.util.AbstractList;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import maps.Document;
import maps.Structure;
import maps.StructureDetails;
import maps.TypeAttachment;
import module.ModelBean;

public class Ajouterdocument extends HttpServlet {

    PrintWriter out;
    public static List<String> progression = new ArrayList<>();
    OutputStream outputStream = null;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        out = response.getWriter();

        if (request.getRequestURI().equals("/IMTRADE/Ajouterdocument") && !request.getMethod().equals("GET")) {
            if (request.getParameter("txt1") != null) {
                Structure structure = (Structure) session.getAttribute("Structure");
                StructureDetails structureDetails = (StructureDetails) session.getAttribute("StructureDetails");

                if (request.getParameter("txt1").equals(structure.getNomStructure())) {
                    if (request.getParameter("txt2").equals(structureDetails.getCapital())
                            && request.getParameter("txt3").equals(structureDetails.getAdresse())
                            && request.getParameter("txt4").equals(structureDetails.getRc())
                            && request.getParameter("txt5").equals(structureDetails.getNif())
                            && request.getParameter("txt6").equals(structureDetails.getNis())
                            && request.getParameter("txt7").equals(structureDetails.getArt())
                            && request.getParameter("txt8").equals(structureDetails.getRib())
                            && request.getParameter("txt9").equals(structureDetails.getBanque())
                            && request.getParameter("txt10").equals(structureDetails.getSite())
                            && request.getParameter("txt11").equals(structureDetails.getContact())) {
                        out.print("oui");
                    } else {

                        StructureDetails structureDetail = new StructureDetails();
                        structureDetail.setIdStructure(structureDetails.getIdStructure());
                        structureDetail.setCapital(request.getParameter("txt2"));
                        structureDetail.setAdresse(request.getParameter("txt3"));
                        structureDetail.setRc(request.getParameter("txt4"));
                        structureDetail.setNif(request.getParameter("txt5"));
                        structureDetail.setNis(request.getParameter("txt6"));
                        structureDetail.setArt(request.getParameter("txt7"));
                        structureDetail.setRib(request.getParameter("txt8"));
                        structureDetail.setBanque(request.getParameter("txt9"));
                        structureDetail.setSite(request.getParameter("txt10"));
                        structureDetail.setContact(request.getParameter("txt11"));
                        structureDetail.setIsDeleted(0);
                        //ModelBean.AddLine1(structureDetail, "StructureDetails");
                        ModelBean.UpdateLine(structureDetail,"StructureDetails",structureDetails.getIdStructureDetais()+"");
                        session.setAttribute("StructureDetails", structureDetail);

                        out.print("non");
                    }
                }
            }
            if (request.getParameter("fonction") != null) {
                Structure structure = (Structure) session.getAttribute("Structure");
                StructureDetails structureDetails = (StructureDetails) session.getAttribute("StructureDetails");
                if (request.getParameter("fonction").equals("creation")) {

                    HashMap<String, ArrayList<String>> ListSN = (HashMap<String, ArrayList<String>>) session.getAttribute("ListSN");
                    List<String[]> ListObject = (List<String[]>) session.getAttribute("ListObject");
                    List<String[]> ListFile_av = (List<String[]>) session.getAttribute("ListFile_av");
                    List<String[]> ListFile_ap = (List<String[]>) session.getAttribute("ListFile_ap");
                    
                    System.out.println("details");
                    for (Map.Entry me : ((HashMap<String, String>) session.getAttribute("hashMap")).entrySet()) {
                        System.out.println("Key: " + me.getKey() + " & Value: " + me.getValue().toString());    
                    }
                    Document newdoc=new Document();
                    /*newdoc.setCommentaire(commentaire);
                    newdoc.setDateCreation(dateCreation);
                    newdoc.setNRef(NRef);
                    newdoc.setIsDeleted(0);
                    newdoc.setIdTypeDoc(0);
                    newdoc.setIdType(0);
                    newdoc.setNAgrement(NAgrement);
                    newdoc.setLink(link);
                    newdoc.setCode(code);
                    newdoc.setIdStructure(0);
                    newdoc.setIdProjet(0);
                    newdoc.setIdDocument(Integer.MIN_VALUE);
                    newdoc.setDateEcheance(dateEcheance);
                    newdoc.setDateValidation(dateValidation);
                    newdoc.setIdDestinataire(0);
                    newdoc.setIdDesignation(0);
                    newdoc.setDocumentEtat(documentEtat);
                    newdoc.set*/
                   
                    
                    

                    System.out.println("ListObject");
                    for (int i = 0; i < ListObject.size(); i++) {
                        String[] get = ListObject.get(i);
                        for (int j = 0; j < get.length; j++) {
                            String string = get[j];
                            System.out.println(string);
                        }
                    }
                    
                    System.out.println("ListFile_av");
                    for (int i = 0; i < ListFile_av.size(); i++) {
                        String[] get = ListFile_av.get(i);
                        for (int j = 0; j < get.length; j++) {
                            String string = get[j];
                            System.out.println(string);
                        }
                    }
                    
                    System.out.println("ListFile_ap");
                    for (int i = 0; i < ListFile_ap.size(); i++) {
                        String[] get = ListFile_ap.get(i);
                        for (int j = 0; j < get.length; j++) {
                            String string = get[j];
                            System.out.println(string);
                        }
                    }
                    
                    

                    System.out.println("ListSN");
                    for (Map.Entry me : ListSN.entrySet()) {
                        System.out.println("Key: " + me.getKey() + " & Value: ");
                        for (int i = 0; i < ((ArrayList<String>)me.getValue()).size(); i++) {
                            String get = ((ArrayList<String>)me.getValue()).get(i);
                            System.out.println(get);
                        }
                    }

                    HashMap<String, String> hashmap = ((HashMap<String, String>) session.getAttribute("hashMap"));
                    String where = "";
                    if (!hashmap.get("projet").equals("")) {
                        where = where + " and (idProjet=" + hashmap.get("projet") + " or idProjet=null) ";
                    }
                    if (!hashmap.get("nature").equals("")) {
                        where = where + " and (idNature=" + hashmap.get("nature") + " or idNature=null) ";
                    }
                    if (!hashmap.get("type").equals("")) {
                        where = where + " and (idType=" + hashmap.get("type") + " or idType=null) ";
                    }
                    if (!hashmap.get("designation").equals("")) {
                        where = where + " and (idDesignation=" + hashmap.get("designation") + " or idDesignation=null) ";
                    }

                    System.out.println("where isdeleted=0 " + where + " and idStructure=" + structure.getIdStructure());
                    List<TypeAttachment> tattap = ((List<TypeAttachment>) ModelBean.GetContentTable("TypeAttachment", "where isdeleted=0 " + where + " and idStructure=" + structure.getIdStructure()));

                    if (!tattap.isEmpty()) {
                        //tattap.

                    }

                    /*for (int i = 0; i < tattap.size(); i++) {
                        TypeAttachment get = tattap.get(i);
                        System.out.println(get.getNomAttachment());
                    }*/
                    //if
                    //liste docs selected
                    //contain all
                    //typeattachment
                    //complete the operation 
                    //else 
                    //show swip inserted doc and not inserted doc 
                    //
                    /*System.out.println("/////");
                    H
                    for (Map.Entry me : ((HashMap<String, String>) session.getAttribute("hashMap")).entrySet()) {
                        System.out.println("Key: " + me.getKey() + " & Value: " + me.getValue());
                    }
                    System.out.println("/////");*/
 /*System.out.println(session.getAttribute("TypeNature"));
                    System.out.println(session.getAttribute("DesignationNature"));
                    System.out.println(session.getAttribute("Destinateurselected"));
                    System.out.println(session.getAttribute("Projet"));*/
                }
                if (request.getParameter("fonction").equals("templated")) {

                }
            }
        }
    }

    public static String getSize(long size) {
        String s = "";
        double kb = size / 1024;
        double mb = kb / 1024;
        double gb = mb / 1024;
        double tb = gb / 1024;
        if (size < 1024L) {
            s = size + " Bytes";
        } else if (size >= 1024 && size < (1024L * 1024)) {
            s = String.format("%.2f", kb) + " KB";
        } else if (size >= (1024L * 1024) && size < (1024L * 1024 * 1024)) {
            s = String.format("%.2f", mb) + " MB";
        } else if (size >= (1024L * 1024 * 1024) && size < (1024L * 1024 * 1024 * 1024)) {
            s = String.format("%.2f", gb) + " GB";
        } else if (size >= (1024L * 1024 * 1024 * 1024)) {
            s = String.format("%.2f", tb) + " TB";
        }
        return s;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        out = response.getWriter();
        if (request.getParameter("pval1") != null) {
            if (((List<String>) session.getAttribute("progression_av")).isEmpty()) {
                ((List<String>) session.getAttribute("progression_av")).add("0");
                ((List<String>) session.getAttribute("progression_av")).add("0");
                ((List<String>) session.getAttribute("progression_av")).add("0");
            }
            //System.out.println(progression_av.get(0)+"%"+progression_av.get(1)+"%"+progression_av.get(2));
            out.print(((List<String>) session.getAttribute("progression_av")).get(0) + "%" + ((List<String>) session.getAttribute("progression_av")).get(1) + "%" + ((List<String>) session.getAttribute("progression_av")).get(2));
            ((List<String>) session.getAttribute("progression_av")).clear();
            session.setAttribute("progression_av", ((List<String>) session.getAttribute("progression_av")));
        }
        if (request.getParameter("pval2") != null) {

            if (((List<String>) session.getAttribute("progression_ap")).isEmpty()) {
                ((List<String>) session.getAttribute("progression_ap")).add("0");
                ((List<String>) session.getAttribute("progression_ap")).add("0");
                ((List<String>) session.getAttribute("progression_ap")).add("0");
            }

            out.print(((List<String>) session.getAttribute("progression_ap")).get(0) + "%" + ((List<String>) session.getAttribute("progression_ap")).get(1) + "%" + ((List<String>) session.getAttribute("progression_ap")).get(2));
            ((List<String>) session.getAttribute("progression_ap")).clear();

        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
