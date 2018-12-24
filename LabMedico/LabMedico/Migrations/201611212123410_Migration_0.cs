namespace LabMedico.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class Migration_0 : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Analisis",
                c => new
                    {
                        AnalisisId = c.Int(nullable: false, identity: true),
                        Nombre = c.String(nullable: false, maxLength: 100),
                        Descripcion = c.String(nullable: false, maxLength: 1000),
                        Requisitos = c.String(nullable: false),
                        Estatus = c.String(nullable: false, maxLength: 3),
                        EstudioId = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.AnalisisId)
                .ForeignKey("dbo.Estudios", t => t.EstudioId, cascadeDelete: true)
                .Index(t => t.EstudioId);
            
            CreateTable(
                "dbo.AnalisisSucursales",
                c => new
                    {
                        AnalisisSucursalId = c.Int(nullable: false, identity: true),
                        SucursalId = c.Int(nullable: false),
                        AnalisisId = c.Int(nullable: false),
                        Costo = c.Decimal(nullable: false, precision: 18, scale: 2),
                        Estatus = c.String(nullable: false, maxLength: 3),
                    })
                .PrimaryKey(t => t.AnalisisSucursalId)
                .ForeignKey("dbo.Analisis", t => t.AnalisisId, cascadeDelete: true)
                .ForeignKey("dbo.Sucursales", t => t.SucursalId, cascadeDelete: true)
                .Index(t => t.SucursalId)
                .Index(t => t.AnalisisId);
            
            CreateTable(
                "dbo.Sucursales",
                c => new
                    {
                        SucursalId = c.Int(nullable: false, identity: true),
                        Nombre = c.String(nullable: false, maxLength: 100),
                        Calle = c.String(nullable: false, maxLength: 100),
                        NumeroInterior = c.Int(nullable: false),
                        NumeroExterior = c.Int(nullable: false),
                        Colonia = c.String(nullable: false, maxLength: 100),
                        DelegacionMunicipio = c.String(nullable: false, maxLength: 100),
                        CodigoPostal = c.Int(nullable: false),
                        Telefono = c.String(nullable: false, maxLength: 100),
                        Horario = c.String(nullable: false, maxLength: 100),
                        Estatus = c.String(nullable: false, maxLength: 3),
                        ZonaId = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.SucursalId);
            
            CreateTable(
                "dbo.Tecnicos",
                c => new
                    {
                        TecnicoId = c.Int(nullable: false, identity: true),
                        Nombre = c.String(nullable: false, maxLength: 100),
                        ApellidoPaterno = c.String(nullable: false, maxLength: 100),
                        ApellidoMaterno = c.String(nullable: false, maxLength: 100),
                        Calle = c.String(nullable: false, maxLength: 100),
                        NumeroInterior = c.Int(nullable: false),
                        NumeroExterior = c.Int(nullable: false),
                        Colonia = c.String(nullable: false, maxLength: 100),
                        DelegacionMunicipio = c.String(nullable: false, maxLength: 100),
                        CodigoPostal = c.Int(nullable: false),
                        Estado = c.String(nullable: false, maxLength: 100),
                        Edad = c.Int(nullable: false),
                        Sexo = c.String(nullable: false, maxLength: 1),
                        Notas = c.String(),
                        Estatus = c.String(nullable: false, maxLength: 3),
                        SucursalId = c.Int(nullable: false),
                        EstudioId = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.TecnicoId)
                .ForeignKey("dbo.Estudios", t => t.EstudioId, cascadeDelete: true)
                .ForeignKey("dbo.Sucursales", t => t.SucursalId, cascadeDelete: true)
                .Index(t => t.SucursalId)
                .Index(t => t.EstudioId);
            
            CreateTable(
                "dbo.Citas",
                c => new
                    {
                        CitaId = c.Int(nullable: false, identity: true),
                        FechaRegistro = c.DateTime(nullable: false),
                        FechaEntrega = c.DateTime(nullable: false),
                        FechaAplicacion = c.DateTime(nullable: false),
                        HoraAplicacion = c.String(nullable: false),
                        Id = c.Int(nullable: false),
                        ClienteId = c.Int(nullable: false),
                        AnalisisId = c.Int(nullable: false),
                        Estatus = c.String(nullable: false, maxLength: 3),
                        Monto = c.Decimal(nullable: false, precision: 18, scale: 2),
                    })
                .PrimaryKey(t => t.CitaId)
                .ForeignKey("dbo.Analisis", t => t.AnalisisId, cascadeDelete: true)
                .ForeignKey("dbo.Clientes", t => t.ClienteId, cascadeDelete: true)
                .ForeignKey("dbo.AspNetUsers", t => t.Id, cascadeDelete: true)
                .Index(t => t.Id)
                .Index(t => t.ClienteId)
                .Index(t => t.AnalisisId);
            
            CreateTable(
                "dbo.Clientes",
                c => new
                    {
                        ClienteId = c.Int(nullable: false, identity: true),
                        Nombre = c.String(nullable: false, maxLength: 100),
                        ApellidoPaterno = c.String(nullable: false, maxLength: 100),
                        ApellidoMaterno = c.String(nullable: false, maxLength: 100),
                        Telefono = c.String(nullable: false, maxLength: 100),
                        Celular = c.String(nullable: false, maxLength: 100),
                        Calle = c.String(nullable: false, maxLength: 100),
                        NumeroInterior = c.Int(nullable: false),
                        NumeroExterior = c.Int(nullable: false),
                        Colonia = c.String(nullable: false, maxLength: 100),
                        DelegacionMunicipio = c.String(nullable: false, maxLength: 100),
                        CodigoPostal = c.Int(nullable: false),
                        Sexo = c.String(nullable: false, maxLength: 1),
                        Peso = c.Decimal(nullable: false, precision: 18, scale: 2),
                        Edad = c.Int(nullable: false),
                        Estatus = c.String(nullable: false, maxLength: 3),
                    })
                .PrimaryKey(t => t.ClienteId);
            
            CreateTable(
                "dbo.Historicos",
                c => new
                    {
                        HistoricoId = c.Int(nullable: false, identity: true),
                        CitaId = c.Int(nullable: false),
                        FechaRegistro = c.DateTime(nullable: false),
                        Monto = c.Decimal(nullable: false, precision: 18, scale: 2),
                    })
                .PrimaryKey(t => t.HistoricoId)
                .ForeignKey("dbo.Citas", t => t.CitaId, cascadeDelete: true)
                .Index(t => t.CitaId);
            
            CreateTable(
                "dbo.AspNetUsers",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Usuario = c.String(),
                        Nombre = c.String(),
                        ApellidoPaterno = c.String(),
                        ApellidoMaterno = c.String(),
                        Calle = c.String(),
                        NumeroInterior = c.Int(),
                        NumeroExterior = c.Int(),
                        Colonia = c.String(),
                        DelegacionMunicipio = c.String(),
                        CodigoPostal = c.Int(),
                        Estado = c.String(),
                        Edad = c.Int(),
                        Sexo = c.String(),
                        Notas = c.String(),
                        SucursalId = c.Int(),
                        Estatus = c.String(),
                        Email = c.String(maxLength: 256),
                        EmailConfirmed = c.Boolean(nullable: false),
                        PasswordHash = c.String(),
                        SecurityStamp = c.String(),
                        PhoneNumber = c.String(),
                        PhoneNumberConfirmed = c.Boolean(nullable: false),
                        TwoFactorEnabled = c.Boolean(nullable: false),
                        LockoutEndDateUtc = c.DateTime(),
                        LockoutEnabled = c.Boolean(nullable: false),
                        AccessFailedCount = c.Int(nullable: false),
                        UserName = c.String(nullable: false, maxLength: 256),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Sucursales", t => t.SucursalId)
                .Index(t => t.SucursalId)
                .Index(t => t.UserName, unique: true, name: "UserNameIndex");
            
            CreateTable(
                "dbo.AspNetUserClaims",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        UserId = c.Int(nullable: false),
                        ClaimType = c.String(),
                        ClaimValue = c.String(),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.AspNetUsers", t => t.UserId, cascadeDelete: true)
                .Index(t => t.UserId);
            
            CreateTable(
                "dbo.AspNetUserLogins",
                c => new
                    {
                        LoginProvider = c.String(nullable: false, maxLength: 128),
                        ProviderKey = c.String(nullable: false, maxLength: 128),
                        UserId = c.Int(nullable: false),
                    })
                .PrimaryKey(t => new { t.LoginProvider, t.ProviderKey, t.UserId })
                .ForeignKey("dbo.AspNetUsers", t => t.UserId, cascadeDelete: true)
                .Index(t => t.UserId);
            
            CreateTable(
                "dbo.AspNetUserRoles",
                c => new
                    {
                        UserId = c.Int(nullable: false),
                        RoleId = c.Int(nullable: false),
                    })
                .PrimaryKey(t => new { t.UserId, t.RoleId })
                .ForeignKey("dbo.AspNetUsers", t => t.UserId, cascadeDelete: true)
                .ForeignKey("dbo.AspNetRoles", t => t.RoleId, cascadeDelete: true)
                .Index(t => t.UserId)
                .Index(t => t.RoleId);
            
            CreateTable(
                "dbo.Estudios",
                c => new
                    {
                        EstudioId = c.Int(nullable: false, identity: true),
                        Nombre = c.String(nullable: false, maxLength: 100),
                        Descripcion = c.String(nullable: false, maxLength: 500),
                        Estatus = c.String(nullable: false, maxLength: 3),
                    })
                .PrimaryKey(t => t.EstudioId);
            
            CreateTable(
                "dbo.AspNetRoles",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Name = c.String(nullable: false, maxLength: 256),
                    })
                .PrimaryKey(t => t.Id)
                .Index(t => t.Name, unique: true, name: "RoleNameIndex");
            
            CreateTable(
                "dbo.TecnicoCitas",
                c => new
                    {
                        TecnicoCitasId = c.Int(nullable: false, identity: true),
                        TecnicoId = c.Int(nullable: false),
                        CitaId = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.TecnicoCitasId)
                .ForeignKey("dbo.Tecnicos", t => t.TecnicoId, cascadeDelete: true)
                .Index(t => t.TecnicoId);
            
            CreateTable(
                "dbo.Zonas",
                c => new
                    {
                        ZonaId = c.Int(nullable: false, identity: true),
                        ZonaNombre = c.String(nullable: false, maxLength: 100),
                        Descripcion = c.String(nullable: false, maxLength: 500),
                    })
                .PrimaryKey(t => t.ZonaId);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.TecnicoCitas", "TecnicoId", "dbo.Tecnicos");
            DropForeignKey("dbo.AspNetUserRoles", "RoleId", "dbo.AspNetRoles");
            DropForeignKey("dbo.Tecnicos", "SucursalId", "dbo.Sucursales");
            DropForeignKey("dbo.Tecnicos", "EstudioId", "dbo.Estudios");
            DropForeignKey("dbo.Analisis", "EstudioId", "dbo.Estudios");
            DropForeignKey("dbo.Citas", "Tecnico_TecnicoId", "dbo.Tecnicos");
            DropForeignKey("dbo.AspNetUsers", "SucursalId", "dbo.Sucursales");
            DropForeignKey("dbo.AspNetUserRoles", "UserId", "dbo.AspNetUsers");
            DropForeignKey("dbo.AspNetUserLogins", "UserId", "dbo.AspNetUsers");
            DropForeignKey("dbo.AspNetUserClaims", "UserId", "dbo.AspNetUsers");
            DropForeignKey("dbo.Citas", "Id", "dbo.AspNetUsers");
            DropForeignKey("dbo.Historicos", "CitaId", "dbo.Citas");
            DropForeignKey("dbo.Citas", "ClienteId", "dbo.Clientes");
            DropForeignKey("dbo.Citas", "AnalisisId", "dbo.Analisis");
            DropForeignKey("dbo.AnalisisSucursales", "SucursalId", "dbo.Sucursales");
            DropForeignKey("dbo.AnalisisSucursales", "AnalisisId", "dbo.Analisis");
            DropIndex("dbo.TecnicoCitas", new[] { "TecnicoId" });
            DropIndex("dbo.AspNetRoles", "RoleNameIndex");
            DropIndex("dbo.AspNetUserRoles", new[] { "RoleId" });
            DropIndex("dbo.AspNetUserRoles", new[] { "UserId" });
            DropIndex("dbo.AspNetUserLogins", new[] { "UserId" });
            DropIndex("dbo.AspNetUserClaims", new[] { "UserId" });
            DropIndex("dbo.AspNetUsers", "UserNameIndex");
            DropIndex("dbo.AspNetUsers", new[] { "SucursalId" });
            DropIndex("dbo.Historicos", new[] { "CitaId" });
            DropIndex("dbo.Citas", new[] { "Tecnico_TecnicoId" });
            DropIndex("dbo.Citas", new[] { "AnalisisId" });
            DropIndex("dbo.Citas", new[] { "ClienteId" });
            DropIndex("dbo.Citas", new[] { "Id" });
            DropIndex("dbo.Tecnicos", new[] { "EstudioId" });
            DropIndex("dbo.Tecnicos", new[] { "SucursalId" });
            DropIndex("dbo.AnalisisSucursales", new[] { "AnalisisId" });
            DropIndex("dbo.AnalisisSucursales", new[] { "SucursalId" });
            DropIndex("dbo.Analisis", new[] { "EstudioId" });
            DropTable("dbo.Zonas");
            DropTable("dbo.TecnicoCitas");
            DropTable("dbo.AspNetRoles");
            DropTable("dbo.Estudios");
            DropTable("dbo.AspNetUserRoles");
            DropTable("dbo.AspNetUserLogins");
            DropTable("dbo.AspNetUserClaims");
            DropTable("dbo.AspNetUsers");
            DropTable("dbo.Historicos");
            DropTable("dbo.Clientes");
            DropTable("dbo.Citas");
            DropTable("dbo.Tecnicos");
            DropTable("dbo.Sucursales");
            DropTable("dbo.AnalisisSucursales");
            DropTable("dbo.Analisis");
        }
    }
}
