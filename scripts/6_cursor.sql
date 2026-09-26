CREATE OR REPLACE PROCEDURE listar_agenda_dia (
  p_medico_id  IN medico.id%TYPE,
  p_dia        IN DATE
) AS
  CURSOR c_agenda IS
    SELECT c.data_hora, p.nome AS paciente, c.status
      FROM consulta c
      JOIN paciente p ON p.id = c.paciente_id
     WHERE c.medico_id = p_medico_id
       AND TRUNC(c.data_hora) = TRUNC(p_dia)
     ORDER BY c.data_hora;
BEGIN
  FOR r IN c_agenda LOOP
    DBMS_OUTPUT.PUT_LINE(
      TO_CHAR(r.data_hora, 'HH24:MI') || ' - ' || r.paciente || ' (' || r.status || ')'
    );
  END LOOP;
END listar_agenda_dia;
/