DROP TABLE klub_sezona;
DROP TABLE statistika;
DROP TABLE najbolji_igrac;
DROP TABLE najbolji_trener;
DROP TABLE sezona;
DROP TABLE igrac;
DROP TABLE klub;
DROP TABLE trener;
DROP TABLE college;
DROP TABLE arena;
DROP TABLE grad;



CREATE TABLE grad(
    grad_id INTEGER CONSTRAINT grad_id_pk PRIMARY KEY,
    naziv VARCHAR2(60) NOT NULL,
    state VARCHAR2(60) NOT NULL,
    država VARCHAR2(60) DEFAULT 'SAD' NOT NULL
);

CREATE TABLE arena(
    arena_id INTEGER CONSTRAINT arena_id_pk PRIMARY KEY,
    naziv VARCHAR2(60) NOT NULL,
    kapacitet VARCHAR2(60) NOT NULL,
    cijena_ulaznice VARCHAR2(60) NOT NULL,
    grad_id INTEGER CONSTRAINT grad_fk_arena_id REFERENCES grad(grad_id)
);

CREATE TABLE college(
    college_id INTEGER CONSTRAINT college_id_pk PRIMARY KEY,
    naziv VARCHAR2(60) NOT NULL,
    grad VARCHAR2(60) NOT NULL
); 

CREATE TABLE trener(
    trener_id INTEGER CONSTRAINT trener_id_pk PRIMARY KEY,
    ime VARCHAR2(60) NOT NULL,
    prezime VARCHAR2(60) NOT NULL,
    dat_rodenja DATE
);

CREATE TABLE klub(
    klub_id INTEGER CONSTRAINT klub_id_pk PRIMARY KEY,
    naziv VARCHAR2(60) NOT NULL,
    konferencija VARCHAR2(60) NOT NULL,
    maskota VARCHAR2(13) DEFAULT 'Nema maskotu',
    godina_osnivanja INTEGER,
    divizija VARCHAR2(60),
    arena_id INTEGER REFERENCES arena(arena_id),
    trener_id INTEGER REFERENCES trener(trener_id)
);


CREATE TABLE igrac(
    igrac_id INTEGER CONSTRAINT igrac_id_pk PRIMARY KEY,
    ime VARCHAR2(60) NOT NULL,
    prezime VARCHAR2(60) NOT NULL,
    dat_rodenja DATE NOT NULL ,
    pozicija VARCHAR(15) NOT NULL,
    klub_id INTEGER REFERENCES klub(klub_id),
    college_id INTEGER REFERENCES college(college_id),
    draft_class INTEGER NOT NULL
);

CREATE TABLE sezona(
    sezona_id INTEGER CONSTRAINT sezona_id_pk PRIMARY KEY,
    godina_održavanja VARCHAR(10) NOT NULL,
    broj_utakmica INTEGER NOT NULL,    
    broj_timova INTEGER NOT NULL
);

CREATE TABLE najbolji_trener(
    coy_id INTEGER CONSTRAINT najbolji_igrac_pk PRIMARY KEY,
    trener_id INTEGER CONSTRAINT trener_fk_najbolji_trener REFERENCES trener(trener_id),
    sezona_id INTEGER CONSTRAINT sezona_fk_najbolji_trener REFERENCES sezona(sezona_id)
);

CREATE TABLE najbolji_igrac(
    mvp_id INTEGER CONSTRAINT mvp_pk PRIMARY KEY,
    igrac_id INTEGER CONSTRAINT igrac_fk_najbolji_igrac REFERENCES igrac(igrac_id),
    sezona_id INTEGER CONSTRAINT sezona_fk_najbolji_igrac REFERENCES sezona(sezona_id)
);

CREATE TABLE statistika(
    statistika_id INTEGER CONSTRAINT statistika_pk PRIMARY KEY,
    status VARCHAR2(20) DEFAULT 'No injury' NOT NULL,
    games_played DECIMAL(5,2) NOT NULL,
    points_avg DECIMAL(5,2) NOT NULL,
    rebounds_avg DECIMAL(5,2) NOT NULL,
    assists_avg INTEGER NOT NULL,
    igrac_id INTEGER CONSTRAINT igrac_fk_statistika REFERENCES igrac(igrac_id),
    sezona_id INTEGER CONSTRAINT sezona_fk_statistika REFERENCES sezona(sezona_id)

);

CREATE TABLE klub_sezona(
    klub_id INTEGER CONSTRAINT klub_fk_klub_sezona REFERENCES klub(klub_id),
    sezona_id INTEGER CONSTRAINT sezona_fk_klub_sezona REFERENCES sezona(sezona_id)
);

--gradovi
INSERT INTO grad(grad_id, naziv, state) VALUES (891, 'Los Angeles', 'Kalifornija');
INSERT INTO grad(grad_id, naziv, state) VALUES (892, 'Brooklyn', 'California');
INSERT INTO grad(grad_id, naziv, state) VALUES (893, 'Philadelphia', 'New York');

--arene
INSERT INTO arena VALUES (991, 'Staples Center', 20000, '50', 891);
INSERT INTO arena VALUES (992, 'Barclays Center', 25000, '60', 892);
INSERT INTO arena VALUES (993, 'Welse Fargo Center', 15000, '25', 893);

--treneri
INSERT INTO trener(trener_id, ime, prezime, dat_rodenja) VALUES (441, 'Doc', 'Rivers', TO_DATE('1961/10/13', 'yyyy/mm/dd'));
INSERT INTO trener(trener_id, ime, prezime, dat_rodenja) VALUES (442, 'Frank', 'Vogel', TO_DATE('1973/06/21', 'yyyy/mm/dd'));
INSERT INTO trener(trener_id, ime, prezime, dat_rodenja) VALUES (443, 'Steve', 'Nash', TO_DATE('1974/02/07', 'yyyy/mm/dd'));

--klubovi
INSERT INTO klub(klub_id, naziv, konferencija,godina_osnivanja, divizija,arena_id, trener_id) VALUES (1,'Lakers', 'Zapadna', null,'Pacifièka', 991, 442);
INSERT INTO klub(klub_id, naziv, konferencija,godina_osnivanja, divizija,arena_id, trener_id) VALUES (2,'Nets', 'Istoèna', null, 'Atlantska', 992, 443);
INSERT INTO klub(klub_id, naziv, konferencija,godina_osnivanja, divizija,arena_id, trener_id) VALUES (3,'76ers', 'Istoèna',null, 'Atlantska', 993, 441);

--college
INSERT INTO college VALUES(345, 'Ketucky', 'Lexington');
INSERT INTO college VALUES(346, 'UConn', 'Lexington');
INSERT INTO college VALUES(347, 'Utah', 'Lexington');
INSERT INTO college VALUES(348, 'Texas', 'Lexington');
INSERT INTO college VALUES(349, 'Duke', 'Lexington');
INSERT INTO college VALUES(350, 'Arizona', 'Lexington');
INSERT INTO college VALUES(351, 'Oklahoma', 'Lexington');
INSERT INTO college VALUES(352, 'Kansas', 'Lexington');
INSERT INTO college VALUES(353, 'LSU', 'Lexington');

--igraèi
INSERT INTO igrac VALUES (111,'LeBron', 'James', TO_DATE('1984/12/30', 'yyyy/mm/dd'), 'Nisko krilo',1,null,2003);
INSERT INTO igrac VALUES (112,'Anthony', 'Davis', TO_DATE('1993/03/11', 'yyyy/mm/dd'), 'Visoko krilo',1,345,2012);
INSERT INTO igrac VALUES (114,'Alex', 'Caruso', TO_DATE('1994/02/28', 'yyyy/mm/dd'), 'Plejmejker',1,348,2017);
INSERT INTO igrac VALUES (113,'Andre', 'Drummond', TO_DATE('1993/08/10', 'yyyy/mm/dd'), 'Centar',1,346,2012);
INSERT INTO igrac VALUES (115,'Ben', 'McLemore', TO_DATE('1995/07/24', 'yyyy/mm/dd'), 'Bek huter',1,352,2013);
INSERT INTO igrac VALUES (121,'Kevin', 'Durant', TO_DATE('1988/09/29', 'yyyy/mm/dd'), 'Nisko krilo',2,348,2008);
INSERT INTO igrac VALUES (122,'Kyrie', 'Irving', TO_DATE('1992/03/23', 'yyyy/mm/dd'), 'Plejmejker',2,349,2011);
INSERT INTO igrac VALUES (123,'James', 'Harden', TO_DATE('1989/08/26', 'yyyy/mm/dd'), 'Bek huter',2,350,2012);
INSERT INTO igrac VALUES (124,'Blake', 'Griffin', TO_DATE('1989/03/16', 'yyyy/mm/dd'), 'Visoko krilo',2,351,2010);
INSERT INTO igrac VALUES (125,'DeAndre', 'Jordan', TO_DATE('1988/07/21', 'yyyy/mm/dd'), 'Centar',2,348,2008);
INSERT INTO igrac VALUES (131,'Joel', 'Embiid', TO_DATE('1994/03/16', 'yyyy/mm/dd'), 'Centar',3,352,2016);
INSERT INTO igrac VALUES (132,'Ben', 'Simmons', TO_DATE('1996/07/20', 'yyyy/mm/dd'), 'Plejmejker',3,353,2017);
INSERT INTO igrac VALUES (133,'Tobias', 'Harris', TO_DATE('1988/07/21', 'yyyy/mm/dd'), 'Visoko krilo',3,348,2008);
INSERT INTO igrac VALUES (134,'Seth', 'Curry', TO_DATE('1990/08/30', 'yyyy/mm/dd'), 'Bek huter',3,349,2014);
INSERT INTO igrac VALUES (135,'Tyrese', 'Maxey', TO_DATE('2000/11/04', 'yyyy/mm/dd'), 'Nisko krilo',3,345,2020);

--sezona                                                                                                                                                                                            
INSERT INTO sezona VALUES (500, '2020/2021', 72, 3);

--statistika 
INSERT INTO statistika (statistika_id, games_played, points_avg, rebounds_avg, assists_avg, igrac_id, sezona_id)VALUES (711, 24, 25.8, 7.7, 7.8, 111, 500);  
INSERT INTO statistika (statistika_id, games_played, points_avg, rebounds_avg, assists_avg, igrac_id, sezona_id)VALUES (712, 24, 21.8, 7.9, 3.1, 112, 500);  
INSERT INTO statistika (statistika_id, games_played, points_avg, rebounds_avg, assists_avg, igrac_id, sezona_id)VALUES (713, 24, 14.9, 12.0, 2.1, 113, 500);  
INSERT INTO statistika (statistika_id, games_played, points_avg, rebounds_avg, assists_avg, igrac_id, sezona_id)VALUES (714, 24, 6.4, 2.9, 2.8, 114, 500);  
INSERT INTO statistika (statistika_id, games_played, points_avg, rebounds_avg, assists_avg, igrac_id, sezona_id)VALUES (715, 24, 7.7, 1.9, 0.7, 115, 500);  
INSERT INTO statistika (statistika_id, games_played, points_avg, rebounds_avg, assists_avg, igrac_id, sezona_id)VALUES (716, 24, 26.9, 7.1, 5.6, 121, 500);  
INSERT INTO statistika (statistika_id, games_played, points_avg, rebounds_avg, assists_avg, igrac_id, sezona_id)VALUES (717, 24, 26.9, 4.8, 6.1, 122, 500);  
INSERT INTO statistika (statistika_id, games_played, points_avg, rebounds_avg, assists_avg, igrac_id, sezona_id)VALUES (718, 24, 24.6, 7.9, 10.8, 123, 500);  
INSERT INTO statistika (statistika_id, games_played, points_avg, rebounds_avg, assists_avg, igrac_id, sezona_id)VALUES (719, 24, 11.8, 4.9, 3.1, 125, 500);  
INSERT INTO statistika (statistika_id, games_played, points_avg, rebounds_avg, assists_avg, igrac_id, sezona_id)VALUES (720, 24, 7.5, 7.5, 1.6, 124, 500);  
INSERT INTO statistika (statistika_id, games_played, points_avg, rebounds_avg, assists_avg, igrac_id, sezona_id)VALUES (721, 24, 14.8, 7.9, 7.1, 132, 500);  
INSERT INTO statistika (statistika_id, games_played, points_avg, rebounds_avg, assists_avg, igrac_id, sezona_id)VALUES (722, 24, 28.5, 10.9, 3.1, 131, 500);  
INSERT INTO statistika (statistika_id, games_played, points_avg, rebounds_avg, assists_avg, igrac_id, sezona_id)VALUES (723, 24, 19.5, 6.9, 3.1, 133, 500);  
INSERT INTO statistika (statistika_id, games_played, points_avg, rebounds_avg, assists_avg, igrac_id, sezona_id)VALUES (724, 24, 12.8, 2.5, 2.6, 134, 500);  
INSERT INTO statistika (statistika_id, games_played, points_avg, rebounds_avg, assists_avg, igrac_id, sezona_id)VALUES (725, 24, 8.0, 1.9, 2.1, 135, 500);  

--najbolji igrac
INSERT INTO najbolji_igrac VALUES (1, 131, 500);

--klub-sezona
INSERT INTO klub_sezona VALUES (1, 500);  
INSERT INTO klub_sezona VALUES (2, 500);
INSERT INTO klub_sezona VALUES (3, 500);

--najbolji trener
INSERT INTO najbolji_trener VALUES (1, 441, 500);

--TOÈKA 5
--ispisi ime i prezime svakog igraèa, a da pritom koristih jedan stupac
SELECT ime || ' ' ||  prezime "Puno ime", pozicija "Pozicija igraèa" 
FROM igrac;

--ispisi sve arene èiji je kapacitet manji ili jednak od 20 000
SELECT *
FROM arena
WHERE kapacitet <= 20000;

--ispisi sve igraèe koij se zovu ili prezivaju James
SELECT *
FROM igrac
WHERE ime = 'James' or prezime = 'James';

--ispisi sve klubove koji se nalaze u Istoènoj konferenciji
SELECT klub_id
FROM klub
WHERE konferencija = 'Istoèna';

--ispisi id statistike za sve igraèe kojima je prosjek skokova veæi od prosjeka asistencija
SELECT statistika_id 
FROM statistika
WHERE rebounds_avg > assists_avg;


--TOÈKA 6
--ispisi sve igrace koji su odigrali barem jednu utakmicu ove sezone
SELECT *
FROM igrac INNER JOIN statistika 
USING (igrac_id)
WHERE games_played <> 0;

--ako postoji trener koji sadrži samoglasnik o u svom imenu, ispihi ime kluba kojeg predvodi
SELECT klub.naziv
FROM klub INNER JOIN trener
USING(trener_id)
WHERE trener.ime LIKE '%o%';

--ispisi imena i prezimena svih igraèa koji zabijaju preko 25 poena po utakmici
SELECT ime , prezime, igrac.dat_rodenja "Roðen", draft_class AS "Aktivan od"
FROM igrac INNER JOIN statistika
USING (igrac_id)
WHERE points_avg >= 25;

--ispisi ime trenera koji je dobio nagradu Coach of the year
SELECT trener.ime
FROM trener INNER JOIN najbolji_trener 
USING (trener_id);

--ispisi datum roÄ‘enja koharkaha koji nije ihao na college
SELECT ime, prezime,  naziv, draft_class
FROM igrac INNER JOIN college
USING (college_id)
WHERE college_id IS NOT NULL;

--TOÈKA 7
--ispisi prosjek asistencija svih igraca
SELECT AVG(assists_avg)
FROM statistika;

--ispisi igrace èiji prosjek skokova premahuje 10
SELECT COUNT(ime)
FROM igrac INNER JOIN statistika 
USING(igrac_id)
WHERE rebounds_avg > 10;


--ispisi igraca koji najvihe zabije u ekipi zvana 76ers
SELECT SUM(points_avg)
FROM igrac
INNER JOIN statistika
USING(igrac_id)
INNER JOIN klub
USING(klub_id)
WHERE klub.naziv = '76ers';

--ispisi imena igraca koji imaju uprosjeku najmanje skokova po utakmici
SELECT ime
FROM igrac INNER JOIN statistika
USING(igrac_id)
WHERE rebounds_avg = (SELECT MIN(rebounds_avg)
                                  FROM statistika);

--ispisi prosjecnu cijenu ulaznica                                  
SELECT AVG(cijena_ulaznice)
FROM arena;

--TOÈKA 8
--ispiši sve o klubu u kojem igra igraè imena LeBron
SELECT * 
FROM klub k
INNER  JOIN igrac i
USING(klub_id)
WHERE i.igrac_id = (SELECT igrac_id
                  FROM igrac
                  WHERE ime = 'LeBron');
                  
-- KRIVO Stavljeno
SELECT *
FROM igrac
WHERE TO_CHAR(dat_rodenja,'YYYY') = '1993';


--ispisi sve igrace koji po prosjeku imaju manje koseva od prosjecnog broja skokova nekog igraca 
SELECT *
FROM igrac 
INNER JOIN statistika 
USING (igrac_id)
WHERE points_avg < ANY(SELECT (rebounds_avg)
                                FROM igrac 
                                INNER JOIN statistika 
                                USING (igrac_id));
                                
--ispisi igrace koji su igrali s Lebronom kad je averageo 20 poena po utakmici
SELECT i.ime
FROM igrac i
INNER JOIN klub
USING(klub_id)       
WHERE klub_id=(SELECT klub_id
        FROM igrac
        INNER JOIN statistika
        USING(igrac_id)
        WHERE ime = 'LeBron' AND points_avg > 20);

--ispisi Mvpa u godini kad je Doc osvojio Coy
SELECT *
FROM najbolji_igrac
INNER JOIN sezona
USING(sezona_id)
INNER JOIN igrac
USING(igrac_id)
WHERE godina_održavanja IN
(SELECT godina_održavanja
FROM najbolji_trener 
INNER JOIN sezona
USING(sezona_id)
INNER JOIN trener t
USING(trener_id)
WHERE t.ime = 'Doc');


--ispsii trenere koji treniraju igraèe iz Texasa
SELECT trener.ime , trener.prezime 
FROM klub
INNER JOIN trener
USING(trener_id)
INNER JOIN igrac
USING(klub_id)
WHERE igrac_id IN (SELECT igrac_id
FROM igrac
INNER JOIN college c
USING(college_id)
WHERE c.naziv = 'Texas' );
     


--toèka 10
ALTER TABLE grad
ADD CONSTRAINT grad_constraint
CHECK(država IN('SAD', 'Kanada'));

ALTER TABLE statistika
ADD CONSTRAINT statistika_constraint
CHECK(points_avg >= 0.0);

ALTER TABLE klub
MODIFY maskota CONSTRAINT
maskota_constraint NOT NULL;
                                  
--toèka 11
COMMENT ON TABLE grad IS 'GRAD pohranjuje podatke o GRADU, KOJI OZNAÈAVA SREDIŠTE KLUBA';
COMMENT ON TABLE arena IS 'ARENA pohranjuje podatke o MJESTU GDJE SE OKUPLJAJU NAVIJAÈI ODREÐENOG KLUBA';
COMMENT ON TABLE klub IS 'KLUB pohranjuje podatke o ORGANIZACIJI, KOJA DJELUJE U NBA LIGI';
COMMENT ON TABLE trener IS 'TRENER pohranjuje podatke o OSOBI, KOJA JE AUTORITET MOMÈADI';
COMMENT ON TABLE igrac IS 'IGRAÈ pohranjuje podatke o OSOBI, KOJA JE DIO MOMÈADI';
COMMENT ON TABLE statistika IS 'STATISTIKA pohranjuje podatke O IGRAÈU TOKOM ODREÐENE SEZONE';
COMMENT ON TABLE sezona IS 'SEZONA pohranjuje podatke o VREMENSKOM PERIODU U KOJEM SE ODRŽAVAJU UTAKMICE';
COMMENT ON TABLE college IS 'COLLEGE pohranjuje podatke o SVEUÈILIŠTU, KOJE JE POHAÐAO IGRAÈ';
COMMENT ON TABLE klub_sezona IS 'KLUB_SEZONA JE POVEZNICA IZMEÐU TABLICE KLUB I TABLICE SEZONA';
COMMENT ON TABLE najbolji_igrac IS 'NAJBOLJI_IGRAÈ pohranjuje podatke o OSOBI, KOJA JE NAJVIŠE UTJECALA NA MOMÈAD';
COMMENT ON TABLE najbolji_trener IS 'NAJBOLJI TRENER pohranjuje podatke o OSOBI, KOJA JE OCJENJENA DA JE NAJBOLJE ODRADILA SVOJ POSAO';

--toèka 12
CREATE INDEX igrac_ime_prezime ON
igrac(ime, prezime);

CREATE INDEX statistika_poeni ON 
statistika(points_avg);

CREATE INDEX college_naziv ON
college(naziv);

--toèka 13
--zamjeni prosjeke koševa igraèa s id-em 114 i 131
CREATE OR REPLACE PROCEDURE update_points_average 
AS points_average_114 statistika.points_avg%TYPE;
BEGIN
SELECT points_avg INTO points_average_114
FROM statistika INNER JOIN igrac
USING(igrac_id)
WHERE igrac_id = 114;

UPDATE statistika
SET points_avg = (SELECT points_avg FROM statistika WHERE igrac_id =  131)
WHERE igrac_id = 114;

UPDATE statistika
SET points_avg = points_average_114
WHERE igrac_id = 131;

END update_points_average;
/

--ažuriraj poene po utakmici igraèima s obzirom na godine
DROP PROCEDURE update_points_avg;
CREATE OR REPLACE PROCEDURE update_points_avg 
AS  godina_fst INTEGER;
argument_fst INTEGER;
BEGIN 
    SELECT FLOOR((TO_DATE('2021/06/30', 'yyyy/mm/dd')- dat_rodenja)/365) 
    INTO godina_fst
    FROM igrac
    WHERE igrac_id = 121;
    
    --argument_fst := 1.0;

    IF godina_fst > 30 THEN
       argument_fst := 1 - argument_fst;
    ELSE  argument_fst := 1 + argument_fst;
    END IF;
    
    UPDATE statistika 
    SET points_avg = points_avg * argument_fst 
    WHERE igrac_id = 121;
    
    COMMIT;    

END update_points_avg;
/

--ažuriraj statistiku igraèa s obzirom jesu li igrali sve utakmice ili nisu
CREATE OR REPLACE PROCEDURE injury_update
IS i_status VARCHAR(20);
   i_gms_played INTEGER;
   i_gms_max INTEGER;
   
BEGIN 
    SELECT games_played INTO i_gms_played
    FROM statistika
    WHERE igrac_id = 133;
    
    SELECT broj_utakmica INTO i_gms_max
    FROM sezona
    WHERE godina_održavanja = '2020/2021';
    
    IF i_gms_played = i_gms_max THEN
        i_status := 'Not able to play';
    ELSE 
        i_status := 'Able to play';
    END IF;
    
END;
/

--ažuriraj prosjek skokova po utakmici igraèa s id-em player_id
CREATE OR REPLACE PROCEDURE rebounds_update(
    p_rebounds_avg statistika.rebounds_avg%TYPE,
    player_id statistika.igrac_id%TYPE  )
AS
BEGIN
    UPDATE statistika
    SET rebounds_avg = p_rebounds_avg
    WHERE igrac_id = player_id;

    COMMIT;
END rebounds_update;
/
    


--toèka14
--pokreni okidaè ukoliko je broj skokova manji nego što je bio
CREATE OR REPLACE TRIGGER trigger_fst
    AFTER UPDATE 
    ON statistika
    FOR EACH ROW WHEN (new.assists_avg < old.assists_avg)
BEGIN
    dbms_output.PUT_LINE('Broj asistencija po utakmici igraca ' 
    || :old.igrac_id || ' se smanjio s ' || :old.assists_avg || 
    ' na ' || :new.assists_avg || '.' );
END trigger_fst;
/



--pokreni okidaè ukoliko igraè nije u moguænosti igrati
CREATE OR REPLACE TRIGGER trigger_snd
    BEFORE UPDATE 
    OF status
    ON statistika
    FOR EACH ROW WHEN (new.status <> 'Able to play' OR new.status <> 'No injury')
BEGIN
    dbms_output.PUT_LINE('Bad luck' );
END trigger_snd;
/

--pokreni okidaè ako cijena ulaznica naraste za više od 20 posto
CREATE OR REPLACE TRIGGER trigger_thd
    AFTER UPDATE 
    ON arena
    FOR EACH ROW WHEN (new.cijena_ulaznice > 1.2*cijena_ulaznice)
BEGIN
    dbms_output.PUT_LINE('Navijaèi æe se pobuniti!' );
END trigger_thd;
/



