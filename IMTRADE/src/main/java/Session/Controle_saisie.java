/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Session;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import maps.Destinateur;
import maps.Objet;
import maps.ObjetType;
import maps.Produit;
import maps.Projet;
import maps.Structure;
import maps.TypeAttachment;
import module.ModelBean;

/**
 *
 * @author Mechri
 */
public class Controle_saisie extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        
        if (request.getRequestURI().equals("/IMTRADE/Controle_saisie") && !request.getMethod().equals("GET")) {
            try {
                Structure structure = (Structure) session.getAttribute("Structure");
                /*if (request.getParameter("table") != null) {
                    String table=request.getParameter("table");
                    switch (table){
                        //*Utilisateur TypeNature TypeAttachment *Structure *Projet 
                        //DesignationNature *Destinateur *Doctype *Membre *ModeLivraison 
                        //*ModeReglement *Nature *Notification *Produit 
                        case "Produit":
                            break; 
                    }
                }*/
                if (request.getParameter("article") != null) {
                    if (request.getParameter("article").equals("typeattachav")) {
                        List<TypeAttachment> tattap = ((List<TypeAttachment>) ModelBean.GetContentTable("TypeAttachment", "where isdeleted=0 and situationAttachment='"+request.getParameter("article")+"' and idStructure="+structure.getIdStructure()));
                         for (int i = 0; i < tattap.size(); i++) {
                                    TypeAttachment get = tattap.get(i);
                                    out.print(get.getNomAttachment()+ "%%");
                                }
                        
                    }
                    if (request.getParameter("article").equals("typeproductarticle")) {
                        List<ObjetType> lobjett = ((List<ObjetType>) ModelBean.GetContentTable("ObjetType", "where isdeleted=0 and nomObjetType ='" + request.getParameter("type") + "'"));
                        //product  
                        if (!lobjett.isEmpty()) {
                            List<Objet> lobjet = ((List<Objet>) ModelBean.GetContentTable("Objet", "where isdeleted=0 and nomObjet='"+request.getParameter("product")+"' and typeObjet=" + lobjett.get(0).getIdObjetType()));
                            if (!lobjet.isEmpty()) {
                                out.print("yes");
                            }else{
                                out.print("no");
                            }
                        } else {
                            out.print("no");
                        }

                    }
                    if (request.getParameter("article").equals("typearticle")) {
                        if (request.getParameter("param").equals("équipement")) {
                            
                            List<ObjetType> lobjett = ((List<ObjetType>) ModelBean.GetContentTable("ObjetType", "where isdeleted=0 and nomObjetType like '%" + request.getParameter("param") + "%'"));

                            if (!lobjett.isEmpty()) {
                                List<Objet> lobjet = ((List<Objet>) ModelBean.GetContentTable("Objet", "where isdeleted=0 and typeObjet=" + lobjett.get(0).getIdObjetType()));
                                for (int i = 0; i < lobjet.size(); i++) {
                                    Objet get = lobjet.get(i);
                                    out.print(get.getNomObjet() + "%%");
                                }
                            } else {
                                List<Objet> lobjet = ((List<Objet>) ModelBean.GetContentTable("Objet", "where isdeleted=0 "));
                                for (int i = 0; i < lobjet.size(); i++) {
                                    Objet get = lobjet.get(i);
                                    out.print(get.getNomObjet() + "%%");
                                }
                            }

                        }
                    }
                    if (request.getParameter("article").equals("productarticle")) {

                        List<Objet> lobjet = ((List<Objet>) ModelBean.GetContentTable("Objet", "where isdeleted=0 and nomObjet like '%" + request.getParameter("param") + "%'"));

                        if (!lobjet.isEmpty()) {
                            List<ObjetType> lobjett = ((List<ObjetType>) ModelBean.GetContentTable("ObjetType", "where isdeleted=0 and idObjetType=" + lobjet.get(0).getTypeObjet()));
                            out.print(lobjett.get(0).getNomObjetType() + "%%" + lobjet.get(0).getPu());
                            List<Produit> lproduit = ((List<Produit>) ModelBean.GetContentTable("Produit", "where isdeleted=0 and idObjet=" + lobjet.get(0).getIdObjet()));
                            if (!lproduit.isEmpty()){
                                out.print("%%"+lproduit.get(0).getUnite());
                            }
                        } else {
                            out.print("%%%%");
                        }
                    }
                    if (request.getParameter("avarticle").equals("interne")) {

                    }
                }
            } catch (Exception e) {
                //e.printStackTrace();
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
