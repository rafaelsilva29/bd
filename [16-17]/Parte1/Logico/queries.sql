-- Query 1 (Quantidade de viagens por cada cliente)

drop view if exists viagens_totais;
create view Viagens_Totais as
	select c.nome, c.nif,  count(*) as Total_Viagens
    from cliente as c
		inner join reserva as r
		on r.Cliente_id_Cliente=c.id_Cliente
	group by c.email;
    
-- Query 2 (Total gasto por cada cliente)

drop view if exists total_gasto;
create view Total_Gasto as
	select c.nome, c.nif  , Sum(Custo) as Gasto
    from cliente as c
		inner join reserva as r
		on r.Cliente_id_Cliente=c.id_Cliente
    group by c.email;
    
-- Query 3 (Duraçao de cada viagem)

drop view if exists duração_viagem;
create view Duração_viagem as
	select Partida, Destino, timediff(Hora_Destino,Hora_partida) as Duração
	from viagem
	group by id_Viagem;
        
-- Query 4 (Facturaçao por cada viagem)

drop view if exists faturaçao_viagem;
create view Faturaçao_Viagem as
	select  Partida, Destino, Sum(Custo) as Faturação
    from viagem as v
		inner join reserva as r
		on v.id_Viagem=r.Viagem_id_Viagem
    group by id_Viagem;

-- Query 5 (Radiografia dos clientes-Homem/Mulher)

drop view if exists clientes_radiografia;
create view Clientes_radiografia as
	select c.genero,  count(*) as Homem_Mulher
    from cliente as c
		
	group by c.genero;

-- Query 6(Quantas viagens por classe)

drop view if exists cliente_classe;
create view Cliente_Classe as
	select r.Classe,  count(*) as Cliente_Classe1 
    from reserva as r
    group by r.Classe; 

-- Query 7(Quantas viagens internacionais/nacionais temos)

drop view if exists viagens_n_i;
create view viagens_N_I as
	select Tipo_comboio, count(*) as Total
    from comboio as c
		inner join viagem as v
        where c.id_Comboio=v.Comboio_id_Comboio
	group by Tipo_comboio;

-- Query 8(Quantas viagens de partida por cada estacao)

drop view if exists Cidade;
create view Cidade as
	select Partida  , Count(*) as Total_Estação
    from viagem as v
    group by Partida;
 
 -- Query 9(Quantas viagem economicas/1ºparte de cada cliente)

drop view if exists quantidade_classes;
create view quantidade_classes as

select c.nome, c.nif, (select count(*) from reserva as r where c.id_Cliente=r.Cliente_id_Cliente and Classe='1ªClasse') as Primeira_classe,
	(select count(*) from reserva as r where c.id_Cliente=r.Cliente_id_Cliente and Classe='Economica') as Economica
from
cliente as c
	group by c.id_Cliente;


-- Query 10 (os 5 melhores clientes da empresa)

drop view if exists five_best_clients;
create view five_best_clients as

select c.nome, c.nif  , Sum(Custo) as Money
    from cliente as c
		inner join reserva as r
		on r.Cliente_id_Cliente=c.id_Cliente
    group by c.nif order by Money desc
	limit 5;
    
-- Query 11 (Quantidade d ereservas por dia)

drop view if exists hora_Reserva;
create view hora_Reserva as
	select date(r.Data_Reserva), count(*) as Numero_Reservas from reserva as r 
            group by date(r.Data_Reserva);

-- Query 12 (Quantidade de viagens feitas por comboio)

drop view if exists Comboio_Viagens;
create view Comboio_Viagens as 
	select c.id_Comboio, count(*) Numero_Viagens from comboio as c
		inner join viagem as v on c.id_Comboio = v.Comboio_id_Comboio
        group by c.id_Comboio;
	
