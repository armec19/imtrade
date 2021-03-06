package maps;
// Generated 9 sept. 2020 14:35:48 by Hibernate Tools 4.3.1



/**
 * Produit generated by hbm2java
 */
public class Produit  implements java.io.Serializable {


     private Integer idProduit;
     private int idObjet;
     private String matricule;
     private String typeProduit;
     private String marque;
     private String modele;
     private String designation;
     private String nomProduit;
     private String unite;
     private double quantite;
     private double utilise;
     private double prix;
     private String image;
     private int isDeleted;

    public Produit() {
    }

    public Produit(int idObjet, String matricule, String typeProduit, String marque, String modele, String designation, String nomProduit, String unite, double quantite, double utilise, double prix, String image, int isDeleted) {
       this.idObjet = idObjet;
       this.matricule = matricule;
       this.typeProduit = typeProduit;
       this.marque = marque;
       this.modele = modele;
       this.designation = designation;
       this.nomProduit = nomProduit;
       this.unite = unite;
       this.quantite = quantite;
       this.utilise = utilise;
       this.prix = prix;
       this.image = image;
       this.isDeleted = isDeleted;
    }
   
    public Integer getIdProduit() {
        return this.idProduit;
    }
    
    public void setIdProduit(Integer idProduit) {
        this.idProduit = idProduit;
    }
    public int getIdObjet() {
        return this.idObjet;
    }
    
    public void setIdObjet(int idObjet) {
        this.idObjet = idObjet;
    }
    public String getMatricule() {
        return this.matricule;
    }
    
    public void setMatricule(String matricule) {
        this.matricule = matricule;
    }
    public String getTypeProduit() {
        return this.typeProduit;
    }
    
    public void setTypeProduit(String typeProduit) {
        this.typeProduit = typeProduit;
    }
    public String getMarque() {
        return this.marque;
    }
    
    public void setMarque(String marque) {
        this.marque = marque;
    }
    public String getModele() {
        return this.modele;
    }
    
    public void setModele(String modele) {
        this.modele = modele;
    }
    public String getDesignation() {
        return this.designation;
    }
    
    public void setDesignation(String designation) {
        this.designation = designation;
    }
    public String getNomProduit() {
        return this.nomProduit;
    }
    
    public void setNomProduit(String nomProduit) {
        this.nomProduit = nomProduit;
    }
    public String getUnite() {
        return this.unite;
    }
    
    public void setUnite(String unite) {
        this.unite = unite;
    }
    public double getQuantite() {
        return this.quantite;
    }
    
    public void setQuantite(double quantite) {
        this.quantite = quantite;
    }
    public double getUtilise() {
        return this.utilise;
    }
    
    public void setUtilise(double utilise) {
        this.utilise = utilise;
    }
    public double getPrix() {
        return this.prix;
    }
    
    public void setPrix(double prix) {
        this.prix = prix;
    }
    public String getImage() {
        return this.image;
    }
    
    public void setImage(String image) {
        this.image = image;
    }
    public int getIsDeleted() {
        return this.isDeleted;
    }
    
    public void setIsDeleted(int isDeleted) {
        this.isDeleted = isDeleted;
    }




}


