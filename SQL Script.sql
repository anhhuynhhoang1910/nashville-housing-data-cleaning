CREATE Database nashvillehousing_cleaning;
USE nashvillehousing_cleaning;

SELECT *
FROM nashville_housing;
------------
ALTER TABLE nashville_housing
ADD SaleDateConverted DATE;

SET SQL_SAFE_UPDATES = 0;

UPDATE nashville_housing
SET SaleDateConverted = STR_TO_DATE(SaleDate, '%d-%b-%y');
---------
SELECT *
FROM nashville_housing
WHERE PropertyAddress is NULL 
ORDER BY ParcelID; 

SELECT a.UniqueID, a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, IFNULL(a.PropertyAddress,b.PropertyAddress)
FROM nashville_housing a
JOIN nashville_housing b
	on a.ParcelID = b.ParcelID
	and a.`UniqueID` <> b.`UniqueID`
WHERE a.PropertyAddress is NULL;

UPDATE nashville_housing a
JOIN nashville_housing b
    ON a.ParcelID = b.ParcelID
    AND a.`UniqueID` <> b.`UniqueID`
SET a.PropertyAddress = IFNULL(a.PropertyAddress, b.PropertyAddress)
WHERE a.PropertyAddress IS NULL;
----- 
SELECT 
    SUBSTRING(PropertyAddress, 1, LOCATE(',', PropertyAddress) - 1 ) AS Address, 
    SUBSTRING(PropertyAddress, LOCATE(',', PropertyAddress) + 1, LENGTH(PropertyAddress)) AS City
FROM nashville_housing;

ALTER TABLE nashville_housing
ADD PropertySplitAddress varchar(255);

Update nashville_housing 
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, LOCATE(',', PropertyAddress) -1 );

ALTER TABLE nashville_housing
ADD PropertySplitCity Varchar(255);

UPDATE nashville_housing
SET PropertySplitCity = SUBSTRING(PropertyAddress, LOCATE(',', PropertyAddress) + 1, LENGTH(PropertyAddress));

---

Select *
From nashville_housing