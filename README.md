# Agenda Médica — PL/SQL

Laboratório de estudo de Oracle e PL/SQL: um sistema de agendamento de consultas
médicas em que as regras de negócio ficam dentro do banco de dados.

A ideia é que a regra valha para qualquer sistema que grave no banco, seja uma
aplicação web, um relatório ou um script de importação.

## O que este projeto demonstra

- Regras de negócio implementadas no próprio banco, com validação de conflito de horário
- Auditoria automática de cancelamentos via trigger
- Consultas agregadas com function reutilizável em SELECT
- Ambiente reproduzível com Docker Compose

## Tecnologias

- Oracle Database 23 Free (imagem `gvenzl/oracle-free`)
- Docker e Docker Compose
- PL/SQL

## Como rodar

1. Copie o arquivo de exemplo e defina as senhas:
```bash
   cp .env.example .env
```
2. Suba o banco:
```bash
   docker compose up -d
```
3. Aguarde o banco ficar pronto:
```bash
   docker logs agenda-oracle | grep "READY"
```
4. Conecte com o usuário definido no `.env`, no serviço `FREEPDB1`, porta `1521`.
5. Execute os scripts da pasta `scripts` na ordem numérica, de `0` a `7`.

## Modelo de dados

- **paciente**: nome, CPF e data de nascimento
- **medico**: nome, CRM e especialidade
- **consulta**: liga paciente e médico, com data/hora e status
- **log_consulta**: auditoria de cancelamentos (sem FK de propósito, para o
  histórico sobreviver mesmo se a consulta for removida)

## PL/SQL

| Objeto | Tipo | O que faz |
|---|---|---|
| `agendar_consulta` | Procedure | Agenda uma consulta e recusa se o médico já tiver horário ocupado |
| `qtd_consultas_dia` | Function | Retorna quantas consultas ativas um médico tem no dia |
| `trg_log_cancelamento` | Trigger | Grava no log automaticamente quando uma consulta é cancelada |
| `listar_agenda_dia` | Procedure com cursor | Percorre e imprime a agenda do médico no dia |

## Testes

O script `7_testes.sql` demonstra as regras em sequência: conflito de horário
recusado, agendamento válido, contagem do dia, cancelamento auditado e agenda impressa.