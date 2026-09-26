CREATE OR REPLACE FUNCTION qtd_consultas_dia (
  p_medico_id  IN medico.id%TYPE,
  p_dia        IN DATE
) RETURN NUMBER AS
  v_qtd NUMBER;
BEGIN
  SELECT COUNT(*)
    INTO v_qtd
    FROM consulta
   WHERE medico_id = p_medico_id
     AND TRUNC(data_hora) = TRUNC(p_dia)
     AND status <> 'CANCELADA';

  RETURN v_qtd;
END qtd_consultas_dia;
/