INSERT INTO paciente (nome, cpf, nascimento)
  VALUES ('Maria Souza', '12345678901', DATE '1985-04-12');
INSERT INTO paciente (nome, cpf, nascimento)
  VALUES ('João Lima', '98765432100', DATE '1992-11-03');

INSERT INTO medico (nome, crm, especialidade)
  VALUES ('Dr. Carlos Silva', 'CE-11111', 'Cardiologia');
INSERT INTO medico (nome, crm, especialidade)
  VALUES ('Dra. Ana Rocha', 'CE-22222', 'Pediatria');

INSERT INTO consulta (paciente_id, medico_id, data_hora)
  VALUES (1, 1, TIMESTAMP '2026-10-01 09:00:00');

COMMIT;