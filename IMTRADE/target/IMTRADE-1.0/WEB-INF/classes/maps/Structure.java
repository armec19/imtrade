package maps;
// Generated 9 sept. 2020 14:35:48 by Hibernate Tools 4.3.1



/**
 * Structure generated by hbm2java
 */
public class Structure  implements java.io.Serializable {


     private Integer idStructure;
     private String nomStructure;
     private String code;
     private int isDeleted;

    public Structure() {
    }

    public Structure(String nomStructure, String code, int isDeleted) {
       this.nomStructure = nomStructure;
       this.code = code;
       this.isDeleted = isDeleted;
    }
   
    public Integer getIdStructure() {
        return this.idStructure;
    }
    
    public void setIdStructure(Integer idStructure) {
        this.idStructure = idStructure;
    }
    public String getNomStructure() {
        return this.nomStructure;
    }
    
    public void setNomStructure(String nomStructure) {
        this.nomStructure = nomStructure;
    }
    public String getCode() {
        return this.code;
    }
    
    public void setCode(String code) {
        this.code = code;
    }
    public int getIsDeleted() {
        return this.isDeleted;
    }
    
    public void setIsDeleted(int isDeleted) {
        this.isDeleted = isDeleted;
    }




}


