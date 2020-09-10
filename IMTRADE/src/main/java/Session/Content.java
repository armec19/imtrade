/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Session;

import Classes.FileUpload;

import com.mysql.jdbc.Blob;
import com.mysql.jdbc.BlobFromLocator;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.nio.channels.Channels;
import java.nio.channels.ReadableByteChannel;
import java.time.LocalDateTime;
import java.util.Iterator;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;

import java.awt.AlphaComposite;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.util.HashMap;
import java.util.Map;
import javax.imageio.ImageIO;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;
import maps.DesignationNature;
import maps.Destinateur;
import maps.DocObjet;
import maps.DocObjetSn;
import maps.Doctype;
import maps.Document;
import maps.Nature;
import maps.Objet;
import maps.ObjetType;
import maps.Structure;
import maps.TypeNature;
import maps.Utilisateur;
import maps.Serialnumber;
import module.ModelBean;

/**
 *
 * @author Mechri
 */
@MultipartConfig
public class Content extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    final List<String[]> ListObject = new ArrayList<String[]>();
    final HashMap<String, ArrayList<String>> ListSN = new HashMap<String, ArrayList<String>>();
    final List<String[]> ListFile_av = new ArrayList<String[]>();
    final List<String[]> ListFile_ap = new ArrayList<String[]>();

    final List<FileUpload> FileContent_av = new ArrayList<FileUpload>();
    final List<FileUpload> FileContent_ap = new ArrayList<FileUpload>();

    final HashMap<String, String> hashMap = new HashMap<>();
    final HashMap<String, String> File = new HashMap<>();

    final String tab[] = {"destinateur", "adr", "phone", "fax", "email", "registre", "agrement", "nif", "articlei"};
    final String txt = "Doit à : ";
    final int max = 35;

    String[] tableau;

    void creation() {
        ListObject.clear();
        ListSN.clear();
        ListFile_av.clear();
        ListFile_ap.clear();
        FileContent_av.clear();
        FileContent_ap.clear();
        progression_av.clear();
        progression_ap.clear();
        session.setAttribute("ListSN", ListSN);
        session.setAttribute("ListObject", ListObject);
        session.setAttribute("ListFile_av", ListFile_av);
        session.setAttribute("ListFile_ap", ListFile_ap);
        session.setAttribute("progression_av", progression_av);
        session.setAttribute("progression_ap", progression_ap);
        session.setAttribute("FileContent_av", FileContent_av);
        session.setAttribute("FileContent_ap", FileContent_ap);

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
        session.setAttribute("Destinateurselected", null);

    }

    static public boolean deleteDirectory(File path) {
        if (path.exists()) {
            File[] files = path.listFiles();
            for (int i = 0; i < files.length; i++) {
                if (files[i].isDirectory()) {
                    deleteDirectory(files[i]);
                } else {
                    files[i].delete();
                }
            }
        }
        return (path.delete());
    }

    public static boolean stringContainsItemFromList(String inputStr, String[] items) {
        return Arrays.stream(items).parallel().anyMatch(inputStr::contains); 
    }

    PrintWriter out;
    HttpSession session = null;
    public static List<String> progression_av = new ArrayList<>();
    public static List<String> progression_ap = new ArrayList<>();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        /*while (request.getParameterNames().hasMoreElements()) {
            System.out.print(request.getParameterNames().nextElement());
        }
        System.out.println();*/
        //System.out.println(request.getParameter("typeT"));
        boolean refrech = true;
        response.setContentType("text/html;charset=UTF-8");
        session = request.getSession();
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur");
        out = response.getWriter();

        String New = (String) session.getAttribute("New");
        Structure structure = (Structure) session.getAttribute("Structure");
        Doctype doctype = (Doctype) session.getAttribute("Doctype");
        //System.out.println(New);
        if (New.equals("true")) {
            String appPath = request.getServletContext().getRealPath("");

            String imagePath = appPath + "\\webfiles\\document\\" + utilisateur.getUsername() + "_" + utilisateur.getIdUtilisateur() + "_" + utilisateur.getIdMembre() + "\\" + doctype.getNomDocument() + "\\" + doctype.getAbbrev() + "\\" /*+ ((HashMap<String, String>) session.getAttribute("hashMap")).get("num")*/;
            //System.out.println(imagePath);
            File fileDir = new File(imagePath);
            //fileDir.delete();
            deleteDirectory(fileDir);
            creation();
            session.setAttribute("New", "false");
        }
        String path = request.getServletContext().getRealPath("");
        path += "\\dist";

        /*
        session.setAttribute("pagename", docType);
         */
        String num = "";
        //System.out.println(request.getRequestURI());
        if (request.getRequestURI().equals("/IMTRADE/Content") && !request.getMethod().equals("GET")) {
            try {

                /*if (request.getParameter("selectpage") != null) {
                    session.setAttribute("pagename", request.getParameter("selectpage"));
                }*/
                if (request.getParameter("Ftype") != null) {
                    if (request.getParameter("Ftype").equals("Add")) {
                        //Serialnumber Serialnumber = (Serialnumber) session.getAttribute("Doctype");
                        List<Serialnumber> serialnumber = (List<Serialnumber>) ModelBean.GetContentTable("Serialnumber", "where isdeleted=0 and sn='" + request.getParameter("SN") + "'");
                        //System.out.println("where isdeleted=0 and sn like '"++"'");
                        //System.out.println(serialnumber.size());

                        boolean testexisting = false;
                        if (doctype.getAbbrev().equals("BE") && serialnumber.size() > 0) {
                            out.print("est existé déjà");
                            testexisting = true;
                        }
                        if (!doctype.getAbbrev().equals("BE") && serialnumber.size() == 0) {
                            out.print("n'est pas existé");
                            testexisting = true;
                        }

                        //System.out.println(request.getParameter("product") + " " + request.getParameter("SN") + " " + request.getParameter("Ftype"));
                        if (testexisting == false) {

                            for (Map.Entry me : ((HashMap<String, ArrayList<String>>) session.getAttribute("ListSN")).entrySet()) {
                                for (int i = 0; i < ((ArrayList<String>) me.getValue()).size(); i++) {
                                    String get = ((ArrayList<String>) me.getValue()).get(i);
                                    if (get.equals(request.getParameter("SN"))) {
                                        testexisting = true;
                                        i = ((ArrayList<String>) me.getValue()).size();
                                    }
                                    //System.out.println(me.getKey()+" "+get+" "+testexisting);
                                }
                            }
                        }
                        if (testexisting == true) {
                            out.print("est existé déjà");
                        } else {
                            out.print("true");
                            if (((HashMap<String, ArrayList<String>>) session.getAttribute("ListSN")).containsKey(request.getParameter("product"))) {
                                (((HashMap<String, ArrayList<String>>) session.getAttribute("ListSN")).get(request.getParameter("product"))).add(request.getParameter("SN"));
                            } else {
                                ArrayList<String> choubir = new ArrayList<>();
                                choubir.add(request.getParameter("SN"));
                                ((HashMap<String, ArrayList<String>>) session.getAttribute("ListSN")).put(request.getParameter("product"), choubir);
                            }
                            //System.out.println((((HashMap<String, ArrayList<String>>) session.getAttribute("ListSN")).get(request.getParameter("product"))).size() + "  " + (((HashMap<String, ArrayList<String>>) session.getAttribute("ListSN")).get(request.getParameter("product"))));

                            //((HashMap<String, ArrayList<String>>) session.getAttribute("ListSN")).put(request.getParameter("product").,request.getParameter("SN"));
                        }

                    }
                    if (request.getParameter("Ftype").equals("delete")) {
                        (((HashMap<String, ArrayList<String>>) session.getAttribute("ListSN")).get(request.getParameter("product"))).remove(request.getParameter("SN"));
                        System.out.println((((HashMap<String, ArrayList<String>>) session.getAttribute("ListSN")).get(request.getParameter("product"))).size() + "  " + (((HashMap<String, ArrayList<String>>) session.getAttribute("ListSN")).get(request.getParameter("product"))));

                    }
                    refrech = false;
                    //((HashMap<String, String[]>) session.getAttribute("ListSN")).
                }

                if (request.getParameter("fileform") != null) {

                    session.setAttribute("New", "false");
                    String type = request.getParameter("fileform");

                    //Utilisateur utilisateur = new Utilisateur("1540", "ARMEC", "Abdo", "Mechri", "RS", "2");
                    //int docid = 1235468;
                    switch (type) {
                        case "Addtype1":

                            Part part = request.getPart("upfile1");
                            String[] tableau = {request.getParameter("typefileinput").trim(), request.getParameter("documentinput").trim(), getFileName(part)};
                            boolean include = false;

                            for (int i = 0; i < ((List<String[]>) session.getAttribute("ListFile_av")).size(); i++) {
                                String[] get = ((List<String[]>) session.getAttribute("ListFile_av")).get(i);
                                if (tableau[0].equals(get[0]) && tableau[1].equals(get[1])) {
                                    include = true;
                                    i = ((List<String[]>) session.getAttribute("ListFile_av")).size();
                                }
                            }

                            if (include == false) {
                                ((List<String>) session.getAttribute("progression_av")).clear();
                                double size = part.getSize();
                                String imageName = part.getSubmittedFileName();

                                if (validateImage(imageName)) {

                                    InputStream i = part.getInputStream();

                                    ((List<String[]>) session.getAttribute("ListFile_av")).add(tableau);
                                    ((List<FileUpload>) session.getAttribute("FileContent_av")).add(new FileUpload(tableau[1], tableau[0], size, i));
                                    session.setAttribute("ListFile_av", ((List<String[]>) session.getAttribute("ListFile_av")));

                                    String appPath = request.getServletContext().getRealPath("");

                                    String imagePath = appPath + "\\webfiles\\document";
                                    File fileDir = new File(imagePath);
                                    if (!fileDir.exists()) {
                                        fileDir.mkdirs();
                                    }
                                    imagePath = imagePath + "//" + utilisateur.getUsername() + "_" + utilisateur.getIdUtilisateur() + "_" + utilisateur.getIdMembre() + "//" + doctype.getNomDocument() + "//" + doctype.getAbbrev() /*+ ((HashMap<String, String>) session.getAttribute("hashMap")).get("num")*/ + "//creation";
                                    fileDir = new File(imagePath);
                                    if (!fileDir.exists()) {
                                        fileDir.mkdirs();
                                    }

                                    try {
                                        InputStream file = i;
                                        String time = LocalDateTime.now() + "";
                                        time = time.substring(0, 10) + " " + time.substring(11, 19);
                                        time = System.currentTimeMillis() + "";
                                        OutputStream outputStream = new FileOutputStream(new File(imagePath + "//" + tableau[1] + "_" + time + ".pdf"));
                                        int read = 0;
                                        final byte[] bytes = new byte[10240];
                                        int result = 0;

                                        while ((read = file.read(bytes)) != -1) {
                                            outputStream.write(bytes, 0, read);
                                            double newlength = new File(imagePath + "//" + tableau[1] + "_" + time + ".pdf").length();
                                            ((List<String>) session.getAttribute("progression_av")).clear();

                                            ((List<String>) session.getAttribute("progression_av")).add(0, "" + ((int) ((newlength / size) * 100)));
                                            ((List<String>) session.getAttribute("progression_av")).add(1, "" + getSize((long) size));
                                            ((List<String>) session.getAttribute("progression_av")).add(2, "" + getSize((long) newlength));

                                        }

                                        outputStream.close();
                                        file.close();

                                    } catch (FileNotFoundException fne) {
                                        out.print("<h1>" + fne.getMessage() + "</h1>");
                                    } catch (IOException ex) {
                                        out.print("<h1>" + ex.getMessage() + "</h1>");
                                    }

                                } else {
                                    out.print("<h1>Invalid file Format</h1>");
                                }
                            }
                            break;
                        case "deletetype1":
                            for (int i = 0; i < ((List<String[]>) session.getAttribute("ListFile_av")).size(); i++) {
                                String[] get = ((List<String[]>) session.getAttribute("ListFile_av")).get(i);
                                if (request.getParameter("typefileinput").trim().equals(get[0]) && request.getParameter("documentinput").trim().equals(get[1])) {
                                    ((List<String[]>) session.getAttribute("ListFile_av")).remove(i);
                                    ((List<FileUpload>) session.getAttribute("FileContent_av")).remove(i);
                                    i = ((List<String[]>) session.getAttribute("ListFile_av")).size();
                                    session.setAttribute("ListFile_av", ((List<String[]>) session.getAttribute("ListFile_av")));
                                }
                            }
                            break;

                        case "Addtype2":

                            Part part2 = request.getPart("upfile2");
                            String[] tableau2 = {request.getParameter("typefileinput").trim(), request.getParameter("documentinput").trim(), getFileName(part2)};
                            boolean include2 = false;

                            for (int i = 0; i < ((List<String[]>) session.getAttribute("ListFile_ap")).size(); i++) {
                                String[] get = ((List<String[]>) session.getAttribute("ListFile_ap")).get(i);
                                if (tableau2[0].equals(get[0]) && tableau2[1].equals(get[1])) {
                                    include2 = true;
                                    i = ((List<String[]>) session.getAttribute("ListFile_ap")).size();
                                }
                            }

                            double size2 = part2.getSize();

                            String imageName2 = part2.getSubmittedFileName();

                            if (include2 == false) {
                                ((List<String>) session.getAttribute("progression_ap")).clear();
                                double size = part2.getSize();

                                String imageName = part2.getSubmittedFileName();

                                if (validateImage(imageName)) {

                                    InputStream i = part2.getInputStream();
                                    ((List<String[]>) session.getAttribute("ListFile_ap")).add(tableau2);
                                    ((List<FileUpload>) session.getAttribute("FileContent_ap")).add(new FileUpload(tableau2[1], tableau2[0], size, i));
                                    session.setAttribute("ListFile_ap", ((List<String[]>) session.getAttribute("ListFile_ap")));
                                    String appPath = request.getServletContext().getRealPath("");
                                    String imagePath = appPath + "\\webfiles\\document";

                                    File fileDir = new File(imagePath);
                                    if (!fileDir.exists()) {
                                        fileDir.mkdirs();
                                    }
                                    imagePath = imagePath + "//" + utilisateur.getUsername() + "_" + utilisateur.getIdUtilisateur() + "_" + utilisateur.getIdMembre() + "//" + doctype.getNomDocument() + "//" + doctype.getAbbrev() /*+ ((HashMap<String, String>) session.getAttribute("hashMap")).get("num")*/ + "//confirmation";
                                    fileDir = new File(imagePath);
                                    if (!fileDir.exists()) {
                                        fileDir.mkdirs();
                                    }

                                    try {
                                        InputStream file = i;
                                        String time = LocalDateTime.now() + "";
                                        time = time.substring(0, 10) + " " + time.substring(11, 19);
                                        time = System.currentTimeMillis() + "";
                                        OutputStream outputStream = new FileOutputStream(new File(imagePath + "//" + tableau2[1] + "_" + time + ".pdf"));
                                        int read = 0;
                                        final byte[] bytes = new byte[10240];
                                        int result = 0;

                                        while ((read = file.read(bytes)) != -1) {
                                            outputStream.write(bytes, 0, read);

                                            double newlength = new File(imagePath + "//" + tableau2[1] + "_" + time + ".pdf").length();
                                            ((List<String>) session.getAttribute("progression_ap")).clear();
                                            ((List<String>) session.getAttribute("progression_ap")).add(0, "" + ((int) ((newlength / size) * 100)));
                                            ((List<String>) session.getAttribute("progression_ap")).add(1, "" + getSize((long) size));
                                            ((List<String>) session.getAttribute("progression_ap")).add(2, "" + getSize((long) newlength));
                                            //System.out.println("send : " + ((List<String>) session.getAttribute("progression_ap")));
                                        }

                                        outputStream.close();
                                        file.close();

                                    } catch (FileNotFoundException fne) {
                                        out.print("<h1>" + fne.getMessage() + "</h1>");
                                    } catch (IOException ex) {
                                        out.print("<h1>" + ex.getMessage() + "</h1>");
                                    }

                                } else {
                                    out.print("<h1>Invalid file Format</h1>");
                                }
                            }

                            break;

                        case "deletetype2":

                            for (int i = 0; i < ((List<String[]>) session.getAttribute("ListFile_ap")).size(); i++) {
                                String[] get = ((List<String[]>) session.getAttribute("ListFile_ap")).get(i);
                                if (request.getParameter("typefileinput").trim().equals(get[0]) && request.getParameter("documentinput").trim().equals(get[1])) {
                                    ((List<String[]>) session.getAttribute("ListFile_ap")).remove(i);
                                    ((List<FileUpload>) session.getAttribute("FileContent_ap")).remove(i);
                                    i = ((List<String[]>) session.getAttribute("ListFile_ap")).size();
                                    session.setAttribute("ListFile_ap", ((List<String[]>) session.getAttribute("ListFile_ap")));
                                }
                            }
                            break;
                    }

                    /*for (int i = 0; i < FileContent_ap.size(); i++) {
                        System.out.println(i + " ap " + ListFile_ap.get(i)[1] + " / " + FileContent_ap.get(i).name);
                    }
                    for (int i = 0; i < FileContent_av.size(); i++) {
                        System.out.println(i + " av " + ListFile_av.get(i)[1] + " / " + FileContent_av.get(i).name);
                    }*/
 /*
                    session.setAttribute("FileContent_av", FileContent_av);

                    session.setAttribute("FileContent_ap", FileContent_ap);
                     */
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            /*File Dir = new File(path);
            if (!Dir.exists()) {
                Dir.mkdirs();
            }*/
            if (request.getParameter("condition") != null && request.getParameter("param") != null) {
                session.setAttribute("New", "false");

                String param = request.getParameter("param").trim();
                String type = request.getParameter("condition").trim();

                //System.out.println(param+" "+);
                /*if ((type.equals("cond4") || type.equals("cond5")) && param.length()> 8) {
                    param=LocalDate.parse(param,
                            DateTimeFormatter.BASIC_ISO_DATE.ofPattern("uuuu-MM-dd", Locale.UK)).format(
                            DateTimeFormatter.ofPattern("dd/MM/uuuu", Locale.UK));
                }*/
                ((HashMap<String, String>) session.getAttribute("hashMap")).replace(type, param);

                /*if (hashMap.get("cond4")param.length() > 8) {
                    //System.out.println(hashMap.get("cond4"));
                    hashMap.replace("cond4", LocalDate.parse(hashMap.get("cond4"),
                            DateTimeFormatter.BASIC_ISO_DATE.ofPattern("uuuu-MM-dd", Locale.UK)).format(
                            DateTimeFormatter.ofPattern("dd/MM/uuuu", Locale.UK)));
                    //System.out.println(hashMap.get("cond4"));
                }
                if (hashMap.get("cond5").length() > 8) {
                    hashMap.replace("cond5", LocalDate.parse(hashMap.get("cond5"),
                            DateTimeFormatter.BASIC_ISO_DATE.ofPattern("uuuu-MM-dd", Locale.UK)).format(
                            DateTimeFormatter.ofPattern("dd/MM/uuuu", Locale.UK)));
                }*/
            }

            try {
                //qrcode//

                //**//
                if (request.getParameter("type") != null) {

                    session.setAttribute("New", "false");
                    String param = request.getParameter("param").trim();
                    String type = request.getParameter("type").trim();

                    switch (type) {
                        case "destinateur":

                            param = "Doit à : " + param;
                            String select1 = request.getParameter("id_selected").trim();
                            //System.out.println(select1);
                            Destinateur destinateur = (((List<Destinateur>) ModelBean.GetContentTable("Destinateur", "where isdeleted=0 and idDestinateur=" + select1))).get(0);
                            session.setAttribute("Destinateurselected", destinateur);
                            ((HashMap<String, String>) session.getAttribute("hashMap")).replace(type, param);
                            param = request.getParameter("id_selected").trim();
                            type = "destinateurid";
                            refrech = true;

                            break;
                        case "projet":
                            String select2 = request.getParameter("id_selected").trim();
                            List<Nature> nature = ((List<Nature>) ModelBean.GetContentTable("Nature", "where isdeleted=0 and idProjet=" + select2));
                            //docparams.put("naturenom", nature1.getNomNature());
                            session.setAttribute("Natureselected", nature);
                            out.print("<script>");
                            out.print("$(document).ready(function () {");
                            out.print("$('#dropdown-nature').html(\"\");");
                            out.print("$('#dropdown-type').html(\"\");");
                            out.print("$('#dropdown-designation').html(\"\");");
                            out.print("$('#nature_span').text(\"Select Nature\");");
                            out.print("$('#type_span').text(\"Select Type\");");
                            out.print("$('#designation_span').text(\"Select Designation\");");

                            for (int idx = 0; idx < nature.size(); idx++) {
                                Nature elem = nature.get(idx);
                                out.print("$('#dropdown-nature').html($('#dropdown-nature').html()+\"<li id='" + elem.getIdNature() + "'>" + elem.getNomNature() + "</li>\");");
                            }

                            out.print("$(\"#dropdown-nature li\").on(\"click\", function () {");

                            out.print("if ($(this).text().length > 0) {\n"
                                    + "                                               $('#dropdown-type').html(\"\");\n"
                                    + "                                               $('#dropdown-designation').html(\"\");\n"
                                    + "                                                $('#nature_span').removeAttr('class');\n"
                                    + "                                                $('#nature_span').addClass($(this).attr(\"id\"));\n"
                                    + "                                                $('#nature_span').text($(this).text());"
                                    + "                                                var id = $(this).attr(\"id\");\n"
                                    + "                                                $.ajax({\n"
                                    + "                                                    url: '/IMTRADE/Content',\n"
                                    + "                                                    method: \"POST\",\n"
                                    + "                                                    data: {\n"
                                    + "                                                        param: $(this).text(),\n"
                                    + "                                                        type: \"nature\",\n"
                                    + "                                                        id_selected: id\n"
                                    + "                                                    },\n"
                                    + "                                                    success: function (data) {\n"
                                    + "                                                        $('#scriptable').html(data);                         \n"
                                    + "                                                    }\n"
                                    + "                                                });\n"
                                    + "                                            }\n");
                            out.print("});");
                            out.print("});");
                            out.print("</script>");
                            refrech = false;
                            param = request.getParameter("id_selected").trim();
                            break;
                        case "nature":
                            String select3 = request.getParameter("id_selected").trim();
                            List<TypeNature> typeNature = ((List<TypeNature>) ModelBean.GetContentTable("TypeNature", "where isdeleted=0 and idNature=" + select3));
                            List<DesignationNature> designationNature = ((List<DesignationNature>) ModelBean.GetContentTable("DesignationNature", "where isdeleted=0 and idNature=" + select3));
                            //docparams.put("naturenom", nature1.getNomNature());
                            session.setAttribute("TypeNatureselected", typeNature);
                            session.setAttribute("DesignationNatureselected", designationNature);
                            List<Nature> naturev = (List<Nature>) session.getAttribute("Natureselected");

                            out.print("<script>");
                            out.print("$(document).ready(function () {");

                            out.print("$('#dropdown-type').html(\"\");");
                            out.print("$('#dropdown-designation').html(\"\");");
                            out.print("$('#type_span').text(\"Select Type\");");
                            out.print("$('#designation_span').text(\"Select Designation\");");

                            out.print("$('#dropdown-type').text(\"\");");
                            for (int idx = 0; idx < typeNature.size(); idx++) {
                                TypeNature elem = typeNature.get(idx);
                                out.print("$('#dropdown-type').html($('#dropdown-type').html()+\"<li id='" + elem.getIdType() + "'>" + elem.getNomType() + "</li>\");");
                            }
                            out.print("$('#dropdown-designation').html(\"\");");
                            for (int idx = 0; idx < designationNature.size(); idx++) {
                                DesignationNature elem = designationNature.get(idx);
                                out.print("$('#dropdown-designation').html($('#dropdown-designation').html()+\"<li id='" + elem.getIdDes() + "'>" + elem.getNomDes() + "</li>\");");
                            }

                            out.print("$(\"#dropdown-type li\").on(\"click\", function () {"
                                    + "if ($(this).text().length > 0) {\n"
                                    + "                                                $('#type_span').removeAttr('class');\n"
                                    + "                                                $('#type_span').addClass($(this).attr(\"id\"));\n"
                                    + "                                                $('#type_span').text($(this).text());"
                                    + "                                                var id = $(this).attr(\"id\");\n"
                                    + "                                                $.ajax({\n"
                                    + "                                                    url: '/IMTRADE/Content',\n"
                                    + "                                                    method: \"POST\",\n"
                                    + "                                                    data: {\n"
                                    + "                                                        param: $(this).text(),\n"
                                    + "                                                        type: \"type\",\n"
                                    + "                                                        id_selected: id\n"
                                    + "                                                    },\n"
                                    + "                                                    success: function (data) {\n"
                                    + "                                                    }\n"
                                    + "                                                });\n"
                                    + "                                            }\n"
                                    + "});");

                            out.print("$(\"#dropdown-designation li\").on(\"click\", function () {"
                                    + "if ($(this).text().length > 0) {\n"
                                    + "                                                $('#designation_span').removeAttr('class');\n"
                                    + "                                                $('#designation_span').addClass($(this).attr(\"id\"));\n"
                                    + "                                                $('#designation_span').text($(this).text());"
                                    + "                                                var id = $(this).attr(\"id\");\n"
                                    + "                                                $.ajax({\n"
                                    + "                                                    url: '/IMTRADE/Content',\n"
                                    + "                                                    method: \"POST\",\n"
                                    + "                                                    data: {\n"
                                    + "                                                        param: $(this).text(),\n"
                                    + "                                                        type: \"designation\",\n"
                                    + "                                                        id_selected: id\n"
                                    + "                                                    },\n"
                                    + "                                                    success: function (data) {\n"
                                    + "                                                    }\n"
                                    + "                                                });\n"
                                    + "                                            }\n"
                                    + "});");

                            out.print("});");
                            out.print("</script>");
                            refrech = false;
                            param = request.getParameter("id_selected").trim();
                            break;
                        //default:    
                        case "type":
                        case "designation":
                            refrech = false;
                            param = request.getParameter("id_selected").trim();
                        default:
                            refrech = true;
                    }

                    //System.out.println(type+" "+param);
                    ((HashMap<String, String>) session.getAttribute("hashMap")).replace(type, param);

                    if (((HashMap<String, String>) session.getAttribute("hashMap")).get("dated").length() > 8) {
                        ((HashMap<String, String>) session.getAttribute("hashMap")).replace("dated", LocalDate.parse(((HashMap<String, String>) session.getAttribute("hashMap")).get("dated"),
                                DateTimeFormatter.BASIC_ISO_DATE.ofPattern("uuuu-MM-dd", Locale.UK)).format(
                                DateTimeFormatter.ofPattern("dd/MM/uuuu", Locale.UK)));
                    }

                }

            } catch (Exception e) {

            }
            try {
                if (request.getParameter("typesn") != null) {
                    if ("addsn".equals(request.getParameter("typesn").trim())) {
                        //System.out.println("ddd");
                        String[] tableau = {request.getParameter("typee").trim(), request.getParameter("product").trim(),
                            request.getParameter("qty").trim(), request.getParameter("um").trim(), request.getParameter("cond").trim()};
                        //System.out.println(tableau);
                        /*or (int i = 0; i < tableau.length; i++) {
                            String string = tableau[i];
                            System.out.println(string);
                        }*/
                        boolean include = false;
                        for (int i = 0; i < ((List<String[]>) session.getAttribute("ListObject")).size(); i++) {
                            String[] get = ((List<String[]>) session.getAttribute("ListObject")).get(i);
                            if (tableau[0].equals(get[0]) && tableau[1].equals(get[1])) {
                                include = true;
                                i = ((List<String[]>) session.getAttribute("ListObject")).size();
                            }
                        }
                        if (include == false) {
                            ((List<String[]>) session.getAttribute("ListObject")).add(tableau);
                        }
                        /*for (int i = 0; i < ((List<String[]>) session.getAttribute("ListObject")).get(0).length; i++) {
                            String string = tableau[i];
                            System.out.println(string);
                        }*/
                    }

                    if ("deletesn".equals(request.getParameter("typesn").trim())) {
                        for (int i = 0; i < ((List<String[]>) session.getAttribute("ListObject")).size(); i++) {
                            String[] get = ((List<String[]>) session.getAttribute("ListObject")).get(i);
                            if (request.getParameter("typee").trim().equals(get[0]) && request.getParameter("product").trim().equals(get[1])) {
                                ((List<String[]>) session.getAttribute("ListObject")).remove(i);
                                i = ((List<String[]>) session.getAttribute("ListObject")).size();
                            }
                        }
                    }
                }
                if (request.getParameter("typeT") != null) {
                    if ("timbre".equals(request.getParameter("typeT").trim())) {
                        ((HashMap<String, String>) session.getAttribute("hashMap")).replace("timbre", request.getParameter("timbre").trim());
                    }

                    session.setAttribute("New", "false");
                    
                    if ("delete".equals(request.getParameter("typeT").trim())) {
                        int i=0;
                        for (; i < ((List<String[]>) session.getAttribute("ListObject")).size(); i++) {
                            String[] get = ((List<String[]>) session.getAttribute("ListObject")).get(i);
                            System.out.println(get[0]+" "+get[1]);
                            System.out.println(get[0].length()+" "+get[1].length());
                            System.out.println(request.getParameter("typee").trim()+" "+request.getParameter("product").trim());
                            System.out.println(request.getParameter("typee").trim().length()+" "+request.getParameter("product").trim().length());
                            if (request.getParameter("typee").trim().equals(get[0]) && request.getParameter("product").trim().equals(get[1])) {
                                ((List<String[]>) session.getAttribute("ListObject")).remove(i);
                                session.setAttribute("ListObject", ((List<String[]>) session.getAttribute("ListObject")));
                                //System.out.println("Yes");
                                
                                i = ((List<String[]>) session.getAttribute("ListObject")).size();
                            }
                            System.out.println(((List<String[]>) session.getAttribute("ListObject")).size());
                            System.out.println("--------------------");
                        }
                    }

                    if (!"tax".equals(request.getParameter("typeT").trim())) {
                        if (!request.getParameter("umcond").equals(null)) {
                            tableau = new String[6];
                            tableau[0] = request.getParameter("typee").trim();
                            tableau[1] = request.getParameter("product").trim();
                            tableau[2] = request.getParameter("umcond").trim();
                            tableau[3] = request.getParameter("qty").trim();
                            tableau[4] = request.getParameter("price").trim();
                            tableau[5] = request.getParameter("total").trim();
                            
                        } else {
                            tableau = new String[5];
                            tableau[0] = request.getParameter("typee").trim();
                            tableau[1] = request.getParameter("product").trim();
                            tableau[2] = request.getParameter("qty").trim();
                            tableau[3] = request.getParameter("price").trim();
                            tableau[4] = request.getParameter("total").trim();
                        }

                        boolean include = false;
                        for (int i = 0; i < ((List<String[]>) session.getAttribute("ListObject")).size(); i++) {
                            String[] get = ((List<String[]>) session.getAttribute("ListObject")).get(i);
                            if (tableau[0].equals(get[0]) && tableau[1].equals(get[1])) {
                                include = true;
                                i = ((List<String[]>) session.getAttribute("ListObject")).size();
                            }
                        }
                        if (include == false) {
                            ((List<String[]>) session.getAttribute("ListObject")).add(tableau);
                        }
                    }
                    
                    ((HashMap<String, String>) session.getAttribute("hashMap")).replace("%t", request.getParameter("pourcent").trim());
                    ((HashMap<String, String>) session.getAttribute("hashMap")).replace("tva", request.getParameter("tva").trim());
                    ((HashMap<String, String>) session.getAttribute("hashMap")).replace("%r", request.getParameter("pourcentr").trim());
                    ((HashMap<String, String>) session.getAttribute("hashMap")).replace("remise", request.getParameter("remise").trim());
                    ((HashMap<String, String>) session.getAttribute("hashMap")).replace("totalht", request.getParameter("totalht").trim());
                    ((HashMap<String, String>) session.getAttribute("hashMap")).replace("totalttc", request.getParameter("totalttc").trim());
                    ((HashMap<String, String>) session.getAttribute("hashMap")).replace("ouvert", request.getParameter("ouvert").trim());
                    ((HashMap<String, String>) session.getAttribute("hashMap")).replace("montant", request.getParameter("montant").trim());

                }
            } catch (Exception e) {
            }
        }
        if (session.getAttribute("doccontents") != null) {
            ArrayList<Objet> doccontents = (ArrayList<Objet>) session.getAttribute("doccontents");
            List<DocObjet> docObjets=(List<DocObjet>)session.getAttribute("docObjet");
            ArrayList<DocObjetSn> docsncontents = (ArrayList<DocObjetSn>) session.getAttribute("docsncontents");
            Document document = (Document) session.getAttribute("docimtrade");
            //System.out.println(document.getCommentaire());
            for (int idx = 0; idx < doccontents.size(); idx++) {
                Objet objet = doccontents.get(idx);
                ObjetType objetType = (((List<ObjetType>) ModelBean.GetContentTable("ObjetType", "where isdeleted=0 and idObjetType=" + objet.getTypeObjet()))).get(0);
                //DocObjetSn docObjetSn=docsncontents.get(idx);

                int count = ModelBean.getCount("DocObjetSn d1, DocObjet d2", "where d1.idDocObjet=d2.idDocObjet and d2.idObject=" + objet.getIdObjet() + " and d2.idDocument=" + document.getIdDocument());

                double pt = count * objet.getPu();

                String[] tableau = {objetType.getNomObjetType(), objet.getNomObjet(),docObjets.get(idx).getCond(),count + "", objet.getPu() + "", pt + ""};
                boolean include = false;
                for (int i = 0; i < ((List<String[]>) session.getAttribute("ListObject")).size(); i++) {
                    String[] get = ((List<String[]>) session.getAttribute("ListObject")).get(i);
                    if (tableau[0].equals(get[0]) && tableau[1].equals(get[1])) {
                        include = true;
                        i = ((List<String[]>) session.getAttribute("ListObject")).size();
                    }
                }
                if (include == false) {
                    ((List<String[]>) session.getAttribute("ListObject")).add(tableau);
                    
                }

            }
            session.setAttribute("doccontents",null);
        }

        Map hints = new HashMap();
        hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H);
        QRCodeWriter writer = new QRCodeWriter();
        BitMatrix bitMatrix = null;
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        if (!"".equals(((HashMap<String, String>) session.getAttribute("hashMap")).get("dated")) || !"".equals(((HashMap<String, String>) session.getAttribute("hashMap")).get("num"))) {
            num = ((HashMap<String, String>) session.getAttribute("hashMap")).get("num") + "." + structure.getCode() + ".";
            if (((HashMap<String, String>) session.getAttribute("hashMap")).get("dated").length() > 8) {
                num = num + ((HashMap<String, String>) session.getAttribute("hashMap")).get("dated").substring(0, 2);
                num = num + ((HashMap<String, String>) session.getAttribute("hashMap")).get("dated").substring(3, 5);
                num = num + ((HashMap<String, String>) session.getAttribute("hashMap")).get("dated").substring(8);
            }
        }

        ((HashMap<String, String>) session.getAttribute("hashMap")).replace("qrcode", doctype.getAbbrev() + "." + num);
        try {
            // Create a qr code with the url as content and a size of 250x250 px
            bitMatrix = writer.encode(((HashMap<String, String>) session.getAttribute("hashMap")).get("qrcode"), BarcodeFormat.QR_CODE, 250, 250, hints);
            MatrixToImageConfig config = new MatrixToImageConfig(MatrixToImageConfig.BLACK, MatrixToImageConfig.WHITE);
            // Load QR image
            BufferedImage qrImage = MatrixToImageWriter.toBufferedImage(bitMatrix, config);
            // Load logo image
            //System.out.println(path);
            File file = new File(path + "\\NONE.png");

            BufferedImage logoImage = ImageIO.read(file);
            // Calculate the delta height and width between QR code and logo
            int deltaHeight = qrImage.getHeight() - logoImage.getHeight();
            int deltaWidth = qrImage.getWidth() - logoImage.getWidth();
            // Initialize combined image
            BufferedImage combined = new BufferedImage(qrImage.getHeight(), qrImage.getWidth(), BufferedImage.TYPE_INT_ARGB);
            Graphics2D g = (Graphics2D) combined.getGraphics();
            // Write QR code to new image at position 0/0
            g.drawImage(qrImage, 0, 0, null);
            g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_OVER, 1f));
            // Write logo into combine image at position (deltaWidth / 2) and
            // (deltaHeight / 2). Background: Left/Right and Top/Bottom must be
            // the same space for the logo to be centered
            String appPath = request.getServletContext().getRealPath("");
            String imagePath = appPath + "\\webfiles\\document\\";

            File fileDir = new File(imagePath);
            if (!fileDir.exists()) {
                fileDir.mkdirs();
            }
            imagePath = imagePath + "\\" + utilisateur.getUsername() + "_" + utilisateur.getIdUtilisateur() + "_" + utilisateur.getIdMembre() + "\\" + doctype.getNomDocument() + "\\" + doctype.getAbbrev() /*+ ((HashMap<String, String>) session.getAttribute("hashMap")).get("num")*/;
            ((HashMap<String, String>) session.getAttribute("hashMap")).replace("docpath", "/" + utilisateur.getUsername() + "_" + utilisateur.getIdUtilisateur() + "_" + utilisateur.getIdMembre() + "/" + doctype.getNomDocument() + "/" + doctype.getAbbrev() /*+ ((HashMap<String, String>) session.getAttribute("hashMap")).get("num")*/);
            fileDir = new File(imagePath);
            if (!fileDir.exists()) {
                fileDir.mkdirs();
            }

            g.drawImage(logoImage, (int) Math.round(deltaWidth / 2), (int) Math.round(deltaHeight / 2), null);

            // Write combined image as PNG to OutputStream
            ImageIO.write(combined, "png", new File(imagePath + "\\Qrcode.png"));

        } catch (Exception e) {
            System.out.println(e);
        }

        session.setAttribute("ListObject", session.getAttribute("ListObject"));
        session.setAttribute("hashMap", session.getAttribute("hashMap"));
        if (refrech) {
            response.sendRedirect("Account/File/content.jsp");
        }

    }

    int f = 0;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        out = response.getWriter();

        //out.print(progression.get(0));
        //System.out.println(progression.get(0));
    }

    private boolean validateImage(String imageName) {
        String fileExt = imageName.substring(imageName.length() - 3);
        if ("pdf".equals(fileExt)) {
            return true;
        }
        return false;
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

    private String getFileName(final Part part) {
        final String partHeader = part.getHeader("content-disposition");
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(
                        content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

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
