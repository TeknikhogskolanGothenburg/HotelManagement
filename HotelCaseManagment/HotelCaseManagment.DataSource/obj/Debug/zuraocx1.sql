IF OBJECT_ID(N'__EFMigrationsHistory') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313200221_init')
BEGIN
    CREATE TABLE [Person] (
        [PersonId] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NULL,
        [SecondName] nvarchar(max) NULL,
        [Addres] nvarchar(max) NULL,
        [Email] nvarchar(max) NULL,
        [BirthDate] datetime2 NOT NULL,
        CONSTRAINT [PK_Person] PRIMARY KEY ([PersonId])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313200221_init')
BEGIN
    CREATE TABLE [Room] (
        [RoomId] int NOT NULL IDENTITY,
        [Sleeps] int NOT NULL,
        [Price] float NOT NULL,
        [RoomDescription] float NOT NULL,
        [LastDayCleaned] datetime2 NOT NULL,
        CONSTRAINT [PK_Room] PRIMARY KEY ([RoomId])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313200221_init')
BEGIN
    CREATE TABLE [Manager] (
        [ManagerId] int NOT NULL IDENTITY,
        [PersonId] int NOT NULL,
        [IsAdmin] bit NOT NULL,
        CONSTRAINT [PK_Manager] PRIMARY KEY ([ManagerId]),
        CONSTRAINT [FK_Manager_Person_PersonId] FOREIGN KEY ([PersonId]) REFERENCES [Person] ([PersonId]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313200221_init')
BEGIN
    CREATE TABLE [User] (
        [UserId] int NOT NULL IDENTITY,
        [PersonId] int NOT NULL,
        CONSTRAINT [PK_User] PRIMARY KEY ([UserId]),
        CONSTRAINT [FK_User_Person_PersonId] FOREIGN KEY ([PersonId]) REFERENCES [Person] ([PersonId]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313200221_init')
BEGIN
    CREATE TABLE [ManagerCredentials] (
        [ManagerCredentialId] int NOT NULL IDENTITY,
        [ManagerId] int NOT NULL,
        [LastesLogin] datetime2 NOT NULL,
        [Password] nvarchar(max) NULL,
        CONSTRAINT [PK_ManagerCredentials] PRIMARY KEY ([ManagerCredentialId]),
        CONSTRAINT [FK_ManagerCredentials_Manager_ManagerId] FOREIGN KEY ([ManagerId]) REFERENCES [Manager] ([ManagerId]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313200221_init')
BEGIN
    CREATE TABLE [ManagerErrorLog] (
        [ManagerErrorLogId] int NOT NULL IDENTITY,
        [ManagerId] int NOT NULL,
        [ErrorCode] nvarchar(max) NULL,
        [ErrorDate] datetime2 NOT NULL,
        CONSTRAINT [PK_ManagerErrorLog] PRIMARY KEY ([ManagerErrorLogId]),
        CONSTRAINT [FK_ManagerErrorLog_Manager_ManagerId] FOREIGN KEY ([ManagerId]) REFERENCES [Manager] ([ManagerId]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313200221_init')
BEGIN
    CREATE TABLE [ManagmentLog] (
        [ManagmentLogId] int NOT NULL IDENTITY,
        [ManagerId] int NOT NULL,
        [ManagerLogText] nvarchar(max) NULL,
        CONSTRAINT [PK_ManagmentLog] PRIMARY KEY ([ManagmentLogId]),
        CONSTRAINT [FK_ManagmentLog_Manager_ManagerId] FOREIGN KEY ([ManagerId]) REFERENCES [Manager] ([ManagerId]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313200221_init')
BEGIN
    CREATE TABLE [Booking] (
        [BookingId] int NOT NULL IDENTITY,
        [UserId] int NOT NULL,
        [RoomId] int NOT NULL,
        [BookingStart] datetime2 NOT NULL,
        [BookingEnd] datetime2 NOT NULL,
        [TotaltPrice] float NOT NULL,
        CONSTRAINT [PK_Booking] PRIMARY KEY ([BookingId]),
        CONSTRAINT [FK_Booking_Room_RoomId] FOREIGN KEY ([RoomId]) REFERENCES [Room] ([RoomId]) ON DELETE CASCADE,
        CONSTRAINT [FK_Booking_User_UserId] FOREIGN KEY ([UserId]) REFERENCES [User] ([UserId]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313200221_init')
BEGIN
    CREATE TABLE [UserCredentials] (
        [UserCredentialId] int NOT NULL IDENTITY,
        [UserId] int NOT NULL,
        [LastesLogin] datetime2 NOT NULL,
        [Password] nvarchar(max) NULL,
        CONSTRAINT [PK_UserCredentials] PRIMARY KEY ([UserCredentialId]),
        CONSTRAINT [FK_UserCredentials_User_UserId] FOREIGN KEY ([UserId]) REFERENCES [User] ([UserId]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313200221_init')
BEGIN
    CREATE TABLE [UserErrorLog] (
        [UserErrorLogId] int NOT NULL IDENTITY,
        [UserId] int NOT NULL,
        [ErrorCode] nvarchar(max) NULL,
        [ErrorDate] datetime2 NOT NULL,
        CONSTRAINT [PK_UserErrorLog] PRIMARY KEY ([UserErrorLogId]),
        CONSTRAINT [FK_UserErrorLog_User_UserId] FOREIGN KEY ([UserId]) REFERENCES [User] ([UserId]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313200221_init')
BEGIN
    CREATE INDEX [IX_Booking_RoomId] ON [Booking] ([RoomId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313200221_init')
BEGIN
    CREATE INDEX [IX_Booking_UserId] ON [Booking] ([UserId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313200221_init')
BEGIN
    CREATE INDEX [IX_Manager_PersonId] ON [Manager] ([PersonId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313200221_init')
BEGIN
    CREATE INDEX [IX_ManagerCredentials_ManagerId] ON [ManagerCredentials] ([ManagerId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313200221_init')
BEGIN
    CREATE INDEX [IX_ManagerErrorLog_ManagerId] ON [ManagerErrorLog] ([ManagerId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313200221_init')
BEGIN
    CREATE INDEX [IX_ManagmentLog_ManagerId] ON [ManagmentLog] ([ManagerId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313200221_init')
BEGIN
    CREATE INDEX [IX_User_PersonId] ON [User] ([PersonId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313200221_init')
BEGIN
    CREATE INDEX [IX_UserCredentials_UserId] ON [UserCredentials] ([UserId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313200221_init')
BEGIN
    CREATE INDEX [IX_UserErrorLog_UserId] ON [UserErrorLog] ([UserId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313200221_init')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20180313200221_init', N'2.1.0-preview1-28290');
END;

GO

