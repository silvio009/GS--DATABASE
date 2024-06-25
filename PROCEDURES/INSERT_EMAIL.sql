SET SERVEROUTPUT ON;


CREATE OR REPLACE PROCEDURE insert_email(
    p_id_email       IN t_jv_email.id_email%TYPE,
    p_id_funcionario IN t_jv_email.id_funcionario%TYPE,
    p_nm_email       IN t_jv_email.nm_email%TYPE,
    p_ds_email       IN t_jv_email.ds_email%TYPE,
    p_st_email       IN t_jv_email.st_email%TYPE
) IS
    v_user VARCHAR2(50);
    v_sqlcode NUMBER;
BEGIN
    SELECT USER INTO v_user FROM dual;

    BEGIN
        INSERT INTO t_jv_email (id_email, id_funcionario, nm_email, ds_email, st_email)
        VALUES (p_id_email, p_id_funcionario, p_nm_email, p_ds_email, p_st_email);
        COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        v_sqlcode := SQLCODE;

        INSERT INTO t_jv_log (id_log, nm_procedure, nm_usuario, dt_error, nr_error)
        VALUES (t_jv_log_seq.NEXTVAL, 'insert_email', v_user, SYSDATE, v_sqlcode);

        DBMS_OUTPUT.PUT_LINE('Erro: Violação de índice duplicado. Registrado na tabela de log.');
    WHEN OTHERS THEN
        v_sqlcode := SQLCODE;

        INSERT INTO t_jv_log (id_log, nm_procedure, nm_usuario, dt_error, nr_error)
        VALUES (t_jv_log_seq.NEXTVAL, 'insert_email', v_user, SYSDATE, v_sqlcode);
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro inesperado. Registrado na tabela de log.');
        RAISE;
END;

EXCEPTION
    WHEN VALUE_ERROR THEN
        v_sqlcode := SQLCODE;
        INSERT INTO t_jv_log (id_log, nm_procedure, nm_usuario, dt_error, nr_error)
        VALUES (t_jv_log_seq.NEXTVAL, 'insert_email', v_user, SYSDATE, v_sqlcode);
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro de valor. Registrado na tabela de log.');
        RAISE;
END insert_email;




DECLARE
BEGIN
    insert_email(1, 1, 'joao.silva@email.com', 'Pessoal', 'Ativo');
    insert_email(2, 2, 'Maria@email.com', 'Pessoal', 'Ativo');
    insert_email(3, 3, 'Carlos@email.com', 'Pessoal', 'Ativo');
    insert_email(4, 4, 'Ana@email.com', 'Pessoal', 'Ativo');
    insert_email(5, 5, 'Pedro@email.com', 'Pessoal', 'Ativo');
END;



