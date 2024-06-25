SET SERVEROUTPUT ON;


-- Esse bloco An�nimo � responvavel por organizar as miss�es por ativas ou cloncluidas com base no DT_INICO E DT_FIM
DECLARE
  CURSOR c_missoes IS
    SELECT CASE
             WHEN dt_fim IS NULL THEN 'Ativas'
             ELSE 'Conclu�das'
           END AS status_missao,
           COUNT(*) AS total
    FROM t_jv_missao
    GROUP BY CASE
               WHEN dt_fim IS NULL THEN 'Ativas'
               ELSE 'Conclu�das'
             END;
  
  v_status_missao VARCHAR2(50);
  v_total NUMBER;
BEGIN
  OPEN c_missoes;
  LOOP
    FETCH c_missoes INTO v_status_missao, v_total;
    EXIT WHEN c_missoes%NOTFOUND;

    -- Tomada de decis�o: Exibir a quantidade de miss�es por status
    IF v_status_missao = 'Ativas' THEN
      DBMS_OUTPUT.PUT_LINE('Miss�es ' || v_status_missao || ' : ' || v_total);
    ELSE
      DBMS_OUTPUT.PUT_LINE('Miss�es ' || v_status_missao || ' : ' || v_total);
    END IF;
    
  END LOOP;
  CLOSE c_missoes;
END;

