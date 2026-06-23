-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Waktu pembuatan: 23 Jun 2026 pada 17.53
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
-- Basis data: `toko_buku`
--

DELIMITER $$
--
-- Prosedur
--
DROP PROCEDURE IF EXISTS `tambah_transaksi`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `tambah_transaksi` (IN `p_id_pelanggan` INT, IN `p_id_buku` INT, IN `p_jumlah` INT)   BEGIN
    DECLARE v_harga DECIMAL(10,2);
    DECLARE v_stok INT;
    DECLARE v_total_harga DECIMAL(10,2);
    DECLARE v_stok_cukup BOOLEAN DEFAULT TRUE;
    
    SELECT harga, stok INTO v_harga, v_stok
    FROM buku
    WHERE id_buku = p_id_buku;
    
    IF v_stok < p_jumlah THEN
        SET v_stok_cukup = FALSE;
        SELECT 'ERROR: Stok tidak mencukupi!' AS Pesan;
    ELSE
        SET v_total_harga = v_harga * p_jumlah;
        
        UPDATE buku
        SET stok = stok - p_jumlah
        WHERE id_buku = p_id_buku;
        
        INSERT INTO transaksi (id_pelanggan, id_buku, jumlah, total_harga, tanggal_transaksi)
        VALUES (p_id_pelanggan, p_id_buku, p_jumlah, v_total_harga, CURDATE());
        
        UPDATE pelanggan
        SET total_belanja = total_belanja + v_total_harga
        WHERE id_pelanggan = p_id_pelanggan;
        
        SELECT 'Transaksi berhasil!' AS Pesan;
    END IF;
END$$

--
-- Fungsi
--
DROP FUNCTION IF EXISTS `hitung_diskon`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `hitung_diskon` (`total_belanja` DECIMAL(10,2)) RETURNS DECIMAL(5,2) DETERMINISTIC BEGIN
    DECLARE diskon DECIMAL(5,2);
    IF total_belanja < 1000000 THEN
        SET diskon = 0;
    ELSEIF total_belanja >= 1000000 AND total_belanja < 5000000 THEN
        SET diskon = 5;
    ELSE
        SET diskon = 10;
    END IF;
    RETURN diskon;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `buku`
--

DROP TABLE IF EXISTS `buku`;
CREATE TABLE IF NOT EXISTS `buku` (
  `id_buku` int NOT NULL AUTO_INCREMENT,
  `judul` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `penulis` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `harga` decimal(10,2) DEFAULT NULL,
  `stok` int DEFAULT NULL,
  PRIMARY KEY (`id_buku`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `buku`
--

INSERT INTO `buku` (`id_buku`, `judul`, `penulis`, `harga`, `stok`) VALUES
(1, 'Pemrograman MySQL', 'Andi Saputra', 150000.00, 10),
(2, 'Belajar PHP', 'Budi Santoso', 200000.00, 8),
(3, 'Database Sistem', 'Citra Dewi', 250000.00, 5),
(4, 'Jaringan Komputer', 'Dedi Kurniawan', 180000.00, 12),
(5, 'Algoritma Dasar', 'Eka Fitriani', 120000.00, 15);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pelanggan`
--

DROP TABLE IF EXISTS `pelanggan`;
CREATE TABLE IF NOT EXISTS `pelanggan` (
  `id_pelanggan` int NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_belanja` decimal(10,2) DEFAULT '0.00',
  `status_member` enum('REGULER','GOLD','PLATINUM') COLLATE utf8mb4_unicode_ci DEFAULT 'REGULER',
  PRIMARY KEY (`id_pelanggan`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `pelanggan`
--

INSERT INTO `pelanggan` (`id_pelanggan`, `nama`, `total_belanja`, `status_member`) VALUES
(1, 'Ahmad Fauzi', 0.00, 'REGULER'),
(2, 'Bella Ramadhani', 0.00, 'REGULER'),
(3, 'Cahyo Nugroho', 0.00, 'REGULER');

--
-- Trigger `pelanggan`
--
DROP TRIGGER IF EXISTS `update_status_member`;
DELIMITER $$
CREATE TRIGGER `update_status_member` AFTER UPDATE ON `pelanggan` FOR EACH ROW BEGIN
    DECLARE status_baru ENUM('REGULER', 'GOLD', 'PLATINUM');
    
    IF NEW.total_belanja >= 5000000 THEN
        SET status_baru = 'PLATINUM';
    ELSEIF NEW.total_belanja >= 1000000 THEN
        SET status_baru = 'GOLD';
    ELSE
        SET status_baru = 'REGULER';
    END IF;
    
    IF NEW.status_member != status_baru THEN
        UPDATE pelanggan
        SET status_member = status_baru
        WHERE id_pelanggan = NEW.id_pelanggan;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi`
--

DROP TABLE IF EXISTS `transaksi`;
CREATE TABLE IF NOT EXISTS `transaksi` (
  `id_transaksi` int NOT NULL AUTO_INCREMENT,
  `id_pelanggan` int DEFAULT NULL,
  `id_buku` int DEFAULT NULL,
  `jumlah` int DEFAULT NULL,
  `total_harga` decimal(10,2) DEFAULT NULL,
  `tanggal_transaksi` date DEFAULT NULL,
  PRIMARY KEY (`id_transaksi`),
  KEY `id_pelanggan` (`id_pelanggan`),
  KEY `id_buku` (`id_buku`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
