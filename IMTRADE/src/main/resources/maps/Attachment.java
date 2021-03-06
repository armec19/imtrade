package maps;
// Generated 9 sept. 2020 14:35:48 by Hibernate Tools 4.3.1



/**
 * Attachment generated by hbm2java
 */
public class Attachment  implements java.io.Serializable {


     private Integer idAttach;
     private int idStructure;
     private String nomAttachment;
     private String typeAttachment;
     private String etatAttachment;
     private Integer idProjet;
     private Integer idNature;
     private Integer idTypeNature;
     private Integer idDesignationNature;
     private int isDeleted;

    public Attachment() {
    }

	
    public Attachment(int idStructure, String nomAttachment, String typeAttachment, String etatAttachment, int isDeleted) {
        this.idStructure = idStructure;
        this.nomAttachment = nomAttachment;
        this.typeAttachment = typeAttachment;
        this.etatAttachment = etatAttachment;
        this.isDeleted = isDeleted;
    }
    public Attachment(int idStructure, String nomAttachment, String typeAttachment, String etatAttachment, Integer idProjet, Integer idNature, Integer idTypeNature, Integer idDesignationNature, int isDeleted) {
       this.idStructure = idStructure;
       this.nomAttachment = nomAttachment;
       this.typeAttachment = typeAttachment;
       this.etatAttachment = etatAttachment;
       this.idProjet = idProjet;
       this.idNature = idNature;
       this.idTypeNature = idTypeNature;
       this.idDesignationNature = idDesignationNature;
       this.isDeleted = isDeleted;
    }
   
    public Integer getIdAttach() {
        return this.idAttach;
    }
    
    public void setIdAttach(Integer idAttach) {
        this.idAttach = idAttach;
    }
    public int getIdStructure() {
        return this.idStructure;
    }
    
    public void setIdStructure(int idStructure) {
        this.idStructure = idStructure;
    }
    public String getNomAttachment() {
        return this.nomAttachment;
    }
    
    public void setNomAttachment(String nomAttachment) {
        this.nomAttachment = nomAttachment;
    }
    public String getTypeAttachment() {
        return this.typeAttachment;
    }
    
    public void setTypeAttachment(String typeAttachment) {
        this.typeAttachment = typeAttachment;
    }
    public String getEtatAttachment() {
        return this.etatAttachment;
    }
    
    public void setEtatAttachment(String etatAttachment) {
        this.etatAttachment = etatAttachment;
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
    public Integer getIdTypeNature() {
        return this.idTypeNature;
    }
    
    public void setIdTypeNature(Integer idTypeNature) {
        this.idTypeNature = idTypeNature;
    }
    public Integer getIdDesignationNature() {
        return this.idDesignationNature;
    }
    
    public void setIdDesignationNature(Integer idDesignationNature) {
        this.idDesignationNature = idDesignationNature;
    }
    public int getIsDeleted() {
        return this.isDeleted;
    }
    
    public void setIsDeleted(int isDeleted) {
        this.isDeleted = isDeleted;
    }




}


