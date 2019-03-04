package bd;

import java.util.*;
import static java.lang.System.out;
import java.io.*;
import java.sql.Time;

public class Viagem {
    private float Preco_Primeira_Classe;
    private float Preco_Economica;
    private int Ocupacao_Primeira_Classe;
    private int Ocupacao_Classe_Economica;
    private String Hora_Partida;
    private String Hora_Destino;
    private String partida;
    private String destino;
    private List<Comboio> Comboio = new ArrayList<>();
    
        public Viagem()
    {
        // inicializa variáveis de instância
        Preco_Primeira_Classe = 0 ;
        Preco_Economica = 0;
        Ocupacao_Primeira_Classe = 0;
        Ocupacao_Classe_Economica= 0;
        Hora_Partida = " ";
        Hora_Destino = " ";
        partida = " ";
        destino = " ";
        Comboio = new ArrayList<>();
    }
    
    public Viagem (Viagem v)
    {
        Preco_Primeira_Classe = v.getPreco_Primeira() ;
        Preco_Economica = v.getPreco_Economica();
        Ocupacao_Primeira_Classe = v.getOcupacaoPrimeira();
        Ocupacao_Classe_Economica= v.getOcupacaoEconomica();
        Hora_Partida = v.getHora_Partida();
        Hora_Destino = v.getHora_Destino();
        partida = v.getPartida();
        destino = v.getDestino() ;
        Comboio = v.getComboio();
    }
    

    public Viagem (float preco_primeira, float preco_economica, int ocupacao_primeira, 
                   int ocupacao_economica, String hora_partida, String hora_chegada, 
                   String partida, String destino, List<Comboio> comboio){
      this.Preco_Primeira_Classe=preco_primeira;
      this.Preco_Economica=preco_economica;
      this.Ocupacao_Primeira_Classe=ocupacao_primeira;
      this.Ocupacao_Classe_Economica=ocupacao_economica;
      this.Hora_Partida=hora_partida;
      this.Hora_Destino=hora_chegada;
      this.partida = partida;
      this.destino = destino;
      this.Comboio = comboio;

    }


    public float getPreco_Primeira() {
        return this.Preco_Primeira_Classe;
    }
    
    public float getPreco_Economica() {
        return this.Preco_Economica;
    }
    
    public int getOcupacaoPrimeira() {
        return this.Ocupacao_Primeira_Classe;
    }
    
    public int getOcupacaoEconomica() {
        return this.Ocupacao_Classe_Economica;
    }
    
    public String getHora_Partida() {
        return this.Hora_Partida;
    }
    
    public String getHora_Destino() {
        return this.Hora_Destino;
    }
    
    public String getPartida() {
        return this.partida;
    }
    
    public String getDestino() {
        return this.destino;
    }
    
    public List<Comboio> getComboio() {
        return this.Comboio;
    }

}
