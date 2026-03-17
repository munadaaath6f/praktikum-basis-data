-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 11 Mar 2026 pada 04.51
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `teknologi_informasi`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `jurusan`
--

CREATE TABLE `jurusan` (
  `id_jurusan` int(11) NOT NULL,
  `nama_jurusan` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `jurusan`
--

INSERT INTO `jurusan` (`id_jurusan`, `nama_jurusan`) VALUES
(1, 'Teknologi Informasi'),
(2, 'Teknik Elektro'),
(3, 'Teknik Mekatronika'),
(4, 'Teknik Informatika');

-- --------------------------------------------------------

--
-- Struktur dari tabel `mahasiswa`
--

CREATE TABLE `mahasiswa` (
  `npm` varchar(20) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `id_jurusan` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `mahasiswa`
--

INSERT INTO `mahasiswa` (`npm`, `nama`, `id_jurusan`) VALUES
('2505001', 'Windah Basudara', 1),
('2505002', 'Miawaug', 1),
('2505003', 'Reza arap', 2),
('2505004', 'Bigmo', 2),
('2505005', 'Shinji Ikari', 3),
('2505006', 'Asuka', 3),
('2505007', 'Lutpi', 4),
('2505008', 'Alfachri', 4);

-- --------------------------------------------------------

--
-- Struktur dari tabel `mata_kuliah`
--

CREATE TABLE `mata_kuliah` (
  `mk_id` int(11) NOT NULL,
  `nama_mk` varchar(100) NOT NULL,
  `sks` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `mata_kuliah`
--

INSERT INTO `mata_kuliah` (`mk_id`, `nama_mk`, `sks`) VALUES
(1, 'Basis Data', 3),
(2, 'Struktur Data', 3),
(3, 'Paradigma sistem', 2),
(4, 'Kalkulus', 3);

-- --------------------------------------------------------

--
-- Struktur dari tabel `nilai`
--

CREATE TABLE `nilai` (
  `nilai_id` int(11) NOT NULL,
  `npm` varchar(20) DEFAULT NULL,
  `mk_id` int(11) DEFAULT NULL,
  `nilai` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `nilai`
--

INSERT INTO `nilai` (`nilai_id`, `npm`, `mk_id`, `nilai`) VALUES
(1, '2505001', 1, 85.00),
(2, '2505001', 2, 87.00),
(3, '2505001', 3, 90.00),
(4, '2505001', 4, 78.00),
(5, '2505002', 1, 83.00),
(6, '2505002', 2, 85.00),
(7, '2505002', 3, 92.00),
(8, '2505002', 4, 80.00),
(9, '2505003', 1, 93.00),
(10, '2505003', 2, 80.00),
(11, '2505003', 3, 76.00),
(12, '2505003', 4, 83.00),
(13, '2505004', 1, 80.00),
(14, '2505004', 2, 82.00),
(15, '2505004', 3, 89.00),
(16, '2505004', 4, 92.00),
(17, '2505005', 1, 81.00),
(18, '2505005', 2, 79.00),
(19, '2505005', 3, 78.00),
(20, '2505005', 4, 90.00),
(21, '2505006', 1, 90.00),
(22, '2505006', 2, 89.00),
(23, '2505006', 3, 87.00),
(24, '2505006', 4, 89.00),
(25, '2505007', 1, 79.00),
(26, '2505007', 2, 91.00),
(27, '2505007', 3, 88.00),
(28, '2505007', 4, 89.00),
(29, '2505008', 1, 83.00),
(30, '2505008', 2, 96.00),
(31, '2505008', 3, 83.00),
(32, '2505008', 4, 83.00);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `jurusan`
--
ALTER TABLE `jurusan`
  ADD PRIMARY KEY (`id_jurusan`);

--
-- Indeks untuk tabel `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD PRIMARY KEY (`npm`),
  ADD KEY `id_jurusan` (`id_jurusan`);

--
-- Indeks untuk tabel `mata_kuliah`
--
ALTER TABLE `mata_kuliah`
  ADD PRIMARY KEY (`mk_id`);

--
-- Indeks untuk tabel `nilai`
--
ALTER TABLE `nilai`
  ADD PRIMARY KEY (`nilai_id`),
  ADD KEY `npm` (`npm`),
  ADD KEY `mk_id` (`mk_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `jurusan`
--
ALTER TABLE `jurusan`
  MODIFY `id_jurusan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `mata_kuliah`
--
ALTER TABLE `mata_kuliah`
  MODIFY `mk_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `nilai`
--
ALTER TABLE `nilai`
  MODIFY `nilai_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD CONSTRAINT `mahasiswa_ibfk_1` FOREIGN KEY (`id_jurusan`) REFERENCES `jurusan` (`id_jurusan`);

--
-- Ketidakleluasaan untuk tabel `nilai`
--
ALTER TABLE `nilai`
  ADD CONSTRAINT `nilai_ibfk_1` FOREIGN KEY (`npm`) REFERENCES `mahasiswa` (`npm`),
  ADD CONSTRAINT `nilai_ibfk_2` FOREIGN KEY (`mk_id`) REFERENCES `mata_kuliah` (`mk_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
