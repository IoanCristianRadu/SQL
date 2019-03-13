Select sysdate
from dual;

SELECT ROUND(months_between(sysdate, '15-NOV-15'))
FROM dual;

SELECT months_between(sysdate, '15-MAR-15')
FROM dual;

CREATE TABLE firme
(codfirma NUMBER(2) CONSTRAINT PKey_firme PRIMARY KEY,
denfirma VARCHAR2(20) NOT NULL,
loc VARCHAR2(20),
zona VARCHAR2(15) CONSTRAINT FZONA_CK check (zona IN ('Moldova','Ardeal','Banat','Muntenia','Dobrogea','Transilvania')));


CREATE TABLE agenti
(codagent VARCHAR2(3) CONSTRAINT pk_agent PRIMARY KEY,
numeagent VARCHAR2(25) NOT NULL,
dataang DATE DEFAULT SYSDATE,
datanast DATE,
functia VARCHAR2(20),
codfirma NUMBER(2),
CONSTRAINT FK_agenti FOREIGN KEY (codfirma) REFERENCES firme(codfirma));

CREATE TABLE fosti_agenti
AS
SELECT codagent,numeagent, functia,codfirma 
FROM agenti;

CREATE TABLE salariati AS SELECT * FROM angajati WHERE 2=3;
INSERT INTO salariati (id_angajat, nume, salariul) VALUES (207, 'Ionescu', 4000);
INSERT INTO salariati (id_angajat, nume, salariul) VALUES (207, 'Poppescu', 4200);
SELECT * FROM salariati;

INSERT INTO salariati
SELECT *
FROM angajati
WHERE id_departament IN ('20','30','50');
COMMIT;

INSERT INTO salariati(id_angajat)
VALUES (&id_angajat);

UPDATE salariati
SET salariul = salariul + 100
WHERE salariul < 3000;

SELECT *
FROM salariati

UPDATE salariati
SET salariul = (SELECT salariul FROM salariati WHERE id_angajat = 125)
WHERE id_manager = 122;

UPDATE salariati
SET (salariul,comision) = (SELECT salariul,comision FROM salariati WHERE id_angajat = 167)
WHERE salariul < (SELECT salariul FROM salariati WHERE id_angajat = 173 AND id_departament = 50);

DELETE FROM salariati
WHERE data_angajare < TO_DATE('01-JAN-99' , 'DD-MM-YY');

DELETE FROM salariati
SELECT * FROM salariati;

ROLLBACK salariati;

SELECT * FROM salariati;
