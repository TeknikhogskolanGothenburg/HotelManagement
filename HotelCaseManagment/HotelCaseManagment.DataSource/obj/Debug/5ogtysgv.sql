IF OBJECT_ID(N'__EFMigrationsHistory') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313130911_init')
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

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313130911_init')
BEGIN
    CREATE TABLE [Room] (
        [ID] int NOT NULL IDENTITY,
        [Sleeps] int NOT NULL,
        [Price] float NOT NULL,
        CONSTRAINT [PK_Room] PRIMARY KEY ([ID])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313130911_init')
BEGIN
    CREATE TABLE [Manager] (
        [ID] int NOT NULL,
        [PersonID] int NOT NULL,
        CONSTRAINT [PK_Manager] PRIMARY KEY ([ID], [PersonID]),
        CONSTRAINT [FK_Manager_Person_PersonID] FOREIGN KEY ([PersonID]) REFERENCES [Person] ([ID]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313130911_init')
BEGIN
    CREATE TABLE [User] (
        [ID] int NOT NULL,
        [PersonID] int NOT NULL,
        CONSTRAINT [PK_User] PRIMARY KEY ([ID], [PersonID]),
        CONSTRAINT [FK_User_Person_PersonID] FOREIGN KEY ([PersonID]) REFERENCES [Person] ([ID]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313130911_init')
BEGIN
    CREATE TABLE [Booking] (
        [Id] int NOT NULL,
        [UserId] int NOT NULL,
        [UserID] int NULL,
        [UserPersonID] int NULL,
        CONSTRAINT [PK_Booking] PRIMARY KEY ([Id], [UserId]),
        CONSTRAINT [FK_Booking_User_UserID_UserPersonID] FOREIGN KEY ([UserID], [UserPersonID]) REFERENCES [User] ([ID], [PersonID]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313130911_init')
BEGIN
    CREATE TABLE [BookingRoom] (
        [RoomID] int NOT NULL,
        [BookingID] int NOT NULL,
        [BookingId] int NULL,
        [BookingUserId] int NULL,
        CONSTRAINT [PK_BookingRoom] PRIMARY KEY ([BookingID], [RoomID]),
        CONSTRAINT [FK_BookingRoom_Room_RoomID] FOREIGN KEY ([RoomID]) REFERENCES [Room] ([ID]) ON DELETE CASCADE,
        CONSTRAINT [FK_BookingRoom_Booking_BookingId_BookingUserId] FOREIGN KEY ([BookingId], [BookingUserId]) REFERENCES [Booking] ([Id], [UserId]) ON DELETE NO ACTION
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313130911_init')
BEGIN
    CREATE INDEX [IX_Booking_UserID_UserPersonID] ON [Booking] ([UserID], [UserPersonID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313130911_init')
BEGIN
    CREATE INDEX [IX_BookingRoom_RoomID] ON [BookingRoom] ([RoomID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313130911_init')
BEGIN
    CREATE INDEX [IX_BookingRoom_BookingId_BookingUserId] ON [BookingRoom] ([BookingId], [BookingUserId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313130911_init')
BEGIN
    CREATE INDEX [IX_Manager_PersonID] ON [Manager] ([PersonID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313130911_init')
BEGIN
    CREATE INDEX [IX_User_PersonID] ON [User] ([PersonID]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20180313130911_init')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20180313130911_init', N'2.1.0-preview1-28290');
END;

GO

