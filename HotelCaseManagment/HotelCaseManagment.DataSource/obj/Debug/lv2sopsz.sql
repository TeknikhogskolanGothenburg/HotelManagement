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
    [Email] nvarchar(450) NULL,
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
    CONSTRAINT [PK_Manager] PRIMARY KEY ([ID]),
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
    [ErrorCode] nvarchar(max) NULL,
    [ErrorDate] datetime2 NOT NULL,
    CONSTRAINT [PK_ManagerErrorLog] PRIMARY KEY ([ID]),
    CONSTRAINT [FK_ManagerErrorLog_Manager_ManagerID] FOREIGN KEY ([ManagerID]) REFERENCES [Manager] ([ID]) ON DELETE NO ACTION
);

GO

CREATE TABLE [ManagmentLog] (
    [ID] int NOT NULL IDENTITY,
    [ManagerID] int NULL,
    [ManagerLogText] nvarchar(max) NULL,
    CONSTRAINT [PK_ManagmentLog] PRIMARY KEY ([ID]),
    CONSTRAINT [FK_ManagmentLog_Manager_ManagerID] FOREIGN KEY ([ManagerID]) REFERENCES [Manager] ([ID]) ON DELETE NO ACTION
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

CREATE UNIQUE INDEX [IX_Manager_PersonID] ON [Manager] ([PersonID]);

GO

CREATE INDEX [IX_ManagerErrorLog_ManagerID] ON [ManagerErrorLog] ([ManagerID]);

GO

CREATE INDEX [IX_ManagmentLog_ManagerID] ON [ManagmentLog] ([ManagerID]);

GO

CREATE UNIQUE INDEX [IX_Person_Email] ON [Person] ([Email]) WHERE [Email] IS NOT NULL;

GO

CREATE UNIQUE INDEX [IX_User_PersonID] ON [User] ([PersonID]);

GO

CREATE INDEX [IX_UserErrorLog_UserID_UserPersonID] ON [UserErrorLog] ([UserID], [UserPersonID]);

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20180316143701_Init', N'2.1.0-preview1-28290');

GO

ALTER TABLE [Booking] DROP CONSTRAINT [FK_Booking_User_UserID_UserPersonID];

GO

ALTER TABLE [UserErrorLog] DROP CONSTRAINT [FK_UserErrorLog_User_UserID_UserPersonID];

GO

DROP INDEX [IX_UserErrorLog_UserID_UserPersonID] ON [UserErrorLog];

GO

ALTER TABLE [User] DROP CONSTRAINT [PK_User];

GO

DROP INDEX [IX_Booking_UserID_UserPersonID] ON [Booking];

GO

DECLARE @var0 sysname;
SELECT @var0 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'UserErrorLog') AND [c].[name] = N'UserPersonID');
IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [UserErrorLog] DROP CONSTRAINT [' + @var0 + '];');
ALTER TABLE [UserErrorLog] DROP COLUMN [UserPersonID];

GO

DECLARE @var1 sysname;
SELECT @var1 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'Booking') AND [c].[name] = N'UserPersonID');
IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [Booking] DROP CONSTRAINT [' + @var1 + '];');
ALTER TABLE [Booking] DROP COLUMN [UserPersonID];

GO

ALTER TABLE [User] ADD CONSTRAINT [PK_User] PRIMARY KEY ([ID]);

GO

CREATE INDEX [IX_UserErrorLog_UserID] ON [UserErrorLog] ([UserID]);

GO

CREATE INDEX [IX_Booking_UserID] ON [Booking] ([UserID]);

GO

ALTER TABLE [Booking] ADD CONSTRAINT [FK_Booking_User_UserID] FOREIGN KEY ([UserID]) REFERENCES [User] ([ID]) ON DELETE NO ACTION;

GO

ALTER TABLE [UserErrorLog] ADD CONSTRAINT [FK_UserErrorLog_User_UserID] FOREIGN KEY ([UserID]) REFERENCES [User] ([ID]) ON DELETE NO ACTION;

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20180319215337_Init2', N'2.1.0-preview1-28290');

GO

