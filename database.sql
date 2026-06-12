-- =====================================================
-- GO WILD WILDLIFE PARK - RELATIONAL DATABASE
-- Unit 2: Creating Systems to Manage Information
-- =====================================================

-- =====================================================
-- PART 1: CREATE TABLES (Normalized Structure)
-- =====================================================

-- 1. DIET TABLE
CREATE TABLE Diet (
    DietID TEXT PRIMARY KEY,
    DietType TEXT NOT NULL,
    NoOfFeedsPerDay INTEGER NOT NULL
);

-- 2. SPECIES TABLE
CREATE TABLE Species (
    SpeciesID TEXT PRIMARY KEY,
    SpeciesType TEXT NOT NULL,
    SpeciesGroup TEXT NOT NULL,
    Lifestyle TEXT NOT NULL,
    ConservationStatus TEXT NOT NULL
);

-- 3. KEEPER TABLE
CREATE TABLE Keeper (
    KeeperID TEXT PRIMARY KEY,
    KeeperName TEXT NOT NULL,
    KeeperDoB TEXT NOT NULL,
    KeeperRank TEXT NOT NULL CHECK (KeeperRank IN ('Senior', 'Standard', 'Junior'))
);

-- 4. ENCLOSURE TABLE
CREATE TABLE Enclosure (
    EnclosureID TEXT PRIMARY KEY,
    EnclosureType TEXT NOT NULL,
    EnclosureLocation TEXT NOT NULL CHECK (EnclosureLocation IN ('North', 'South', 'East', 'West'))
);

-- 5. ANIMAL TABLE
CREATE TABLE Animal (
    AnimalID TEXT PRIMARY KEY,
    AnimalName TEXT NOT NULL,
    Gender TEXT NOT NULL CHECK (Gender IN ('M', 'F')),
    YearOfArrival INTEGER NOT NULL CHECK (YearOfArrival >= 1900 AND YearOfArrival <= 2024),
    SpeciesID TEXT NOT NULL,
    DietID TEXT NOT NULL,
    KeeperID TEXT NOT NULL,
    EnclosureID TEXT NOT NULL,
    FOREIGN KEY (SpeciesID) REFERENCES Species(SpeciesID),
    FOREIGN KEY (DietID) REFERENCES Diet(DietID),
    FOREIGN KEY (KeeperID) REFERENCES Keeper(KeeperID),
    FOREIGN KEY (EnclosureID) REFERENCES Enclosure(EnclosureID)
);


-- =====================================================
-- PART 2: IMPORT DATA FROM CSV
-- =====================================================

-- Insert into Diet table (distinct values)
INSERT INTO Diet (DietID, DietType, NoOfFeedsPerDay) VALUES
('D1', 'Omnivore', 6),
('D2', 'Herbivore', 6),
('D3', 'Carnivore', 4),
('D4', 'Omnivore', 5),
('D5', 'Herbivore', 3),
('D6', 'Herbivore', 2),
('D7', 'Omnivore', 4),
('D8', 'Omnivore', 3),
('D9', 'Omnivore', 2),
('D10', 'Omnivore', 1),
('D11', 'Herbivore', 1);

-- Note: The CSV shows variations - updating based on actual data
UPDATE Diet SET NoOfFeedsPerDay = 6 WHERE DietID = 'D1';
UPDATE Diet SET NoOfFeedsPerDay = 6 WHERE DietID = 'D2';
UPDATE Diet SET NoOfFeedsPerDay = 4 WHERE DietID = 'D3';
INSERT INTO Diet (DietID, DietType, NoOfFeedsPerDay) VALUES ('D4', 'Omnivore', 5) ON CONFLICT(DietID) DO UPDATE SET NoOfFeedsPerDay=5;
INSERT INTO Diet (DietID, DietType, NoOfFeedsPerDay) VALUES ('D5', 'Herbivore', 3) ON CONFLICT(DietID) DO UPDATE SET NoOfFeedsPerDay=3;
INSERT INTO Diet (DietID, DietType, NoOfFeedsPerDay) VALUES ('D6', 'Herbivore', 2) ON CONFLICT(DietID) DO UPDATE SET NoOfFeedsPerDay=2;
INSERT INTO Diet (DietID, DietType, NoOfFeedsPerDay) VALUES ('D7', 'Omnivore', 4) ON CONFLICT(DietID) DO UPDATE SET NoOfFeedsPerDay=4;
INSERT INTO Diet (DietID, DietType, NoOfFeedsPerDay) VALUES ('D8', 'Omnivore', 3) ON CONFLICT(DietID) DO UPDATE SET NoOfFeedsPerDay=3;
INSERT INTO Diet (DietID, DietType, NoOfFeedsPerDay) VALUES ('D9', 'Omnivore', 2) ON CONFLICT(DietID) DO UPDATE SET NoOfFeedsPerDay=2;
INSERT INTO Diet (DietID, DietType, NoOfFeedsPerDay) VALUES ('D10', 'Omnivore', 1) ON CONFLICT(DietID) DO UPDATE SET NoOfFeedsPerDay=1;
INSERT INTO Diet (DietID, DietType, NoOfFeedsPerDay) VALUES ('D11', 'Herbivore', 1) ON CONFLICT(DietID) DO UPDATE SET NoOfFeedsPerDay=1;

-- Insert into Species table (distinct values)
INSERT INTO Species (SpeciesID, SpeciesType, SpeciesGroup, Lifestyle, ConservationStatus) VALUES
('S3', 'Gorilla', 'Mammal', 'Troop', 'Threatened'),
('S4', 'Orang-utan', 'Mammal', 'Solitary', 'Critically Endangered'),
('S6', 'Rhinoceros', 'Mammal', 'Solitary', 'Critically Endangered'),
('S7', 'Crocodile', 'Reptile', 'Social', 'Vulnerable'),
('S8', 'Elephant', 'Mammal', 'Herd', 'Threatened'),
('S9', 'Armadillo', 'Mammal', 'Solitary', 'Endangered'),
('S10', 'Giant Tortoise', 'Reptile', 'Herd', 'Vulnerable'),
('S11', 'Lion', 'Mammal', 'Pride', 'Vulnerable'),
('S12', 'Raccoon', 'Mammal', 'Solitary', 'Least Concern'),
('S13', 'Leopard', 'Mammal', 'Solitary', 'Threatened'),
('S14', 'Chinchilla', 'Mammal', 'Solitary', 'Endangered'),
('S15', 'Tamarin', 'Mammal', 'Troop', 'Critically Endangered'),
('S16', 'Penguin', 'Bird', 'Group', 'Threatened'),
('S17', 'Sea Turtle', 'Reptile', 'Solitary', 'Endangered'),
('S18', 'Sloth', 'Mammal', 'Solitary', 'Endangered'),
('S19', 'Kakapo', 'Bird', 'Solitary', 'Endangered'),
('S20', 'Hippopotamus', 'Mammal', 'Herd', 'Vulnerable');

-- Insert into Keeper table
INSERT INTO Keeper (KeeperID, KeeperName, KeeperDoB, KeeperRank) VALUES
('K1', 'Dave', '18-06-64', 'Senior'),
('K2', 'Kayden', '21-01-85', 'Junior'),
('K3', 'Suki', '09-08-98', 'Standard'),
('K4', 'Temi', '16-04-00', 'Senior');

-- Insert into Enclosure table
INSERT INTO Enclosure (EnclosureID, EnclosureType, EnclosureLocation) VALUES
('E1', 'Moat', 'North'),
('E2', 'Glass', 'North'),
('E3', 'Fence', 'South'),
('E4', 'Walled', 'South'),
('E5', 'Pen', 'South'),
('E6', 'Fence', 'East'),
('E7', 'Walled', 'East'),
('E8', 'Pen', 'East'),
('E9', 'Glass', 'West'),
('E10', 'Fence', 'West');

-- Insert into Animal table (complete dataset)
INSERT INTO Animal (AnimalID, AnimalName, Gender, YearOfArrival, SpeciesID, DietID, KeeperID, EnclosureID) VALUES
('A3', 'Geoffrey', 'M', 2018, 'S3', 'D1', 'K1', 'E2'),
('A4', 'Oliver', 'M', 2011, 'S4', 'D1', 'K1', 'E1'),
('A6', 'Roger', 'M', 2000, 'S6', 'D2', 'K2', 'E3'),
('A7', 'Clive', 'M', 2013, 'S7', 'D3', 'K2', 'E3'),
('A8', 'Eddie', 'M', 2016, 'S8', 'D2', 'K2', 'E4'),
('A9', 'Arnie', 'M', 2012, 'S9', 'D1', 'K2', 'E5'),
('A10', 'Gavin', 'M', 2015, 'S10', 'D2', 'K2', 'E5'),
('A11', 'Lucy', 'F', 2011, 'S11', 'D3', 'K3', 'E4'),
('A12', 'Robbie', 'M', 2017, 'S12', 'D1', 'K3', 'E5'),
('A13', 'Laura', 'F', 2018, 'S13', 'D3', 'K3', 'E3'),
('A14', 'Casey', 'F', 2013, 'S14', 'D2', 'K3', 'E5'),
('A15', 'Trevor', 'M', 2000, 'S15', 'D1', 'K3', 'E3'),
('A16', 'Polly', 'F', 2017, 'S16', 'D1', 'K4', 'E2'),
('A17', 'Sarah', 'F', 2015, 'S17', 'D1', 'K4', 'E2'),
('A18', 'Stan', 'M', 2018, 'S18', 'D1', 'K4', 'E3'),
('A19', 'Kara', 'F', 2001, 'S19', 'D2', 'K4', 'E4'),
('A20', 'Henry', 'M', 2003, 'S20', 'D2', 'K4', 'E3'),
('A22', 'Eliza', 'F', 2003, 'S8', 'D2', 'K2', 'E4'),
('A23', 'George', 'M', 2000, 'S3', 'D1', 'K1', 'E2'),
('A24', 'Carlos', 'M', 2017, 'S7', 'D3', 'K2', 'E3'),
('A25', 'Lenie', 'F', 2015, 'S11', 'D3', 'K3', 'E4'),
('A26', 'Roberta', 'F', 2018, 'S12', 'D1', 'K3', 'E5'),
('A27', 'Peter', 'M', 2001, 'S16', 'D1', 'K4', 'E2'),
('A28', 'Percy', 'M', 2003, 'S16', 'D1', 'K4', 'E2'),
('A29', 'Petal', 'F', 2003, 'S16', 'D1', 'K4', 'E2'),
('A30', 'Sammie', 'F', 2013, 'S18', 'D1', 'K4', 'E3'),
('A31', 'Lionel', 'M', 2016, 'S11', 'D3', 'K3', 'E4'),
('A32', 'Gertrude', 'F', 2012, 'S3', 'D1', 'K1', 'E2'),
('A33', 'Olive', 'F', 2015, 'S4', 'D1', 'K1', 'E1'),
('A34', 'Ossie', 'M', 2011, 'S4', 'D1', 'K1', 'E1'),
('A35', 'Lena', 'F', 2017, 'S13', 'D3', 'K3', 'E3'),
('A36', 'Rommy', 'F', 2018, 'S6', 'D2', 'K2', 'E3'),
('A37', 'Tulisa', 'F', 2013, 'S15', 'D1', 'K3', 'E3'),
('A38', 'Chrissie', 'F', 2000, 'S7', 'D3', 'K2', 'E3'),
('A39', 'Elsie', 'F', 2017, 'S8', 'D2', 'K2', 'E4'),
('A40', 'Colin', 'M', 2015, 'S7', 'D3', 'K2', 'E3'),
('A41', 'Hattie', 'F', 2018, 'S20', 'D2', 'K4', 'E3'),
('A42', 'Robbie', 'M', 2017, 'S6', 'D2', 'K2', 'E3'),
('A43', 'Luna', 'F', 2018, 'S11', 'D3', 'K3', 'E4'),
('A44', 'Rebbi', 'M', 2013, 'S12', 'D1', 'K3', 'E5'),
('A45', 'Penni', 'F', 2000, 'S16', 'D1', 'K4', 'E2'),
('A46', 'Emmie', 'F', 2000, 'S8', 'D2', 'K2', 'E4'),
('A47', 'Lope', 'M', 2017, 'S13', 'D3', 'K3', 'E3'),
('A48', 'Cressida', 'F', 2015, 'S14', 'D2', 'K3', 'E5'),
('A49', 'Tommy', 'M', 2018, 'S15', 'D1', 'K3', 'E3'),
('A50', 'Gareth', 'M', 2017, 'S3', 'D1', 'K1', 'E2');


-- =====================================================
-- PART 3: QUERIES (Task 3)
-- =====================================================

-- QUERY 1: Alphabetical sorted list of keepers (ID, name, rank)
SELECT KeeperID, KeeperName, KeeperRank
FROM Keeper
ORDER BY KeeperName ASC;

-- QUERY 2: Number of animals in each type of enclosure
SELECT e.EnclosureType, COUNT(a.AnimalID) AS NumberOfAnimals
FROM Enclosure e
LEFT JOIN Animal a ON e.EnclosureID = a.EnclosureID
GROUP BY e.EnclosureType
ORDER BY NumberOfAnimals DESC;

-- QUERY 3: Parameter query - keepers by rank
-- (User enters rank: Senior, Standard, or Junior)
SELECT KeeperName, KeeperDoB
FROM Keeper
WHERE KeeperRank = [Enter Rank (Senior/Standard/Junior):];

-- QUERY 4: Species with more than three feeds per day
SELECT s.SpeciesType, d.NoOfFeedsPerDay, COUNT(a.AnimalID) AS TotalAnimals
FROM Species s
JOIN Animal a ON s.SpeciesID = a.SpeciesID
JOIN Diet d ON a.DietID = d.DietID
WHERE d.NoOfFeedsPerDay > 3
GROUP BY s.SpeciesType, d.NoOfFeedsPerDay
ORDER BY d.NoOfFeedsPerDay DESC;

-- QUERY 5: Omnivores that are critically endangered
SELECT a.AnimalID, a.YearOfArrival, a.SpeciesID, a.KeeperID
FROM Animal a
JOIN Species s ON a.SpeciesID = s.SpeciesID
JOIN Diet d ON a.DietID = d.DietID
WHERE d.DietType = 'Omnivore' 
AND s.ConservationStatus = 'Critically Endangered';


-- =====================================================
-- PART 4: ADVANCED QUERIES (Task 4)
-- =====================================================

-- Query: Animals supervised by Dave and Temi (grouped by keeper)
-- Returns animals supervised by Dave
SELECT 'Dave' AS KeeperName, a.AnimalID, a.AnimalName, s.SpeciesType
FROM Animal a
JOIN Keeper k ON a.KeeperID = k.KeeperID
JOIN Species s ON a.SpeciesID = s.SpeciesID
WHERE k.KeeperName = 'Dave'

UNION ALL

-- Returns animals supervised by Temi
SELECT 'Temi' AS KeeperName, a.AnimalID, a.AnimalName, s.SpeciesType
FROM Animal a
JOIN Keeper k ON a.KeeperID = k.KeeperID
JOIN Species s ON a.SpeciesID = s.SpeciesID
WHERE k.KeeperName = 'Temi';

-- Query: Number of animals per keeper with overall total (using GROUP BY with ROLLUP)
SELECT 
    COALESCE(k.KeeperName, 'TOTAL') AS KeeperName,
    COUNT(a.AnimalID) AS NumberOfAnimals
FROM Keeper k
LEFT JOIN Animal a ON k.KeeperID = a.KeeperID
GROUP BY k.KeeperName
UNION ALL
SELECT 'OVERALL TOTAL' AS KeeperName, COUNT(*) FROM Animal;

-- Alternative using GROUP BY with ROLLUP (for supported databases)
SELECT 
    CASE WHEN GROUPING(k.KeeperName) = 1 THEN 'OVERALL TOTAL' ELSE k.KeeperName END AS KeeperName,
    COUNT(a.AnimalID) AS NumberOfAnimals
FROM Keeper k
LEFT JOIN Animal a ON k.KeeperID = a.KeeperID
GROUP BY ROLLUP(k.KeeperName);


-- =====================================================
-- PART 5: DATA VALIDATION VIEWS
-- =====================================================

-- View for data integrity checking
CREATE VIEW AnimalFullDetails AS
SELECT 
    a.AnimalID,
    a.AnimalName,
    a.Gender,
    a.YearOfArrival,
    s.SpeciesType,
    s.ConservationStatus,
    d.DietType,
    d.NoOfFeedsPerDay,
    k.KeeperName,
    k.KeeperRank,
    e.EnclosureType,
    e.EnclosureLocation
FROM Animal a
JOIN Species s ON a.SpeciesID = s.SpeciesID
JOIN Diet d ON a.DietID = d.DietID
JOIN Keeper k ON a.KeeperID = k.KeeperID
JOIN Enclosure e ON a.EnclosureID = e.EnclosureID;


-- =====================================================
-- PART 6: STORED PROCEDURE / AUTOMATED FUNCTION (Task B)
-- =====================================================

-- Function to calculate animal age at park
-- (Automated function for data entry forms)

-- For SQLite (using triggers for automation)
CREATE TRIGGER update_animal_age 
AFTER INSERT ON Animal
BEGIN
    UPDATE Animal 
    SET YearOfArrival = NEW.YearOfArrival
    WHERE AnimalID = NEW.AnimalID;
END;

-- For MySQL/PostgreSQL (stored function)
/*
DELIMITER //
CREATE FUNCTION CalculateYearsAtPark(arrival_year INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE current_year INT;
    SET current_year = YEAR(CURDATE());
    RETURN current_year - arrival_year;
END//
DELIMITER ;
*/


-- =====================================================
-- PART 7: TESTING QUERIES
-- =====================================================

-- Test 1: Verify data integrity - check for orphan records
SELECT 'Orphan Animals' AS Test, COUNT(*) AS Count 
FROM Animal a 
WHERE a.SpeciesID NOT IN (SELECT SpeciesID FROM Species)
UNION ALL
SELECT 'Orphan Animals - Diet', COUNT(*) 
FROM Animal a 
WHERE a.DietID NOT IN (SELECT DietID FROM Diet)
UNION ALL
SELECT 'Orphan Animals - Keeper', COUNT(*) 
FROM Animal a 
WHERE a.KeeperID NOT IN (SELECT KeeperID FROM Keeper)
UNION ALL
SELECT 'Orphan Animals - Enclosure', COUNT(*) 
FROM Animal a 
WHERE a.EnclosureID NOT IN (SELECT EnclosureID FROM Enclosure);

-- Test 2: Verify validation checks - invalid gender values
SELECT AnimalID, AnimalName, Gender 
FROM Animal 
WHERE Gender NOT IN ('M', 'F');

-- Test 3: Verify validation checks - future arrival years
SELECT AnimalID, AnimalName, YearOfArrival 
FROM Animal 
WHERE YearOfArrival > 2024 OR YearOfArrival < 1900;

-- Test 4: Test forms validation - enclosure location check
SELECT EnclosureID, EnclosureLocation 
FROM Enclosure 
WHERE EnclosureLocation NOT IN ('North', 'South', 'East', 'West');

-- Test 5: Count verification
SELECT 'Total Animals' AS Category, COUNT(*) AS Count FROM Animal
UNION ALL
SELECT 'Total Species', COUNT(*) FROM Species
UNION ALL
SELECT 'Total Keepers', COUNT(*) FROM Keeper
UNION ALL
SELECT 'Total Enclosures', COUNT(*) FROM Enclosure
UNION ALL
SELECT 'Total Diet Types', COUNT(*) FROM Diet;


-- =====================================================
-- PART 8: DATA ENTRY FORM VALIDATION SUGGESTIONS
-- =====================================================

/*
DATA VALIDATION RULES FOR FORMS:

1. Animal Form:
   - AnimalID: Presence check + Format check (must start with 'A' followed by number)
   - Gender: Value lookup (M or F only)
   - YearOfArrival: Range check (1900-2024)
   - SpeciesID: Table lookup (must exist in Species table)
   - DietID: Table lookup (must exist in Diet table)
   - KeeperID: Table lookup (must exist in Keeper table)
   - EnclosureID: Table lookup (must exist in Enclosure table)

2. Species Form:
   - SpeciesID: Presence check + Format check
   - ConservationStatus: Value lookup (Threatened, Critically Endangered, Vulnerable, Endangered, Least Concern)

3. Diet Form:
   - NoOfFeedsPerDay: Range check (1-10)

4. Keeper Form:
   - KeeperRank: Value lookup (Senior, Standard, Junior)
   - KeeperDoB: Format check (DD-MM-YY) + Range check (must be over 16)

5. Enclosure Form:
   - EnclosureLocation: Value lookup (North, South, East, West)
*/


-- =====================================================
-- PART 9: SAMPLE REPORTS
-- =====================================================

-- Report: Complete Park Inventory
SELECT 
    '=== PARK INVENTORY REPORT ===' AS Report,
    datetime('now') AS GeneratedOn;
    
SELECT 
    'Animals by Keeper' AS Section;
    
SELECT 
    k.KeeperName,
    k.KeeperRank,
    COUNT(a.AnimalID) AS AnimalsInCare,
    GROUP_CONCAT(a.AnimalName, ', ') AS AnimalNames
FROM Keeper k
LEFT JOIN Animal a ON k.KeeperID = a.KeeperID
GROUP BY k.KeeperID
ORDER BY AnimalsInCare DESC;

SELECT 
    'Animals by Enclosure Type' AS Section;
    
SELECT 
    e.EnclosureType,
    e.EnclosureLocation,
    COUNT(a.AnimalID) AS Occupancy,
    GROUP_CONCAT(DISTINCT s.SpeciesType, ', ') AS SpeciesPresent
FROM Enclosure e
LEFT JOIN Animal a ON e.EnclosureID = a.EnclosureID
LEFT JOIN Species s ON a.SpeciesID = s.SpeciesID
GROUP BY e.EnclosureID
ORDER BY e.EnclosureLocation, Occupancy DESC;

SELECT 
    'Conservation Status Summary' AS Section;
    
SELECT 
    s.ConservationStatus,
    COUNT(a.AnimalID) AS NumberOfAnimals,
    GROUP_CONCAT(DISTINCT s.SpeciesType, ', ') AS Species
FROM Species s
LEFT JOIN Animal a ON s.SpeciesID = a.SpeciesID
GROUP BY s.ConservationStatus
ORDER BY 
    CASE s.ConservationStatus
        WHEN 'Critically Endangered' THEN 1
        WHEN 'Endangered' THEN 2
        WHEN 'Threatened' THEN 3
        WHEN 'Vulnerable' THEN 4
        ELSE 5
    END;