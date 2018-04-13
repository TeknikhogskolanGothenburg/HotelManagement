IF OBJECT_ID(N'__EFMigrationsHistory') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180314231442_init')
BEGIN
    CREATE TABLE [Person] (
        [Id] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NOT NULL,
        [SecondName] nvarchar(max) NOT NULL,
        [Addres] nvarchar(max) NOT NULL,
        [BirthDate] datetime2 NOT NULL,
        CONSTRAINT [PK_Person] PRIMARY KEY ([Id])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180314231442_init')
BEGIN
    CREATE TABLE [Room] (
        [Id] int NOT NULL IDENTITY,
        [Sleeps] int NOT NULL,
        [Price] float NOT NULL,
        [RoomDescription] float NOT NULL,
        [LastDayCleaned] datetime2 NOT NULL,
        CONSTRAINT [PK_Room] PRIMARY KEY ([Id])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180314231442_init')
BEGIN
    CREATE TABLE [Manager] (
        [Id] int NOT NULL IDENTITY,
        [PersonId] int NOT NULL,
        [IsAdmin] bit NOT NULL,
        [LastesLogin] datetime2 NOT NULL,
        [Password] nvarchar(max) NOT NULL,
        [Email] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_Manager] PRIMARY KEY ([Id], [PersonId]),
        CONSTRAINT [FK_Manager_Person_PersonId] FOREIGN KEY ([PersonId]) REFERENCES [Person] ([Id]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180314231442_init')
BEGIN
    CREATE TABLE [User] (
        [Id] int NOT NULL IDENTITY,
        [PersonId] int NOT NULL,
        [LastesLogin] datetime2 NOT NULL,
        [Password] nvarchar(max) NOT NULL,
        [Email] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_User] PRIMARY KEY ([Id], [PersonId]),
        CONSTRAINT [FK_User_Person_PersonId] FOREIGN KEY ([PersonId]) REFERENCES [Person] ([Id]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180314231442_init')
BEGIN
    CREATE TABLE [ManagerErrorLog] (
        [Id] int NOT NULL IDENTITY,
        [ManagersId] int NOT NULL,
        [ErrorCode] nvarchar(max) NOT NULL,
        [ErrorDate] datetime2 NOT NULL,
        CONSTRAINT [PK_ManagerErrorLog] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_ManagerErrorLog_Manager_ManagersId] FOREIGN KEY ([ManagersId]) REFERENCES [Manager] ([Id]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180314231442_init')
BEGIN
    CREATE TABLE [ManagmentLog] (
        [Id] int NOT NULL IDENTITY,
        [ManagersId] int NOT NULL,
        [ManagerLogText] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_ManagmentLog] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_ManagmentLog_Manager_ManagersId] FOREIGN KEY ([ManagersId]) REFERENCES [Manager] ([Id]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180314231442_init')
BEGIN
    CREATE TABLE [Booking] (
        [Id] int NOT NULL IDENTITY,
        [UsersId] int NOT NULL,
        [RoomsId] int NOT NULL,
        [BookingStart] datetime2 NOT NULL,
        [BookingEnd] datetime2 NOT NULL,
        [TotaltPrice] float NOT NULL,
        CONSTRAINT [PK_Booking] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Booking_Room_RoomsId] FOREIGN KEY ([RoomsId]) REFERENCES [Room] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_Booking_User_UsersId] FOREIGN KEY ([UsersId]) REFERENCES [User] ([Id]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180314231442_init')
BEGIN
    CREATE TABLE [UserErrorLog] (
        [Id] int NOT NULL IDENTITY,
        [UsersId] int NOT NULL,
        [ErrorCode] nvarchar(max) NOT NULL,
        [ErrorDate] datetime2 NOT NULL,
        CONSTRAINT [PK_UserErrorLog] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_UserErrorLog_User_UsersId] FOREIGN KEY ([UsersId]) REFERENCES [User] ([Id]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180314231442_init')
BEGIN
    CREATE INDEX [IX_Booking_RoomsId] ON [Booking] ([RoomsId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180314231442_init')
BEGIN
    CREATE INDEX [IX_Booking_UsersId] ON [Booking] ([UsersId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180314231442_init')
BEGIN
    CREATE INDEX [IX_Manager_PersonId] ON [Manager] ([PersonId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180314231442_init')
BEGIN
    CREATE INDEX [IX_ManagerErrorLog_ManagersId] ON [ManagerErrorLog] ([ManagersId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180314231442_init')
BEGIN
    CREATE INDEX [IX_ManagmentLog_ManagersId] ON [ManagmentLog] ([ManagersId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180314231442_init')
BEGIN
    CREATE INDEX [IX_User_PersonId] ON [User] ([PersonId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180314231442_init')
BEGIN
    CREATE INDEX [IX_UserErrorLog_UsersId] ON [UserErrorLog] ([UsersId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180314231442_init')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20180314231442_init', N'2.1.0-preview1-28290');
END;

GO

