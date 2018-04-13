IF OBJECT_ID(N'__EFMigrationsHistory') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;

GO

CREATE TABLE [Booking] (
    [Id] int NOT NULL IDENTITY,
    [UserId] int NOT NULL,
    CONSTRAINT [PK_Booking] PRIMARY KEY ([Id])
);

GO

CREATE TABLE [Person] (
    [ID] int NOT NULL IDENTITY,
    [Name] nvarchar(max) NULL,
    [SecondName] nvarchar(max) NULL,
    [Addres] nvarchar(max) NULL,
    [Email] nvarchar(max) NULL,
    [BirthDate] datetime2 NOT NULL,
    CONSTRAINT [PK_Person] PRIMARY KEY ([ID])
);

GO

CREATE TABLE [Room] (
    [ID] int NOT NULL IDENTITY,
    [Sleeps] int NOT NULL,
    [Price] float NOT NULL,
    CONSTRAINT [PK_Room] PRIMARY KEY ([ID])
);

GO

CREATE TABLE [Manager] (
    [ID] int NOT NULL,
    [PersonID] int NOT NULL,
    CONSTRAINT [PK_Manager] PRIMARY KEY ([ID], [PersonID]),
    CONSTRAINT [FK_Manager_Person_PersonID] FOREIGN KEY ([PersonID]) REFERENCES [Person] ([ID]) ON DELETE CASCADE
);

GO

CREATE TABLE [User] (
    [ID] int NOT NULL,
    [PersonID] int NOT NULL,
    CONSTRAINT [PK_User] PRIMARY KEY ([ID], [PersonID]),
    CONSTRAINT [FK_User_Booking_ID] FOREIGN KEY ([ID]) REFERENCES [Booking] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_User_Person_PersonID] FOREIGN KEY ([PersonID]) REFERENCES [Person] ([ID]) ON DELETE CASCADE
);

GO

CREATE TABLE [BookingRoom] (
    [RoomID] int NOT NULL,
    [BookingID] int NOT NULL,
    CONSTRAINT [PK_BookingRoom] PRIMARY KEY ([BookingID], [RoomID]),
    CONSTRAINT [FK_BookingRoom_Booking_BookingID] FOREIGN KEY ([BookingID]) REFERENCES [Booking] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_BookingRoom_Room_RoomID] FOREIGN KEY ([RoomID]) REFERENCES [Room] ([ID]) ON DELETE CASCADE
);

GO

CREATE INDEX [IX_BookingRoom_RoomID] ON [BookingRoom] ([RoomID]);

GO

CREATE INDEX [IX_Manager_PersonID] ON [Manager] ([PersonID]);

GO

CREATE UNIQUE INDEX [IX_User_ID] ON [User] ([ID]);

GO

CREATE INDEX [IX_User_PersonID] ON [User] ([PersonID]);

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20180313132150_Init', N'2.1.0-preview1-28290');

GO

