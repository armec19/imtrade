package maps;
// Generated 9 sept. 2020 14:35:48 by Hibernate Tools 4.3.1



/**
 * ObjetType generated by hbm2java
 */
public class ObjetType  implements java.io.Serializable {


     private Integer idObjetType;
     private String nomObjetType;
     private int isDeleted;

    public ObjetType() {
    }

    public ObjetType(String nomObjetType, int isDeleted) {
       this.nomObjetType = nomObjetType;
       this.isDeleted = isDeleted;
    }
   
    public Integer getIdObjetType() {
        return this.idObjetType;
    }
    
    public void setIdObjetType(Integer idObjetType) {
        this.idObjetType = idObjetType;
    }
    public String getNomObjetType() {
        return this.nomObjetType;
    }
    
    public void setNomObjetType(String nomObjetType) {
        this.nomObjetType = nomObjetType;
    }
    public int getIsDeleted() {
        return this.isDeleted;
    }
    
    public void setIsDeleted(int isDeleted) {
        this.isDeleted = isDeleted;
    }




}


