LOAD CSV WITH HEADERS FROM 'file:///tipo_reserva.csv' AS row
CREATE (tr: Tipo_Reserva {id_Tipo_Reserva: toInt(row.id_Tipo_Reserva)})
SET tr.Tipo_Quarto = toString(row.Tipo_Quarto),
 	tr.Opcao_Estadia = toString(row.Opcao_Estadia),
 	tr.Reserva_id_Reserva = toInt(row.Reserva_id_Reserva)
RETURN tr;
