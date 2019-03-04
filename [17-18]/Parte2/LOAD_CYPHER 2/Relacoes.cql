// Relaçao Morada -> Cliente

MATCH(m:Morada),(c:Cliente)
WHERE m.id_Morada = c.Morada_id_Morada
CREATE (c)-[:MORA]->(m);

// Relaçao Cartao_Cidado -> Cliente

MATCH(cc:Cartao_Cidado),(c:Cliente)
WHERE cc.id_Cartao_Cidadao = c.Cartao_Cidado_id_Cartao_Cidadao
CREATE (c)-[:PERTENCE]->(cc);

// Relaçao Cliente -> Reserva

MATCH(c:Cliente),(r:Reserva)
WHERE c.id_Cliente = r.Cliente_id_Cliente
CREATE (c)-[:EFETUA]->(r);

// Relaçao Hotel -> Reserva

MATCH(h:Hotel),(r:Reserva)
WHERE h.id_Hotel = r.Hotel_id_Hotel
CREATE (h)-[:POSSUI]->(r);

// Relaçao Hotel -> Quarto

MATCH(q:Quarto),(h:Hotel)
WHERE q.Hotel_id_Hotel = h.id_Hotel
CREATE (h)-[:CONSTITUIDO]->(q);


// Relaçao Reserva -> TipoReserva

MATCH(r:Reserva),(tr:Tipo_Reserva)
WHERE r.id_Reserva = tr.Reserva_id_Reserva
CREATE (r)-[:DEFINIDA]->(tr);