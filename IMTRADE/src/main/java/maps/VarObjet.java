package maps;
// Generated 9 sept. 2020 14:35:48 by Hibernate Tools 4.3.1



/**
 * VarObjet generated by hbm2java
 */
public class VarObjet  implements java.io.Serializable {


     private Integer idVarObjet;
     private int idObjet;
     private String nomVarObjet;
     private String valeurVarObjet;
     private int isDeleted;

    public VarObjet() {
    }

    public VarObjet(int idObjet, String nomVarObjet, String valeurVarObjet, int isDeleted) {
       this.idObjet = idObjet;
       this.nomVarObjet = nomVarObjet;
       this.valeurVarObjet = valeurVarObjet;
       this.isDeleted = isDeleted;
    }
   
    public Integer getIdVarObjet() {
        return this.idVarObjet;
    }
    
    public void setIdVarObjet(Integer idVarObjet) {
        this.idVarObjet = idVarObjet;
    }
    public int getIdObjet() {
        return this.idObjet;
    }
    
    public void setIdObjet(int idObjet) {
        this.idObjet = idObjet;
    }
    public String getNomVarObjet() {
        return this.nomVarObjet;
    }
    
    public void setNomVarObjet(String nomVarObjet) {
        this.nomVarObjet = nomVarObjet;
    }
    public String getValeurVarObjet() {
        return this.valeurVarObjet;
    }
    
    public void setValeurVarObjet(String valeurVarObjet) {
        this.valeurVarObjet = valeurVarObjet;
    }
    public int getIsDeleted() {
        return this.isDeleted;
    }
    
    public void setIsDeleted(int isDeleted) {
        this.isDeleted = isDeleted;
    }




}


