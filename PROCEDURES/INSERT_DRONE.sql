SET SERVEROUTPUT ON;


CREATE OR REPLACE PROCEDURE insert_drone(
    p_id_drone      IN t_jv_drone.id_drone%TYPE,
    p_nm_modelo     IN t_jv_drone.nm_modelo%TYPE,
    p_nm_funcao     IN t_jv_drone.nm_funcao%TYPE,
    p_nm_fabricante IN t_jv_drone.nm_fabricante%TYPE,
    p_nr_distancia  IN t_jv_drone.nr_distancia%TYPE,
    p_tp_bateria    IN t_jv_drone.tp_bateria%TYPE
) IS
    v_user VARCHAR2(50);
    v_sqlcode NUMBER;
BEGIN
    SELECT USER INTO v_user FROM dual;

    BEGIN
        INSERT INTO t_jv_drone (id_drone, nm_modelo, nm_funcao, nm_fabricante, nr_distancia, tp_bateria)
        VALUES (p_id_drone, p_nm_modelo, p_nm_funcao, p_nm_fabricante, p_nr_distancia, p_tp_bateria);
        COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        v_sqlcode := SQLCODE;

        INSERT INTO t_jv_log (id_log, nm_procedure, nm_usuario, dt_error, nr_error)
        VALUES (t_jv_log_seq.NEXTVAL, 'insert_drone', v_user, SYSDATE, v_sqlcode);

        DBMS_OUTPUT.PUT_LINE('Erro: Violação de índice duplicado. Registrado na tabela de log.');
    WHEN OTHERS THEN
        v_sqlcode := SQLCODE;

        INSERT INTO t_jv_log (id_log, nm_procedure, nm_usuario, dt_error, nr_error)
        VALUES (t_jv_log_seq.NEXTVAL, 'insert_drone', v_user, SYSDATE, v_sqlcode);
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro inesperado. Registrado na tabela de log.');
        RAISE;
END;

EXCEPTION
    WHEN VALUE_ERROR THEN
        v_sqlcode := SQLCODE;
        INSERT INTO t_jv_log (id_log, nm_procedure, nm_usuario, dt_error, nr_error)
        VALUES (t_jv_log_seq.NEXTVAL, 'insert_drone', v_user, SYSDATE, v_sqlcode);
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro de valor. Registrado na tabela de log.');
        RAISE;
END insert_drone;


DECLARE
BEGIN
    insert_drone(1, 'Drone DJI Mini 3 Pro Fly More', 'Monitoramento', 'loja DJI', '100m', 'Bateria longa');
    insert_drone(2, 'Yellow Drone', 'Inspeção', 'loja DJI', '100m', 'Bateria curta');
    insert_drone(3, 'Drone DJI Mini 4 Pro DJI RC 2', 'Monitoramento', 'loja DJI', '100m', 'Bateria media');
    insert_drone(4, 'Drone Zangão - E88 Pro', 'Monitoramento', 'loja DJI', '100m', 'Bateria longa');
    insert_drone(5, 'Drone elite pro', 'Monitoramento', 'loja DJI', '200m', 'Bateria longa');
END;

