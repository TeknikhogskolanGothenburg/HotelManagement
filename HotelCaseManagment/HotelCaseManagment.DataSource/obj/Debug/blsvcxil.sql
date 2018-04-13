IF OBJECT_ID(N'__EFMigrationsHistory') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313180549_init2')
BEGIN
    CREATE TABLE [Booking] (
        [Id] int NOT NULL IDENTITY,
        [UserId] int NOT NULL,
        [BookingTime] datetime2 NOT NULL,
        [TotaltPrice] float NOT NULL,
        CONSTRAINT [PK_Booking] PRIMARY KEY ([Id])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313180549_init2')
BEGIN
    CREATE TABLE [ManagmentLog] (
        [ID] int NOT NULL,
        [ManagerID] int NOT NULL,
        [ManagerLog] nvarchar(max) NULL,
        CONSTRAINT [PK_ManagmentLog] PRIMARY KEY ([ID], [ManagerID])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313180549_init2')
BEGIN
    CREATE TABLE [Person] (
        [ID] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NULL,
        [SecondName] nvarchar(max) NULL,
        [Addres] nvarchar(max) NULL,
        [Email] nvarchar(max) NULL,
        [BirthDate] datetime2 NOT NULL,
        CONSTRAINT [PK_Person] PRIMARY KEY ([ID])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313180549_init2')
BEGIN
    CREATE TABLE [UserCredentials] (
        [Id] int NOT NULL,
        [UserID] int NOT NULL,
        [Attemps] int NOT NULL,
        [LastesLogin] datetime2 NOT NULL,
        CONSTRAINT [PK_UserCredentials] PRIMARY KEY ([Id], [UserID])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313180549_init2')
BEGIN
    CREATE TABLE [Room] (
        [ID] int NOT NULL IDENTITY,
        [Sleeps] int NOT NULL,
        [Price] float NOT NULL,
        [BookingId] int NULL,
        CONSTRAINT [PK_Room] PRIMARY KEY ([ID]),
        CONSTRAINT [FK_Room_Booking_BookingId] FOREIGN KEY ([BookingId]) REFERENCES [Booking] ([Id]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313180549_init2')
BEGIN
    CREATE TABLE [ErrorLog] (
        [ID] int NOT NULL,
        [PersonID] int NOT NULL,
        [ErrorCode] nvarchar(max) NULL,
        CONSTRAINT [PK_ErrorLog] PRIMARY KEY ([ID], [PersonID]),
        CONSTRAINT [FK_ErrorLog_Person_PersonID] FOREIGN KEY ([PersonID]) REFERENCES [Person] ([ID]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313180549_init2')
BEGIN
    CREATE TABLE [Manager] (
        [ID] int NOT NULL,
        [PersonID] int NOT NULL,
        [IsAdmin] int NOT NULL,
        [ManagmentLogID] int NULL,
        [ManagmentLogManagerID] int NULL,
        CONSTRAINT [PK_Manager] PRIMARY KEY ([ID], [PersonID]),
        CONSTRAINT [FK_Manager_Person_PersonID] FOREIGN KEY ([PersonID]) REFERENCES [Person] ([ID]) ON DELETE CASCADE,
        CONSTRAINT [FK_Manager_ManagmentLog_ManagmentLogID_ManagmentLogManagerID] FOREIGN KEY ([ManagmentLogID], [ManagmentLogManagerID]) REFERENCES [ManagmentLog] ([ID], [ManagerID]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313180549_init2')
BEGIN
    CREATE TABLE [User] (
        [ID] int NOT NULL,
        [PersonID] int NOT NULL,
        [BookingId] int NULL,
        [UserCredentialsId] int NULL,
        [UserCredentialsUserID] int NULL,
        CONSTRAINT [PK_User] PRIMARY KEY ([ID], [PersonID]),
        CONSTRAINT [FK_User_Booking_BookingId] FOREIGN KEY ([BookingId]) REFERENCES [Booking] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_User_Person_PersonID] FOREIGN KEY ([PersonID]) REFERENCES [Person] ([ID]) ON DELETE CASCADE,
        CONSTRAINT [FK_User_UserCredentials_UserCredentialsId_UserCredentialsUserID] FOREIGN KEY ([UserCredentialsId], [UserCredentialsUserID]) REFERENCES [UserCredentials] ([Id], [UserID]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313180549_init2')
BEGIN
    CREATE INDEX [IX_ErrorLog_PersonID] ON [ErrorLog] ([PersonID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313180549_init2')
BEGIN
    CREATE INDEX [IX_Manager_PersonID] ON [Manager] ([PersonID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313180549_init2')
BEGIN
    CREATE UNIQUE INDEX [IX_Manager_ManagmentLogID_ManagmentLogManagerID] ON [Manager] ([ManagmentLogID], [ManagmentLogManagerID]) WHERE [ManagmentLogID] IS NOT NULL AND [ManagmentLogManagerID] IS NOT NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313180549_init2')
BEGIN
    CREATE INDEX [IX_Room_BookingId] ON [Room] ([BookingId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313180549_init2')
BEGIN
    CREATE UNIQUE INDEX [IX_User_BookingId] ON [User] ([BookingId]) WHERE [BookingId] IS NOT NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313180549_init2')
BEGIN
    CREATE INDEX [IX_User_PersonID] ON [User] ([PersonID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313180549_init2')
BEGIN
    CREATE UNIQUE INDEX [IX_User_UserCredentialsId_UserCredentialsUserID] ON [User] ([UserCredentialsId], [UserCredentialsUserID]) WHERE [UserCredentialsId] IS NOT NULL AND [UserCredentialsUserID] IS NOT NULL;
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313180549_init2')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20180313180549_init2', N'2.1.0-preview1-28290');
END;

GO

