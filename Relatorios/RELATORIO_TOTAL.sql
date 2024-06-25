SET SERVEROUTPUT ON;

-- Esse bloco de Anônimo é respnsavel gerar um tabela com todos os valores agrupador e com sub-total e total
DECLARE
    v_total_geral NUMBER := 0;
BEGIN
    FOR r IN (SELECT id_drone, nm_modelo, nm_funcao, nm_fabricante, nr_distancia, tp_bateria
              FROM t_jv_drone
              ORDER BY nm_modelo)
    LOOP
        DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('||' || RPAD('id_drone', 10) || RPAD('nm_modelo', 15) || RPAD('nm_funcao', 15) || RPAD('nm_fabricante', 15) || RPAD('nr_distancia', 15) || 'tp_bateria');
        FOR drone IN (SELECT * FROM t_jv_drone WHERE nm_modelo = r.nm_modelo)
        LOOP
            DBMS_OUTPUT.PUT_LINE('||' || RPAD(drone.id_drone, 10) || RPAD(drone.nm_modelo, 15) || RPAD(drone.nm_funcao, 15) || RPAD(drone.nm_fabricante, 15) || RPAD(drone.nr_distancia, 15) || drone.tp_bateria);
        END LOOP;
        
        -- Calcular subtotal
        DECLARE
            v_subtotal NUMBER := 0;
        BEGIN
            FOR sub_r IN (SELECT nr_distancia
                          FROM t_jv_drone
                          WHERE nm_modelo = r.nm_modelo)
            LOOP
                DECLARE
                    v_nr_distancia NUMBER;
                BEGIN
                    v_nr_distancia := TO_NUMBER(REPLACE(sub_r.nr_distancia, 'm', ''));
                    v_subtotal := v_subtotal + v_nr_distancia;
                EXCEPTION
                    WHEN VALUE_ERROR THEN
                        DBMS_OUTPUT.PUT_LINE('Erro ao converter um valor para número. Verifique os dados na coluna nr_distancia.');
                        DBMS_OUTPUT.PUT_LINE('Valor problemático: ' || sub_r.nr_distancia);
                END;
            END LOOP;
            DBMS_OUTPUT.PUT_LINE('||' || RPAD('Sub-Total', 10) || RPAD('', 15) || v_subtotal);
            v_total_geral := v_total_geral + v_subtotal;
        END;
    END LOOP;
    
    -- Exibir total geral
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('||' || RPAD('Total Geral : ', 14) || RPAD('', 15) || v_total_geral);
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------------------------------------');
END;



