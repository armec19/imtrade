/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Session;

import Classes.Model;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import maps.Membre;
import maps.Structure;
import maps.StructureDetails;
import maps.Utilisateur;
import module.ModelBean;

/**
 *
 * @author Mechri
 */
public class AccountManager extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        try {

            if (request.getMethod().equals("GET")) {
                if ((request.getParameter("Email") != null) && (request.getParameter("Hashuser") != null)) {
                    String email = (String) request.getParameter("Email");
                    String hash = (String) request.getParameter("Hashuser");
                    List<Utilisateur> lutilisateur = (List<Utilisateur>) ModelBean.GetContentTable("Utilisateur", "where isDeleted=0 and username='" + email + "' and hash='" + hash + "'");

                    if (lutilisateur.isEmpty()) {
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    } else {
                        request.setAttribute("mail", email);
                    }
                }
            }
            if (request.getRequestURI().equals("/IMTRADE/AccountManager") && !request.getMethod().equals("GET")) {
                if (request.getParameter("type") != null) {

                    if (request.getParameter("type").equals("login")) {
                        //out.print(request.getParameter("userparam") + " " + request.getParameter("passparam"));
                        String email = (String) request.getParameter("userparam");
                        String hash = (String) request.getParameter("passparam");
                        hash = Model.gethash(hash);
                        List<Utilisateur> lutilisateur = (List<Utilisateur>) ModelBean.GetContentTable("Utilisateur", "where isDeleted=0 and username='" + email + "' and hash='" + hash + "'");
                        System.out.println(lutilisateur.size());
                        out.print(lutilisateur.size());
                        if (!lutilisateur.isEmpty()) {
                            /*Cookie cookie = new Cookie("Utilisateur", lutilisateur.get(0).getIdUtilisateur() + "");
                        cookie.setMaxAge(60*60*24*356);
                        
                        // Add both the cookies in the response header.
                        response.addCookie(cookie);*/
                            session.setAttribute("Selectedpage", "Main.jsp");
                            session.setAttribute("Utilisateur", lutilisateur.get(0));
                            List<Membre> lMembre = (List<Membre>) ModelBean.GetContentTable("Membre", "where isDeleted=0 and idMembre=" + lutilisateur.get(0).getIdMembre());
                            session.setAttribute("Membre", lMembre.get(0));

                            List<Structure> lstructure = (List<Structure>) ModelBean.GetContentTable("Structure", "where isDeleted=0 and idStructure=" + lutilisateur.get(0).getIdStructure());
                            session.setAttribute("Structure", lstructure.get(0));

                            List<StructureDetails> lstructureDetails = (List<StructureDetails>) ModelBean.GetContentTable("StructureDetails", "where isDeleted=0 and idStructure=" + lutilisateur.get(0).getIdStructure());
                            session.setAttribute("StructureDetails", lstructureDetails.get(0));

                            session.setAttribute("pageindex", "Main.jsp");
                            session.setAttribute("islocked", "false");
                        }
                    }

                    if (request.getParameter("type").equals("reset")) {
                        String email = (String) request.getParameter("mail");
                        String hash = (String) request.getParameter("hash");
                        String pass = (String) request.getParameter("password");
                        List<Utilisateur> lutilisateur = (List<Utilisateur>) ModelBean.GetContentTable("Utilisateur", "where isDeleted=0 and username='" + email + "' and hash='" + hash + "'");
                        Utilisateur utilisateur = lutilisateur.get(0);
                        String id = utilisateur.getIdUtilisateur() + "";
                        utilisateur.setPassword(pass);
                        utilisateur.setHash(Model.gethash(pass));
                        ModelBean.UpdateLine(utilisateur, "Utilisateur", id);
                    }

                    if (request.getParameter("type").equals("logout")) {
                        session.invalidate();
                        response.sendRedirect("login.jsp");

                    }
                    if (request.getParameter("type").equals("recouver")) {
                        //out.print(request.getParameter("mailparam"));
                        String email = (String) request.getParameter("mailparam");

                        List<Utilisateur> lutilisateur = (List<Utilisateur>) ModelBean.GetContentTable("Utilisateur", "where username='" + email + "'");
                        System.out.println(lutilisateur.size());
                        if (lutilisateur.isEmpty()) {
                            out.print("empty");
                        } else {
                            session.setAttribute("mailparam", email);

                            boolean sended = Model.SendMail("a.mechri@imtrade-dz.com", "Changer le mot de passe de l'utilisateur", "\nVotre demande est bien reçue.\n\n\nVeuillez consulter ce lien pour obtenir un nouveau mot de passe : \n\nhttp://localhost:8080/IMTRADE/change_pswd.jsp?Email=" + lutilisateur.get(0).getUsername() + "&Hashuser=" + lutilisateur.get(0).getHash());
                            if (sended == false) {
                                out.print(sended);
                            } else {
                                out.print(email);
                            }

                            //request.setAttribute("mailrecouver", lutilisateur.get(0).getUsername());
                            //response.sendRedirect("change_pswd.jsp");
                        }
                    }
                    if (request.getParameter("type").equals("unlock")) {
                        String hash = Model.gethash(request.getParameter("passparam"));
                        Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur");
                        //System.out.println(hash);
                        //System.out.println(utilisateur.getHash());
                        if (hash.equals(utilisateur.getHash())) {
                            session.setAttribute("islocked", "false");
                            out.print("1");
                        } else {
                            out.print("0");
                        }

                    }
                    if (request.getParameter("type").equals("lock")) {
                        session.setAttribute("islocked", "true");
                    }
                }

            }
        } catch (Exception e) {
            response.sendRedirect("Error/500.jsp");
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
