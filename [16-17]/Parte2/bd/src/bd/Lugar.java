package bd;


public class Lugar
{
    
    private int N_Lugar ;
    private String Classe ;
    
    public Lugar()
    {
        N_Lugar = 0;
        Classe = " ";
    }
    
    public Lugar (Lugar a){
        N_Lugar = a.getN_Lugar();
        Classe = a.getClasse();
    }
    
    public Lugar (int N_Lugar, String Classe){
        setLugar(N_Lugar);
        setClasse(Classe);
    }
    
    public int getN_Lugar(){
        return this.N_Lugar;
    }
    
    public String getClasse(){
        return this.Classe;
    }
    
    public void setLugar(int lugar){
        this.N_Lugar = lugar;
    }
    
    public void setClasse(String Classe){
        this.Classe = Classe;
    }
   
}

