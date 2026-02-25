create database firma_transport_marfa;
use firma_transport_marfa;
CREATE TABLE Masini(
	id_masina INT PRIMARY KEY,
    marca  VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    an_fabricatie INT,
    nr_inmatriculare VARCHAR(20) UNIQUE,
    capacitate_tonaj DECIMAL(6,2) 
);
CREATE TABLE Soferi(
		id_sofer INT PRIMARY KEY,
        nume VARCHAR(50) NOT NULL,
        prenume VARCHAR(50) NOT NULL,
        categorie_permis ENUM('B','C','CE') NOT NULL,
        data_angajare DATE CHECK(data_angajare >= '2010-01-01'),
        telefon VARCHAR(15) UNIQUE
	);
    CREATE TABLE Transporturi(
		id_transport INT PRIMARY KEY,
        data_plecare DATE NOT NULL,
        locatie_plecare VARCHAR(100) NOT NULL,
        locatie_destinatie VARCHAR(100) NOT NULL,
        distanta_km INT CHECK(distanta_km >= 10),
        tip_marfa VARCHAR(50)
	);
    CREATE TABLE AlocariTransport(
		id_alocare INT PRIMARY KEY,
        id_transport INT,
        id_masina INT,
        id_sofer INT,
		status_transport ENUM('Planificat','In curs','Finalizat'),
		FOREIGN KEY (id_transport) REFERENCES Transporturi(id_transport),
		FOREIGN KEY (id_masina) REFERENCES Masini(id_masina),
		FOREIGN KEY (id_sofer) REFERENCES Soferi(id_sofer)
	);
    CREATE TABLE Revizii(
		id_revizie INT PRIMARY KEY,
        id_masina INT,
        data_revizie DATE NOT NULL,
        tip_revizie ENUM('Tehnica','ITP','Ulei'),  
        cost DECIMAL(10,2) CHECK(cost >=0),
        FOREIGN KEY (id_masina) REFERENCES Masini(id_masina)
    );
    INSERT INTO Masini (id_masina, marca, model, an_fabricatie, nr_inmatriculare, capacitate_tonaj) VALUES (1, 'Mercedes', 'Actros', 2018, 'B123ABC', 20.5);
	INSERT INTO Masini (id_masina, marca, model, an_fabricatie, nr_inmatriculare, capacitate_tonaj) VALUES (2, 'Volvo', 'FH', 2020, 'B456DEF', 18.0);
	INSERT INTO Masini (id_masina, marca, model, an_fabricatie, nr_inmatriculare, capacitate_tonaj) VALUES (3, 'Scania', 'R-Series', 2017, 'B789GHI', 22.0);
	INSERT INTO Masini (id_masina, marca, model, an_fabricatie, nr_inmatriculare, capacitate_tonaj) VALUES (4, 'MAN', 'TGX', 2019, 'B234JKL', 19.5);
	INSERT INTO Masini (id_masina, marca, model, an_fabricatie, nr_inmatriculare, capacitate_tonaj) VALUES (5, 'DAF', 'XF', 2016, 'B567MNO', 17.0);
	INSERT INTO Masini (id_masina, marca, model, an_fabricatie, nr_inmatriculare, capacitate_tonaj) VALUES (6, 'Mercedes', 'Atego', 2021, 'B112PQR', 14.2);
	INSERT INTO Masini (id_masina, marca, model, an_fabricatie, nr_inmatriculare, capacitate_tonaj) VALUES (7, 'Volvo', 'FMX', 2022, 'B789XYZ', 21.7);
	INSERT INTO Masini (id_masina, marca, model, an_fabricatie, nr_inmatriculare, capacitate_tonaj) VALUES (8, 'Scania', 'G-Series', 2015, 'B645QWE', 16.3);
	INSERT INTO Masini (id_masina, marca, model, an_fabricatie, nr_inmatriculare, capacitate_tonaj) VALUES (9, 'MAN', 'TGS', 2023, 'B312RTY', 23.0);
	INSERT INTO Masini (id_masina, marca, model, an_fabricatie, nr_inmatriculare, capacitate_tonaj) VALUES (10, 'DAF', 'CF', 2018, 'B957UIO', 15.5);
	INSERT INTO Masini (id_masina, marca, model, an_fabricatie, nr_inmatriculare, capacitate_tonaj) VALUES (11, 'Mercedes', 'Sprinter', 2020, 'B128ASD', 4.5);
	INSERT INTO Masini (id_masina, marca, model, an_fabricatie, nr_inmatriculare, capacitate_tonaj) VALUES (12, 'Volvo', 'FL', 2016, 'B839ZXC', 10.0);
	INSERT INTO Masini (id_masina, marca, model, an_fabricatie, nr_inmatriculare, capacitate_tonaj) VALUES (13, 'Scania', 'P-Series', 2019, 'B745BNM', 19.9);
	INSERT INTO Masini (id_masina, marca, model, an_fabricatie, nr_inmatriculare, capacitate_tonaj) VALUES (14, 'MAN', 'TGM', 2017, 'B384QAZ', 12.8);
	INSERT INTO Masini (id_masina, marca, model, an_fabricatie, nr_inmatriculare, capacitate_tonaj) VALUES (15, 'DAF', 'LF', 2021, 'B698WSX', 6.2);
	INSERT INTO Masini (id_masina, marca, model, an_fabricatie, nr_inmatriculare, capacitate_tonaj) VALUES (16, 'Mercedes', 'Actros', 2023, 'B521EDC', 24.0);
	INSERT INTO Masini (id_masina, marca, model, an_fabricatie, nr_inmatriculare, capacitate_tonaj) VALUES (17, 'Volvo', 'FH', 2015, 'B304RFV', 20.3);
	INSERT INTO Masini (id_masina, marca, model, an_fabricatie, nr_inmatriculare, capacitate_tonaj) VALUES (18, 'Scania', 'R-Series', 2024, 'B119TGB', 21.5);
	INSERT INTO Masini (id_masina, marca, model, an_fabricatie, nr_inmatriculare, capacitate_tonaj) VALUES (19, 'MAN', 'TGX', 2022, 'B887YHN', 19.2);
	INSERT INTO Masini (id_masina, marca, model, an_fabricatie, nr_inmatriculare, capacitate_tonaj) VALUES (20, 'DAF', 'XF', 2020, 'B673UJM', 18.4);
	INSERT INTO Masini (id_masina, marca, model, an_fabricatie, nr_inmatriculare, capacitate_tonaj) VALUES (21, 'Mercedes', 'Atego', 2016, 'B900IKL', 13.0);
	INSERT INTO Masini (id_masina, marca, model, an_fabricatie, nr_inmatriculare, capacitate_tonaj) VALUES (22, 'Volvo', 'FMX', 2019, 'B766OLP', 17.6);
	INSERT INTO Masini (id_masina, marca, model, an_fabricatie, nr_inmatriculare, capacitate_tonaj) VALUES (23, 'Scania', 'G-Series', 2013, 'B554HGF', 16.8);
	INSERT INTO Masini (id_masina, marca, model, an_fabricatie, nr_inmatriculare, capacitate_tonaj) VALUES (24, 'MAN', 'TGS', 2018, 'B332VBN', 21.1);
	INSERT INTO Masini (id_masina, marca, model, an_fabricatie, nr_inmatriculare, capacitate_tonaj) VALUES (25, 'DAF', 'CF', 2023, 'B444CXZ', 14.6);
    INSERT INTO Soferi (id_sofer, nume, prenume, categorie_permis, data_angajare, telefon) VALUES (1, 'Popescu', 'Ion', 'C', '2018-05-15', '0721234567');
	INSERT INTO Soferi (id_sofer, nume, prenume, categorie_permis, data_angajare, telefon) VALUES (2, 'Ionescu', 'Maria', 'CE', '2019-06-22', '0732345678');
	INSERT INTO Soferi (id_sofer, nume, prenume, categorie_permis, data_angajare, telefon) VALUES (3, 'Georgescu', 'Andrei', 'B', '2020-07-10', '0743456789');
	INSERT INTO Soferi (id_sofer, nume, prenume, categorie_permis, data_angajare, telefon) VALUES (4, 'Vasilescu', 'Elena', 'C', '2017-03-04', '0754567890');
	INSERT INTO Soferi (id_sofer, nume, prenume, categorie_permis, data_angajare, telefon) VALUES (5, 'Dumitrescu', 'Victor', 'B', '2021-01-11', '0765678901');
	INSERT INTO Soferi (id_sofer, nume, prenume, categorie_permis, data_angajare, telefon) VALUES (6, 'Marin', 'Ion', 'C', '2020-04-20', '0776789012');
	INSERT INTO Soferi (id_sofer, nume, prenume, categorie_permis, data_angajare, telefon) VALUES (7, 'Popa', 'Alexandru', 'CE', '2019-02-14', '0787890123');
	INSERT INTO Soferi (id_sofer, nume, prenume, categorie_permis, data_angajare, telefon) VALUES (8, 'Ionescu', 'Gabriel', 'B', '2021-09-05', '0798901234');
	INSERT INTO Soferi (id_sofer, nume, prenume, categorie_permis, data_angajare, telefon) VALUES (9, 'Mihail', 'Cristina', 'C', '2018-12-18', '0729012345');
	INSERT INTO Soferi (id_sofer, nume, prenume, categorie_permis, data_angajare, telefon) VALUES (10, 'Tudor', 'Andreea', 'CE', '2017-11-23', '0730123456');
	INSERT INTO Soferi (id_sofer, nume, prenume, categorie_permis, data_angajare, telefon) VALUES (11, 'Constantin', 'Alina', 'B', '2020-03-09', '0741234567');
	INSERT INTO Soferi (id_sofer, nume, prenume, categorie_permis, data_angajare, telefon) VALUES (12, 'Dima', 'Stefan', 'C', '2016-06-16', '0752345678');
	INSERT INTO Soferi (id_sofer, nume, prenume, categorie_permis, data_angajare, telefon) VALUES (13, 'Enache', 'Lavinia', 'CE', '2019-04-17', '0763456789');
	INSERT INTO Soferi (id_sofer, nume, prenume, categorie_permis, data_angajare, telefon) VALUES (14, 'Pascu', 'Mihai', 'B', '2021-05-10', '0774567890');
	INSERT INTO Soferi (id_sofer, nume, prenume, categorie_permis, data_angajare, telefon) VALUES (15, 'Nica', 'Ionut', 'C', '2017-08-29', '0785678901');
	INSERT INTO Soferi (id_sofer, nume, prenume, categorie_permis, data_angajare, telefon) VALUES (16, 'Munteanu', 'Ana', 'CE', '2020-10-04', '0796789012');
	INSERT INTO Soferi (id_sofer, nume, prenume, categorie_permis, data_angajare, telefon) VALUES (17, 'Dumitru', 'Lucian', 'B', '2018-11-02', '0727890123');
	INSERT INTO Soferi (id_sofer, nume, prenume, categorie_permis, data_angajare, telefon) VALUES (18, 'Lupu', 'Andrei', 'C', '2021-02-15', '0738901234');
	INSERT INTO Soferi (id_sofer, nume, prenume, categorie_permis, data_angajare, telefon) VALUES (19, 'Radu', 'Simona', 'CE', '2016-04-07', '0749012345');
	INSERT INTO Soferi (id_sofer, nume, prenume, categorie_permis, data_angajare, telefon) VALUES (20, 'Balan', 'George', 'B', '2019-06-29', '0750123456');
	INSERT INTO Soferi (id_sofer, nume, prenume, categorie_permis, data_angajare, telefon) VALUES (21, 'Ciobanu', 'Marius', 'C', '2021-07-12', '0761234567');
	INSERT INTO Soferi (id_sofer, nume, prenume, categorie_permis, data_angajare, telefon) VALUES (22, 'Stanciu', 'Vasile', 'CE', '2017-05-18', '0772345678');
	INSERT INTO Soferi (id_sofer, nume, prenume, categorie_permis, data_angajare, telefon) VALUES (23, 'Ionescu', 'Daniela', 'B', '2020-09-25', '0783456789');
	INSERT INTO Soferi (id_sofer, nume, prenume, categorie_permis, data_angajare, telefon) VALUES (24, 'Popescu', 'Cristian', 'C', '2018-02-03', '0794567890');
	INSERT INTO Soferi (id_sofer, nume, prenume, categorie_permis, data_angajare, telefon) VALUES (25, 'Munteanu', 'Ioana', 'CE', '2019-07-11', '0725678901');
	INSERT INTO Transporturi (id_transport, data_plecare, locatie_plecare, locatie_destinatie, distanta_km, tip_marfa) 
	VALUES (1, '2023-04-15', 'Bucuresti', 'Cluj-Napoca', 400, 'Mancare');
	INSERT INTO Transporturi (id_transport, data_plecare, locatie_plecare, locatie_destinatie, distanta_km, tip_marfa) 
	VALUES (2, '2023-04-17', 'Timisoara', 'Iasi', 450, 'Electrocasnice');
	INSERT INTO Transporturi (id_transport, data_plecare, locatie_plecare, locatie_destinatie, distanta_km, tip_marfa) 
	VALUES (3, '2023-04-20', 'Constanta', 'Sibiu', 300, 'Mobilier');
	INSERT INTO Transporturi (id_transport, data_plecare, locatie_plecare, locatie_destinatie, distanta_km, tip_marfa) 
	VALUES (4, '2023-04-22', 'Brasov', 'Bucuresti', 200, 'Constructii');
	INSERT INTO Transporturi (id_transport, data_plecare, locatie_plecare, locatie_destinatie, distanta_km, tip_marfa) 
	VALUES (5, '2023-04-25', 'Cluj-Napoca', 'Oradea', 150, 'Cosmetice');
	INSERT INTO Transporturi (id_transport, data_plecare, locatie_plecare, locatie_destinatie, distanta_km, tip_marfa) 
	VALUES (6, '2023-05-01', 'Iasi', 'Timisoara', 600, 'Autoturisme');
	INSERT INTO Transporturi (id_transport, data_plecare, locatie_plecare, locatie_destinatie, distanta_km, tip_marfa) 
	VALUES (7, '2023-05-03', 'Ploiesti', 'Bucuresti', 50, 'Electronice');
	INSERT INTO Transporturi (id_transport, data_plecare, locatie_plecare, locatie_destinatie, distanta_km, tip_marfa) 
	VALUES (8, '2023-05-06', 'Sibiu', 'Targu Mures', 100, 'Alimente');
	INSERT INTO Transporturi (id_transport, data_plecare, locatie_plecare, locatie_destinatie, distanta_km, tip_marfa) 
	VALUES (9, '2023-05-10', 'Bucuresti', 'Suceava', 500, 'Bucurii');
	INSERT INTO Transporturi (id_transport, data_plecare, locatie_plecare, locatie_destinatie, distanta_km, tip_marfa) 
	VALUES (10, '2023-05-12', 'Timisoara', 'Constanta', 600, 'Carne');
	INSERT INTO Transporturi (id_transport, data_plecare, locatie_plecare, locatie_destinatie, distanta_km, tip_marfa) 
	VALUES (11, '2023-05-15', 'Brasov', 'Arad', 450, 'Textile');
	INSERT INTO Transporturi (id_transport, data_plecare, locatie_plecare, locatie_destinatie, distanta_km, tip_marfa) 
	VALUES (12, '2023-05-18', 'Iasi', 'Pitesti', 350, 'Mobilier');
	INSERT INTO Transporturi (id_transport, data_plecare, locatie_plecare, locatie_destinatie, distanta_km, tip_marfa) 
	VALUES (13, '2023-05-20', 'Cluj-Napoca', 'Bucuresti', 480, 'Masini');
	INSERT INTO Transporturi (id_transport, data_plecare, locatie_plecare, locatie_destinatie, distanta_km, tip_marfa) 
	VALUES (14, '2023-05-22', 'Sibiu', 'Satu Mare', 600, 'Bucurii');
	INSERT INTO Transporturi (id_transport, data_plecare, locatie_plecare, locatie_destinatie, distanta_km, tip_marfa) 
	VALUES (15, '2023-05-24', 'Targu Mures', 'Cluj-Napoca', 150, 'Cosmetice');
	INSERT INTO Transporturi (id_transport, data_plecare, locatie_plecare, locatie_destinatie, distanta_km, tip_marfa) 
	VALUES (16, '2023-05-26', 'Oradea', 'Timisoara', 280, 'Electrocasnice');
	INSERT INTO Transporturi (id_transport, data_plecare, locatie_plecare, locatie_destinatie, distanta_km, tip_marfa) 
	VALUES (17, '2023-05-28', 'Bucuresti', 'Constanta', 230, 'Mancare');
	INSERT INTO Transporturi (id_transport, data_plecare, locatie_plecare, locatie_destinatie, distanta_km, tip_marfa) 
	VALUES (18, '2023-05-30', 'Brasov', 'Iasi', 350, 'Carne');
	INSERT INTO Transporturi (id_transport, data_plecare, locatie_plecare, locatie_destinatie, distanta_km, tip_marfa) 
	VALUES (19, '2023-06-01', 'Suceava', 'Sibiu', 500, 'Bucurii');
	INSERT INTO Transporturi (id_transport, data_plecare, locatie_plecare, locatie_destinatie, distanta_km, tip_marfa) 
	VALUES (20, '2023-06-04', 'Timisoara', 'Pitesti', 420, 'Textile');
	INSERT INTO Transporturi (id_transport, data_plecare, locatie_plecare, locatie_destinatie, distanta_km, tip_marfa) 
	VALUES (21, '2023-06-06', 'Cluj-Napoca', 'Targu Mures', 100, 'Electronice');
	INSERT INTO Transporturi (id_transport, data_plecare, locatie_plecare, locatie_destinatie, distanta_km, tip_marfa) 
	VALUES (22, '2023-06-08', 'Iasi', 'Suceava', 200, 'Mobilier');
	INSERT INTO Transporturi (id_transport, data_plecare, locatie_plecare, locatie_destinatie, distanta_km, tip_marfa) 
	VALUES (23, '2023-06-10', 'Bucuresti', 'Brasov', 180, 'Cosmetice');
	INSERT INTO Transporturi (id_transport, data_plecare, locatie_plecare, locatie_destinatie, distanta_km, tip_marfa) 
	VALUES (24, '2023-06-12', 'Timisoara', 'Sibiu', 200, 'Alimente');
	INSERT INTO Transporturi (id_transport, data_plecare, locatie_plecare, locatie_destinatie, distanta_km, tip_marfa) 
	VALUES (25, '2023-06-15', 'Oradea', 'Cluj-Napoca', 150, 'Autoturisme');
	INSERT INTO AlocariTransport (id_alocare, id_transport, id_masina, id_sofer, status_transport) 
	VALUES (1, 1, 1, 1, 'Planificat');
	INSERT INTO AlocariTransport (id_alocare, id_transport, id_masina, id_sofer, status_transport) 
	VALUES (2, 2, 2, 2, 'In curs');
	INSERT INTO AlocariTransport (id_alocare, id_transport, id_masina, id_sofer, status_transport) 
	VALUES (3, 3, 3, 3, 'Finalizat');
	INSERT INTO AlocariTransport (id_alocare, id_transport, id_masina, id_sofer, status_transport) 
	VALUES (4, 4, 4, 4, 'Planificat');
	INSERT INTO AlocariTransport (id_alocare, id_transport, id_masina, id_sofer, status_transport) 
	VALUES (5, 5, 5, 5, 'In curs');
	INSERT INTO AlocariTransport (id_alocare, id_transport, id_masina, id_sofer, status_transport) 
	VALUES (6, 6, 6, 6, 'Finalizat');
	INSERT INTO AlocariTransport (id_alocare, id_transport, id_masina, id_sofer, status_transport) 
	VALUES (7, 7, 7, 7, 'Planificat');
	INSERT INTO AlocariTransport (id_alocare, id_transport, id_masina, id_sofer, status_transport) 
	VALUES (8, 8, 8, 8, 'In curs');
	INSERT INTO AlocariTransport (id_alocare, id_transport, id_masina, id_sofer, status_transport) 
	VALUES (9, 9, 9, 9, 'Finalizat');
	INSERT INTO AlocariTransport (id_alocare, id_transport, id_masina, id_sofer, status_transport) 
	VALUES (10, 10, 10, 10, 'Planificat');
	INSERT INTO AlocariTransport (id_alocare, id_transport, id_masina, id_sofer, status_transport) 
	VALUES (11, 11, 11, 11, 'In curs');
	INSERT INTO AlocariTransport (id_alocare, id_transport, id_masina, id_sofer, status_transport) 
	VALUES (12, 12, 12, 12, 'Finalizat');
	INSERT INTO AlocariTransport (id_alocare, id_transport, id_masina, id_sofer, status_transport) 
	VALUES (13, 13, 13, 13, 'Planificat');
	INSERT INTO AlocariTransport (id_alocare, id_transport, id_masina, id_sofer, status_transport) 
	VALUES (14, 14, 14, 14, 'In curs');
	INSERT INTO AlocariTransport (id_alocare, id_transport, id_masina, id_sofer, status_transport) 
	VALUES (15, 15, 15, 15, 'Finalizat');
	INSERT INTO AlocariTransport (id_alocare, id_transport, id_masina, id_sofer, status_transport) 
	VALUES (16, 16, 16, 16, 'Planificat');
	INSERT INTO AlocariTransport (id_alocare, id_transport, id_masina, id_sofer, status_transport) 
	VALUES (17, 17, 17, 17, 'In curs');
	INSERT INTO AlocariTransport (id_alocare, id_transport, id_masina, id_sofer, status_transport) 
	VALUES (18, 18, 18, 18, 'Finalizat');
	INSERT INTO AlocariTransport (id_alocare, id_transport, id_masina, id_sofer, status_transport) 
	VALUES (19, 19, 19, 19, 'Planificat');
	INSERT INTO AlocariTransport (id_alocare, id_transport, id_masina, id_sofer, status_transport) 
	VALUES (20, 20, 20, 20, 'In curs');
	INSERT INTO AlocariTransport (id_alocare, id_transport, id_masina, id_sofer, status_transport) 
	VALUES (21, 21, 21, 21, 'Finalizat');
	INSERT INTO AlocariTransport (id_alocare, id_transport, id_masina, id_sofer, status_transport) 
	VALUES (22, 22, 22, 22, 'Planificat');
	INSERT INTO AlocariTransport (id_alocare, id_transport, id_masina, id_sofer, status_transport) 
	VALUES (23, 23, 23, 23, 'In curs');
	INSERT INTO AlocariTransport (id_alocare, id_transport, id_masina, id_sofer, status_transport) 
	VALUES (24, 24, 24, 24, 'Finalizat');
	INSERT INTO AlocariTransport (id_alocare, id_transport, id_masina, id_sofer, status_transport) 
	VALUES (25, 25, 25, 25, 'Planificat');
    INSERT INTO Revizii (id_revizie, id_masina, data_revizie, tip_revizie, cost) 
	VALUES (1, 1, '2023-01-15', 'ITP', 350.00);
	INSERT INTO Revizii (id_revizie, id_masina, data_revizie, tip_revizie, cost) 
	VALUES (2, 2, '2023-03-20', 'Tehnica', 400.00);
	INSERT INTO Revizii (id_revizie, id_masina, data_revizie, tip_revizie, cost) 
	VALUES (3, 3, '2023-06-10', 'Ulei', 120.00);
	INSERT INTO Revizii (id_revizie, id_masina, data_revizie, tip_revizie, cost) 
	VALUES (4, 4, '2023-02-05', 'ITP', 350.00);
	INSERT INTO Revizii (id_revizie, id_masina, data_revizie, tip_revizie, cost) 
	VALUES (5, 5, '2023-05-30', 'Tehnica', 450.00);
	INSERT INTO Revizii (id_revizie, id_masina, data_revizie, tip_revizie, cost) 
	VALUES (6, 6, '2023-04-18', 'Ulei', 130.00);
	INSERT INTO Revizii (id_revizie, id_masina, data_revizie, tip_revizie, cost) 
	VALUES (7, 7, '2023-07-05', 'ITP', 375.00);
	INSERT INTO Revizii (id_revizie, id_masina, data_revizie, tip_revizie, cost) 
	VALUES (8, 8, '2023-01-22', 'Tehnica', 420.00);
	INSERT INTO Revizii (id_revizie, id_masina, data_revizie, tip_revizie, cost) 
	VALUES (9, 9, '2023-03-15', 'Ulei', 125.00);
	INSERT INTO Revizii (id_revizie, id_masina, data_revizie, tip_revizie, cost) 
	VALUES (10, 10, '2023-06-01', 'ITP', 340.00);
	INSERT INTO Revizii (id_revizie, id_masina, data_revizie, tip_revizie, cost) 
	VALUES (11, 11, '2023-05-25', 'Tehnica', 410.00);
	INSERT INTO Revizii (id_revizie, id_masina, data_revizie, tip_revizie, cost) 
	VALUES (12, 12, '2023-02-12', 'Ulei', 140.00);
	INSERT INTO Revizii (id_revizie, id_masina, data_revizie, tip_revizie, cost) 
	VALUES (13, 13, '2023-08-01', 'ITP', 360.00);
	INSERT INTO Revizii (id_revizie, id_masina, data_revizie, tip_revizie, cost) 
	VALUES (14, 14, '2023-03-30', 'Tehnica', 440.00);
	INSERT INTO Revizii (id_revizie, id_masina, data_revizie, tip_revizie, cost) 
	VALUES (15, 15, '2023-06-25', 'Ulei', 135.00);
	INSERT INTO Revizii (id_revizie, id_masina, data_revizie, tip_revizie, cost) 
	VALUES (16, 16, '2023-05-10', 'ITP', 370.00);
	INSERT INTO Revizii (id_revizie, id_masina, data_revizie, tip_revizie, cost) 
	VALUES (17, 17, '2023-02-28', 'Tehnica', 430.00);
	INSERT INTO Revizii (id_revizie, id_masina, data_revizie, tip_revizie, cost) 
	VALUES (18, 18, '2023-04-10', 'Ulei', 120.00);
	INSERT INTO Revizii (id_revizie, id_masina, data_revizie, tip_revizie, cost) 
	VALUES (19, 19, '2023-07-20', 'ITP', 365.00);
	INSERT INTO Revizii (id_revizie, id_masina, data_revizie, tip_revizie, cost) 
	VALUES (20, 20, '2023-06-15', 'Tehnica', 460.00);
	INSERT INTO Revizii (id_revizie, id_masina, data_revizie, tip_revizie, cost) 
	VALUES (21, 21, '2023-08-10', 'Ulei', 125.00);
	INSERT INTO Revizii (id_revizie, id_masina, data_revizie, tip_revizie, cost) 
	VALUES (22, 22, '2023-05-05', 'ITP', 355.00);
	INSERT INTO Revizii (id_revizie, id_masina, data_revizie, tip_revizie, cost) 
	VALUES (23, 23, '2023-01-30', 'Tehnica', 420.00);
	INSERT INTO Revizii (id_revizie, id_masina, data_revizie, tip_revizie, cost) 
	VALUES (24, 24, '2023-03-25', 'Ulei', 115.00);
	INSERT INTO Revizii (id_revizie, id_masina, data_revizie, tip_revizie, cost) 
	VALUES (25, 25, '2023-06-05', 'ITP', 375.00);
    
    
  
DELIMITER //


CREATE TRIGGER unicitate_alocare_sofer
BEFORE INSERT ON AlocariTransport
FOR EACH ROW
BEGIN
  
  IF EXISTS (
    SELECT 1 FROM AlocariTransport
    WHERE id_sofer = NEW.id_sofer AND id_transport = NEW.id_transport
  ) THEN
    
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Șoferul este deja alocat la acest transport!';
  END IF;
END;
//


DELIMITER ;


 INSERT INTO AlocariTransport (id_alocare, id_transport, id_masina, id_sofer, status_transport)
 VALUES (99, 1, 1, 1, 'In Curs');










DELIMITER //




CREATE FUNCTION cost_total_revizii(id_camion INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  
  DECLARE total DECIMAL(10,2);

  SELECT SUM(cost) INTO total FROM Revizii WHERE id_masina = id_camion;

  RETURN IFNULL(total, 0.00);
END;
//


DELIMITER ;



 SELECT cost_total_revizii(1);










DELIMITER //

CREATE PROCEDURE afiseaza_revizii_camion(IN id_camion INT)
BEGIN
    
    SELECT id_revizie, data_revizie, tip_revizie, cost FROM Revizii WHERE id_masina = id_camion;
END;
//


DELIMITER ;


CALL afiseaza_revizii_camion(5);
