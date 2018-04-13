IF OBJECT_ID(N'__EFMigrationsHistory') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315112144_Init')
BEGIN
    CREATE TABLE [Person] (
        [ID] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NULL,
        [SecondName] nvarchar(max) NULL,
        [Addres] nvarchar(max) NULL,
        [BirthDate] datetime2 NOT NULL,
        CONSTRAINT [PK_Person] PRIMARY KEY ([ID])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315112144_Init')
BEGIN
    CREATE TABLE [Room] (
        [ID] int NOT NULL IDENTITY,
        [Sleeps] int NOT NULL,
        [Price] float NOT NULL,
        [RoomDescription] float NOT NULL,
        [LastDayCleaned] datetime2 NOT NULL,
        CONSTRAINT [PK_Room] PRIMARY KEY ([ID])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315112144_Init')
BEGIN
    CREATE TABLE [Manager] (
        [ID] int NOT NULL,
        [PersonID] int NOT NULL,
        [IsAdmin] bit NOT NULL,
        [LastesLogin] datetime2 NOT NULL,
        [Password] nvarchar(max) NULL,
        [Email] nvarchar(450) NOT NULL,
        CONSTRAINT [PK_Manager] PRIMARY KEY ([ID], [Email], [PersonID]),
        CONSTRAINT [FK_Manager_Person_PersonID] FOREIGN KEY ([PersonID]) REFERENCES [Person] ([ID]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315112144_Init')
BEGIN
    CREATE TABLE [Users] (
        [ID] int NOT NULL,
        [PersonID] int NOT NULL,
        [LastesLogin] datetime2 NOT NULL,
        [Password] nvarchar(max) NULL,
        [Email] nvarchar(450) NOT NULL,
        CONSTRAINT [PK_Users] PRIMARY KEY ([ID], [Email], [PersonID]),
        CONSTRAINT [FK_Users_Person_PersonID] FOREIGN KEY ([PersonID]) REFERENCES [Person] ([ID]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315112144_Init')
BEGIN
    CREATE TABLE [ManagerErrorLog] (
        [ID] int NOT NULL IDENTITY,
        [ManagerID] int NULL,
        [ManagerEmail] nvarchar(450) NULL,
        [ManagerPersonID] int NULL,
        [ErrorCode] nvarchar(max) NULL,
        [ErrorDate] datetime2 NOT NULL,
        CONSTRAINT [PK_ManagerErrorLog] PRIMARY KEY ([ID]),
        CONSTRAINT [FK_ManagerErrorLog_Manager_ManagerID_ManagerEmail_ManagerPersonID] FOREIGN KEY ([ManagerID], [ManagerEmail], [ManagerPersonID]) REFERENCES [Manager] ([ID], [Email], [PersonID]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315112144_Init')
BEGIN
    CREATE TABLE [ManagmentLog] (
        [ID] int NOT NULL IDENTITY,
        [ManagerID] int NULL,
        [ManagerEmail] nvarchar(450) NULL,
        [ManagerPersonID] int NULL,
        [ManagerLogText] nvarchar(max) NULL,
        CONSTRAINT [PK_ManagmentLog] PRIMARY KEY ([ID]),
        CONSTRAINT [FK_ManagmentLog_Manager_ManagerID_ManagerEmail_ManagerPersonID] FOREIGN KEY ([ManagerID], [ManagerEmail], [ManagerPersonID]) REFERENCES [Manager] ([ID], [Email], [PersonID]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315112144_Init')
BEGIN
    CREATE TABLE [Booking] (
        [ID] int NOT NULL IDENTITY,
        [RoomID] int NOT NULL,
        [BookingStart] datetime2 NOT NULL,
        [BookingEnd] datetime2 NOT NULL,
        [TotaltPrice] float NOT NULL,
        [UserID] int NULL,
        [UserEmail] nvarchar(450) NULL,
        [UserPersonID] int NULL,
        CONSTRAINT [PK_Booking] PRIMARY KEY ([ID]),
        CONSTRAINT [FK_Booking_Room_RoomID] FOREIGN KEY ([RoomID]) REFERENCES [Room] ([ID]) ON DELETE CASCADE,
        CONSTRAINT [FK_Booking_Users_UserID_UserEmail_UserPersonID] FOREIGN KEY ([UserID], [UserEmail], [UserPersonID]) REFERENCES [Users] ([ID], [Email], [PersonID]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315112144_Init')
BEGIN
    CREATE TABLE [UserErrorLog] (
        [ID] int NOT NULL IDENTITY,
        [UserID] int NULL,
        [UserEmail] nvarchar(450) NULL,
        [UserPersonID] int NULL,
        [ErrorCode] nvarchar(max) NULL,
        [ErrorDate] datetime2 NOT NULL,
        CONSTRAINT [PK_UserErrorLog] PRIMARY KEY ([ID]),
        CONSTRAINT [FK_UserErrorLog_Users_UserID_UserEmail_UserPersonID] FOREIGN KEY ([UserID], [UserEmail], [UserPersonID]) REFERENCES [Users] ([ID], [Email], [PersonID]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315112144_Init')
BEGIN
    CREATE INDEX [IX_Booking_RoomID] ON [Booking] ([RoomID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315112144_Init')
BEGIN
    CREATE INDEX [IX_Booking_UserID_UserEmail_UserPersonID] ON [Booking] ([UserID], [UserEmail], [UserPersonID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315112144_Init')
BEGIN
    CREATE INDEX [IX_Manager_PersonID] ON [Manager] ([PersonID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315112144_Init')
BEGIN
    CREATE INDEX [IX_ManagerErrorLog_ManagerID_ManagerEmail_ManagerPersonID] ON [ManagerErrorLog] ([ManagerID], [ManagerEmail], [ManagerPersonID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315112144_Init')
BEGIN
    CREATE INDEX [IX_ManagmentLog_ManagerID_ManagerEmail_ManagerPersonID] ON [ManagmentLog] ([ManagerID], [ManagerEmail], [ManagerPersonID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315112144_Init')
BEGIN
    CREATE INDEX [IX_UserErrorLog_UserID_UserEmail_UserPersonID] ON [UserErrorLog] ([UserID], [UserEmail], [UserPersonID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315112144_Init')
BEGIN
    CREATE INDEX [IX_Users_PersonID] ON [Users] ([PersonID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315112144_Init')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20180315112144_Init', N'2.1.0-preview1-28290');
END;

GO

