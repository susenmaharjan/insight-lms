USE [lms]
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([Id], [Type]) VALUES (1, N'Admin')
INSERT [dbo].[Roles] ([Id], [Type]) VALUES (2, N'User')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [Username], [Password], [RoleId], [Email]) VALUES (2, N'admin', N'admin', 1, N'susenmaharjan1994@gmail.com')
INSERT [dbo].[Users] ([Id], [Username], [Password], [RoleId], [Email]) VALUES (3, N'susen', N'susen', 2, N'susenmaharjan1994@gmail.com')
INSERT [dbo].[Users] ([Id], [Username], [Password], [RoleId], [Email]) VALUES (7, N'shyam', N'nepal123', 2, N'susenmaharjan1994@gmail.com')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET IDENTITY_INSERT [dbo].[Books] ON 

INSERT [dbo].[Books] ([Id], [Title], [Author], [Quantity], [Availability]) VALUES (1, N'Book1', N'Ram', 3, 1)
INSERT [dbo].[Books] ([Id], [Title], [Author], [Quantity], [Availability]) VALUES (3, N'Math', N'Hari', 2, 1)
INSERT [dbo].[Books] ([Id], [Title], [Author], [Quantity], [Availability]) VALUES (4, N'Catbook', N'dog', 3, 1)
INSERT [dbo].[Books] ([Id], [Title], [Author], [Quantity], [Availability]) VALUES (5, N'apple', N'woz', 2, 1)
INSERT [dbo].[Books] ([Id], [Title], [Author], [Quantity], [Availability]) VALUES (6, N'mein kamph', N'hitler', 0, 1)
SET IDENTITY_INSERT [dbo].[Books] OFF
GO
SET IDENTITY_INSERT [dbo].[Records] ON 

INSERT [dbo].[Records] ([Id], [UserId], [BookId], [ApprovedOn], [Expiry], [ReturnStatus]) VALUES (1, 3, 3, CAST(N'2020-04-13T15:44:22.560' AS DateTime), NULL, 1)
INSERT [dbo].[Records] ([Id], [UserId], [BookId], [ApprovedOn], [Expiry], [ReturnStatus]) VALUES (2, 3, 5, CAST(N'2020-04-13T19:03:30.760' AS DateTime), CAST(N'2020-04-13T19:03:30.760' AS DateTime), NULL)
INSERT [dbo].[Records] ([Id], [UserId], [BookId], [ApprovedOn], [Expiry], [ReturnStatus]) VALUES (3, 3, 5, CAST(N'2020-04-13T18:59:54.953' AS DateTime), NULL, NULL)
INSERT [dbo].[Records] ([Id], [UserId], [BookId], [ApprovedOn], [Expiry], [ReturnStatus]) VALUES (4, 7, 5, CAST(N'2020-04-13T18:56:39.830' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Records] OFF
GO
