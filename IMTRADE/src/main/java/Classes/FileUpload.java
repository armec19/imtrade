/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Classes;

import java.io.InputStream;
import java.io.Serializable;

/**
 *
 * @author Mechri
 */
public class FileUpload{
    public String name;
    public String type;
    public double size;
    public InputStream content;

    public FileUpload(String name, String type, double size, InputStream content) {
        this.name = name;
        this.type = type;
        this.size = size;
        this.content = content;
    }
    
    
    
}
