SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE insert_ambiente(
    p_id_ambiente       IN t_jv_ambiente.id_ambiente%TYPE,
    p_id_missao         IN t_jv_ambiente.id_missao%TYPE,
    p_nm_geolocalizacao IN t_jv_ambiente.nm_geolocalizacao%TYPE,
    p_nr_temperatura    IN t_jv_ambiente.nr_temperatura%TYPE,
    p_tp_fauna          IN t_jv_ambiente.tp_fauna%TYPE
) IS
    v_user VARCHAR2(50);
    v_sqlcode NUMBER;
BEGIN
    SELECT USER INTO v_user FROM dual;

    BEGIN
        INSERT INTO t_jv_ambiente (id_ambiente, id_missao, nm_geolocalizacao, nr_temperatura, tp_fauna)
        VALUES (p_id_ambiente, p_id_missao, p_nm_geolocalizacao, p_nr_temperatura, p_tp_fauna);
        COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        v_sqlcode := SQLCODE;

        INSERT INTO t_jv_log (id_log, nm_procedure, nm_usuario, dt_error, nr_error)
        VALUES (t_jv_log_seq.NEXTVAL, 'insert_ambiente', v_user, SYSDATE, v_sqlcode);

        DBMS_OUTPUT.PUT_LINE('Erro: Violação de índice duplicado. Registrado na tabela de log.');
    WHEN OTHERS THEN
        v_sqlcode := SQLCODE;

        INSERT INTO t_jv_log (id_log, nm_procedure, nm_usuario, dt_error, nr_error)
        VALUES (t_jv_log_seq.NEXTVAL, 'insert_ambiente', v_user, SYSDATE, v_sqlcode);
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro inesperado. Registrado na tabela de log.');
        RAISE;
END;

EXCEPTION
    WHEN VALUE_ERROR THEN
        v_sqlcode := SQLCODE;
        INSERT INTO t_jv_log (id_log, nm_procedure, nm_usuario, dt_error, nr_error)
        VALUES (t_jv_log_seq.NEXTVAL, 'insert_ambiente', v_user, SYSDATE, v_sqlcode);
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro de valor. Registrado na tabela de log.');
        RAISE;
END insert_ambiente;


DECLARE
BEGIN
    insert_ambiente(1, 1, 'Oceano Atlântico', '10°C', 'Marinha');
    insert_ambiente(2, 2, 'ceano Índico', '12°C', 'Marinha');
    insert_ambiente(3, 3, 'Oceano Glacial Ártico', '5°C', 'Marinha');
    insert_ambiente(4, 4, 'Oceano Glacial Antártico', '10°C', 'Marinha');
    insert_ambiente(5, 5, 'Oceano Pacifico', '18°C', 'Marinha');
END;

