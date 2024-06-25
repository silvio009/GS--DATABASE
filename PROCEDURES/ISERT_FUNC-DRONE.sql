
SET SERVEROUTPUT ON;


CREATE OR REPLACE PROCEDURE insert_func_drone(
    p_id_drone       IN t_jv_func_drone.id_drone%TYPE,
    p_id_funcionario IN t_jv_func_drone.id_funcionario%TYPE
) IS
    v_user VARCHAR2(50);
    v_sqlcode NUMBER;
BEGIN
    SELECT USER INTO v_user FROM dual;

    BEGIN
        INSERT INTO t_jv_func_drone (id_drone, id_funcionario)
        VALUES (p_id_drone, p_id_funcionario);
        COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        v_sqlcode := SQLCODE;

        INSERT INTO t_jv_log (id_log, nm_procedure, nm_usuario, dt_error, nr_error)
        VALUES (t_jv_log_seq.NEXTVAL, 'insert_func_drone', v_user, SYSDATE, v_sqlcode);

        DBMS_OUTPUT.PUT_LINE('Erro: Violação de índice duplicado. Registrado na tabela de log.');
    WHEN OTHERS THEN
        v_sqlcode := SQLCODE;

        INSERT INTO t_jv_log (id_log, nm_procedure, nm_usuario, dt_error, nr_error)
        VALUES (t_jv_log_seq.NEXTVAL, 'insert_func_drone', v_user, SYSDATE, v_sqlcode);
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro inesperado. Registrado na tabela de log.');
        RAISE;
END;

EXCEPTION
    WHEN VALUE_ERROR THEN
        v_sqlcode := SQLCODE;
        INSERT INTO t_jv_log (id_log, nm_procedure, nm_usuario, dt_error, nr_error)
        VALUES (t_jv_log_seq.NEXTVAL, 'insert_func_drone', v_user, SYSDATE, v_sqlcode);
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro de valor. Registrado na tabela de log.');
        RAISE;
END insert_func_drone;


DECLARE
BEGIN
    insert_func_drone(1, 1);
    insert_func_drone(2, 2);
    insert_func_drone(3, 3);
    insert_func_drone(4, 4);
    insert_func_drone(5, 5);
END;

