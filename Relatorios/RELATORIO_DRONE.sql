SET SERVEROUTPUT ON;


-- Esse bloco de Anônimo é respnsavel por pegar os tipos de drones que estão disponiveis para uso
DECLARE
  CURSOR c_funcoes IS
    SELECT nm_funcao, COUNT(*) AS total
    FROM t_jv_drone
    GROUP BY nm_funcao;
  
  v_nm_funcao t_jv_drone.nm_funcao%TYPE;
  v_total NUMBER;
BEGIN
  OPEN c_funcoes;
  LOOP
    FETCH c_funcoes INTO v_nm_funcao, v_total;
    EXIT WHEN c_funcoes%NOTFOUND;

    -- Tomada de decisão: Exibir mensagem específica para diferentes funções de monitoramento marítimo
    IF v_nm_funcao = 'Inspeção' THEN
      DBMS_OUTPUT.PUT_LINE('Função: ' || v_nm_funcao || ' tem ' || v_total || ' drones dedicados à inspeção de áreas marítimas.');
    ELSIF v_nm_funcao = 'Carga' THEN
      DBMS_OUTPUT.PUT_LINE('Função: ' || v_nm_funcao || ' tem ' || v_total || ' drones dedicados à carga de suprimentos marítimos.');
    ELSIF v_nm_funcao = 'Monitoramento' THEN
      DBMS_OUTPUT.PUT_LINE('Função: ' || v_nm_funcao || ' tem ' || v_total || ' drones dedicados ao monitoramento marítimo.');
    ELSE
      DBMS_OUTPUT.PUT_LINE('Função: ' || v_nm_funcao || ' tem ' || v_total || ' drones.');
    END IF;
    
  END LOOP;
  CLOSE c_funcoes;
END;

