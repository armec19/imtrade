package maps;
// Generated 9 sept. 2020 14:35:48 by Hibernate Tools 4.3.1



/**
 * Nature generated by hbm2java
 */
public class Nature  implements java.io.Serializable {


     private Integer idNature;
     private int idProjet;
     private String nomNature;
     private int isDeleted;

    public Nature() {
    }

    public Nature(int idProjet, String nomNature, int isDeleted) {
       this.idProjet = idProjet;
       this.nomNature = nomNature;
       this.isDeleted = isDeleted;
    }
   
    public Integer getIdNature() {
        return this.idNature;
    }
    
    public void setIdNature(Integer idNature) {
        this.idNature = idNature;
    }
    public int getIdProjet() {
        return this.idProjet;
    }
    
    public void setIdProjet(int idProjet) {
        this.idProjet = idProjet;
    }
    public String getNomNature() {
        return this.nomNature;
    }
    
    public void setNomNature(String nomNature) {
        this.nomNature = nomNature;
    }
    public int getIsDeleted() {
        return this.isDeleted;
    }
    
    public void setIsDeleted(int isDeleted) {
        this.isDeleted = isDeleted;
    }




}


