-- Query 1 (Quantidade de reservas por cada cliente)

drop view if exists reservas_totais;
create view reservas_totais as
	select cc.Nome,c.Email, count(*) as Total_Reservas from Cartao_Cidadao as cc
		inner join Cliente as c
			on c.Cartao_Cidadao_id_Cartao_Cidadao = cc.id_Cartao_Cidadao
		inner join Reserva as r
			on c.id_Cliente=r.Cliente_id_Cliente
		group by c.id_Cliente;

-- Query 2(Quantidade quartos resevados por cliente)

drop view if exists quartos_clientes;
create view quartos_clientes as	
	select cc.Nome, c.Email, sum(Quantidade_Quartos) as Total_Quartos from Cartao_Cidadao as cc
		inner join Cliente as c
			on c.Cartao_Cidadao_id_Cartao_Cidadao = cc.id_Cartao_Cidadao
		inner join Reserva as r
			on c.id_Cliente=r.Cliente_id_Cliente
	    group by c.id_Cliente;

-- Query 3 (Informaçao completa de cliente)

drop view if exists cliente_morada;
create view cliente_morada as
		select cc.Nome, cc.Numero, c.Email, c.NºCartao_Debito , c.Contacto_Telefonico, m.Rua , m.Localidade, m.Codigo_Postal  from  Cartao_Cidadao as cc
			inner join Cliente as c
				on cc.id_Cartao_Cidadao=c.Cartao_Cidadao_id_Cartao_Cidadao
			inner join Morada as m
				on m.id_Morada=c.Morada_id_Morada
		group by c.id_Cliente;

-- Query 4 (Hotel por Cliente)

drop view if exists hotel_por_cliente;
create view hotel_por_cliente as
		select cc.Nome, c.Email,  h.Nome_Hotel, r.Quantidade_Quartos from Cartao_Cidadao as cc
			inner join Cliente as c
				on cc.id_Cartao_Cidadao=c.Cartao_Cidadao_id_Cartao_Cidadao
			inner join Reserva as r
				on r.Cliente_id_Cliente=c.id_Cliente
			inner join Hotel as h
				on r.Hotel_id_Hotel=h.id_Hotel
		group by r.id_Reserva;
			

-- Query 5 (Total gasto por cada cliente)

drop view if exists total_gasto;
create view total_gasto as
	select cc.Nome, cc.Numero, c.Email, Sum(Preco) as Gasto from Cartao_Cidadao as cc
		inner join Cliente as c
			on cc.id_Cartao_Cidadao=c.Cartao_Cidadao_id_Cartao_Cidadao
		inner join Reserva as r
			on c.id_Cliente=r.Cliente_id_Cliente
    group by c.id_Cliente;

-- Query 6 (Tipo de reserva por cliente)

drop view if exists tipo_reserva_cliente;
create view tipo_reserva_Cliente as
	select r.id_Reserva, cc.Nome, c.Email, h.Nome_Hotel,  tr.Tipo_Quarto, tr.Opcao_Estadia from Tipo_Reserva as tr
		inner join Reserva as r
			on tr.id_Tipo_Reserva=r.id_Reserva
		inner join Hotel as h
			on h.id_Hotel=r.Hotel_id_Hotel
		inner join Cliente as c
			on c.id_Cliente = r.Cliente_id_Cliente
		inner join Cartao_Cidadao as cc
			on cc.id_Cartao_Cidadao=c.Cartao_Cidadao_id_Cartao_Cidadao
		group by r.id_Reserva;

-- Query 7(Duraçao de cada estadia)

drop view if exists duraçao_estadia;
create view duraçao_estadia as
	select cc.Nome, c.Email, r.id_Reserva, datediff(r.Data_Check_Out,r.Data_Check_In) as Duração from Hotel as h
		inner join Reserva as r
			on r.Hotel_id_Hotel=h.id_Hotel
		inner join Cliente as c
			on c.id_Cliente = r.Cliente_id_Cliente
		inner join Cartao_Cidadao as cc
			on cc.id_Cartao_Cidadao=c.Cartao_Cidadao_id_Cartao_Cidadao
		group by r.id_Reserva;
        
-- Query 8 (Facturaçao por cada Hotel)

drop view if exists faturacao_hotel;
create view faturacao_hotel as
	select  h.Nome_Hotel, h.Cidade, h.Classificacao, Sum(Preco) as Faturação from Hotel as h
		inner join reserva as r
			on h.id_Hotel=r.Hotel_id_Hotel
    group by h.id_Hotel;

-- Query 9 (Hotel por cidade)

drop view if exists hotel_cidade;
create view hotel_cidade as
	select h.Nome_hotel, h.Cidade, h.Classificacao, h.Contacto, h.Endereco from Hotel as h
	group by h.id_Hotel;

-- Query 10 (Quantidade de rservas feitas para um hotel)

drop view if exists hotel_reservas;
create view hotel_reservas as 
	select h.Nome_Hotel, h.Cidade, count(*) as Quantidade_de_Reservas from Hotel as h
		inner join Reserva as r
			on r.Hotel_id_Hotel=h.id_Hotel
        group by h.id_Hotel;
	

-- Query 11(Quantas reservas por tipo quarto e hotel)
drop view if exists reservas_tipo_quarto;
create view reservas_tipo_quarto as
	select h.Nome_Hotel, tr.Tipo_Quarto, tr.Opcao_Estadia from Tipo_Reserva as tr
		inner join reserva as r 
			on r.id_Reserva=tr.Reserva_id_Reserva
		inner join Hotel as h
			on r.Hotel_id_Hotel=h.id_Hotel;
		

-- Query 12(Quantidade de quartos por Hotel)

drop view if exists total_quartos_hotel;
create view total_quartos_hotel as
	select h.Nome_Hotel, h.Cidade, count(*) as Total_Quartos from quarto as q
		inner join hotel as h
        where h.id_Hotel=q.Hotel_id_Hotel
	group by h.id_Hotel;


-- Query 13 (os 10 melhores clientes da empresa)

drop view if exists ten_best_clients;
create view ten_best_clients as
select cc.Nome, c.Email, c.NºCartao_Debito , Sum(Preco) as Money from Cartao_Cidadao as cc
	inner join Cliente as c
		on c.Cartao_Cidadao_id_Cartao_Cidadao=cc.id_Cartao_Cidadao
	inner join Reserva  as r
		on r.Cliente_id_Cliente=c.id_Cliente
    group by c.id_Cliente order by Money desc
	limit 10;
    
-- Query 14 (Quantidade de reservas por dia)

drop view if exists quantidade_reserva;
create view quantidade_reserva as
	select date (r.Data_Reserva), count(*) as Numero_Reservas from Reserva as r 
            group by date(r.Data_Reserva);

-- Query 15 (Quantidade de reservas feitas para um hotel)

drop view if exists hotel_reservas;
create view hotel_reservas as 
	select h.Nome_Hotel, h.Cidade, count(*) as Quantidade_de_Reservas from Hotel as h
		inner join Reserva as r
			on r.Hotel_id_Hotel=h.id_Hotel
        group by h.id_Hotel;

-- Query 16(Quartos por Hotel)

drop view if exists quartos_hotel;
create view quartos_hotel as
	select h.Nome_Hotel, h.Cidade, q.Tipo_Quarto, q.Capacidade, q.Descricao from Quarto as q
		inner join Hotel as h
			where h.id_Hotel=q.Hotel_id_Hotel;
		

-- Query 17(Capacidade de cada Hotel)

drop view if exists capacidade_hotel;
create view capacidade_hotel as
	select  h.Nome_Hotel, Sum(Capacidade) from Hotel as h	
		inner join Quarto as q
			on h.id_Hotel=q.Hotel_id_Hotel
		group by h.id_Hotel;

 	

drop view if exists classificacao_hotel;
create view classificacao_hotel as 
		select h.Nome_Hotel, h.Endereco, h.Cidade, h.Classificacao from Hotel as h
		order by h.Classificacao;