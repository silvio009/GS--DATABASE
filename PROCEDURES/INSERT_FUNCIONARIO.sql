
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE insert_funcionario(
    p_id_funcionario IN t_jv_funcionario.id_funcionario%TYPE,
    p_nm_funcionario IN t_jv_funcionario.nm_funcionario%TYPE,
    p_nr_cpf         IN t_jv_funcionario.nr_cpf%TYPE,
    p_nm_cargo       IN t_jv_funcionario.nm_cargo%TYPE,
    p_cd_senha       IN t_jv_funcionario.cd_senha%TYPE
) IS
    v_user VARCHAR2(50);
    v_sqlcode NUMBER;
BEGIN
    SELECT USER INTO v_user FROM dual;


    BEGIN
        INSERT INTO t_jv_funcionario (id_funcionario, nm_funcionario, nr_cpf, nm_cargo, cd_senha)
        VALUES (p_id_funcionario, p_nm_funcionario, p_nr_cpf, p_nm_cargo, p_cd_senha);
        COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        v_sqlcode := SQLCODE;

        INSERT INTO t_jv_log (id_log, nm_procedure, nm_usuario, dt_error, nr_error)
        VALUES (t_jv_log_seq.NEXTVAL, 'insert_funcionario', v_user, SYSDATE, v_sqlcode);

        DBMS_OUTPUT.PUT_LINE('Erro: Violação de índice duplicado. Registrado na tabela de log.');
    WHEN OTHERS THEN
        v_sqlcode := SQLCODE;

        INSERT INTO t_jv_log (id_log, nm_procedure, nm_usuario, dt_error, nr_error)
        VALUES (t_jv_log_seq.NEXTVAL, 'insert_funcionario', v_user, SYSDATE, v_sqlcode);
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro inesperado. Registrado na tabela de log.');
        RAISE;
END;

EXCEPTION
    WHEN VALUE_ERROR THEN
        v_sqlcode := SQLCODE;
        INSERT INTO t_jv_log (id_log, nm_procedure, nm_usuario, dt_error, nr_error)
        VALUES (t_jv_log_seq.NEXTVAL, 'insert_funcionario', v_user, SYSDATE, v_sqlcode);
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro de valor. Registrado na tabela de log.');
        RAISE;
END insert_funcionario;



DECLARE
BEGIN
    insert_funcionario(1, 'Jorge', 0675530254, 'Operador Senior', 'senha123');
    insert_funcionario(2, 'Maria', 0654321987, 'Operador', 'senha456');
    insert_funcionario(3, 'Carlos', 0698765432, 'Operador', 'senha789');
    insert_funcionario(4, 'Ana', 0612345678, 'Assistente Operador', 'senhaABC');
    insert_funcionario(5, 'Pedro', 0632109876, 'analista', 'senhaXYZ');
END;















