-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 09, 2024 at 01:08 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pendaftar_mhs_baru`
--

-- --------------------------------------------------------

--
-- Table structure for table `pendaftar`
--

CREATE TABLE `pendaftar` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `no_telpon` varchar(20) NOT NULL,
  `alamat` text NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `jenis_kelamin` enum('L','P') NOT NULL,
  `nilai` decimal(5,2) NOT NULL,
  `progdi_id` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pendaftar`
--

INSERT INTO `pendaftar` (`id`, `nama`, `email`, `no_telpon`, `alamat`, `tanggal_lahir`, `jenis_kelamin`, `nilai`, `progdi_id`) VALUES
(1, 'Romy', 'romy@gmail.com', '08123456789', 'Jl. Contoh No. 123', '1995-08-15', 'L', 85.00, 'A11'),
(2, 'Mico', 'mico@gmail.com', '087654321', '123 Contoh St.', '1994-11-20', 'L', 81.25, 'A12'),
(3, 'Rifan', 'rifan@gmail.com', '0854321098', '456 Model Rd.', '1996-03-08', 'L', 77.50, 'B12'),
(4, 'Zee', 'zee@gmail.com', '081112223344', '789 Test Ave.', '1993-07-12', 'P', 88.75, 'A15'),
(5, 'Freya', 'freya@gmail.com', '081234567890', '987 Trial Blvd.', '1992-01-30', 'P', 84.00, 'B11'),
(6, 'Romz', 'romz@gmail.com', '08123456789', 'Jl. Demak No. 123', '2000-08-15', 'L', 89.00, 'A11'),
(7, 'Romx', 'romx@gmail.com', '08123456789', 'Jl. Jepara No. 1', '2004-08-15', 'L', 75.00, 'A11'),
(8, 'Roma', 'roma@gmail.com', '08123456789', 'Jl. Semarang No. 14', '2001-08-15', 'L', 95.00, 'A11'),
(9, 'Romb', 'romb@gmail.com', '08123456789', 'Jl. Semarang No. 14', '2003-08-15', 'L', 95.00, 'A11'),
(10, 'romxzy', 'romxzy@gmail.com', '089746561632', 'Jepara', '2004-06-14', 'L', 98.00, 'A15'),
(11, 'ROMY NUR WIDIANTO DAFALAH', 'romynurwidiantodafalah@gmail.com', '0899912345', 'Desa BAWU RT 38 RW 08 Kec. Batealit Kab. Jepara', '2004-06-14', 'L', 98.00, 'A11');

--
-- Triggers `pendaftar`
--
DELIMITER $$
CREATE TRIGGER `trg_insert_pendaftaran` AFTER INSERT ON `pendaftar` FOR EACH ROW BEGIN
    DECLARE v_status ENUM('diterima', 'ditolak');
    DECLARE v_nim VARCHAR(20);
    
    IF NEW.nilai >= 85 THEN
        SET v_status = 'diterima';
        SET v_nim = CONCAT((SELECT kode FROM progdi WHERE kode = NEW.progdi_id), '.', YEAR(CURRENT_DATE), '.', LPAD((SELECT COUNT(*) + 1 FROM pendaftaran WHERE progdi_id = NEW.progdi_id AND status = 'diterima'), 5, '0'));
    ELSE
        SET v_status = 'ditolak';
        SET v_nim = NULL;
    END IF;
    
    INSERT INTO pendaftaran (nama, nilai, progdi_id, status, nim)
    VALUES (NEW.nama, NEW.nilai, NEW.progdi_id, v_status, v_nim);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pendaftaran`
--

CREATE TABLE `pendaftaran` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `nilai` decimal(5,2) NOT NULL,
  `progdi_id` varchar(10) DEFAULT NULL,
  `tanggal_pendaftaran` date DEFAULT curdate(),
  `status` enum('diterima','ditolak') NOT NULL,
  `nim` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pendaftaran`
--

INSERT INTO `pendaftaran` (`id`, `nama`, `nilai`, `progdi_id`, `tanggal_pendaftaran`, `status`, `nim`) VALUES
(1, 'Romy', 85.00, 'A11', '2024-07-08', 'diterima', 'A11.2024.00001'),
(2, 'Mico', 81.25, 'A12', '2024-07-08', 'ditolak', NULL),
(3, 'Rifan', 77.50, 'B12', '2024-07-08', 'ditolak', NULL),
(4, 'Zee', 88.75, 'A15', '2024-07-08', 'diterima', 'A15.2024.00001'),
(5, 'Freya', 84.00, 'B11', '2024-07-08', 'ditolak', NULL),
(6, 'Romz', 89.00, 'A11', '2024-07-08', 'diterima', 'A11.2024.00002'),
(7, 'Romx', 75.00, 'A11', '2024-07-08', 'ditolak', NULL),
(8, 'Roma', 95.00, 'A11', '2024-07-08', 'diterima', 'A11.2024.00003'),
(9, 'Romb', 95.00, 'A11', '2024-07-08', 'diterima', 'A11.2024.00004'),
(10, 'romxzy', 98.00, 'A15', '2024-07-09', 'diterima', 'A15.2024.00002'),
(11, 'ROMY NUR WIDIANTO DAFALAH', 98.00, 'A11', '2024-07-09', 'diterima', 'A11.2024.00005');

--
-- Triggers `pendaftaran`
--
DELIMITER $$
CREATE TRIGGER `trg_update_nim` AFTER UPDATE ON `pendaftaran` FOR EACH ROW BEGIN
    IF NEW.status = 'diterima' AND NEW.nim IS NULL THEN
        UPDATE pendaftaran
        SET nim = CONCAT((SELECT kode FROM progdi WHERE kode = NEW.progdi_id), '.', YEAR(NEW.tanggal_pendaftaran), '.', LPAD((SELECT COUNT(*) + 1 FROM pendaftaran WHERE progdi_id = NEW.progdi_id AND status = 'diterima'), 5, '0'))
        WHERE id = NEW.id;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `progdi`
--

CREATE TABLE `progdi` (
  `kode` varchar(10) NOT NULL,
  `nama_progdi` varchar(100) NOT NULL,
  `fakultas` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `progdi`
--

INSERT INTO `progdi` (`kode`, `nama_progdi`, `fakultas`) VALUES
('A11', 'Teknik Informatika - S1', 'Fakultas Ilmu Komputer'),
('A12', 'Sistem Informasi - S1', 'Fakultas Ilmu Komputer'),
('A14', 'Desain Komunikasi Visual - S1', 'Fakultas Ilmu Komputer'),
('A15', 'Ilmu Komunikasi - S1', 'Fakultas Ilmu Komputer'),
('B11', 'Manajemen - S1', 'Fakultas Ekonomi dan Bisnis'),
('B12', 'Akuntansi - S1', 'Fakultas Ekonomi dan Bisnis'),
('C11', 'Bahasa Inggris - S1', 'Fakultas Ilmu Budaya'),
('C12', 'Sastra Jepang - S1', 'Fakultas Ilmu Budaya'),
('D11', 'Kesehatan Masyarakat - S1', 'Fakultas Kesehatan'),
('D12', 'Kesehatan Lingkungan - S1', 'Fakultas Kesehatan');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pendaftar`
--
ALTER TABLE `pendaftar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `progdi_id` (`progdi_id`);

--
-- Indexes for table `pendaftaran`
--
ALTER TABLE `pendaftaran`
  ADD PRIMARY KEY (`id`),
  ADD KEY `progdi_id` (`progdi_id`);

--
-- Indexes for table `progdi`
--
ALTER TABLE `progdi`
  ADD PRIMARY KEY (`kode`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pendaftar`
--
ALTER TABLE `pendaftar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `pendaftaran`
--
ALTER TABLE `pendaftaran`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `pendaftar`
--
ALTER TABLE `pendaftar`
  ADD CONSTRAINT `pendaftar_ibfk_1` FOREIGN KEY (`progdi_id`) REFERENCES `progdi` (`kode`);

--
-- Constraints for table `pendaftaran`
--
ALTER TABLE `pendaftaran`
  ADD CONSTRAINT `pendaftaran_ibfk_1` FOREIGN KEY (`progdi_id`) REFERENCES `progdi` (`kode`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
