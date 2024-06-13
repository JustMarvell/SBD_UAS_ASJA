-- Create the database for happytravel
-- This line can be changed to comment when the database has been created
CREATE DATABASE happytravel;

-- Use the database
-- This line too
use happytravel;

-- Create table for cities
CREATE TABLE Cities (
    CityCode CHAR(3) PRIMARY KEY,
    CityName VARCHAR(50) NOT NULL
);

-- Create table for accommodations
CREATE TABLE Accommodations (
    AccommodationCode VARCHAR(10) PRIMARY KEY,
    CityCode CHAR(3) NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Email VARCHAR(100),
    URL VARCHAR(255),
    AccommodationType ENUM('Hotel', 'GuestHouse') NOT NULL,
    StarRating float,
    WalkingDistanceToCenter INT,
    WalkingDistanceToBusStop INT,
    WalkingDistanceToPlaces INT,
    PriceSingleRoomPeak DECIMAL(10, 2),
    PriceSingleRoomMid DECIMAL(10, 2),
    PriceSingleRoomOff DECIMAL(10, 2),
    PriceDoubleRoomPeak DECIMAL(10, 2),
    PriceDoubleRoomMid DECIMAL(10, 2),
    PriceDoubleRoomOff DECIMAL(10, 2),
    FOREIGN KEY (CityCode) REFERENCES Cities(CityCode) 
);

-- Create table for travel options
CREATE TABLE TravelOptions (
    TravelCode CHAR(6) PRIMARY KEY,
    CityCode CHAR(3) NOT NULL,
    TravelType VARCHAR(50) NOT NULL,
    PricePeak DECIMAL(10, 2),
    PriceMid DECIMAL(10, 2),
    PriceOff DECIMAL(10, 2),
    FOREIGN KEY (CityCode) REFERENCES Cities(CityCode)
);

-- Create table for trip periods
CREATE TABLE TripPeriods (
    PeriodCode CHAR(6) PRIMARY KEY,
    PeriodDescription VARCHAR(50) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL
);

-- Create table for customers
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Gender ENUM('Male', 'Female') NOT NULL, 
    BirthDate DATE NOT NULL
);

-- Create table for bookings
CREATE TABLE Bookings (
    BookingNumber INT AUTO_INCREMENT PRIMARY KEY,
    AccommodationCode VARCHAR(10) NOT NULL,
    PeriodCode CHAR(6) NOT NULL,
    TravelCode CHAR(6),
    NumberOfSingleRooms INT NOT NULL,
    NumberOfDoubleRooms INT NOT NULL,
    CustomerID INT NOT NULL,
    FOREIGN KEY (AccommodationCode) REFERENCES Accommodations(AccommodationCode),
    FOREIGN KEY (PeriodCode) REFERENCES TripPeriods(PeriodCode),
    FOREIGN KEY (TravelCode) REFERENCES TravelOptions(TravelCode),
	FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create table for participants
CREATE TABLE Participants (
    BookingNumber INT NOT NULL,
    SequenceNumber INT NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Gender ENUM('Male', 'Female') NOT NULL,
    BirthDate DATE NOT NULL,
    PRIMARY KEY (BookingNumber, SequenceNumber),
    FOREIGN KEY (BookingNumber) REFERENCES Bookings(BookingNumber)
);

-- Insert data into Cities table
INSERT INTO Cities (CityCode, CityName) VALUES
('LON', 'London'),
('PAR', 'Paris'),
('ROM', 'Rome'),
('MIL', 'Milan'),
('BAR', 'Barcelona'),
('BUK', 'Bukares'),
('BUD', 'Budapest'),
('BER', 'Berlin'),
('MAD', 'Madrid');


-- Insert data into Accommodations table
INSERT INTO Accommodations (AccommodationCode, CityCode, Name, Address, Email, URL, AccommodationType, StarRating, WalkingDistanceToCenter, WalkingDistanceToBusStop, WalkingDistanceToPlaces, PriceSingleRoomPeak, PriceSingleRoomMid, PriceSingleRoomOff, PriceDoubleRoomPeak, PriceDoubleRoomMid, PriceDoubleRoomOff) VALUES
('LON001', 'LON', 'London Hotel', '123 London Street', 'info@londonhotel.com', 'http://www.londonhotel.com', 'Hotel', 4, 2, 1, 3, 100.00, 80.00, 60.00, 150.00, 120.00, 90.00),
('PAR002', 'PAR', 'Paris Guesthouse', '456 Paris Avenue', 'info@parisguesthouse.com', 'http://www.parisguesthouse.com', 'GuestHouse', NULL, 1, 2, 1, 80.00, 70.00, 60.00, 120.00, 100.00, 80.00),
('ROM003', 'ROM', 'Rome Hotel', '789 Rome Road', 'info@romehotel.com', 'http://www.romehotel.com', 'Hotel', 3, 3, 2, 1, 90.00, 80.00, 70.00, 130.00, 110.00, 90.00),
('MIL004', 'MIL', 'Milan Hotel', '101 Milan Street', 'info@milanhotel.com', 'http://www.milanhotel.com', 'Hotel', 4.2, 1, 5, 6, 120.00, 100.00, 60.00, 130.00, 120.00, 100.00),
('BAR005', 'BAR', 'Barcelona Hotel', '189 Barca Avenue', 'info@barcelonahotel.com', 'http://www.barcahotel.com', 'Hotel', 4.9, 1, 2, 1, 100.00, 85.00, 75.00, 135.00, 115.00, 95.00),
('BUK006', 'BUK', 'Bukarest Guesthouse', '615 Bukarest Street', 'info@bukarestguesthouse.com', 'http://www.bukarestgouesthouse.com', 'GuestHouse', NULL, 5, 2, 5, 150.00, 130.00, 100.00, 163.00, 145.00, 120.00),
('BUD007', 'BUD', 'Budapest Guesthouse', '112 budapest Road', 'info@budapestguesthouse.com', 'http://www.budapestguesthouse.com', 'GuestHouse', NULL, 4, 1, 2, 110.00, 95.00, 85.00, 125.00, 105.00, 95.00),
('BER008', 'BER', 'Berlin Hotel', '439 Berlin Avenue', 'info@berlinhotel.com', 'http://www.berlinhotel.com', 'Hotel', 4.1, 2, 1, 2, 120.00, 95.00, 85.00, 135.00, 120.00, 100.00),
('MAD009', 'MAD', 'Madrid Hotel', '125 Madrid Street', 'info@madridonahotel.com', 'http://www.madridhotel.com', 'Hotel', 3, 6, 3, 2, 130.00, 120.00, 100.00, 135.00, 125.00, 110.00);

-- Insert data into TravelOptions table
INSERT INTO TravelOptions (TravelCode, CityCode, TravelType, PricePeak, PriceMid, PriceOff) VALUES
('TRV001', 'LON', 'Flight', 200.00, 150.00, 100.00),
('TRV002', 'PAR', 'Train', 150.00, 120.00, 90.00),
('TRV003', 'ROM', 'Bus', 100.00, 80.00, 60.00),
('TRV004', 'MIL', 'Train', 130.00, 110.00, 90.00),
('TRV005', 'BAR', 'Bus', 90.00, 80.00, 70.00),
('TRV006', 'BUK', 'Flight', 120.00, 110.00, 90.00),
('TRV007', 'BAR', 'Flight', 125.00, 115.00, 97.00),
('TRV008', 'BUK', 'Train', 100.00, 90.00, 70.00),
('TRV009', 'BER', 'Bus', 95.00, 80.00, 70.00),
('TRV010', 'MAD', 'Flight', 120.00, 100.00, 80.00);

-- Insert data into TripPeriods table
INSERT INTO TripPeriods (PeriodCode, PeriodDescription, StartDate, EndDate) VALUES
('PER001', 'One Week', '2024-07-01', '2024-07-08'),
('PER002', 'Midweek', '2024-07-05', '2024-07-09'),
('PER003', 'Long Weekend', '2024-07-08', '2024-07-11');

-- Insert data into Customers table
INSERT INTO Customers (Name, Gender, BirthDate) VALUES
('John Doe', 'Male', '1990-05-15'),
('Jane Smith', 'Female', '1985-09-20'),
('Sam Brown', 'Male', '1978-03-10'),
('Jonathan Brooks', 'Male', '1978-04-15'),
('Emily Dawson', 'Female', '1985-10-22'),
('Michael Harris', 'Male', '1992-01-09'),
('Sarah Thompson', 'Female', '1968-06-30');

-- Insert data into Bookings table
INSERT INTO Bookings (AccommodationCode, PeriodCode, TravelCode, NumberOfSingleRooms, NumberOfDoubleRooms, CustomerID) VALUES
('LON001', 'PER001', 'TRV001', 2, 1, 1),
('PAR002', 'PER002', 'TRV002', 1, 2, 2),
('ROM003', 'PER003', 'TRV003', 1, 1, 3);

-- Insert data into Participants table
INSERT INTO Participants (BookingNumber, SequenceNumber, Name, Gender, BirthDate) VALUES
(1, 1, 'John Doe', 'Male', '1990-05-15'),
(1, 2, 'Jane Doe', 'Female', '1992-08-20'),
(1, 3, 'Jake Doe', 'Male', '2015-10-25'),
(2, 1, 'Jane Smith', 'Female', '1985-09-20'),
(2, 2, 'John Smith', 'Male', '1980-07-12'),
(3, 1, 'Sam Brown', 'Male', '1978-03-10');

-- the line below is to view the table
-- just remove the "--" symbol
-- select * from cities;
-- select * from Accommodations;
-- select * from TravelOptions;
-- select * from TripPeriods;
-- select * from Customers;
-- select * from Bookings;
-- select * from Participants;

/*
   Kelompok ASJA
- Acquire
- Strive
- Joyfull
- Accomplish
*/
