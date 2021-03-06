package maps;
// Generated 9 sept. 2020 14:35:48 by Hibernate Tools 4.3.1



/**
 * StructureDetails generated by hbm2java
 */
public class StructureDetails  implements java.io.Serializable {


     private Integer idStructureDetais;
     private int idStructure;
     private String capital;
     private String adresse;
     private String rc;
     private String nif;
     private String nis;
     private String art;
     private String rib;
     private String banque;
     private String site;
     private String contact;
     private int isDeleted;

    public StructureDetails() {
    }

    public StructureDetails(int idStructure, String capital, String adresse, String rc, String nif, String nis, String art, String rib, String banque, String site, String contact, int isDeleted) {
       this.idStructure = idStructure;
       this.capital = capital;
       this.adresse = adresse;
       this.rc = rc;
       this.nif = nif;
       this.nis = nis;
       this.art = art;
       this.rib = rib;
       this.banque = banque;
       this.site = site;
       this.contact = contact;
       this.isDeleted = isDeleted;
    }
   
    public Integer getIdStructureDetais() {
        return this.idStructureDetais;
    }
    
    public void setIdStructureDetais(Integer idStructureDetais) {
        this.idStructureDetais = idStructureDetais;
    }
    public int getIdStructure() {
        return this.idStructure;
    }
    
    public void setIdStructure(int idStructure) {
        this.idStructure = idStructure;
    }
    public String getCapital() {
        return this.capital;
    }
    
    public void setCapital(String capital) {
        this.capital = capital;
    }
    public String getAdresse() {
        return this.adresse;
    }
    
    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }
    public String getRc() {
        return this.rc;
    }
    
    public void setRc(String rc) {
        this.rc = rc;
    }
    public String getNif() {
        return this.nif;
    }
    
    public void setNif(String nif) {
        this.nif = nif;
    }
    public String getNis() {
        return this.nis;
    }
    
    public void setNis(String nis) {
        this.nis = nis;
    }
    public String getArt() {
        return this.art;
    }
    
    public void setArt(String art) {
        this.art = art;
    }
    public String getRib() {
        return this.rib;
    }
    
    public void setRib(String rib) {
        this.rib = rib;
    }
    public String getBanque() {
        return this.banque;
    }
    
    public void setBanque(String banque) {
        this.banque = banque;
    }
    public String getSite() {
        return this.site;
    }
    
    public void setSite(String site) {
        this.site = site;
    }
    public String getContact() {
        return this.contact;
    }
    
    public void setContact(String contact) {
        this.contact = contact;
    }
    public int getIsDeleted() {
        return this.isDeleted;
    }
    
    public void setIsDeleted(int isDeleted) {
        this.isDeleted = isDeleted;
    }




}


