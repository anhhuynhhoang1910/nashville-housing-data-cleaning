CREATE Database nashvillehousing_cleaning;
USE nashvillehousing_cleaning;
SET SQL_SAFE_UPDATES = 0;

-- VIEW DATASET 

SELECT *
FROM nashville_housing;

-- TRANSFORMING SALEDATE FROM STRING TO DATE TYPE

ALTER TABLE nashville_housing
ADD SaleDateConverted DATE;

UPDATE nashville_housing
SET SaleDateConverted = STR_TO_DATE(SaleDate, '%d-%b-%y');

-- FILLING PROPERTYADDRESS VIA PARCELID REFERENCE

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

-- BREAKING OUT ADDRESS INTO INDIVIDUAL COLUMNS
 
SELECT 
    SUBSTRING(PropertyAddress, 1, LOCATE(',', PropertyAddress) - 1 ) AS Address, 
    SUBSTRING(PropertyAddress, LOCATE(',', PropertyAddress) + 1, LENGTH(PropertyAddress)) AS City
FROM nashville_housing;

ALTER TABLE nashville_housing
ADD PropertySplitAddress varchar(255),
ADD PropertySplitCity Varchar(255);

UPDATE nashville_housing 
SET 
    PropertySplitAddress = SUBSTRING(PropertyAddress, 1, LOCATE(',', PropertyAddress) - 1),
    PropertySplitCity = TRIM(SUBSTRING(PropertyAddress, LOCATE(',', PropertyAddress) + 1, LENGTH(PropertyAddress)));
    
SELECT 
	SUBSTRING_INDEX(OwnerAddress, ',', 1) AS Address,
    SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 2), ',', -1) AS City,
    SUBSTRING_INDEX(OwnerAddress, ',', -1) AS State 
FROM nashville_housing;

ALTER TABLE nashville_housing 
ADD OwnerSplitAddress varchar(255),
ADD OwnerSplitCity varchar(255),
ADD OwnerSplitState varchar(255);

UPDATE nashville_housing
SET OwnerSplitAddress = SUBSTRING_INDEX(OwnerAddress, ',', 1),
	OwnerSplitCity = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 2), ',', -1)),
	OwnerSplitState = TRIM(SUBSTRING_INDEX(OwnerAddress, ',', -1));
    
-- CHANGE Y AND N TO YES AND NO IN 'SOLD AS VACANT' AS FIELD

SELECT SoldAsVacant, COUNT(SoldAsVacant)
FROM nashville_housing
GROUP BY SoldAsVacant
ORDER BY 2;

SELECT SoldAsVacant, 
	   CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
			WHEN SoldAsVacant = 'N' THEN 'No'
			ELSE SoldAsVacant
			END AS Changed 
FROM nashville_housing; 

UPDATE nashville_housing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
			            WHEN SoldAsVacant = 'N' THEN 'No'
			            ELSE SoldAsVacant
		             	END; 

-- DELETE UNUSED COLUMNS

ALTER TABLE nashville_housing
DROP COLUMN OwnerAddress,
DROP COLUMN TaxDistrict,
DROP COLUMN PropertyAddress,
DROP COLUMN SaleDate;

-- REMOVE DUPLICATES

WITH RowNumCTE AS(
	SELECT *,
		   ROW_NUMBER() OVER (
		   PARTITION BY ParcelID,
				        SalePrice,
				        LegalReference,
                        SaleDateConverted,
                        PropertySplitAddress
	       ORDER BY UniqueID
					) row_num
	FROM nashville_housing)
SELECT * 
FROM RowNumCTE 
WHERE row_num > 1
ORDER BY PropertySplitAddress;

DELETE a
FROM nashville_housing a
JOIN (
    SELECT UniqueID,
           ROW_NUMBER() OVER (
           PARTITION BY ParcelID,
                        SalePrice,
                        LegalReference,
                        SaleDateConverted,
                        PropertySplitAddress
           ORDER BY UniqueID
                    ) AS row_num
    FROM nashville_housing
) b ON a.UniqueID = b.UniqueID
WHERE b.row_num > 1;

--

SET SQL_SAFE_UPDATES = 1;

select *
from nashville_housing