package maps;
// Generated 9 sept. 2020 14:35:48 by Hibernate Tools 4.3.1



/**
 * ModeLivraison generated by hbm2java
 */
public class ModeLivraison  implements java.io.Serializable {


     private Integer idModeL;
     private String nomMode;
     private int isDeleted;

    public ModeLivraison() {
    }

    public ModeLivraison(String nomMode, int isDeleted) {
       this.nomMode = nomMode;
       this.isDeleted = isDeleted;
    }
   
    public Integer getIdModeL() {
        return this.idModeL;
    }
    
    public void setIdModeL(Integer idModeL) {
        this.idModeL = idModeL;
    }
    public String getNomMode() {
        return this.nomMode;
    }
    
    public void setNomMode(String nomMode) {
        this.nomMode = nomMode;
    }
    public int getIsDeleted() {
        return this.isDeleted;
    }
    
    public void setIsDeleted(int isDeleted) {
        this.isDeleted = isDeleted;
    }




}


