-- Procedure 1 (Todos dos clientes)
 
 DELIMITER $$
 drop procedure if exists getA_n_clientes $$
 create procedure getA_n_clientes(in quantidade int)
   begin
		select * from Cliente limit quantidade;
   end $$
 DELIMITER ;

-- Procedure 2 (Dado um nome, anuncia o preço associado)

DELIMITER $$
DROP procedure IF EXISTS name_Preco $$
CREATE PROCEDURE name_Preco(IN Nome VARCHAR(45))
BEGIN
		if (not exists (select cc.Nome from Cartao_Cidadao as cc where (cc.Nome = Nome)))
					then select 'Nome não existe na plataforma' as msg1;
		else
				select r.Preco from Reserva as r
                inner join Cliente as c on r.Cliente_id_Cliente = c.id_Cliente
                inner join Cartao_Cidadao as cc on cc.id_Cartao_Cidadao = c.Cartao_Cidadao_id_Cartao_Cidadao and Nome=cc.Nome
                group by r.Preco;
		end if;

END$$

DELIMITER ;


-- Procedure 3 (Dado um determinado dia, devolve o numero de reservas efetuadas nesse dia)


DELIMITER $$

DROP procedure IF EXISTS numero_Reservas $$
CREATE PROCEDURE numero_Reservas(IN Date1 date)
BEGIN
		if( not exists(select r.Data_Reserva from Reserva as r where (date(r.Data_Reserva)=Date1)))
			then select 'Nao foram feitas reservas neste dia' as msg1;
		
        else 
			select Date1, count(*) as Numero_Reservas from Reserva as r
            where (date(r.Data_Reserva)=Date1);
        end if;    
END$$

DELIMITER ;


-- Procedure 4 (Dado um nome, devolve o total de numero de quartos reservados por esse cliente, independentemente do hotel)

DELIMITER $$

DROP procedure IF EXISTS quantidade_Quartos $$
CREATE PROCEDURE quantidade_Quartos(IN Nome varchar(45))
BEGIN
		if(not exists( select cc.Nome from Cartao_Cidadao as cc where (cc.Nome=Nome)))
				then select 'Nao existe esse nome' as msg1;
		else 
				select count(r.Quantidade_Quartos) as Numero_de_Quartos from Reserva as r
                inner join Cliente as c on r.Cliente_id_Cliente=c.id_Cliente 
                inner join Cartao_Cidadao as cc on cc.id_Cartao_Cidadao = c.Cartao_Cidadao_id_Cartao_Cidadao and (cc.Nome = Nome);
		end if;
END$$

DELIMITER ;

-- Procedure 5 (Calcula o quarto mais barato, com tudo incluido, de um determinado hotel)

DELIMITER $$

DROP procedure IF EXISTS maisBarato $$
CREATE PROCEDURE maisBarato(IN Nome_Do_Hotel varchar(45))
BEGIN
		if(not exists( select h.Nome_Hotel from Hotel as h where (h.Nome_Hotel = Nome_Do_Hotel)))
				then select 'Esse hotel não existe' as msg1;
		else 
				select Min(q.Preco_3) as Mais_barato from Quarto as q
                inner join Hotel as h on h.id_Hotel = q.Hotel_id_Hotel and h.Nome_Hotel = Nome_Do_Hotel;
		end if;
END$$

DELIMITER ;


-- Procedure 6 (Mostra todos os hoteis com uma determinada classificação)

DELIMITER $$

DROP procedure IF EXISTS hoteis_classificacao $$
CREATE PROCEDURE hoteis_classificacao(IN classificacao decimal(2,1))
BEGIN
		if(not exists( select h.Classificacao from Hotel as h where (h.Classificacao=classificacao)))
					then select 'Classificação nao atribuida a nenhum hotel' as msg1;
		else 
			select h.Nome_Hotel, h.Cidade, h.Classificacao from Hotel as h 
            where h.Classificacao=classificacao
            order by h.classificacao;
		end if;
END$$

DELIMITER ;


-- Procedure 7 (Dá a faturacao de todos os hoteis, num determinado dia de reserva)

DELIMITER $$

DROP procedure IF EXISTS faturacao $$
CREATE PROCEDURE faturacao(in date1 date)
BEGIN
			if(not exists (select r.Data_Reserva from Reserva as r where (date(r.Data_Reserva)=date1)))
						then select 'Nao existe faturacao para esta data' as msg1;
			else 
					select h.Nome_Hotel, sum(r.Preco) as Faturacao from Reserva as r 
                    inner join Hotel as h on h.id_Hotel=r.Hotel_id_Hotel 
                    where date(r.Data_Reserva) = date1
                    group by h.id_Hotel;
			end if;
END$$

DELIMITER ;
