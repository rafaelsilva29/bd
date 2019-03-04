package bd;

import java.util.List;
import java.util.*;
import static java.lang.System.out;
import java.io.*;


public class Reserva 
{
    private int id_Reserva;
    private float custo;
    private int lugar;
    private String classe;
    private String Data_Reserva;
    private List<Cliente> clientes = new ArrayList<>();
    private List<Viagem> viagens = new ArrayList<>();
    
public Reserva (int id, float custo,int lugar, String classe, String data_reserva, List<Cliente> clientes, List<Viagem> viagens){
    this.id_Reserva=id;
    this.custo=custo;
    this.lugar=lugar;
    this.classe=classe;
    this.Data_Reserva=data_reserva;
    this.clientes = clientes;
    this.viagens = viagens;
    
}

    
    public int getid_Reserva(){
        return this.id_Reserva;
    }
    
    public float getCusto(){
        return this.custo;
    }

    
    public int getLugar(){
        return this.lugar;
    }
    
    public String getClasse(){
        return this.classe;
    }
    
    public String getData_Reserva(){
        return this.Data_Reserva;
    }
    
    public List<Cliente> getCliente(){
        return this.clientes;
    }
    
    public List<Viagem> getViagem() {
        return this.viagens;
    }
}
