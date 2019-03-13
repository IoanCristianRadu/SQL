1)-- Operatorul UNION (suprima duplicatele) si UNION ALL
select prenume, id_departament
from angajati 
where prenume = 'Kevin'
union all
select prenume_client, null
from clienti
where prenume_client = 'Kevin';

2)-- Operatorul UNION utilizat pentru FULL JOIN
select id_angajat, nume, a.id_departament, denumire_departament
from angajati a, departamente d
where a.id_departament(+) = d.id_departament
union
select id_angajat, nume, a.id_departament, denumire_departament
from angajati a, departamente d
where a.id_departament = d.id_departament(+);

3)-- Operatorul INTERSECT
select nume, salariul, salariul*(1+nvl(comision,0)) venit, comision
from angajati
intersect
select nume, salariul, salariul venit, comision
from angajati;

4)-- Operatorul MINUS
select nume, salariul, salariul*(1+nvl(comision,0)) venit, comision
from angajati
minus
select nume, salariul, salariul venit, comision
from angajati;

5)--operatorul minus pentru a afisa clientii care nu au nicio comanda
select nume_client, nr_comanda
from  clienti c, comenzi co
where c.id_client = co.id_client(+)
minus
select nume_client, nr_comanda
from  clienti c, comenzi co
where c.id_client = co.id_client;

select nume_client, nr_comanda
from  clienti c, comenzi co
where c.id_client = co.id_client(+)
minus
select nume_client, prenume_client, nr_comanda
from  clienti c, comenzi co
where c.id_client = co.id_client;

select nume_client, prenume_client, nr_comanda
from  clienti c, comenzi co
where c.id_client = co.id_client(+)
and nr_comanda is null;
6)-- sa se afiseze doar departamentele in care toti angajatii au salariul <10000
-- prima metoda --> prin functia de grup
select id_departament
from angajati 
group by id_departament 
having max(salariul) < 10000;

7)-- a doua metoda --> cu operatorul MINUS
select id_departament
from angajati 
minus
select id_departament
from angajati 
where salariul >=10000;

8)-- a treia metoda cu operatorul IN si o subcerere
select distinct id_departament
from angajati 
where nvl(id_departament,0) not in (select id_departament from angajati where salariul >=10000);

9)--functii de grup
select co.nr_comanda, data, sum(pret*cantitate)
from comenzi co, rand_comenzi r
where co.nr_comanda=r.nr_comanda
group by co.nr_comanda, data;

--10)
select avg(max(salariul))
from angajati
group by id_departament;


-- Exercitii recapitulative
-- 1) Sa se afiseze numele, salariul, data angajarii, denumirea functiei pentru angajatii care 
--au functia Programmer sau Accountant si au fost angajati intre 1995 si 1998.
select a.nume, a.salariul, a.data_angajare, f.denumire_functie
from functii f, angajati a where a.id_functie = f.id_functie 
and a.data_angajare between to_date('01.01.1995','DD.MM.YYYY') 
and to_date('31.12.1999','DD.MM.YYYY') and f.denumire_functie  in ('Programmer',   'Accountant');

-- 2) Sa se realizeze o operatie de modificare a pretului la produse astfel incat noul pret sa se
--mareasca cu 15% pentru toate produsele care au pretul mai mic decat pretul mediu al produsului care contine denumirea cuvantunl sound  (se actualizeaza tabela  rand_comenzi). La final sa se anuleze operatia de actualizare.
update rand_comenzi 
set pret = pret * 1.15
where pret <(select avg(r.pret) from rand_comenzi r, produse p where p.id_produs = r.id_produs and lower(p.denumire_produs) like '%sound%');

-- 3) Sa se afiseze numele, data angajarii, functia actuala si functiile detinute de angajatii 
--din departamentele 50 si 80 in perioada 1995-1999.
select a.id_angajat, a.nume, a.data_angajare, a.id_functie, i.id_functie from angajati a, istoric_functii i
where a.id_angajat = i.id_angajat  and a.id_departament in (50,80)and data_inceput between to_date('01.01.1995','DD.MM.YYYY') and to_date('31.12.1999','DD.MM.YYYY') ;

-- 4) Sa se realizeze o operatie de modificare a pretului la produse astfel incat noul pret sa se micsoreze cu 5% pentru toate produsele care au cantitatea comandata mai mica decat cantitatea medie comandata din produsul cu denumireacare conþine CPU. (se actualizeaza tabela  rand_comenzi). La final sa se anuleze operatia de actualizare.
update rand_comenzi set pret = pret*0.95
where cantitate < (select avg(cantitate) from rand_comenzi r, produse p where r.id_produs = p.id_produs and p.denumire_produs like '%CPU%');

-- 5) Sa se afiseze denumirea produselor si valoarea totala comandata a acestora (sum(cantitate*pret)
--cuprinsa intre 1500 si 4000.
select denumire_produs, sum(cantitate*pret) from produse p, rand_comenzi r
where p.id_produs = r.id_produs group by denumire_produs
having sum(cantitate*pret) between 1500 and 4000;

-- 6) Sa se afiseze numarul comenzii, data, valoarea totala (sum(cantitate*pret)), numarul de 
--produse pentru comenzile online incheiate in perioada 1999-2000 si contin cel putin 2 produse.
select r.nr_comanda, c.data, sum(cantitate*pret), count(p.id_produs)
from produse p, rand_comenzi r, comenzi c
where p.id_produs = r.id_produs and c.nr_comanda = r.nr_comanda and INITCAP(c.modalitate) like '%Online%' group by r.nr_comanda, c.data;

-- 7) Sa se afiseze numarul comenzii, denumirea produsului, pretul, cantitatea si valoarea pentru produsele care contin in denumire cuvantul  Monitor.
select nr_comanda, denumire_produs, pret, cantitate, pret*cantitate
from produse p, rand_comenzi rc
where p.id_produs = rc.id_produs and Initcap(denumire_produs) like '%Monitor%';

-- 8) Sã se afiºeze numele, id-ul departamentului si numãrul de comenzi incheiate de angajatii din departamentul 80 in luna noiembrie. 
select nume, id_departament, count(nr_comanda)
from angajati a, comenzi c
where a.id_angajat = c.id_angajat and id_departament = 80 and extract(month from data) = 11
group by nume, id_departament;

-- 9) Sa se realizeze actualizarea pretului la produse astfel incat noul pret sa se micsoreze cu 10% pentru toate produsele care au pretul mai 
--mare decat al pretul mediu al produsului cu id-ul ‘3155’ (se actualizeaza tabela  rand_comenzi). La final sa se anuleze actualizarea.
update rand_comenzi
set pret = pret*0.9
where pret >(select avg(pret) from rand_comenzi where id_produs = '3155');

-- 10) Sa se afiseze numele, denumirea functiei,  numarul de comenzi pentru angajatii care au incheiat cel putin 2 comenzi.
select nume, denumire_functie, count(nr_comanda)
from angajati a, functii f, comenzi c
where a.id_functii = f.id_functii and a.id_angajat = c.id_angajat
group by nume, denumire_functie
having count(nr_comanda)>=2;

-- 11) Sa se realizeze actualizarea pretului la produse astfel incat noul pret sa se mareasca cu 5% pentru toate produsele care au valoarea 
--comandata (cantitate*pret)  mai mare sau egala cu 1000 (se actualizeaza tabela  rand_comenzi). La final sa se anuleze operatia de actualizare.
update rand_comenzi
set pret = pret*1.05
where cantitate*pret >=1000;
rollback;

-- 12) Sa se afiseze numele, numarul de comenzi, salariul si bonusul fiecarui angajat. Bonusul se va calcula in functie de numarul de comenzi incheiate, astfel:
--	intre 1-2 comenzi – 5% din salariul lunar;
--	intre 3-5 comenzi – 7% din salariul lunar;
--	mai mult de 5 comenzi – 10% din salariul lunar.
select nume, count(nr_comanda), salariul, 
salariul*case
  when count(nr_comanda) between 1 and 2 then 1.05
  when count(nr_comanda) between 3 and 5 then 1.07
  else 1.1
  end bonus
from angajati a, comenzi c
where a.id_angajat = c.id_angajat
group by nume, salariul;

-- 13) Sa se afiseze nr_comanda, data, valoarea comenzii, pentru comenzile incheiate in 1999 cu valoarea totala (sum(cantitate*pret)) mai mare de 2000, în ordinea datei.
select co.nr_comanda, data, sum(cantitate*pret) 
from comenzi co, rand_comenzi rc
where co.nr_comanda=rc.nr_comanda and extract(year from data) = 1999
group by co.nr_comanda, data
having sum(cantitate*pret)>2000;

-- 14) Sa se afiseze numarul comenzii, data, valoarea totala comandata  (sum(cantitate*pret)) si sa se calculeze cheltuielile de transport pentru livrarea acestora astfel:
--	pentru comenzi cu valoarea de pana la 1000 cheltuielile de transport sa fie de 100
--	pentru comenzi cu valoarea 1000  si 2000 cheltuielile de transport sa fie de 200
--	pentru comenzi cu valoarea mai mare de 2000 cheltuielile de transport sa fie de 300
select c.nr_comanda, data, sum(cantitate*pret),
case when sum(cantitate*pret) < 1000 then 100
when sum(cantitate*pret) between 1000 and 2000 then 200
else 300
end cheltuieli_transport
from comenzi c, rand_comenzi r
where c.nr_comanda = r.nr_comanda
group by c.nr_comanda, data;

-- 15) Sa se afiseze id_client, id_produs si cantitatea totala din fiecare produs, vanduta unui client.
select cl.id_client, r.id_produs, sum(r.cantitate)
from clienti cl, rand_comenzi r, comenzi co
where cl.id_client = co.id_client and r.nr_comanda=co.nr_comanda
group by cl.id_client, r.id_produs;

-- 16) Sa se afiseze numele, denumirea departamentului unde lucreaza si nivelul ierarhic pentru toti angajatii care au subordonati si care au 
--aceeasi functie ca angajatul Russell.
select a.nume, d.denumire_departament, level
from angajati a, departamente d
where a.id_departament = d.id_departament and connect_by_isleaf = 0 and a.id_functie = (select id_functie from angajati where nume = 'Russell')
connect by prior a.id_angajat = a.id_manager
start with a.id_angajat = 100;

-- 17) Sa se afiseze numele angajatilor care nu au subalterni si care au aceeasi functie ca angajatul Rogers, nivelul ierarhic si denumirea departamentului unde acestia lucreaza.
select nume from angajati
where CONNECT_BY_ISLEAF = 1 and id_functie= (select id_functie from angajati where nume = 'Rogers')
connect by prior id_angajat = id_manager;