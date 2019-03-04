-- Procedure 1 (Todos dos clientes)
 
 DELIMITER $$
 drop procedure if exists GetA_n_Clientes $$
 create procedure Get_n_Clientes(in quantidade int)
   begin
		select * from cliente
		limit quantidade;
   end $$
 DELIMITER ;
 
 -- Procedure 2 ( Dado uma partida, mostras os destinos)

DELIMITER $$
 drop procedure if exists dest_Part $$
 create procedure dest_Part(in partida varchar(25))
   begin
		if (not exists(select v.Partida from viagem as v where (v.Partida=partida)))
				then select ' Partida nao existe' as msg1;
		else 
			select v.id_Viagem, v.Hora_Partida, v.Partida, v.Destino from viagem as v 
            where v.Partida=partida
            group by v.id_Viagem;
		end if;
   end $$
 DELIMITER ;
 
 -- Procedure 3 ( Dada uma data mostras as viagens nesse dia)

DELIMITER $$
 drop procedure if exists date_Viag $$
 create procedure date_Viag(in date1 date)
   begin
		if (not exists(select v.Hora_Partida from viagem as v where (date(v.Hora_Partida)=date1)))
				then select 'Nao ha viagens nesse dia' as msg1;
		else 
			select date1, v.Partida, v.Destino from viagem as v 
            where (date(v.Hora_Partida)=date1)
            group by v.id_Viagem;
		end if;
   end $$
 DELIMITER ;
 
-- Procedure 4 (Viagem por cliente)

DELIMITER $$
drop procedure if exists Viagem_por_Cliente $$
create procedure Viagem_por_Cliente(in cliente varchar(45))
	begin
			if (not exists(select c.nif, c.email from cliente as c where (c.nome=cliente)))
				then select ' Cliente nao existe' as msg1;
            else
				select c.nome, c.email, v.Partida, v.Destino from cliente as c
				inner join reserva as r on c.id_Cliente=r.Cliente_id_Cliente and cliente=c.nome
				inner join viagem as v on v.id_Viagem = r.Viagem_id_Viagem
				group by r.id_Reserva;
			end if;
    end $$
DELIMITER ;

-- Procedure 5 (Calcular o valor gasto de um certo cliente)

DELIMITER $$
drop procedure if exists total_gasto_Cliente $$
create procedure total_gasto_Cliente(in cliente varchar(45))
	begin 
		if (not exists(select c.nif, c.email from cliente as c where (c.nome=cliente)))
			then select ' Cliente nao existe' as msg1;
		else
            select c.nome, c.nif  , Sum(Custo) as Gasto
			from cliente as c
			inner join reserva as r
			on r.Cliente_id_Cliente=c.id_Cliente and cliente=c.nome
			group by c.email;
		end if;
	end $$
DELIMITER ;

-- Procedure 6 (Quantas reservas foram feitas num certo dia)

DELIMITER $$
 drop procedure if exists date_Reserv $$
 create procedure date_Reserv(in date1 date)
   begin
		if (not exists(select r.Data_reserva from reserva as r where (date(r.Data_reserva)=date1)))
				then select 'Nao ha reservas nesse dia' as msg1;
		else 
			select date1, count(*) as Numero_Reservas from reserva as r 
            where (date(r.Data_Reserva)=date1);
		end if;
   end $$
 DELIMITER ;
 
 -- Procedure 7 (Dado uma viagem e um lugar, diz-me que se senta nesse lugar)
 
DELIMITER $$
 drop procedure if exists lugar_Cliente $$
 create procedure lugar_Cliente(in idViagem int, in assento int)
   begin
		if (not exists(select r.Viagem_id_Viagem from reserva as r where (r.Viagem_id_Viagem=idViagem)))
				then select 'Viagem incorreta' as msg1;
		else 
			select c.nome, c.email, r.Cliente_id_Cliente as ID_CLIENTE, r.lugar from reserva as r 
				inner join cliente as c on r.Cliente_id_Cliente=c.id_Cliente
			where idViagem=r.Viagem_id_Viagem and assento=lugar;
		end if;
   end $$
 DELIMITER ;
 
 -- Procedure 8 (Factiraço num determinado mes)
 
 DELIMITER $$
 drop procedure if exists mes_Fact $$
 create procedure mes_Fact(in date1 date)
   begin
		if (not exists(select r.Data_Reserva from reserva as r where (date(r.Data_Reserva)=date1)))
				then select 'Nao houve faturaçao nesse dia' as msg1;
		else 
			select date1 as Data_Pedida, Sum(Custo) from reserva as Facturaçao
			where (date(Data_reserva)=date1);
		end if;
   end $$
 DELIMITER ;
 
