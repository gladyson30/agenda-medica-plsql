SET SERVEROUTPUT ON;

-- 1. Tenta marcar o João às 9h com o Dr. Carlos: DEVE FALHAR (horário da Maria)
EXEC agendar_consulta(2, 1, TIMESTAMP '2026-10-01 09:00:00');

-- 2. Marca o João às 10h: deve passar
EXEC agendar_consulta(2, 1, TIMESTAMP '2026-10-01 10:00:00');
COMMIT;

-- 3. Conta as consultas do dia: deve dar 2
SELECT qtd_consultas_dia(1, DATE '2026-10-01') AS qtd FROM DUAL;

-- 4. Cancela a consulta da Maria: a trigger grava no log
UPDATE consulta SET status = 'CANCELADA' WHERE id = 1;
COMMIT;
SELECT * FROM log_consulta;

-- 5. Mostra a agenda do dia com o cursor
EXEC listar_agenda_dia(1, DATE '2026-10-01');



