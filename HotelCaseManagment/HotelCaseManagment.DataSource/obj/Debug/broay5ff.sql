IF OBJECT_ID(N'__EFMigrationsHistory') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315100106_init')
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

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315100106_init')
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

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315100106_init')
BEGIN
    CREATE TABLE [Manager] (
        [ID] int NOT NULL,
        [IsAdmin] bit NOT NULL,
        [LastesLogin] datetime2 NOT NULL,
        [Password] nvarchar(max) NULL,
        [Email] nvarchar(450) NOT NULL,
        CONSTRAINT [PK_Manager] PRIMARY KEY ([ID], [Email]),
        CONSTRAINT [FK_Manager_Person_ID] FOREIGN KEY ([ID]) REFERENCES [Person] ([ID]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315100106_init')
BEGIN
    CREATE TABLE [User] (
        [ID] int NOT NULL IDENTITY,
        [LastesLogin] datetime2 NOT NULL,
        [Password] nvarchar(max) NULL,
        [Email] nvarchar(max) NULL,
        [PersonID] int NULL,
        CONSTRAINT [PK_User] PRIMARY KEY ([ID]),
        CONSTRAINT [FK_User_Person_PersonID] FOREIGN KEY ([PersonID]) REFERENCES [Person] ([ID]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315100106_init')
BEGIN
    CREATE TABLE [ManagerErrorLog] (
        [ID] int NOT NULL IDENTITY,
        [ManagerID] int NULL,
        [ManagerEmail] nvarchar(450) NULL,
        [ErrorCode] nvarchar(max) NULL,
        [ErrorDate] datetime2 NOT NULL,
        CONSTRAINT [PK_ManagerErrorLog] PRIMARY KEY ([ID]),
        CONSTRAINT [FK_ManagerErrorLog_Manager_ManagerID_ManagerEmail] FOREIGN KEY ([ManagerID], [ManagerEmail]) REFERENCES [Manager] ([ID], [Email]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315100106_init')
BEGIN
    CREATE TABLE [ManagmentLog] (
        [ID] int NOT NULL IDENTITY,
        [ManagerID] int NULL,
        [ManagerEmail] nvarchar(450) NULL,
        [ManagerLogText] nvarchar(max) NULL,
        CONSTRAINT [PK_ManagmentLog] PRIMARY KEY ([ID]),
        CONSTRAINT [FK_ManagmentLog_Manager_ManagerID_ManagerEmail] FOREIGN KEY ([ManagerID], [ManagerEmail]) REFERENCES [Manager] ([ID], [Email]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315100106_init')
BEGIN
    CREATE TABLE [PersonManager] (
        [ManagerID] int NOT NULL,
        [PersonID] int NOT NULL,
        [ManagerID1] int NULL,
        [ManagerEmail] nvarchar(450) NULL,
        CONSTRAINT [PK_PersonManager] PRIMARY KEY ([ManagerID], [PersonID]),
        CONSTRAINT [FK_PersonManager_Person_PersonID] FOREIGN KEY ([PersonID]) REFERENCES [Person] ([ID]) ON DELETE CASCADE,
        CONSTRAINT [FK_PersonManager_Manager_ManagerID1_ManagerEmail] FOREIGN KEY ([ManagerID1], [ManagerEmail]) REFERENCES [Manager] ([ID], [Email]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315100106_init')
BEGIN
    CREATE TABLE [Booking] (
        [ID] int NOT NULL IDENTITY,
        [UserID] int NOT NULL,
        [RoomID] int NOT NULL,
        [BookingStart] datetime2 NOT NULL,
        [BookingEnd] datetime2 NOT NULL,
        [TotaltPrice] float NOT NULL,
        CONSTRAINT [PK_Booking] PRIMARY KEY ([ID]),
        CONSTRAINT [FK_Booking_Room_RoomID] FOREIGN KEY ([RoomID]) REFERENCES [Room] ([ID]) ON DELETE CASCADE,
        CONSTRAINT [FK_Booking_User_UserID] FOREIGN KEY ([UserID]) REFERENCES [User] ([ID]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315100106_init')
BEGIN
    CREATE TABLE [PersonUser] (
        [UserID] int NOT NULL,
        [PersonID] int NOT NULL,
        CONSTRAINT [PK_PersonUser] PRIMARY KEY ([UserID], [PersonID]),
        CONSTRAINT [FK_PersonUser_Person_PersonID] FOREIGN KEY ([PersonID]) REFERENCES [Person] ([ID]) ON DELETE CASCADE,
        CONSTRAINT [FK_PersonUser_User_UserID] FOREIGN KEY ([UserID]) REFERENCES [User] ([ID]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315100106_init')
BEGIN
    CREATE TABLE [UserErrorLog] (
        [ID] int NOT NULL IDENTITY,
        [UserID] int NULL,
        [ErrorCode] nvarchar(max) NULL,
        [ErrorDate] datetime2 NOT NULL,
        CONSTRAINT [PK_UserErrorLog] PRIMARY KEY ([ID]),
        CONSTRAINT [FK_UserErrorLog_User_UserID] FOREIGN KEY ([UserID]) REFERENCES [User] ([ID]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315100106_init')
BEGIN
    CREATE INDEX [IX_Booking_RoomID] ON [Booking] ([RoomID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315100106_init')
BEGIN
    CREATE INDEX [IX_Booking_UserID] ON [Booking] ([UserID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315100106_init')
BEGIN
    CREATE INDEX [IX_ManagerErrorLog_ManagerID_ManagerEmail] ON [ManagerErrorLog] ([ManagerID], [ManagerEmail]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315100106_init')
BEGIN
    CREATE INDEX [IX_ManagmentLog_ManagerID_ManagerEmail] ON [ManagmentLog] ([ManagerID], [ManagerEmail]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315100106_init')
BEGIN
    CREATE INDEX [IX_PersonManager_PersonID] ON [PersonManager] ([PersonID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315100106_init')
BEGIN
    CREATE INDEX [IX_PersonManager_ManagerID1_ManagerEmail] ON [PersonManager] ([ManagerID1], [ManagerEmail]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315100106_init')
BEGIN
    CREATE INDEX [IX_PersonUser_PersonID] ON [PersonUser] ([PersonID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315100106_init')
BEGIN
    CREATE INDEX [IX_User_PersonID] ON [User] ([PersonID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315100106_init')
BEGIN
    CREATE INDEX [IX_UserErrorLog_UserID] ON [UserErrorLog] ([UserID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180315100106_init')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20180315100106_init', N'2.1.0-preview1-28290');
END;

GO

