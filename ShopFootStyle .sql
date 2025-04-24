-- Tạo cơ sở dữ liệu
CREATE DATABASE SHOP_BAN_DEP1002;
GO
USE SHOP_BAN_DEP1002;
GO


-- Bảng KieuDang
CREATE TABLE KieuDang (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ten NVARCHAR(255) NOT NULL,
    trangthai INTEGER NOT NULL,
);

-- Thêm dữ liệu vào bảng KieuDang
INSERT INTO KieuDang (ten, trangthai) VALUES 
(N'Kiểu tròn mũi', 1),
(N'Kiểu vuông mũi', 1),
(N'Kiểu mũi nhọn', 1),
(N'Kiểu có quai chéo', 1),
(N'Kiểu quai ngang', 1),
(N'Kiểu quai chéo chồng', 1),
(N'Kiểu dây mảnh', 1),
(N'Kiểu khóa gài', 1);


-- Bảng MauSac
CREATE TABLE MauSac (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ten NVARCHAR(255) NOT NULL,
    trangthai INTEGER NOT NULL,
);

INSERT INTO MauSac (ten, trangthai) VALUES 
(N'Đen', 1),          -- Đen
(N'Trắng', 1),        -- Trắng
(N'Đỏ', 1),           -- Đỏ
(N'Vàng', 1),         -- Vàng
(N'Xanh lá cây', 1), -- Xanh lá cây
(N'Xanh dương', 1),  -- Xanh dương
(N'Nâu', 1),         -- Nâu
(N'Tím than', 1),         -- Tím
(N'Cam', 1),
(N'Kem',1),  -- Kem
(N'Hồng', 1);        -- Hồng


-- Bảng ChatLieu
CREATE TABLE ChatLieu (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ten NVARCHAR(255) NOT NULL,
    trang_thai INTEGER NOT NULL,
);

INSERT INTO ChatLieu (ten, trang_thai) VALUES 
(N'Da', 1),             -- Chất liệu da
(N'Vải', 1),            -- Chất liệu vải
(N'Cao su', 1),         -- Chất liệu cao su
(N'Nhựa', 1),           -- Chất liệu nhựa
(N'Len', 1),            -- Chất liệu len
(N'Lưới', 1),           -- Chất liệu lưới
(N'Da tổng hợp', 1),    -- Chất liệu da tổng hợp
(N'Xốp', 1),            -- Chất liệu xốp
(N'Vải canvas', 1),     -- Chất liệu vải canvas
(N'Bông', 1),          -- Chất liệu nhung
(N'Giả da', 1);         -- Chất liệu giả da


-- Bảng Size
CREATE TABLE Size (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ten NVARCHAR(255) NOT NULL,
	trang_thai INTEGER NOT NULL
);

-- Thêm dữ liệu vào bảng Size (kích cỡ dép)
INSERT INTO Size (ten, trang_thai) VALUES 
('35', 1),
('36', 1),
('37', 1),
('38', 1),
('39', 1),
('40', 1),
('41', 1),
('42', 1),
('43', 1),
('44', 1);

-- Bảng DanhMuc
CREATE TABLE DanhMuc (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ten NVARCHAR(255) NOT NULL,
    trangthai INTEGER NOT NULL,
    ngay_tao DATE NOT NULL,
    ngay_sua DATE
);

-- Thêm dữ liệu vào bảng DanhMuc
INSERT INTO DanhMuc (ten, trangthai, ngay_tao, ngay_sua) VALUES 
(N'Dép xỏ ngón', 1, '2024-10-14', NULL),
(N'Dép sandal', 1, '2024-10-14', NULL),
(N'Dép quai hậu', 1, '2024-10-14', NULL),
(N'Dép lê', 1, '2024-10-14', NULL),
(N'Dép Kẹp', 1, '2024-10-14', NULL),
(N'Dép cao gót', 1, '2024-10-14', NULL),
(N'Dép thể thao', 1, '2024-10-14', NULL),
(N'Dép quai thắt', 1, '2024-10-14', NULL),
(N'Dép phòng tắm', 1, '2024-10-14', NULL);

-- Bảng SanPham
CREATE TABLE SanPham (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ma NVARCHAR(255) UNIQUE NOT NULL,
    ten NVARCHAR(255) NOT NULL,
    trangThai INTEGER NOT NULL,
    anh NVARCHAR(255) NOT NULL,
    thuongHieu NVARCHAR(255) NOT NULL,
    ngayTao DATE,
    ngaySua DATETIME2,
    giaBan DECIMAL(18, 2),
    moTa NVARCHAR(3000),
    gioiTinh BIT,  -- true cho Nam, false cho Nữ
    id_Kieu_dang INT NOT NULL,
    id_chat_lieu INT NOT NULL,
    id_danh_muc_san_pham INT NOT NULL,
    CONSTRAINT fk_kieu_dang_sp FOREIGN KEY (id_Kieu_dang) REFERENCES KieuDang(id),
    CONSTRAINT fk_chat_lieu_sp FOREIGN KEY (id_chat_lieu) REFERENCES ChatLieu(id),
    CONSTRAINT fk_danh_muc_sp FOREIGN KEY (id_danh_muc_san_pham) REFERENCES DanhMuc(id)
);


-- Bảng Anh
CREATE TABLE Anh (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ten VARCHAR(255),
    id_san_pham INT,
    FOREIGN KEY (id_san_pham) REFERENCES SanPham(id)
);
CREATE TABLE Vai_Tro (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ten_vai_tro NVARCHAR(50) NOT NULL -- Ví dụ: Admin, NhanVien, KhachHang
);
INSERT INTO Vai_Tro (ten_vai_tro) VALUES 
('ADMIN'), 
('STAFF'),
('CLIENT');
-- Bảng KhachHang
CREATE TABLE Users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    tai_khoan NVARCHAR(255) UNIQUE NOT NULL, 
    mat_khau NVARCHAR(255) NOT NULL,          
    email NVARCHAR(255) NOT NULL,             
    trang_thai INT ,                  
    id_vai_tro INT NOT NULL,                  
    ngay_tao DATE NOT NULL,                  
    ngay_sua DATE NULL,                       
    CONSTRAINT FK_VaiTro_User FOREIGN KEY (id_vai_tro) REFERENCES Vai_Tro(id)
);
ALTER TABLE Users ADD reset_token VARCHAR(255) Null;
ALTER TABLE Users ADD reset_token_expiration DATETIME Null;

-- Bảng Voucher
CREATE TABLE Voucher (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ten NVARCHAR(255),
    ma VARCHAR(55),
    gia_tri_giam DECIMAL(10, 2),
    gia_tri_don_hang_toi_thieu DECIMAL(10, 2),
    ngay_bat_dau DATE,
    ngay_ket_thuc DATE,
    trang_thai INT, -- Trạng thái: 0 = Còn hiệu lực, 1 = Hết hiệu lực
	ly_do NVARCHAR(255)
);

-- Bảng KhachHang
CREATE TABLE Khach_Hang (
    id INT IDENTITY(1,1) PRIMARY KEY,          -- Khóa chính, tự động tăng
    ho_ten NVARCHAR(255) NOT NULL,            -- Họ và tên khách hàng
    sdt VARCHAR(15) NOT NULL,                 -- Số điện thoại
    dia_chi NVARCHAR(255) NOT NULL,           -- Địa chỉ khách hàng
    gioi_tinh BIT NOT NULL DEFAULT 0,         -- Giới tính (0 = Nam, 1 = Nữ)
    user_id INT NOT NULL,                     -- Tham chiếu đến bảng Users
    CONSTRAINT FK_User_KhachHang FOREIGN KEY (user_id) REFERENCES Users(id)
);
-- Bảng Khach_Hang_Voucher
CREATE TABLE Khach_Hang_Voucher (
    khach_hang_id INT NOT NULL,
    voucher_id INT NOT NULL,
    trang_thai INT, -- Trạng thái của voucher cho khách hàng: 0 = Còn hiệu lực, 1 = Đã sử dụng, 2 = Hết hiệu lực
	ghi_chu NVARCHAR(255),
    PRIMARY KEY (khach_hang_id, voucher_id),
    FOREIGN KEY (khach_hang_id) REFERENCES Khach_Hang(id),
    FOREIGN KEY (voucher_id) REFERENCES Voucher(id)
);

CREATE TRIGGER UpdateVoucherAndCustomerVoucherStatus
ON Voucher
AFTER UPDATE
AS
BEGIN
    DECLARE @current_date DATETIME = GETDATE();

    -- Cập nhật trạng thái voucher nếu ngày kết thúc đã qua
    UPDATE v
    SET v.trang_thai = 1  -- 1 = Hết hiệu lực
    FROM Voucher v
    WHERE v.ngay_ket_thuc < @current_date AND v.trang_thai = 0;

    -- Cập nhật trạng thái trong bảng Khach_Hang_Voucher
    UPDATE khv
    SET khv.trang_thai = 2  -- 2 = Hết hiệu lực
    FROM Khach_Hang_Voucher khv
    INNER JOIN Voucher v ON khv.voucher_id = v.id
    WHERE v.ngay_ket_thuc < @current_date AND v.trang_thai = 1;
END;



-- Bảng ChiTietSanPham
CREATE TABLE ChiTietSanPham (
    id INT IDENTITY(1,1) PRIMARY KEY,
    idsanpham INT NOT NULL,  -- Khóa ngoại để liên kết với bảng SanPham
	soLuong int not null,
    trangthai INTEGER,	
    qrcode NVARCHAR(255),
    idmausac INT NOT NULL,
    idsize INT NOT NULL,
    CONSTRAINT fk_san_pham_ctsp FOREIGN KEY (idsanpham) REFERENCES SanPham(id) ON DELETE CASCADE,
    CONSTRAINT fk_mau_sac_ctsp FOREIGN KEY (idmausac) REFERENCES MauSac(id),
    CONSTRAINT fk_size_ctsp FOREIGN KEY (idsize) REFERENCES Size(id)
);

ALTER TABLE ChiTietSanPham
ADD image NVARCHAR(255);


CREATE TABLE NhapHang (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_chi_tiet_san_pham INT NOT NULL, -- Khóa ngoại đến bảng ChiTietSanPham
    soLuong INT NOT NULL,              -- Số lượng nhập
    giaNhap DECIMAL(18, 2) NOT NULL,   -- Giá nhập
    ngayNhap DATE NOT NULL,            -- Ngày nhập hàng         
    CONSTRAINT fk_chi_tiet_san_pham FOREIGN KEY (id_chi_tiet_san_pham) REFERENCES ChiTietSanPham(id) ON DELETE CASCADE
);
CREATE TABLE dbo.nhan_vien (
    id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    gioi_tinh INT NULL,                       
    cccd NVARCHAR(255) NULL,                
    dia_chi NVARCHAR(255) NULL,             
    email NVARCHAR(255) NULL,               
    ma_nhan_vien NVARCHAR(255) NULL,          
    quoc_tinh NVARCHAR(255) NULL,           
    sdt VARCHAR(15) NOT NULL,           
    ten_nhan_vien NVARCHAR(255) NULL,        
    trang_thai INT NULL,                                                   
    user_id INT NOT NULL,                     
    CONSTRAINT FK_User_NhanVien FOREIGN KEY (user_id) REFERENCES Users(id)
);

CREATE TABLE TrangThai (
    id INT IDENTITY(1,1) PRIMARY KEY,
    ten NVARCHAR(255) NOT NULL
);

CREATE TABLE HoaDon (
    id INT IDENTITY(1,1) PRIMARY KEY,
    diaChi NVARCHAR(255),
    hoTen NVARCHAR(255),
    sdt VARCHAR(15),
    ngayTao DATETIME,
    ngay_nhan_hang DATETIME,
    ngay_thanh_toan DATE,
    moTa NVARCHAR(255),
	tienHang DECIMAL(18, 2),
	tienShip DECIMAL(18, 2),
	tienGiam DECIMAL(18, 2),
    tongTien DECIMAL(18, 2),
    trangThai INT,  -- Khóa ngoại tham chiếu đến TrangThai
    loaiHoaDon BIT, -- Khóa ngoại tham chiếu đến LoaiHoaDon
    phuongThucThanhToan BIT, -- Khóa ngoại tham chiếu đến PhuongThucThanhToan
    hinhThucNhanHang BIT,
    idNhanVien INT,
    idKhachHang INT,
	idVoucher INT,
	lyDoHuy NVARCHAR(255),
	Id_dia_chi_van_chuyen INT,
	trangThaiThanhToan BIT,
    CONSTRAINT fk_nhan_vien_hd FOREIGN KEY (idNhanVien) REFERENCES nhan_vien(id),
    CONSTRAINT fk_khach_hang_hd FOREIGN KEY (idKhachHang) REFERENCES Khach_Hang(id),
    CONSTRAINT fk_trang_thai FOREIGN KEY (trangThai) REFERENCES TrangThai(id),
	CONSTRAINT fk_voucher FOREIGN KEY (idVoucher) REFERENCES Voucher(id),
);

CREATE TABLE tinh (
    Id_tinh INT PRIMARY KEY IDENTITY(1,1),
    ma_tinh NVARCHAR(10),
    ten_tinh NVARCHAR(100),
    ngay_tao DATETIME DEFAULT GETDATE(),
    ngay_cap_nhat DATETIME DEFAULT GETDATE()
);

-- Tạo bảng huyen
CREATE TABLE huyen (
    Id_huyen INT PRIMARY KEY IDENTITY(1,1),
    ten_huyen NVARCHAR(100),
    id_tinh INT,
    ngay_tao DATETIME DEFAULT GETDATE(),
    ngay_cap_nhat DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_huyen_id_tinh FOREIGN KEY (id_tinh) REFERENCES tinh(Id_tinh)
);

-- Tạo bảng xa
CREATE TABLE xa (
    Id_xa INT PRIMARY KEY IDENTITY(1,1),
    ten_xa NVARCHAR(100),
    id_huyen INT,
    ngay_tao DATETIME DEFAULT GETDATE(),
    ngay_cap_nhat DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_xa_id_huyen FOREIGN KEY (id_huyen) REFERENCES huyen(Id_huyen)
);

-- Tạo bảng dia_chi_van_chuyen
CREATE TABLE dia_chi_van_chuyen (
    Id_dia_chi_van_chuyen INT PRIMARY KEY IDENTITY(1,1),
    id_tinh INT,
    id_huyen INT,
    id_xa INT,
    dia_chi_cu_the NVARCHAR(100),
    ngay_tao DATETIME DEFAULT GETDATE(),
    ngay_cap_nhat DATETIME DEFAULT GETDATE(),
    trang_thai BIT DEFAULT 1,
    mo_ta NVARCHAR(MAX),
    khach_hang_id INT,
    CONSTRAINT FK_dia_chi_van_chuyen_id_nguoi_dung FOREIGN KEY (khach_hang_id) REFERENCES Khach_Hang(id),
    CONSTRAINT FK_dia_chi_van_chuyen_id_tinh FOREIGN KEY (id_tinh) REFERENCES tinh(Id_tinh),
    CONSTRAINT FK_dia_chi_van_chuyen_id_huyen FOREIGN KEY (id_huyen) REFERENCES huyen(Id_huyen),
    CONSTRAINT FK_dia_chi_van_chuyen_id_xa FOREIGN KEY (id_xa) REFERENCES xa(Id_xa)
)

CREATE TABLE TrangThaiHoaDonChiTiet (
    id INT IDENTITY(1,1) PRIMARY KEY,
    tenTrangThai NVARCHAR(255) NOT NULL
);

CREATE TABLE HoaDonChiTiet (
    id INT IDENTITY(1,1) PRIMARY KEY, -- ID tự tăng
    donGia DECIMAL(18, 2), -- Đơn giá, không được null
    soLuong INT,           -- Số lượng, không được null
    idHoaDon INT,          -- Khóa ngoại tới bảng Hóa Đơn
    idCTSP INT,            -- Khóa ngoại tới bảng Chi Tiết Sản Phẩm
    id_trangThai INT,      -- Khóa ngoại tới bảng Trạng Thái Hóa Đơn Chi Tiết
    lyDoHuy NVARCHAR(500) NULL,     -- Lý do hủy sản phẩm (tùy chọn)

    -- Định nghĩa khóa ngoại
    CONSTRAINT fk_hoa_don_hdt FOREIGN KEY (idHoaDon) REFERENCES HoaDon(id),
    CONSTRAINT fk_ctsp_hdt FOREIGN KEY (idCTSP) REFERENCES ChiTietSanPham(id),
    CONSTRAINT fk_trang_thai_hdt FOREIGN KEY (id_trangThai) REFERENCES TrangThaiHoaDonChiTiet(id)
);


-- Bảng GioHang
CREATE TABLE GioHang (
    id INT IDENTITY(1,1) PRIMARY KEY,
    idKhachHang INT,       -- Để có thể nhận giá trị null cho khách lẻ
    ngayTao DATE NOT NULL,
    trangThai INTEGER NOT NULL,
    CONSTRAINT fk_khach_hang_gh FOREIGN KEY (idKhachHang) REFERENCES Khach_Hang(id)
);

-- Bảng GioHangChiTiet
CREATE TABLE GioHangChiTiet (
    id INT IDENTITY(1,1) PRIMARY KEY,
    idGioHang INT NOT NULL,
    idCTSP INT NOT NULL,
    soLuong INTEGER NOT NULL,
    CONSTRAINT fk_gio_hang_ghct FOREIGN KEY (idGioHang) REFERENCES GioHang(id),
    CONSTRAINT fk_ctsp_ghct FOREIGN KEY (idCTSP) REFERENCES ChiTietSanPham(id)
);


CREATE TABLE KhuyenMai (
    id INT PRIMARY KEY IDENTITY(1,1), -- Sử dụng IDENTITY để tự động tăng ID
    ma NVARCHAR(255) UNIQUE NOT NULL,
    ten NVARCHAR(255) NOT NULL,
    ngay_bat_dau DATE NOT NULL,
    ngay_ket_thuc DATE NOT NULL,
    mo_ta NVARCHAR(500), 
    trang_thai INTEGER NOT NULL, -- 0: Không hoạt động, 1: Hoạt động
    loai_giam_gia BIT NOT NULL DEFAULT 0, -- true: Giảm %, false: Giảm VND
    muc_giam DECIMAL(18, 2) -- Thêm cột mức giảm với kiểu DECIMAL
);

GO
-- Bảng ctsp_khuen_mai
CREATE TABLE dbo.ctsp_khuyen_mai (
    id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    don_gia_sau_khi_giam NUMERIC(18, 2) NULL,
    loai_giam_gia BIT NOT NULL,
    muc_giam NUMERIC(18, 2) NOT NULL,
    trang_thai INT NOT NULL,
    id_khuyen_mai INT NOT NULL,
    id_san_pham INT NOT NULL,
    CONSTRAINT FK_ctsp_khuyen_mai_san_pham FOREIGN KEY (id_san_pham) REFERENCES dbo.SanPham(id),
    CONSTRAINT FK_ctsp_khuyen_mai_khuyen_mai FOREIGN KEY (id_khuyen_mai) REFERENCES dbo.KhuyenMai(id)
);


INSERT INTO TrangThai (ten) VALUES 
(N'Chờ xác nhận'),
(N'Đang xử lý'),
(N'Chờ đơn vị vận chuyển'),
(N'Đang vận chuyển'),
(N'Chờ nhận hàng'),
(N'Đã nhận hàng'),
(N'Hoàn thành'),
(N'Hủy'),
(N'Tạo đơn hàng')


INSERT INTO TrangThaiHoaDonChiTiet (tenTrangThai) VALUES 
(N'Chờ xử lý'),
(N'Đang giao hàng'),
(N'Hoàn tất'),
(N'Đã hủy'),
(N'Đã nhận hàng');




INSERT INTO SanPham (ma, ten, trangThai, anh, thuongHieu, ngayTao, giaBan, moTa, gioiTinh, id_Kieu_dang, id_chat_lieu, id_danh_muc_san_pham) 
VALUES ('SP1', N'Dép nam quai ngang chữ H Phong cách thời trang giới trẻ hot, SANG CHẢNH', 1, N'Dép nam quai ngang chữ H Siêu Cấp, Dép phong cách thời trang giới trẻ hot theo thòi gian SANG CHẢNH, lịch sự trắng.png', 'Hermes', '2024-12-16', 175000.00, NULL, 1, 1, 5, 8),
('SP2', N'Dép lông hồng đi trong nhà', 1, N'Dép lông nữ hồng.jpg', 'Hermes', '2024-12-16', 175000.00, NULL, 1, 1, 5, 8),
('SP3', N'Dép quai ngang Balen', 1, N'Dép nam quai ngang Balen đế cao su đúc bền chống trơn trượt màu đen - BLĐ Koya .png', 'Hermes', '2024-12-16', 175000.00, NULL, 1, 1, 5, 8),
('SP4', N'Dép quai ngang nam chữ H', 1, N'Dép nam quai ngang chữ H Siêu Cấp, Dép phong cách thời trang giới trẻ hot theo thòi gian SANG CHẢNH, lịch sự cam.png', 'Hermes', '2024-12-16', 175000.00, NULL, 1, 1, 5, 8),
('SP5', N'Dép quai hậu nữ khóa màu đen', 1, N'Dép nhựa quai hậu nữ kiểu gài khoá màu đen.jpg', 'Hermes', '2024-12-16', 175000.00, NULL, 1, 1, 5, 8),
('SP6', N'Dép nữ MWC, quai ngang dính nơ', 1, N'Dép Nữ MWC 8294 - Dép Nữ Quai Ngang Đính Nơ Tiểu Thư Siêu Xinh, Dép Nữ Đế Đúc Năng Động, Trẻ Trung, Thời Trang Màu Trắng.jpg', 'Hermes', '2024-12-16', 175000.00, NULL, 1, 1, 5, 8),
('SP7', N'Dép nữ quai ngang bản to nhún cách', 1, N'Dép Nữ MWC 8347 - Dép Nữ Quai Ngang Bản To Nhún Cách Điệu, Dép Đế Đúc 3cm Năng Động,Trẻ Trung, Thời Trang Màu Nâu.jpg', 'Hermes', '2024-12-16', 175000.00, NULL, 1, 1, 5, 8),
('SP8', N'Dép quai nữ đính khóa', 1, N'Dép Nữ MWC 8397 - Dép Quai Nữ Đính Khóa Chữ Nhỏ Xinh, Dép Nữ Đế Cao Phong Cách Trẻ Trung, Thời Trang Đen.jpg', 'Hermes', '2024-12-16', 175000.00, NULL, 1, 1, 5, 8),
('SP9', N'Dép Sandal Cross đế cao', 1, N'Dép Nữ MWC 8422 - Dép Sandal Cross Đế Cao 7cm Gắn Sticker Siêu Xinh, Trẻ Trung, Thời Trang Màu Đen.jpg', 'Hermes', '2024-12-16', 175000.00, NULL, 1, 1, 5, 8),
('SP10', N'Dép nữ quai thắt nút cách điệu lạ mắt', 1, N'Dép Nữ MWC 8443 - Dép Nữ Quai Thắt Nút Cách Điệu Lạ Mắt, Dép Đế Bệt Năng Động, Trẻ Trung Thời Trang Màu Be.jpg', 'Hermes', '2024-12-16', 175000.00, NULL, 1, 1, 5, 8),
('SP11', N'Dép nữ quai thắt đế 4cm', 1, N'Dép Nữ MWC 8456 - Dép Nữ Quai Kéo Thắt Nơ Cách Điệu Lạ Mắt, Dép Đế Cao 4cm Năng Động, Trẻ Trung,Thời Trang Màu Đen.jpg', 'Hermes', '2024-12-16', 175000.00, NULL, 1, 1, 5, 8),
('SP12', N'Dép nữ quai thắt đế cao 4cm', 1, N'Dép nam quai ngang chữ H Siêu Cấp, Dép phong cách thời trang giới trẻ hot theo thòi gian SANG CHẢNH, lịch sự cam.png', 'Hermes', '2024-12-16', 175000.00, NULL, 1, 1, 5, 8),
('SP13', N'Dép nữ quai mảnh đính đá', 1, N'Dép Nữ MWC 8483 - Dép Nữ Quai Mảnh Đính Đá Sang Chảnh Siêu Bền Đẹp, Dép Đế Bệt Nữ Đi Làm, Đi Chơi, Dạo Phố Hottrend Thời Trang Quai Nâu.jpg', 'Hermes', '2024-12-16', 175000.00, NULL, 1, 1, 5, 8),
('SP14', N'Dép nữ dạo phố siêu bền đẹp', 1, N'Dép Nữ MWC 8491 - Dép Nữ Dạo Phố, Đi Chơi Siêu Bền Đẹp, Dép Nữ Quai Quai Ngang Rọ Phong Cách Năng Động, Trẻ Trung Màu Nâu Sữa.jpg', 'Hermes', '2024-12-16', 175000.00, NULL, 1, 1, 5, 8),
('SP28', N'Dép nữ đế bệt quai mảnh đi chơi', 1, N'Dép Nữ MWC 8496 - Dép Nữ Đế Bệt Quai Mảnh Đi Chơi, Đi Biển, Dạo Phố, Năng Động, Trẻ Trung, Thời Trang Quai Đen Đế Nâu.jpg', 'Hermes', '2024-12-16', 175000.00, NULL, 1, 1, 5, 8),
('SP16', N'Dép nữ quai ngang bản to siêu bền đẹp', 1, N'Dép Nữ MWC 8497 - Dép Nữ Quai Ngang Bản To Siêu Bền Đẹp, Dép Nữ Đế Bệt Phong Cách Thời Thượng màu đen.jpg', 'Hermes', '2024-12-16', 175000.00, NULL, 1, 1, 5, 8),
('SP15', N'Dép nữ dạo phố quai ngang bản to phối xỏ ngón năng động', 1, N'Dép Nữ MWC 8499 - Dép Nữ Dạo Phố, Đi Học, Đi Chơi Siêu Bền Đẹp, Dép Nữ Quai Ngang Bản To Phối Xỏ Ngón Năng Động, Trẻ Trung Quai Đen Đế Nâu.jpg', 'Hermes', '2024-12-16', 175000.00, NULL, 1, 1, 5, 8),
('SP17', N'Dép nữ quai ngang chữ H bản to', 1, N'Dép Nữ MWC 8501 - Dép Nữ Quai Ngang Chữ H Bản To Siêu Êm Nhẹ, Dép Nữ Đế Đúc Nguyên Khối Năng Động,Trẻ Trung, Thời Trang Màu Đen.jpg', 'Hermes', '2024-12-16', 175000.00, NULL, 1, 1, 5, 8),
('SP18', N'Dép nữ đế bánh mì cao 5cm, quai tròng đính khoen sang chảnh', 1, N'Dép nữ MWC NUDE- 8322 Dép Nữ Đế Bánh Mì Cao 5cm,Dép Nữ Quai Tròn Đính Khoen Sang Chảnh Thời Trang Màu Đeb.jpg', 'Hermes', '2024-12-16', 175000.00, NULL, 1, 1, 5, 8),
('SP19', N'Dép quai dán nam nữ Dior', 1, N'Dép quai dán nam nữ di or in hoạ tiết giá rẻ đế mới ,dày dặn chắc chắn quai ngang thời trang nam nữ cháy phố.png', 'Hermes', '2024-12-16', 175000.00, NULL, 1, 1, 5, 8),
('SP20', N'Dép quai ngang đen', 1, N'Dép quai ngang đen.jpg', 'Hermes', '2024-12-16', 175000.00, NULL, 1, 1, 5, 8),
('SP21', N'Dép tổ ong công nghệ nano', 1, N'Dép tổ ong công nghệ nano cam.jpg', 'Hermes', '2024-12-16', 175000.00, NULL, 1, 1, 5, 8),
('SP22', N'Dép xỏ ngón đen', 1, N'Dép xỏ ngón đen.jpg', 'Hermes', '2024-12-16', 175000.00, NULL, 1, 1, 5, 8),
('SP23', N'Dép da cao cấp da', 1, N'depdacaocaptrang.png', 'Hermes', '2024-12-16', 175000.00, NULL, 1, 1, 5, 8),
('SP24', N'Dép Gucci', 1, N'depguci.png', 'Hermes', '2024-12-16', 175000.00, NULL, 1, 1, 5, 8),
('SP25', N'Dép lông be', 1, N'depLongBe.png', 'Hermes', '2024-12-16', 175000.00, NULL, 1, 1, 5, 8),
('SP26', N'Dép vip', 1, N'depVip1.png', 'Hermes', '2024-12-16', 175000.00, NULL, 1, 1, 5, 8),
('SP27', N'Dép nữ quai thắt nút cách điệu', 1, N'mwcDép Nữ MWC 8443 - Dép Nữ Quai Thắt Nút Cách Điệu Lạ Mắt, Dép Đế Bệt Năng Động, Trẻ Trung Thời Trang Màu Nâu.jpg', 'Hermes', '2024-12-16', 175000.00, NULL, 1, 1, 5, 8)

select * from HoaDon