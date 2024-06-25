
SET SERVEROUTPUT ON;


-- Esse bloco Anônimo é responvavel por contar quantos funcionarios tem em cada cargo
DECLARE
  CURSOR c_cargos IS
    SELECT nm_cargo, COUNT(*) AS total
    FROM t_jv_funcionario
    GROUP BY nm_cargo;
  
  v_nm_cargo t_jv_funcionario.nm_cargo%TYPE;
  v_total NUMBER;
BEGIN
  OPEN c_cargos;
  LOOP
    FETCH c_cargos INTO v_nm_cargo, v_total;
    EXIT WHEN c_cargos%NOTFOUND;

    -- Tomada de decisão: Exibir a quantidade de funcionários por cargo
    DBMS_OUTPUT.PUT_LINE('Cargo: ' || v_nm_cargo || ' tem ' || v_total || ' funcionários.');
    
  END LOOP;
  CLOSE c_cargos;
END;

