package bd;
 
import java.util.*;
import static java.lang.System.out;
import java.io.*;

public class Comboio 
{
    private int id_Comboio;
    private String Tipo_comboio;
    private int Lotacao_Primeira_Classe;
    private int Lotacao_Economica;
    private int Capacidade;
    private List<Lugar> LC;
    
    public Comboio() 
    {   
        Tipo_comboio = " ";
        Lotacao_Primeira_Classe = 0 ;
        Lotacao_Economica = 0 ;
        Capacidade = 0 ;
        LC = null ;  
    }
    
public Comboio (int id_Comboio, String Tipo_comboio, int Lotacao_Primeira_Classe, int Lotacao_Economica, int Capacidade, List<Lugar> LC)
{
    this.id_Comboio = id_Comboio;
    this.Tipo_comboio = Tipo_comboio;
    this.Lotacao_Primeira_Classe = Lotacao_Primeira_Classe;
    this.Lotacao_Economica = Lotacao_Economica;
    this.Capacidade = Capacidade;
    this.LC = LC;
}
    public int getId_Comboio(){
        return this.id_Comboio;
    }
    
    public String getTipo_comboio(){
        return this.Tipo_comboio;
    }
    
    public int getLotacao_Primeira_Classe(){
        return this.Lotacao_Primeira_Classe;
    }
    
    public int getLotacao_Economica(){
        return this.Lotacao_Economica;
    }
    
    public int getCapacidade() {
        return this.Capacidade;
    }
    
    public List<Lugar> getLC(){
        return this.LC;
    }
    

}

