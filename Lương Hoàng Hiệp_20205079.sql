Create table KhachHang(
MaKH varchar(4) PRIMARY KEY,
HoTen varchar(30),
SoDienThoai varchar(10),
CoQuan varchar(30));

Create table NhaChoThue(
MaN varchar(4) PRIMARY KEY,
DiaChi varchar(30),
GiaThue money,
TenChuNha varchar(20));

Create table HopDong(
MaKH varchar(4),
MaN varchar(4),
NgayBatDau date,
NgayKetThuc date,
constraint PK_HD PRIMARY KEY(MaKH,MaN));

INSERT INTO NhaChoThue
VALUES ('N1', 'HaNoi', 3000000,'Hoang');

INSERT INTO NhaChoThue
VALUES 
('N2', 'ThaiNguyen', 30000000,'Hieu'),
('N3', 'HaiPhong', 500000,'Hiep'),
('N4', 'HaNoi', 12000000,'Hoang'),
('N5', 'ThanhHoa', 2000000,'Dat'),
('N6', 'ThaiBinh', 3500000,'Dat'),
('N7', 'NamDinh', 4000000,'Dat'),
('N8', 'HaNoi', 15000000,'Hoang'),
('N9', 'ThaiNguyen', 20000000,'Hieu'),
('N10', 'HaNoi', 1000000,'Hiep');

Insert into KhachHang
Values('KH01','NongVanDen','0987654321','Dai hoc Bach Khoa'),
('KH02','TranVanHieu','0987754321','Dai hoc Bach Khoa'),
('KH03','PhamVuHoang','0957654321','Dai hoc Cong Nghe'),
('KH04','PhamTrungHieu','0987654329','Dai hoc Ngoai Thuong'),
('KH05','NguyenHoangHiep','0987154321','Dai hoc Bach Khoa'),
('KH06','CaoBaQuat','0987654399','Dai hoc Xay Dung'),
('KH07','TranVanTrung','0987774321','Dai hoc Su Pham'),
('KH08','LeVanHung','0989954321','Dai hoc Xay Dung'),
('KH09','CaoBaHai','0987650021','Dai hoc Cong Nghe'),
('KH10','NguyenKimHuy','0987098321','Dai hoc Su Pham'),
('KH11','NguyenBaQuoc','0987114321','Dai hoc Kinh Te QD'),
('KH12','LeTrongTuan','0987622221','Dai hoc Ngoai Thuong'),
('KH13','BuiVanQuang','0988676321','Dai hoc Bach Khoa'),
('KH14','LeTrongTung','0987000321','Dai hoc Ngoai Thuong'),
('KH15','NguyenNgocChung','0981114321','Dai hoc Bach Khoa');

INSERT INTO HopDong
VALUES 
('KH14', 'N8', '2002-01-01','2004-01-01'),
('KH08', 'N9', '2002-02-02','2004-02-02'),
('KH11', 'N1', '2002-03-03','2004-03-03'),
('KH03', 'N10', '2002-04-04','2004-04-04'),
('KH09', 'N2', '2002-05-05','2004-05-05'),
('KH10', 'N9', '2002-06-06','2004-06-06'),
('KH07', 'N5', '2002-07-07','2004-07-07'),
('KH12', 'N8', '2002-08-08','2004-08-08'),
('KH11', 'N7', '2002-09-09','2004-09-09'),
('KH13', 'N2', '2002-10-10','2004-10-10');


SELECT DiaChi,TenChuNha
FROM NhaChoThue
WHERE GiaThue<10000000;

SELECT KhachHang.MaKH,KhachHang.HoTen,KhachHang.CoQuan
FROM KhachHang,NhaChoThue,HopDong
WHERE KhachHang.MaKH=HopDong.MaKH AND NhaChoThue.MaN=HopDong.MaN AND NhaChoThue.TenChuNha='Hieu';

SELECT *
FROM NhaChoThue
WHERE MaN NOT IN (SELECT MaN FROM HopDong);

SELECT MAX(NhaChoThue.GiaThue) as GiaCaoNhat
FROM NhaChoThue
WHERE MaN IN (SELECT MaN FROM HopDong);

SELECT KhachHang.HoTen,KhachHang.SoDienThoai
FROM KhachHang
WHERE CoQuan = 'Dai hoc Su Pham'

CREATE NONCLUSTERED INDEX index_CoQuan
ON KhachHang (CoQuan ASC);

SELECT KhachHang.HoTen,KhachHang.SoDienThoai
FROM KhachHang
WHERE CoQuan = 'Dai hoc Su Pham'

CREATE INDEX index_TenChuNha
ON NhaChoThue (TenChuNha);
EXECUTE sp_helpindex KhachHang;
DROP INDEX index_CoQuan ON KhachHang;

SELECT DISTINCT NhaChoThue.TenChuNha,COUNT(HopDong.MaN) as SoLuong
FROM NhaChoThue,HopDong
WHERE NhaChoThue.MaN=HopDong.MaN
GROUP BY NhaChoThue.TenChuNha;

CREATE PROCEDURE MyStoredProcedure @Gia int
AS
SELECT *FROM HopDong Where HopDong.MaN IN (SELECT MaN FROM NhaChoThue WHERE NhaChoThue.GiaThue> @Gia);

EXEC MyStoredProcedure @Gia = 10000000;

CREATE PROCEDURE KH @Gia int
AS
SELECT *FROM KhachHang Where KhachHang.MaKH IN (SELECT MaKH 
												FROM NhaChoThue,HopDong 
												WHERE NhaChoThue.MaN=HopDong.MaN
												GROUP BY HopDong.MaKH
												HAVING SUM(NhaChoThue.GiaThue)>@Gia);

EXEC KH @Gia = 10000000;

