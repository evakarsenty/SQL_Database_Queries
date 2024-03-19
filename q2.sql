CREATE table Investor (
    ID integer primary key,
    Name varchar(100),
    DateOfBirth date check (DateOfBirth <= '2004-01-01'),
    Mail varchar(100) unique check(Mail LIKE '%_@_%'),
    InscriptionDate date,
)

CREATE table Premium_Investor (
    ID integer primary key foreign key references Investor(ID) ON DELETE CASCADE ,
    F_Project varchar(100),
    InscriptionDate date references Investor(InscriptionDate),
    PremiumInscriptionDate date check (PremiumInscriptionDate >= DATEADD(YEAR ,01,InscriptionDate)),
)

CREATE table Employee (
    ID integer primary key foreign key references Premium_Investor(ID) ON DELETE CASCADE ,
    Sector varchar(100),
)

CREATE table Economist (
    ID integer primary key foreign key references Employee(ID) ON DELETE CASCADE,
)

CREATE table Lawyer (
    ID integer primary key foreign key references Employee(ID) ON DELETE CASCADE ,
)

CREATE table Beginner_Investor (
    ID integer primary key foreign key references Investor(ID) ON DELETE CASCADE ,
    InscriptionDate date references Investor(InscriptionDate),
    BeginnerInscriptionDate date check (BeginnerInscriptionDate <= DATEADD(MM,03,InscriptionDate)),
    Guide_ID integer not null foreign key references Economist(ID),
)

CREATE table Company (
    Symbol varchar(100) primary key ,
    Sector varchar(100),
    Founded integer,
    Location varchar(100),
)

CREATE table Rivalry (
    Symbol1 varchar(100) primary key foreign key references Company(Symbol),
    Symbol2 varchar(100) primary key foreign key references Company(Symbol),
    CHECK (Symbol1 != Symbol2),
    Reason varchar(100),
)

CREATE table InterestedIn (
    ID integer primary key foreign key references Economist(ID) ON DELETE CASCADE,
    Symbol varchar(100) primary key foreign key references Company(Symbol) ON DELETE CASCADE ,
    BlogResume varchar(100),
)

CREATE table TransactionTable (
    IdInvestor integer primary key foreign key references Investor(ID),
    TDate date primary key ,
    Amount float check (Amount > 1000),
)

CREATE table SuspectTransaction (
    IdInvestor integer primary key foreign key references TransactionTable(IdInvestor)ON DELETE CASCADE,
    TransactionDate date primary key foreign key references TransactionTable(TDate)ON DELETE CASCADE,
    IdLawyer integer primary key foreign key references Lawyer(ID) ON DELETE CASCADE ,
    Decision varchar(100),
)

CREATE table Stock (
    SDate date primary key ,
    Symbol varchar(100) primary key foreign key references Company(Symbol) ON DELETE CASCADE ,
    Price float,
)

CREATE table BelongsTo (
    CompanySymbol varchar(100) foreign key references Stock(Symbol),
    SDate date foreign key references Stock(SDate),
)

CREATE table Buying (
    SDate date primary key foreign key references Stock(SDate),
    Symbol varchar(100) primary key foreign key references Stock(Symbol) ON DELETE CASCADE ,
    ID integer primary key foreign key references Investor(ID) ON DELETE CASCADE ,
    Quantity integer,
)

