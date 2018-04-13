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
    [BookingTime] datetime2 NOT NULL,
    [TotaltPrice] float NOT NULL,
    CONSTRAINT [PK_Booking] PRIMARY KEY ([Id])
);

GO

CREATE TABLE [ManagmentLog] (
    [ID] int NOT NULL,
    [ManagerID] int NOT NULL,
    [ManagerLog] nvarchar(max) NULL,
    CONSTRAINT [PK_ManagmentLog] PRIMARY KEY ([ID], [ManagerID])
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

CREATE TABLE [UserCredentials] (
    [Id] int NOT NULL,
    [UserID] int NOT NULL,
    [Attemps] int NOT NULL,
    [LastesLogin] datetime2 NOT NULL,
    CONSTRAINT [PK_UserCredentials] PRIMARY KEY ([Id], [UserID])
);

GO

CREATE TABLE [Room] (
    [ID] int NOT NULL IDENTITY,
    [Sleeps] int NOT NULL,
    [Price] float NOT NULL,
    [BookingId] int NULL,
    CONSTRAINT [PK_Room] PRIMARY KEY ([ID]),
    CONSTRAINT [FK_Room_Booking_BookingId] FOREIGN KEY ([BookingId]) REFERENCES [Booking] ([Id]) ON DELETE NO ACTION
);

GO

CREATE TABLE [ErrorLog] (
    [ID] int NOT NULL,
    [PersonID] int NOT NULL,
    [ErrorCode] nvarchar(max) NULL,
    CONSTRAINT [PK_ErrorLog] PRIMARY KEY ([ID], [PersonID]),
    CONSTRAINT [FK_ErrorLog_Person_PersonID] FOREIGN KEY ([PersonID]) REFERENCES [Person] ([ID]) ON DELETE CASCADE
);

GO

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

GO

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

GO

CREATE INDEX [IX_ErrorLog_PersonID] ON [ErrorLog] ([PersonID]);

GO

CREATE INDEX [IX_Manager_PersonID] ON [Manager] ([PersonID]);

GO

CREATE UNIQUE INDEX [IX_Manager_ManagmentLogID_ManagmentLogManagerID] ON [Manager] ([ManagmentLogID], [ManagmentLogManagerID]) WHERE [ManagmentLogID] IS NOT NULL AND [ManagmentLogManagerID] IS NOT NULL;

GO

CREATE INDEX [IX_Room_BookingId] ON [Room] ([BookingId]);

GO

CREATE UNIQUE INDEX [IX_User_BookingId] ON [User] ([BookingId]) WHERE [BookingId] IS NOT NULL;

GO

CREATE INDEX [IX_User_PersonID] ON [User] ([PersonID]);

GO

CREATE UNIQUE INDEX [IX_User_UserCredentialsId_UserCredentialsUserID] ON [User] ([UserCredentialsId], [UserCredentialsUserID]) WHERE [UserCredentialsId] IS NOT NULL AND [UserCredentialsUserID] IS NOT NULL;

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20180313180549_init2', N'2.1.0-preview1-28290');

GO

ALTER TABLE [Room] DROP CONSTRAINT [FK_Room_Booking_BookingId];

GO

DROP INDEX [IX_Room_BookingId] ON [Room];

GO

DECLARE @var0 sysname;
SELECT @var0 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'Room') AND [c].[name] = N'BookingId');
IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [Room] DROP CONSTRAINT [' + @var0 + '];');
ALTER TABLE [Room] DROP COLUMN [BookingId];

GO

ALTER TABLE [Booking] ADD [RoomID] int NULL;

GO

CREATE INDEX [IX_Booking_RoomID] ON [Booking] ([RoomID]);

GO

ALTER TABLE [Booking] ADD CONSTRAINT [FK_Booking_Room_RoomID] FOREIGN KEY ([RoomID]) REFERENCES [Room] ([ID]) ON DELETE NO ACTION;

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20180313181831_init3', N'2.1.0-preview1-28290');

GO

