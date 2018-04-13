IF OBJECT_ID(N'__EFMigrationsHistory') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;

GO

CREATE TABLE [Person] (
    [ID] int NOT NULL IDENTITY,
    [Name] nvarchar(max) NULL,
    [SecondName] nvarchar(max) NULL,
    [Password] nvarchar(max) NULL,
    [Email] nvarchar(max) NULL,
    [Addres] nvarchar(max) NULL,
    [BirthDate] datetime2 NOT NULL,
    CONSTRAINT [PK_Person] PRIMARY KEY ([ID])
);

GO

CREATE TABLE [Room] (
    [ID] int NOT NULL IDENTITY,
    [Sleeps] int NOT NULL,
    [Price] float NOT NULL,
    [RoomDescription] float NOT NULL,
    [LastDayCleaned] datetime2 NOT NULL,
    CONSTRAINT [PK_Room] PRIMARY KEY ([ID])
);

GO

CREATE TABLE [Manager] (
    [ID] int NOT NULL IDENTITY,
    [PersonID] int NOT NULL,
    [IsAdmin] bit NOT NULL,
    [LastesLogin] datetime2 NOT NULL,
    CONSTRAINT [PK_Manager] PRIMARY KEY ([ID], [PersonID]),
    CONSTRAINT [FK_Manager_Person_PersonID] FOREIGN KEY ([PersonID]) REFERENCES [Person] ([ID]) ON DELETE CASCADE
);

GO

CREATE TABLE [User] (
    [ID] int NOT NULL IDENTITY,
    [PersonID] int NOT NULL,
    [LastesLogin] datetime2 NOT NULL,
    CONSTRAINT [PK_User] PRIMARY KEY ([ID], [PersonID]),
    CONSTRAINT [FK_User_Person_PersonID] FOREIGN KEY ([PersonID]) REFERENCES [Person] ([ID]) ON DELETE CASCADE
);

GO

CREATE TABLE [ManagerErrorLog] (
    [ID] int NOT NULL IDENTITY,
    [ManagerID] int NULL,
    [ManagerPersonID] int NULL,
    [ErrorCode] nvarchar(max) NULL,
    [ErrorDate] datetime2 NOT NULL,
    CONSTRAINT [PK_ManagerErrorLog] PRIMARY KEY ([ID]),
    CONSTRAINT [FK_ManagerErrorLog_Manager_ManagerID_ManagerPersonID] FOREIGN KEY ([ManagerID], [ManagerPersonID]) REFERENCES [Manager] ([ID], [PersonID]) ON DELETE NO ACTION
);

GO

CREATE TABLE [ManagmentLog] (
    [ID] int NOT NULL IDENTITY,
    [ManagerID] int NULL,
    [ManagerPersonID] int NULL,
    [ManagerLogText] nvarchar(max) NULL,
    CONSTRAINT [PK_ManagmentLog] PRIMARY KEY ([ID]),
    CONSTRAINT [FK_ManagmentLog_Manager_ManagerID_ManagerPersonID] FOREIGN KEY ([ManagerID], [ManagerPersonID]) REFERENCES [Manager] ([ID], [PersonID]) ON DELETE NO ACTION
);

GO

CREATE TABLE [Booking] (
    [ID] int NOT NULL IDENTITY,
    [RoomID] int NOT NULL,
    [BookingStart] datetime2 NOT NULL,
    [BookingEnd] datetime2 NOT NULL,
    [TotaltPrice] float NOT NULL,
    [UserID] int NULL,
    [UserPersonID] int NULL,
    CONSTRAINT [PK_Booking] PRIMARY KEY ([ID]),
    CONSTRAINT [FK_Booking_Room_RoomID] FOREIGN KEY ([RoomID]) REFERENCES [Room] ([ID]) ON DELETE CASCADE,
    CONSTRAINT [FK_Booking_User_UserID_UserPersonID] FOREIGN KEY ([UserID], [UserPersonID]) REFERENCES [User] ([ID], [PersonID]) ON DELETE NO ACTION
);

GO

CREATE TABLE [UserErrorLog] (
    [ID] int NOT NULL IDENTITY,
    [UserID] int NULL,
    [UserPersonID] int NULL,
    [ErrorCode] nvarchar(max) NULL,
    [ErrorDate] datetime2 NOT NULL,
    CONSTRAINT [PK_UserErrorLog] PRIMARY KEY ([ID]),
    CONSTRAINT [FK_UserErrorLog_User_UserID_UserPersonID] FOREIGN KEY ([UserID], [UserPersonID]) REFERENCES [User] ([ID], [PersonID]) ON DELETE NO ACTION
);

GO

CREATE INDEX [IX_Booking_RoomID] ON [Booking] ([RoomID]);

GO

CREATE INDEX [IX_Booking_UserID_UserPersonID] ON [Booking] ([UserID], [UserPersonID]);

GO

CREATE INDEX [IX_Manager_PersonID] ON [Manager] ([PersonID]);

GO

CREATE INDEX [IX_ManagerErrorLog_ManagerID_ManagerPersonID] ON [ManagerErrorLog] ([ManagerID], [ManagerPersonID]);

GO

CREATE INDEX [IX_ManagmentLog_ManagerID_ManagerPersonID] ON [ManagmentLog] ([ManagerID], [ManagerPersonID]);

GO

CREATE INDEX [IX_User_PersonID] ON [User] ([PersonID]);

GO

CREATE INDEX [IX_UserErrorLog_UserID_UserPersonID] ON [UserErrorLog] ([UserID], [UserPersonID]);

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20180316134957_Init', N'2.1.0-preview1-28290');

GO

