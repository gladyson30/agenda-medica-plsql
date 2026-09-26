CREATE TABLE paciente (
  id          NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nome        VARCHAR2(100) NOT NULL,
  cpf         CHAR(11)      NOT NULL UNIQUE,
  nascimento  DATE          NOT NULL
);

CREATE TABLE medico (
  id             NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nome           VARCHAR2(100) NOT NULL,
  crm            VARCHAR2(20)  NOT NULL UNIQUE,
  especialidade  VARCHAR2(50)  NOT NULL
);

CREATE TABLE consulta (
  id           NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  paciente_id  NUMBER    NOT NULL,
  medico_id    NUMBER    NOT NULL,
  data_hora    TIMESTAMP NOT NULL,
  status       VARCHAR2(20) DEFAULT 'AGENDADA' NOT NULL,
  CONSTRAINT fk_consulta_paciente FOREIGN KEY (paciente_id) REFERENCES paciente(id),
  CONSTRAINT fk_consulta_medico   FOREIGN KEY (medico_id)   REFERENCES medico(id),
  CONSTRAINT ck_consulta_status   CHECK (status IN ('AGENDADA', 'REALIZADA', 'CANCELADA'))
);

CREATE TABLE log_consulta (
  id               NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  consulta_id      NUMBER       NOT NULL,
  status_anterior  VARCHAR2(20),
  status_novo      VARCHAR2(20),
  data_alteracao   TIMESTAMP    DEFAULT SYSTIMESTAMP,
  usuario_banco    VARCHAR2(50) DEFAULT USER
);