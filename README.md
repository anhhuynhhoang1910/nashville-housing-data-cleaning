# 🛠️ SQL Project: Data Cleaning & Standardization (Nashville Housing)

![MySQL](https://img.shields.io/badge/MySQL-005C84?style=for-the-badge&logo=mysql&logoColor=white)
![Data Cleaning](https://img.shields.io/badge/Data_Cleaning-FF9E0F?style=for-the-badge&logo=data-databricks&logoColor=white)

*( 🇬🇧 [Read in English](#english-version) | 🇻🇳 [Đọc bản Tiếng Việt](#phiên-bản-tiếng-việt) )*

---

## English Version

## 1. Project Overview
This project focuses purely on the **Data Preparation and Transformation** phase. The objective is to take a raw real estate dataset containing over 56,000 records, identify system errors (missing values, incorrect formats, duplicates), and utilize SQL to transform it into a highly structured, clean dataset ready for downstream analytical pipelines. 
* **Tool Used:** MySQL

## 2. Advanced SQL Techniques Applied
* **Window Functions & CTEs:** Leveraged `ROW_NUMBER() OVER(PARTITION BY ...)` in conjunction with Common Table Expressions (CTEs) to accurately identify and remove duplicate records without compromising original data integrity.
* **Self-Joins & Data Imputation:** Resolved `NULL` values in the Address field by joining the table to itself and retrieving missing data through cross-referenced `ParcelID`.
* **Complex String Manipulation:** Combined `SUBSTRING_INDEX()`, `SUBSTRING()`, `LOCATE()`, and `TRIM()` functions to parse messy, concatenated address strings into distinct spatial data fields (Address, City, State).
* **Control Flow:** Standardized categorical data consistency using `CASE WHEN` statements.

## 3. Data Quality Impact (Before & After)
* **Uniqueness:** Successfully identified and eradicated **104** duplicate rows caused by human/system entry errors.
* **Completeness:** Imputed and recovered **29** missing `PropertyAddress` (`NULL`) values via cross-reference tracking, achieving zero data loss.
* **Consistency:** Harmonized the `SoldAsVacant` field, standardizing over **450** inconsistent entries ('Y', 'N') into a uniform binary format ('Yes', 'No').
* **Optimization:** Dropped **4** redundant raw data columns after successful extraction and conversion, significantly optimizing database storage and query performance.

## 4. Detailed Cleaning Process (Step-by-Step)
1. **Date Standardization:** Converted the original string format of the `SaleDate` field into the standard SQL `DATE` format.
2. **Handling Missing Data:** Populated `NULL` property addresses using Self-Joins.
3. **Address Parsing:** Split the original `PropertyAddress` and `OwnerAddress` fields into granular columns (Address, City, State) to facilitate future geographical filtering.
4. **Data Harmonization:** Replaced 'Y' and 'N' with 'Yes' and 'No' in the `SoldAsVacant` column.
5. **Table Optimization:** Removed unused columns.
6. **Deduplication:** Engineered a robust filter to delete replicated rows.


---

## Phiên bản Tiếng Việt
*( ⬆️ [Back to English Version](#english-version) )*

## 1. Tổng quan dự án
Dự án này tập trung vào giai đoạn **Data Preparation và Transformation**. Mục tiêu là tiếp nhận một bộ dữ liệu thô (Raw Data) về thị trường bất động sản Nashville với hơn 56.000 bản ghi, định vị các lỗi hệ thống (thiếu sót, định dạng sai, trùng lặp) và sử dụng SQL để tinh chỉnh thành một bộ dữ liệu sạch (Clean Data) chuẩn mực, sẵn sàng cho các pipeline phân tích phía sau. 
* **Công cụ sử dụng:** MySQL.

## 2. Kỹ thuật SQL nâng cao được áp dụng
* **Window Functions & CTEs:** Sử dụng `ROW_NUMBER() OVER(PARTITION BY ...)` kết hợp với Common Table Expressions (CTE) để định vị và loại bỏ chính xác các bản ghi trùng lặp mà không làm suy hao dữ liệu gốc.
* **Self-Joins & Data Imputation:** Khôi phục các giá trị `NULL` ở trường Địa chỉ bằng cách `JOIN` bảng với chính nó, truy xuất dữ liệu lấp đầy thông qua mã lô đất tham chiếu (`ParcelID`).
* **Complex String Manipulation:** Kết hợp logic `SUBSTRING_INDEX()`, `SUBSTRING()`, `LOCATE()`, và `TRIM()` để bóc tách các chuỗi địa chỉ hỗn hợp thành các trường không gian độc lập (Address, City, State).
* **Control Flow:** Chuẩn hóa tính nhất quán của dữ liệu phân loại bằng lệnh `CASE WHEN`.

## 3. Báo cáo chất lượng dữ liệu
* **Tính duy nhất (Uniqueness):** Phát hiện và xóa bỏ vĩnh viễn **104** dòng dữ liệu bị nhân bản (Duplicates) do lỗi nhập liệu của hệ thống.
* **Tính toàn vẹn (Completeness):** Lấp đầy **29** ô địa chỉ bị trống (`NULL`) bằng kỹ thuật truy vết tham chiếu chéo, đạt tỷ lệ thất thoát dữ liệu 0% (Zero data loss).
* **Tính nhất quán (Consistency):** Đồng nhất hoàn toàn cột `SoldAsVacant`, chuyển đổi hơn **450** giá trị rác ('Y', 'N') thành định dạng chuẩn ('Yes', 'No').
* **Tối ưu hóa (Optimization):** Cắt bỏ (`DROP`) **4** cột dữ liệu thô nguyên thủy sau khi đã bóc tách và chuyển đổi thành công, giúp tiết kiệm không gian lưu trữ và tăng tốc truy vấn.

## 4. Quy trình làm sạch chi tiết
1. **Chuẩn hóa Ngày tháng:** Chuyển đổi định dạng chuỗi (String) ban đầu của trường `SaleDate` sang định dạng `DATE` chuẩn.
2. **Xử lý Dữ liệu Thiếu:** Khôi phục dữ liệu `PropertyAddress` bị `NULL` bằng Self-Joins.
3. **Bóc tách Địa chỉ:** Xé lẻ trường `PropertyAddress` và `OwnerAddress` ban đầu thành các cột định danh chi tiết (Địa chỉ, Thành phố, Bang) hỗ trợ lọc dữ liệu không gian.
4. **Đồng nhất Dữ liệu:** Chuyển đổi các giá trị 'Y', 'N' thành 'Yes', 'No' trong cột `SoldAsVacant`.
5. **Dọn dẹp Bảng:** Xóa bỏ các cột gốc không còn giá trị sử dụng.
6. **Loại bỏ Trùng lặp (Deduplication):** Xây dựng bộ lọc với kỹ thuật phân mảnh dữ liệu (Partition) để xóa các dòng bị sao chép.
