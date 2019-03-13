//Creating a database based on the columns of another database

CREATE TABLE nume_tabela
AS
SELECT [*, nume coloane] FROM nume_tabela_sursa
[WHERE conditie];

INSERT INTO salariati(id_angajat)
VALUES (&id_angajat);

UPDATE salariati
SET (salariul,comision) = (SELECT salariul,comision FROM salariati WHERE id_angajat = 167)
WHERE salariul < (SELECT salariul FROM salariati WHERE id_angajat = 173 AND id_departament = 50);

MERGE INTO salariati USING angajati 
ON (salariati.id_angajat = angajati.id_angajat)
WHEN MATCHED THEN 
UPDATE SET salariati.salariul=angajati.salariul
WHEN NOT MATCHED THEN
INSERT  (id_angajat, nume, salariul) VALUES (angajati.id_angajat, angajati.nume, angajati.salariul);

CONSTRAINT FK_agenti FOREIGN KEY (codfirma) REFERENCES firme(codfirma));


GROUP BY	se precizeaza campul dupa care vor fi grupate datele in cazul expresiilor si functiilor de grup (SUM(), AVG(), COUNT(), MIN(), MAX());
HAVING		in cazul functiilor de grup conditiile impuse acestora se precizeaza in clauza HAVING;
ORDER BY	precizeaza ordonarea in functie un anumite campuri ascendent (ASC) – implicit sau descendent (DESC). Numai ORDER BY permite utilizarea aliasului;



LOWER() , UPPER() , INITCAP() , ||

CONCAT() , LENGHT() , SUBSTR('MAMALIGA' , 2 , 3) = AMA


ROUND(45.923 , 2) = 45.92   // --0,++++ , TRUNC(45.923 , 2) = 45.92
ROUND(45.923 , 0) = 46 , TRUNC(45.932 , 0) = 45

ROUND(data , 'MONTH')
ROUND - rotunjire clasica
TRUNC - prin scadere

MONTHS_BETWEEN() , ADD_MONTHS() , NEXT_DAY(data, 'FRIDAY') , LAST_DAY()

EXTRACT(YEAR FROM data) ,EXTRACT(MONTH FROM data) , EXTRACT(DAY FROM data)    // -------------------!! returneaza mereu numere

NVL(comision , 0), 
NVL2(comision, 1, 0) //1 daca are comision, 0 daca nu are , 
NULLIF(1,1) = NULL
NULLIF(1 , 2) = 1
COALESCE -> coalesce(id_manager,commission,-1) = afiseaza id_manager, daca NULL -> afiseaza commision , daca NULL -> afiseaza -1

________________________

Functii de grup

AVG([DISTINCT|ALL] n) – calculeaza media aritmetica a valorilor
COUNT(* | [DISTINCT|ALL] expr) – intoarce numarul total al valorilor
MAX([DISTINCT|ALL] expr) – intoarce valoarea maxima MIN([DISTINCT|ALL] expr) – intoarce valoarea minima
SUM([DISTINCT|ALL] n) – calculeaza suma valorilor





