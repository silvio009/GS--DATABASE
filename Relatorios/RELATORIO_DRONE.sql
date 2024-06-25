SET SERVEROUTPUT ON;


-- Esse bloco de An�nimo � respnsavel por pegar os tipos de drones que est�o disponiveis para uso
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

    -- Tomada de decis�o: Exibir mensagem espec�fica para diferentes fun��es de monitoramento mar�timo
    IF v_nm_funcao = 'Inspe��o' THEN
      DBMS_OUTPUT.PUT_LINE('Fun��o: ' || v_nm_funcao || ' tem ' || v_total || ' drones dedicados � inspe��o de �reas mar�timas.');
    ELSIF v_nm_funcao = 'Carga' THEN
      DBMS_OUTPUT.PUT_LINE('Fun��o: ' || v_nm_funcao || ' tem ' || v_total || ' drones dedicados � carga de suprimentos mar�timos.');
    ELSIF v_nm_funcao = 'Monitoramento' THEN
      DBMS_OUTPUT.PUT_LINE('Fun��o: ' || v_nm_funcao || ' tem ' || v_total || ' drones dedicados ao monitoramento mar�timo.');
    ELSE
      DBMS_OUTPUT.PUT_LINE('Fun��o: ' || v_nm_funcao || ' tem ' || v_total || ' drones.');
    END IF;
    
  END LOOP;
  CLOSE c_funcoes;
END;

