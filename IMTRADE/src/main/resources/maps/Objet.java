package maps;
// Generated 9 sept. 2020 14:35:48 by Hibernate Tools 4.3.1



/**
 * Objet generated by hbm2java
 */
public class Objet  implements java.io.Serializable {


     private Integer idObjet;
     private int typeObjet;
     private String nomObjet;
     private double pu;
     private Integer idStructure;
     private Integer idProjet;
     private Integer idNature;
     private Integer idDesignationNature;
     private Integer idTypeNature;
     private int isDeleted;

    public Objet() {
    }

	
    public Objet(int typeObjet, String nomObjet, double pu, int isDeleted) {
        this.typeObjet = typeObjet;
        this.nomObjet = nomObjet;
        this.pu = pu;
        this.isDeleted = isDeleted;
    }
    public Objet(int typeObjet, String nomObjet, double pu, Integer idStructure, Integer idProjet, Integer idNature, Integer idDesignationNature, Integer idTypeNature, int isDeleted) {
       this.typeObjet = typeObjet;
       this.nomObjet = nomObjet;
       this.pu = pu;
       this.idStructure = idStructure;
       this.idProjet = idProjet;
       this.idNature = idNature;
       this.idDesignationNature = idDesignationNature;
       this.idTypeNature = idTypeNature;
       this.isDeleted = isDeleted;
    }
   
    public Integer getIdObjet() {
        return this.idObjet;
    }
    
    public void setIdObjet(Integer idObjet) {
        this.idObjet = idObjet;
    }
    public int getTypeObjet() {
        return this.typeObjet;
    }
    
    public void setTypeObjet(int typeObjet) {
        this.typeObjet = typeObjet;
    }
    public String getNomObjet() {
        return this.nomObjet;
    }
    
    public void setNomObjet(String nomObjet) {
        this.nomObjet = nomObjet;
    }
    public double getPu() {
        return this.pu;
    }
    
    public void setPu(double pu) {
        this.pu = pu;
    }
    public Integer getIdStructure() {
        return this.idStructure;
    }
    
    public void setIdStructure(Integer idStructure) {
        this.idStructure = idStructure;
    }
    public Integer getIdProjet() {
        return this.idProjet;
    }
    
    public void setIdProjet(Integer idProjet) {
        this.idProjet = idProjet;
    }
    public Integer getIdNature() {
        return this.idNature;
    }
    
    public void setIdNature(Integer idNature) {
        this.idNature = idNature;
    }
    public Integer getIdDesignationNature() {
        return this.idDesignationNature;
    }
    
    public void setIdDesignationNature(Integer idDesignationNature) {
        this.idDesignationNature = idDesignationNature;
    }
    public Integer getIdTypeNature() {
        return this.idTypeNature;
    }
    
    public void setIdTypeNature(Integer idTypeNature) {
        this.idTypeNature = idTypeNature;
    }
    public int getIsDeleted() {
        return this.isDeleted;
    }
    
    public void setIsDeleted(int isDeleted) {
        this.isDeleted = isDeleted;
    }




}


