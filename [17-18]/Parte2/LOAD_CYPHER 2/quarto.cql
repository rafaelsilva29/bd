LOAD CSV WITH HEADERS FROM 'file:///quarto.csv' AS row
CREATE (q: Quarto {id_Quarto: toInt(row.id_Quarto)})
SET q.Tipo_Quarto = toString(row.Tipo_Quarto),
	q.Capacidade = toInt(row.Capacidade),
	q.Descricao = toString(row.Descricao),
	q.Preco_1 = toFloat(row.Preco_1),
	q.Preco_2 = toFloat(row.Preco_2),
	q.Preco_3 = toFloat(row.Preco_3),
	q.Hotel_id_Hotel = toInt(row.Hotel_id_Hotel)
RETURN q;
