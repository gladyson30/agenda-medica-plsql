CREATE OR REPLACE PROCEDURE agendar_consulta (
  p_paciente_id  IN consulta.paciente_id%TYPE,
  p_medico_id    IN consulta.medico_id%TYPE,
  p_data_hora    IN consulta.data_hora%TYPE
) AS
  v_ocupado NUMBER;
BEGIN
  SELECT COUNT(*)
    INTO v_ocupado
    FROM consulta
   WHERE medico_id = p_medico_id
     AND data_hora = p_data_hora
     AND status <> 'CANCELADA';

  IF v_ocupado > 0 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Médico já possui consulta neste horário.');
  END IF;

  INSERT INTO consulta (paciente_id, medico_id, data_hora)
  VALUES (p_paciente_id, p_medico_id, p_data_hora);
END agendar_consulta;
/