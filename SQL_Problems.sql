select a.nume, a.salariul, a.data_angajare, f.denumire_functie
from functii f, angajati a where a.id_functie = f.id_functie 
and a.data_angajare between to_date('01.01.1995','DD.MM.YYYY') 
and to_date('31.12.1999','DD.MM.YYYY') and f.denumire_functie  in ('Programmer',   'Accountant');

update rand_comenzi 
set pret = pret * 1.15
where pret <(select avg(r.pret) from rand_comenzi r, produse p where p.id_produs = r.id_produs and lower(p.denumire_produs) like '%sound%');

select a.id_angajat, a.nume, a.data_angajare, a.id_functie, i.id_functie from angajati a, istoric_functii i
where a.id_angajat = i.id_angajat  and a.id_departament in (50,80)and data_inceput between to_date('01.01.1995','DD.MM.YYYY') and to_date('31.12.1999','DD.MM.YYYY') ;

update rand_comenzi set pret = pret*0.95
where cantitate < (select avg(cantitate) from rand_comenzi r, produse p where r.id_produs = p.id_produs and p.denumire_produs like '%CPU%');

select denumire_produs, sum(cantitate*pret) from produse p, rand_comenzi r
where p.id_produs = r.id_produs group by denumire_produs
having sum(cantitate*pret) between 1500 and 4000;

select r.nr_comanda, c.data, sum(cantitate*pret), count(p.id_produs)
from produse p, rand_comenzi r, comenzi c
where p.id_produs = r.id_produs and c.nr_comanda = r.nr_comanda and INITCAP(c.modalitate) like '%Online%' group by r.nr_comanda, c.data;

select nr_comanda, denumire_produs, pret, cantitate, pret*cantitate
from produse p, rand_comenzi rc
where p.id_produs = rc.id_produs and Initcap(denumire_produs) like '%Monitor%';

select nume, id_departament, count(nr_comanda)
from angajati a, comenzi c
where a.id_angajat = c.id_angajat and id_departament = 80 and extract(month from data) = 11
group by nume, id_departament;

update rand_comenzi
set pret = pret*0.9
where pret >(select avg(pret) from rand_comenzi where id_produs = '3155');

select nume, denumire_functie, count(nr_comanda)
from angajati a, functii f, comenzi c
where a.id_functii = f.id_functii and a.id_angajat = c.id_angajat
group by nume, denumire_functie
having count(nr_comanda)>=2;

update rand_comenzi
set pret = pret*1.05
where cantitate*pret >=1000;
rollback;

select nume, count(nr_comanda), salariul, 
salariul*case
  when count(nr_comanda) between 1 and 2 then 1.05
  when count(nr_comanda) between 3 and 5 then 1.07
  else 1.1
  end bonus
from angajati a, comenzi c
where a.id_angajat = c.id_angajat
group by nume, salariul;

select co.nr_comanda, data, sum(cantitate*pret) 
from comenzi co, rand_comenzi rc
where co.nr_comanda=rc.nr_comanda and extract(year from data) = 1999
group by co.nr_comanda, data
having sum(cantitate*pret)>2000;

select c.nr_comanda, data, sum(cantitate*pret),
case when sum(cantitate*pret) < 1000 then 100
when sum(cantitate*pret) between 1000 and 2000 then 200
else 300
end cheltuieli_transport
from comenzi c, rand_comenzi r
where c.nr_comanda = r.nr_comanda
group by c.nr_comanda, data;

select cl.id_client, r.id_produs, sum(r.cantitate)
from clienti cl, rand_comenzi r, comenzi co
where cl.id_client = co.id_client and r.nr_comanda=co.nr_comanda
group by cl.id_client, r.id_produs;

select a.nume, d.denumire_departament, level
from angajati a, departamente d
where a.id_departament = d.id_departament and connect_by_isleaf = 0 and a.id_functie = (select id_functie from angajati where nume = 'Russell')
connect by prior a.id_angajat = a.id_manager
start with a.id_angajat = 100;

select nume from angajati
where CONNECT_BY_ISLEAF = 1 and id_functie= (select id_functie from angajati where nume = 'Rogers')
connect by prior id_angajat = id_manager;