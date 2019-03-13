CREATE SEQUENCE id_ang
INCREMENT BY 1 START WITH 0 MINVALUE 0;

CREATE SEQUENCE id_auto
INCREMENT BY 1 START WITH 100 MINVALUE 100;

CREATE TABLE angajat(
id_angajat NUMBER(4) CONSTRAINT pk_angajat PRIMARY KEY,
nume VARCHAR2(30) CONSTRAINT nn_angajat_nume NOT NULL,
prenume VARCHAR2(30) CONSTRAINT nn_angajat_prenume NOT NULL,
cnp VARCHAR2(13) CONSTRAINT nn_angajat_cnp NOT NULL,
salariu NUMBER(4) CONSTRAINT nn_angajat_salariu NOT NULL,
functie VARCHAR(30) CONSTRAINT nn_angajat_functie NOT NULL
);

ALTER TABLE angajat
MODIFY(nume VARCHAR2(40));

ALTER TABLE angajat
MODIFY(prenume VARCHAR2(40));


CREATE TABLE autovehicul
(id_autovehicul NUMBER(4) CONSTRAINT pk_autovehicul PRIMARY KEY,
data_fabricatiei DATE CONSTRAINT nn_autovehicul_dfabricatie NOT NULL,
consum NUMBER(2) CONSTRAINT nn_autovehicul_consum NOT NULL,
data_ultimei_revizii DATE,
id_angajat NUMBER(4) DEFAULT NULL,
FOREIGN KEY(id_angajat) REFERENCES angajat(id_angajat)
);


INSERT INTO angajat VALUES (id_ang.nextval,'Nastase' , 'Adriana' , '2950623452235' , '3000' , 'manager');
INSERT INTO angajat VALUES (id_ang.nextval,'Rusu' , 'Mihai' , '1850311423326' , '2500' , 'bucatar');
INSERT INTO angajat VALUES(id_ang.nextval,'Vintila' , 'Raul' , '1650826287704' , '1500' , 'sofer');
INSERT INTO angajat VALUES(id_ang.nextval,'Simion' , 'Cornel' , '1550919490004' , '1750' , 'sofer');
INSERT INTO angajat VALUES(id_ang.nextval,'Sendroiu' , 'Ion' , '1920305492204' , '1625' , 'sofer');
INSERT INTO angajat VALUES (id_ang.nextval,'Ionescu' , 'Burtoiu' , '1750228457732' , '1500','sofer');


INSERT INTO autovehicul VALUES (id_auto.nextval, '10-JAN-10',9,'5-SEP-15',NULL);
INSERT INTO autovehicul VALUES (id_auto.nextval, '25-MAR-1995',10,'6-SEP-15',NULL);
INSERT INTO autovehicul VALUES (id_auto.nextval , '15-JUN-05',5,'8-SEP-15',3);
INSERT INTO autovehicul VALUES (id_auto.nextval, '20-AUG-12',4,'9-SEP-15',4);
INSERT INTO autovehicul VALUES (id_auto.nextval , '23-FEB-13',6,'3-SEP-15',5);

CREATE TABLE descriere_tura(
id_tura NUMBER(4) CONSTRAINT pk_dt PRIMARY KEY,
descriere VARCHAR2(100) CONSTRAINT nn_dt_descriere NOT NULL
);

ALTER TABLE descriere_tura
MODIFY(descriere VARCHAR2(110));

INSERT INTO descriere_tura VALUES(1,'Intre orele 6 si 12');
INSERT INTO descriere_tura VALUES(2, 'Intre orele 12 si 18');
INSERT INTO descriere_tura VALUES(3,'Intre orele 18 si 24');
INSERT INTO descriere_tura VALUES(4, 'Intre orele 8 si 14');
INSERT INTO descriere_tura VALUES(5, 'Intre orele 14 si 20');

CREATE TABLE tura(
data DATE,
id_tura NUMBER(4),
id_angajat NUMBER(4),
CONSTRAINT PK_tura PRIMARY KEY (data,id_tura,id_angajat),
FOREIGN KEY (id_tura) REFERENCES descriere_tura(id_tura),
FOREIGN KEY (id_angajat) REFERENCES angajat(id_angajat)
);

INSERT INTO tura VALUES('11-JAN-2016' , 1,1);
INSERT INTO tura VALUES('11-JAN-2016',1,2);
INSERT INTO tura VALUES('11-JAN-2016',1,3);
INSERT INTO tura VALUES('11-JAN-2016',2,3);
INSERT INTO tura VALUES('11-JAN-2016',2,2);
INSERT INTO tura VALUES('11-JAN-2016',3,4);
INSERT INTO tura VALUES('11-JAN-2016',4,5);

CREATE TABLE client(
id_client NUMBER(4) CONSTRAINT pk_client PRIMARY KEY,
nume VARCHAR2(30) CONSTRAINT nn_client_nume NOT NULL,
prenume VARCHAR2(30) CONSTRAINT nn_client_prenume NOT NULL,
telefon VARCHAR2(10) CONSTRAINT nn_client_telefon NOT NULL,
adresa VARCHAR2(100) CONSTRAINT nn_client_adresa NOT NULL,
punct_de_reper VARCHAR2(30),
adresa2 VARCHAR2(100)
);

INSERT INTO client VALUES(1,'Radu' , 'Doru' , '0720192834' , 'Bucuresti, Calea Victoriei' , 'Langa Parcul Cismigiu' , NULL);
INSERT INTO client VALUES(2, 'Topliceanu' , 'Laura' , '0752348293' , 'Bucuresti, Strada Izvor' , NULL,NULL);
INSERT INTO client VALUES(3,'Amalia' , 'Raluca' , '0723948574' , 'Bucuresti, Strada Sergent Major Cara Anghel', NULL,NULL );
INSERT INTO client VALUES(4, 'Turcu' , 'Andrei' , '0723728444' , 'Bucuresti, Strada Crinul de Padure' , NULL,NULL);
INSERT INTO client VALUES(5, 'Ghenea' , 'Marcel' , '0728983456' , 'Bucuresti, Aleea Pravat' , NULL,NULL);

CREATE TABLE bon_fiscal(
id_bon_fiscal NUMBER(4) CONSTRAINT pk_bon PRIMARY KEY,
data DATE CONSTRAINT nn_bon_data NOT NULL,
ora NUMBER(2) CONSTRAINT nn_bon_ora NOT NULL,
id_client NUMBER(4),
id_angajat NUMBER(4),
FOREIGN KEY (id_client) REFERENCES client(id_client),
FOREIGN KEY (id_angajat) REFERENCES angajat(id_angajat)
);

INSERT INTO bon_fiscal VALUES(1,'11-JAN-2016',14,1,3);
INSERT INTO bon_fiscal VALUES(2,'11-JAN-2016',14,2,4);
INSERT INTO bon_fiscal VALUES(3,'11-JAN-2016',14,3,3);
INSERT INTO bon_fiscal VALUES(4,'11-JAN-2016',15,4,5);
INSERT INTO bon_fiscal VALUES(5,'11-JAN-2016',15,5,4);


CREATE TABLE meniu(
id_meniu NUMBER(4) CONSTRAINT pk_meniu PRIMARY KEY,
descriere VARCHAR2(100) CONSTRAINT nn_meniu_desc NOT NULL,
ora_inceput_servire NUMBER(2) CONSTRAINT nn_meniu_inceput NOT NULL,
ora_sfarsit_servire NUMBER(2) CONSTRAINT nn_meniu_sfarsit NOT NULL
);

INSERT INTO meniu VALUES(1 , 'Meniu standard', 6,24);
INSERT INTO meniu VALUES(2, 'Meniu promotional', 6,24);
INSERT INTO meniu VALUES(3, 'Meniu sezonier', 6,24);
INSERT INTO meniu VALUES(4, 'Meniu copii', 6,24);
INSERT INTO meniu VALUES(5, 'Meniu VIP', 6,24);


CREATE TABLE tip_mancare(
id_tip_mancare NUMBER(4) CONSTRAINT pk_tm PRIMARY KEY,
denumire VARCHAR2(100),
pret NUMBER(4,2) CONSTRAINT nn_tm_pret NOT NULL,
id_meniu NUMBER(4),
FOREIGN KEY (id_meniu) REFERENCES meniu(id_meniu)
);

ALTER TABLE tip_mancare
MODIFY denumire NOT NULL;


INSERT INTO tip_mancare VALUES(1,'Carnivora',20,1);
INSERT INTO tip_mancare VALUES(2,'Clasica',18,1);
INSERT INTO tip_mancare VALUES(3,'Diavola',22,1);
INSERT INTO tip_mancare VALUES(4,'Rustica',19,1);
INSERT INTO tip_mancare VALUES(5,'Taraneasca',17,1);

CREATE TABLE lista_bon_fiscal(
id_lista_bon_fiscal NUMBER(4),
cantitate NUMBER(4) CONSTRAINT nn_lbf_cantitate NOT NULL,
id_bon_fiscal NUMBER(4),
id_tip_mancare NUMBER(4),
CONSTRAINT pk_lbf PRIMARY KEY(id_lista_bon_fiscal, id_bon_fiscal , id_tip_mancare),
FOREIGN KEY (id_bon_fiscal) REFERENCES bon_fiscal(id_bon_fiscal),
FOREIGN KEY (id_tip_mancare) REFERENCES tip_mancare(id_tip_mancare)
);

ALTER TABLE lista_bon_fiscal
MODIFY(cantitate NUMBER(3));


INSERT INTO lista_bon_fiscal VALUES(1,2,1,1);
INSERT INTO lista_bon_fiscal VALUES(1,3,1,2);
INSERT INTO lista_bon_fiscal VALUES(2,1,2,3);
INSERT INTO lista_bon_fiscal VALUES(3,1,3,4);
INSERT INTO lista_bon_fiscal VALUES(4,1,4,5);

UPDATE angajat
SET nume = 'Popescu'
WHERE id_angajat = 3;

UPDATE angajat
SET functie = 'Sofer'
WHERE functie = 'sofer';

UPDATE angajat
SET functie = 'Bucatar'
WHERE functie = 'bucatar';

UPDATE angajat
SET functie = 'Manager'
WHERE functie = 'manager';

prompt 'Se pensioneaza angajatul cu id-ul 6'
DELETE FROM angajat
WHERE id_angajat = 6;

prompt 'Preturile se maresc cu 10% datorita cresterii TVA-ului';
UPDATE tip_mancare
SET pret = pret*1.1;

prompt 'Vizualizarea tuturor livrarilor astfel: angajatul ce a facut livrarea, clientul ce a primit livrarea si numarul bonului fiscal'
Select a.nume,a.prenume, c.nume Nume_Client, c.prenume Prenume_Client, b.id_bon_fiscal
FROM angajat a, client c, bon_fiscal b
WHERE a.id_angajat = b.id_angajat AND b.id_client = c.id_client;

prompt 'Vizualizarea numarului de comenzi livrate in ultima luna'
SELECT COUNT(ROWID)
FROM bon_fiscal
WHERE MONTHS_BETWEEN(sysdate , DATA) <1;

prompt 'Vizualizarea anterioara + tipul de mancare livrat si cantitatea din fiecare'
Select a.nume NumeAngajat, c.nume NumeClient, b.id_bon_fiscal IdBonFiscal,c.id_client, lb.cantitate Cantitate, tm.denumire Denumire, tm.pret Pret , lb.cantitate * tm.pret Valoare
FROM angajat a, client c, bon_fiscal b, lista_bon_fiscal lb, tip_mancare tm
WHERE a.id_angajat = b.id_angajat AND b.id_client = c.id_client AND b.id_bon_fiscal = lb.id_bon_fiscal AND tm.id_tip_mancare = lb.id_tip_mancare;

prompt 'Vizualizarea tuturor angajatilor si orele in care acestia au muncit'
SELECT *
FROM angajat a,tura t,descriere_tura dt
WHERE a.id_angajat = t.id_angajat AND t.id_tura = dt.id_tura;

prompt 'Vizualizarea soferilor si a autovehiculelor acestora'
SELECT a.nume,a.prenume,a.functie,au.id_autovehicul,au.data_fabricatiei,au.consum,au.data_ultimei_revizii
FROM angajat a, autovehicul au
WHERE au.id_angajat = a.id_angajat;

prompt 'Vizualizarea meniului'
SELECT tm.denumire, tm.pret
FROM tip_mancare tm, meniu m
WHERE tm.id_meniu = m.id_meniu;

prompt 'Afisarea angajatilor ce muncesc intre orele 6 si 12'
SELECT a.nume,a.prenume,a.functie,t.data,dt.descriere
FROM angajat a, tura t, descriere_tura dt
WHERE a.id_angajat = t.id_angajat AND dt.id_tura = t.id_tura AND dt.id_tura = 1;

prompt 'Afisarea tuturor clientilor ce au comandat in ultima luna'
SELECT *
FROM client c, bon_fiscal bf
WHERE c.id_client = bf.id_client AND MONTHS_BETWEEN(bf.data , sysdate) < 1;

prompt 'Afisarea tuturor soferilor'
SELECT *
FROM angajat
WHERE UPPER(functie) = 'SOFER';

prompt 'Afisarea functiilor si calificarile necesare pentru acestea'
SELECT functie,
CASE functie
WHEN 'Sofer' THEN 'Necesita propriul autovehicul'
WHEN 'Bucatar' THEN 'Minim 2 ani experienta'
WHEN 'Manager' THEN 'Studii economice superioare, experienta in domeniu reprezinta un plus'
END AS Calificari
FROM angajat
GROUP BY functie;

prompt 'Afisarea functiilor si calificarile necesare pentru acestea folosind DECODE'
SELECT functie, DECODE(functie, 'Sofer' , 'Necesita propriul autovehicul' , 
'Bucatar' , 'Minim 2 ani experienta' , 
'Manager' , 'Studii economice superioare, experienta in domeniu reprezinta un plus' , 
'Null')
as Calificari
FROM angajat
GROUP BY functie;

prompt 'Afisarea tuturor angajatilor ce castiga mai mult decat media salariilor tuturor angajatilor'
SELECT nume,prenume,salariu
FROM angajat
WHERE salariu > (SELECT avg(salariu) FROM angajat);

prompt 'Utilizarea UNION'
SELECT a.nume,a.prenume,au.id_autovehicul,au.data_fabricatiei
FROM angajat a, autovehicul au
WHERE au.id_angajat = a.id_angajat AND EXTRACT(year FROM au.data_fabricatiei) < 2013
UNION
SELECT a.nume,a.prenume,au.id_autovehicul,au.data_fabricatiei
FROM angajat a, autovehicul au
WHERE au.id_angajat = a.id_angajat AND EXTRACT(year FROM au.data_fabricatiei) >= 2013;

prompt 'Afisarea tuturor clientilor + NVL'
SELECT nume,prenume,adresa,NVL(punct_de_reper , 'Nu este precizat') , NVL(adresa2 , 'Nu este precizata')
FROM client;

SELECT functie, AVG(salariu) Salariul_Mediu
FROM angajat
GROUP BY functie
HAVING AVG(salariu) > 1500;

prompt 'Crearea unui view pentru accesarea mai convenienta a acestor date'
CREATE VIEW Necesitati_functii AS
SELECT functie, DECODE(functie, 'Sofer' , 'Necesita propriul autovehicul' , 
'Bucatar' , 'Minim 2 ani experienta' , 
'Manager' , 'Studii economice superioare, experienta in domeniu reprezinta un plus' , 
'Null')
as Calificari
FROM angajat
GROUP BY functie;

SELECT * FROM Necesitati_functii;

prompt 'Crearea unui sinonim'
CREATE SYNONYM angajati FOR angajat;

SELECT * from angajati;

CREATE SYNONYM autovehicule for autovehicul;

CREATE VIEW NoSoferi AS
SELECT *
FROM angajat
WHERE salariu >= 1500
MINUS 
SELECT *
FROM angajat
WHERE UPPER(functie) LIKE ('SOFER');

