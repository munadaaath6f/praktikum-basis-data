-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Waktu pembuatan: 23 Jun 2026 pada 18.18
-- Versi server: 8.4.7
-- Versi PHP: 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Basis data: `db_praktikum`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `tagihan`
--

DROP TABLE IF EXISTS `tagihan`;
CREATE TABLE IF NOT EXISTS `tagihan` (
  `id_tagihan` int NOT NULL AUTO_INCREMENT,
  `nim` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_mhs` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jumlah` decimal(12,2) NOT NULL,
  `status_bayar` enum('Belum Lunas','Lunas') COLLATE utf8mb4_unicode_ci DEFAULT 'Belum Lunas',
  `tgl_tagihan` date NOT NULL,
  PRIMARY KEY (`id_tagihan`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `tagihan`
--

INSERT INTO `tagihan` (`id_tagihan`, `nim`, `nama_mhs`, `jumlah`, `status_bayar`, `tgl_tagihan`) VALUES
(1, '2021001', 'Andi Saputra', 2500000.00, 'Lunas', '2026-01-10'),
(2, '2021002', 'Budi Santoso', 2500000.00, 'Lunas', '2026-01-10'),
(3, '2021003', 'Citra Lestari', 2750000.00, 'Belum Lunas', '2026-01-10');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
