CREATE DATABASE peta_indonesia;

USE peta_indonesia;

CREATE TABLE provinsi (
id_provinsi INT AUTO_INCREMENT PRIMARY KEY,
nama_provinsi VARCHAR(100) NOT NULL
);

INSERT INTO provinsi (nama_provinsi) VALUES
('Jawa Barat'), ('Jawa Tengah'), ('Jawa Timur');

CREATE TABLE kabupaten_kota (
id_kabupaten INT AUTO_INCREMENT PRIMARY KEY,
id_provinsi INT,
nama_kabupaten VARCHAR(100) NOT NULL,
FOREIGN KEY (id_provinsi) REFERENCES provinsi(id_provinsi)
);

INSERT INTO kabupaten_kota (id_provinsi, nama_kabupaten) VALUES 
(1, 'Bandung'), (1, 'Bekasi'), 
(2, 'Semarang'), 
(3, 'Surabaya'); 

CREATE TABLE kecamatan (
id_kecamatan INT AUTO_INCREMENT PRIMARY KEY,
id_kabupaten INT,
nama_kecamatan VARCHAR(100) NOT NULL,
FOREIGN KEY (id_kabupaten) REFERENCES kabupaten_kota(id_kabupaten)
);

INSERT INTO kecamatan (id_kabupaten, nama_kecamatan) VALUES
(1, 'Cicendo'), (1, 'Coblong'), (1, 'Antapani'),
(2, 'Bekasi Barat'), (2, 'Bekasi Utara'),
(3, 'Tembalang'),
(4, 'Bubutan'), (4, 'Jambangan');

CREATE TABLE desa_kelurahan (
id_desa INT AUTO_INCREMENT PRIMARY KEY,
id_kecamatan INT,
nama_desa VARCHAR(100) NOT NULL,
FOREIGN KEY (id_kecamatan) REFERENCES kecamatan(id_kecamatan)
);

INSERT INTO desa_kelurahan (id_kecamatan, nama_desa) VALUES
(1, 'Sukajadi'),
(2, 'Dago'), 
(3, 'Antapani Kidul'), 
(4, 'Pondok Ungu'), 
(5, 'Harapan Makmur'),
(6, 'Bulusan'),
(7, 'Sukasari'),
(8, 'Mekar Jaya');

CREATE TABLE data_peta (
id_peta INT AUTO_INCREMENT PRIMARY KEY,
id_desa INT,
koordinat TEXT,
luas_wilayah FLOAT,
batas_utara VARCHAR(100),
batas_selatan VARCHAR(100),
batas_timur VARCHAR(100),
batas_barat VARCHAR(100),
FOREIGN KEY (id_desa) REFERENCES desa_kelurahan(id_desa)
);

INSERT INTO data_peta (id_desa, koordinat, luas_wilayah, batas_utara, batas_selatan, batas_timur, batas_barat) VALUES
(1, '[-6.9, 107.6]', 3.5, 'Cicendo', 'Sukajadi', 'Cihampelas', 'Pasteur'),
(2, '[-6.8, 107.6]', 2.8, 'Coblong', 'Dago Atas', 'Lembang', 'Cihampelas');

CREATE TABLE populasi (
id_populasi INT AUTO_INCREMENT PRIMARY KEY,
id_desa INT,
tahun INT,
jumlah_penduduk INT,
FOREIGN KEY (id_desa) REFERENCES desa_kelurahan(id_desa)
);

INSERT INTO populasi (id_desa, tahun, jumlah_penduduk) VALUES
(1, 2023, 19000),
(2, 2023, 16000),
(3, 2023, 18000),
(4, 2023, 17000),
(5, 2023, 19500),
(6, 2023, 4100),
(7, 2023, 2800);

CREATE TABLE data_pembangunan (
id_pembangunan INT AUTO_INCREMENT PRIMARY KEY,
id_desa INT,
nama_proyek VARCHAR(255),
tahun_mulai INT,
tahun_selesai INT,
STATUS ENUM('Perencanaan', 'Berjalan', 'Selesai'),
FOREIGN KEY (id_desa) REFERENCES desa_kelurahan(id_desa)
);

INSERT INTO data_pembangunan (id_desa, nama_proyek, tahun_mulai, tahun_selesai, STATUS) VALUES
(1, 'Pembangunan Jalan Lingkungan', 2022, 2023, 'Selesai'),
(2, 'Revitalisasi Trotoar', 2023, 2024, 'Berjalan'),
(3, 'Pembangunan Posyandu', 2024, 2025, 'Perencanaan'),
(4, 'Pembangunan Jembatan Desa', 2023, 2024, 'Berjalan'),
(5, 'Perluasan Drainase', 2024, 2025, 'Perencanaan');

SHOW TABLES;

----------- pertemuan 2 ------------
-------- soal 1 --------
CREATE OR REPLACE VIEW view_populasi_desa AS
SELECT 
d.nama_desa,
k.nama_kecamatan,
p.tahun,
p.jumlah_penduduk
FROM desa_kelurahan d
JOIN kecamatan k ON d.id_kecamatan = k.id_kecamatan
JOIN populasi p ON d.id_desa = p.id_desa
WHERE p.tahun = 2023;

SELECT * FROM view_populasi_desa;

-------- soal 2 --------
CREATE VIEW view_desa_penduduk_pembangunan AS
SELECT 
d.nama_desa,
k.nama_kecamatan,
kk.nama_kabupaten,
p.tahun,
p.jumlah_penduduk,
b.nama_proyek,
b.status
FROM desa_kelurahan d
JOIN kecamatan k ON d.id_kecamatan = k.id_kecamatan
JOIN kabupaten_kota kk ON k.id_kabupaten = kk.id_kabupaten
JOIN populasi p ON d.id_desa = p.id_desa
JOIN data_pembangunan b ON d.id_desa = b.id_desa;

SELECT * FROM view_desa_penduduk_pembangunan WHERE STATUS = 'Berjalan';

-------- soal 3 --------
CREATE VIEW view_desa_padat_penduduk AS
SELECT 
d.nama_desa,
k.nama_kecamatan,
p.tahun,
p.jumlah_penduduk
FROM desa_kelurahan d
JOIN kecamatan k ON d.id_kecamatan = k.id_kecamatan
JOIN populasi p ON d.id_desa = p.id_desa
WHERE p.tahun = 2023 AND p.jumlah_penduduk > 15000;

SELECT * FROM view_desa_padat_penduduk;

-------- soal 4 --------
CREATE VIEW view_statistik_kecamatan AS
SELECT 
k.id_kecamatan,
k.nama_kecamatan,
COUNT(DISTINCT b.id_pembangunan) AS jumlah_proyek,
AVG(p.jumlah_penduduk) AS rata_rata_penduduk,
MAX(p.jumlah_penduduk) AS penduduk_terbanyak
FROM kecamatan k
JOIN desa_kelurahan d ON d.id_kecamatan = k.id_kecamatan
JOIN populasi p ON d.id_desa = p.id_desa
JOIN data_pembangunan b ON d.id_desa = b.id_desa
GROUP BY k.id_kecamatan, k.nama_kecamatan;

SELECT * FROM view_statistik_kecamatan;

-------- soal 5 --------
CREATE OR REPLACE VIEW view_desa_aktif_pembangunan AS
SELECT 
d.nama_desa,
k.nama_kecamatan,
COUNT(b.id_pembangunan) AS total_proyek
FROM desa_kelurahan d
JOIN kecamatan k ON d.id_kecamatan = k.id_kecamatan
JOIN data_pembangunan b ON d.id_desa = b.id_desa
GROUP BY d.id_desa, d.nama_desa, k.nama_kecamatan
HAVING COUNT(b.id_pembangunan) = 1;

SELECT * FROM view_desa_aktif_pembangunan;