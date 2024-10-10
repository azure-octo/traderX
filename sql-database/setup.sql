/*

Enter custom T-SQL here that would run after SQL Server has started up. 

*/

-- Drop Table Trades IF EXISTS;
IF OBJECT_ID('Trades', 'U') IS NOT NULL
    DROP TABLE Trades;

-- Drop Table AccountUsers IF EXISTS; 
IF OBJECT_ID('AccountUsers', 'U') IS NOT NULL
    DROP TABLE AccountUsers;

-- Drop Table Positions IF EXISTS; 
IF OBJECT_ID('Positions', 'U') IS NOT NULL
    DROP TABLE Positions;

-- Drop Table Accounts IF EXISTS; 
IF OBJECT_ID('Accounts', 'U') IS NOT NULL
    DROP TABLE Accounts;

-- Drop Sequence ACCOUNTS_SEQ IF EXISTS;
IF OBJECT_ID('ACCOUNTS_SEQ', 'SO') IS NOT NULL
    DROP SEQUENCE ACCOUNTS_SEQ;

CREATE TABLE Accounts ( ID INTEGER PRIMARY KEY, DisplayName VARCHAR (50) ) ; 

CREATE TABLE AccountUsers ( AccountID INTEGER NOT NULL, Username VARCHAR(15) NOT NULL, PRIMARY KEY (AccountID,Username));  

ALTER TABLE AccountUsers ADD FOREIGN KEY (AccountID) References Accounts(ID); 

CREATE TABLE Positions ( AccountID INTEGER , Security VARCHAR(15) , Updated DATETIME, Quantity INTEGER, Primary Key (AccountID, Security) );  

Alter Table Positions ADD FOREIGN KEY (AccountID) References Accounts(ID) ; 

-- CREATE TABLE Trades ( ID Varchar (50) Primary Key, AccountID INTEGER, Created TIMESTAMP, Updated TIMESTAMP, Security VARCHAR (15) ,  Side VARCHAR(10) check (Side in ('Buy','Sell')),  Quantity INTEGER check Quantity > 0 , State VARCHAR(20) check (State in ('New', 'Processing', 'Settled', 'Cancelled'))) ;  
CREATE TABLE Trades (ID VARCHAR(50) PRIMARY KEY, AccountID INT, Created DATETIME, Updated DATETIME, Security VARCHAR(15), Side VARCHAR(10) CHECK (Side IN ('Buy', 'Sell')), Quantity INT CHECK (Quantity > 0), State VARCHAR(20) CHECK (State IN ('New', 'Processing', 'Settled', 'Cancelled')));

Alter Table Trades Add Foreign Key (AccountID) references Accounts(ID); 

CREATE SEQUENCE ACCOUNTS_SEQ start with 65000 INCREMENT BY 1;

--- SAMPLE DATA ---

INSERT into Accounts (ID, DisplayName) VALUES (22214, 'Test Account 20'); 
INSERT into Accounts (ID, DisplayName) VALUES (11413, 'Private Clients Fund TTXX'); 
INSERT into Accounts (ID, DisplayName) VALUES (42422, 'Algo Execution Partners'); 
INSERT into Accounts (ID, DisplayName) VALUES (52355, 'Big Corporate Fund'); 
INSERT into Accounts (ID, DisplayName) VALUES (62654, 'Hedge Fund TXY1'); 
INSERT into Accounts (ID, DisplayName) VALUES (10031, 'Internal Trading Book'); 
INSERT into Accounts (ID, DisplayName) VALUES (44044, 'Trading Account 1'); 

INSERT into AccountUsers (AccountID, Username) VALUES (22214, 'user01'); 
INSERT into AccountUsers (AccountID, Username) VALUES (22214, 'user03'); 
INSERT into AccountUsers (AccountID, Username) VALUES (22214, 'user09'); 
INSERT into AccountUsers (AccountID, Username) VALUES (22214, 'user05'); 
INSERT into AccountUsers (AccountID, Username) VALUES (22214, 'user07'); 

INSERT into AccountUsers (AccountID, Username) VALUES (62654, 'user09'); 
INSERT into AccountUsers (AccountID, Username) VALUES (62654, 'user05'); 
INSERT into AccountUsers (AccountID, Username) VALUES (62654, 'user07'); 
INSERT into AccountUsers (AccountID, Username) VALUES (62654, 'user01'); 

INSERT into AccountUsers (AccountID, Username) VALUES (10031, 'user01'); 
INSERT into AccountUsers (AccountID, Username) VALUES (10031, 'user03'); 
INSERT into AccountUsers (AccountID, Username) VALUES (10031, 'user09'); 

INSERT into AccountUsers (AccountID, Username) VALUES (44044, 'user09'); 
INSERT into AccountUsers (AccountID, Username) VALUES (44044, 'user05'); 
INSERT into AccountUsers (AccountID, Username) VALUES (44044, 'user07'); 
INSERT into AccountUsers (AccountID, Username) VALUES (44044, 'user04'); 
INSERT into AccountUsers (AccountID, Username) VALUES (44044, 'user01'); 
INSERT into AccountUsers (AccountID, Username) VALUES (44044, 'user06'); 
 

INSERT into Trades(ID, Created, Updated, Security, Side, Quantity, State, AccountID) VALUES('TRADE-22214-AABBCC', SYSDATETIME(), SYSDATETIME(), 'IBM', 'Sell', 100, 'Settled', 22214); 
INSERT into Trades(ID, Created, Updated, Security, Side, Quantity, State, AccountID) VALUES('TRADE-22214-DDEEFF', SYSDATETIME(), SYSDATETIME(), 'MS', 'Buy', 1000, 'Settled', 22214); 
INSERT into Trades(ID, Created, Updated, Security, Side, Quantity, State, AccountID) VALUES('TRADE-22214-GGHHII', SYSDATETIME(), SYSDATETIME(), 'C', 'Sell', 2000, 'Settled', 22214); 

INSERT into Positions (AccountID, Security, Updated, Quantity) VALUES(22214, 'MS',SYSDATETIME(), 1000); 
INSERT into Positions (AccountID, Security, Updated, Quantity) VALUES(22214, 'IBM',SYSDATETIME(), -100); 
INSERT into Positions (AccountID, Security, Updated, Quantity) VALUES(22214, 'C',SYSDATETIME(), -2000); 


INSERT into Trades(ID, Created, Updated, Security, Side, Quantity, State, AccountID) VALUES('TRADE-52355-AABBCC', SYSDATETIME(), SYSDATETIME(), 'BAC', 'Sell', 2400, 'Settled', 52355); 
INSERT into Positions (AccountID, Security, Updated, Quantity) VALUES(52355, 'BAC',SYSDATETIME(), -2400); 

GO