CREATE OR REPLACE TRIGGER trg_log_cancelamento
AFTER UPDATE OF status ON consulta
FOR EACH ROW
WHEN (NEW.status = 'CANCELADA' AND OLD.status <> 'CANCELADA')
BEGIN
  INSERT INTO log_consulta (consulta_id, status_anterior, status_novo)
  VALUES (:OLD.id, :OLD.status, :NEW.status);
END;
/