CREATE DATABASE akademik;

USE akademik;

CREATE TABLE Asal (
  Id_Asal INT PRIMARY KEY AUTO_INCREMENT,
  Nama_Asal VARCHAR(20) NOT NULL
);

CREATE TABLE Mahasiswa (
  NIM CHAR(12) PRIMARY KEY,
  Nama VARCHAR(80) NOT NULL,
  Angkatan INT NOT NULL,
  Id_Asal INT,
  FOREIGN KEY (Id_Asal) REFERENCES Asal(Id_Asal) ON DELETE SET NULL
);

CREATE TABLE Dosen (
  NIDN CHAR(5) PRIMARY KEY, 
  Nama VARCHAR(80) NOT NULL,
  Email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Matakuliah (
  Kode_MK CHAR(2) PRIMARY KEY,
  Nama_MK VARCHAR(100) NOT NULL,
  Sks INT NOT NULL CHECK (Sks > 0)
);

CREATE TABLE KRS (
  Id_KRS INT PRIMARY KEY AUTO_INCREMENT,
  NIM CHAR(12),
  Kode_MK CHAR(2),
  Semester INT NOT NULL CHECK (Semester > 0),
  FOREIGN KEY (NIM) REFERENCES Mahasiswa(NIM) ON DELETE CASCADE,
  FOREIGN KEY (Kode_MK) REFERENCES Matakuliah(Kode_MK) ON DELETE CASCADE,
  UNIQUE (NIM, Kode_MK)
);


INSERT INTO Asal (Nama_Asal) VALUES
('Jawa Barat'),
('Jawa Tengah'),
('Jawa Timur');

INSERT INTO Mahasiswa (NIM, Nama, Angkatan, Id_Asal) VALUES
('230441100099', 'Aini', 2023, 3),
('230441100088', 'Friska', 2023, 2),
('230441100022', 'Lanny', 2023, 3),
('230441100036', 'Citra', 2023, 3),
('230441100071', 'Nanda', 2023, 1),
('230441100068', 'Vivi', 2023, 2),
('230441100031', 'Alin', 2023, 2),
('230441100176', 'Giska', 2023, 1),
('230441100138', 'Ana', 2023, 1),
('230441100109', 'Marsha', 2023, 1);

INSERT INTO Dosen (NIDN, Nama, Email) VALUES
('11001', 'Mohammad Syarif, ST., M.Cs', 'MohammadSyarief@gmail.com'),
('11002', 'Mala Rosa Aprillya, S.Kom., M.Kom.', 'rosaprillya@gmail.com'),
('11003', 'Dr.Wahyudi Setiawan, S.Kom., M.Kom.', 'WahyudiSetiawan@gmail.com'),
('11004', 'Wahyudi Agustiono, S.Kom., M.Sc, Ph.D.', 'WahyudiAgustiono@gmail.com'),
('11005', 'Rosida Vivin Nahari, S.Kom,.MT', 'RosidaVivin@gmail.com'),
('11006', 'Eza Rahmanita, ST.,MT', 'EzaRahmanita@gmail.com'),
('11007', 'Sri Herawati, S.Kom, M.Kom', 'SriHerawati@gmail.com'),
('11008', 'Fitri Damayanti, S.Kom., M.Kom.', 'FitriDamayanti@gmail.com'),
('11009', 'Novi Prastiti, S.Kom, M.Kom', 'NoviPrastiti@gmail.com'),
('11010', 'Firli Irhamni, ST., M.Kom.', 'FirliIrhamni@gmail.com');

INSERT INTO Matakuliah (Kode_MK, Nama_MK, Sks) VALUES
('01', 'Sistem Menejemen Basis Data', 4),
('02', 'Pemrograman Bergerak', 4),
('03', 'Data Mining', 3),
('04', 'Implementasi dan Pengujian Perangkat Lunak', 3),
('05', 'Manajemen Proyek IT', 3),
('06', 'Perencanaan Sumber Daya Perusahaan', 3),
('07', 'Sistem Pendukung Keputusan', 3),
('08', 'Etika dan Profesi', 2),
('09', 'Financial Technology', 3),
('10', 'Pengantar Basis Data', 4);

INSERT INTO KRS (NIM, Kode_MK, Semester) VALUES
('230441100099', '01', 4),
('230441100071', '02', 4),
('230441100088', '07', 4),
('230441100022', '05', 4),
('230441100068', '04', 4);

SELECT * FROM Asal;
SELECT * FROM Mahasiswa;
SELECT * FROM Dosen;
SELECT * FROM Matakuliah;
SELECT * FROM KRS;

ALTER TABLE Dosen RENAME TO Data_Dosen;
SHOW TABLES;
DROP DATABASE akademik;