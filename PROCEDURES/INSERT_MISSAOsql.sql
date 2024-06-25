SET SERVEROUTPUT ON;



CREATE OR REPLACE PROCEDURE insert_missao(
    p_id_missao IN t_jv_missao.id_missao%TYPE,
    p_id_drone  IN t_jv_missao.id_drone%TYPE,
    p_nm_missao IN t_jv_missao.nm_missao%TYPE,
    p_ds_missao IN t_jv_missao.ds_missao%TYPE,
    p_dt_inicio IN t_jv_missao.dt_inicio%TYPE,
    p_dt_fim    IN t_jv_missao.dt_fim%TYPE
) IS
    v_user VARCHAR2(50);
    v_sqlcode NUMBER;
BEGIN
    SELECT USER INTO v_user FROM dual;

    BEGIN
        INSERT INTO t_jv_missao (id_missao, id_drone, nm_missao, ds_missao, dt_inicio, dt_fim)
        VALUES (p_id_missao, p_id_drone, p_nm_missao, p_ds_missao, p_dt_inicio, p_dt_fim);
        COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        v_sqlcode := SQLCODE;

        INSERT INTO t_jv_log (id_log, nm_procedure, nm_usuario, dt_error, nr_error)
        VALUES (t_jv_log_seq.NEXTVAL, 'insert_missao', v_user, SYSDATE, v_sqlcode);

        DBMS_OUTPUT.PUT_LINE('Erro: Violação de índice duplicado. Registrado na tabela de log.');
    WHEN OTHERS THEN
        v_sqlcode := SQLCODE;

        INSERT INTO t_jv_log (id_log, nm_procedure, nm_usuario, dt_error, nr_error)
        VALUES (t_jv_log_seq.NEXTVAL, 'insert_missao', v_user, SYSDATE, v_sqlcode);
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro inesperado. Registrado na tabela de log.');
        RAISE;
END;

EXCEPTION
    WHEN VALUE_ERROR THEN
        v_sqlcode := SQLCODE;
        INSERT INTO t_jv_log (id_log, nm_procedure, nm_usuario, dt_error, nr_error)
        VALUES (t_jv_log_seq.NEXTVAL, 'insert_missao', v_user, SYSDATE, v_sqlcode);
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro de valor. Registrado na tabela de log.');
        RAISE;
END insert_missao;


DECLARE
BEGIN
    insert_missao(1, 1, 'Controle dos oceanos', 'inpeção por diversar areas do oceano', SYSDATE, NULL);
    insert_missao(2, 2, 'Controle dos oceanos', 'inpeção por lixo', SYSDATE, SYSDATE);
    insert_missao(3, 3, 'Controle dos oceanos', 'inpeção por pesca ilegal', SYSDATE, SYSDATE);
    insert_missao(4, 4, 'Controle dos oceanos', 'inpeção por resídos poluentes', SYSDATE, NULL);
    insert_missao(5, 5, 'Controle dos oceanos', 'inpeção por habitats', SYSDATE, NULL);
END;



