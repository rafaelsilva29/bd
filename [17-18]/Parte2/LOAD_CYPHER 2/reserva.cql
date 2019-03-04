LOAD CSV WITH HEADERS FROM 'file:///reserva.csv' AS row
CREATE (r: Reserva {id_Reserva: toInt(row.id_Reserva)})
SET r.Data_Check_In = toString(row.Data_Check_In),
	r.Data_Check_Out = toString(row.Data_Check_Out),
	r.Data_Reserva = toString(row.Data_Reserva),
	r.Preco = toFloat(row.Preco),
	r.Quantidade_Quartos = toInt(row.Quantidade_Quartos),
	r.Cliente_id_Cliente = toInt(row.Cliente_id_Cliente),
	r.Hotel_id_Hotel = toInt(row.Hotel_id_Hotel)
RETURN r;
