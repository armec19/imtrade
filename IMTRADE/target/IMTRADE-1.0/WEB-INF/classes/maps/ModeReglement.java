package maps;
// Generated 9 sept. 2020 14:35:48 by Hibernate Tools 4.3.1



/**
 * ModeReglement generated by hbm2java
 */
public class ModeReglement  implements java.io.Serializable {


     private Integer idModeR;
     private String nomMode;
     private int isDeleted;

    public ModeReglement() {
    }

    public ModeReglement(String nomMode, int isDeleted) {
       this.nomMode = nomMode;
       this.isDeleted = isDeleted;
    }
   
    public Integer getIdModeR() {
        return this.idModeR;
    }
    
    public void setIdModeR(Integer idModeR) {
        this.idModeR = idModeR;
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

