using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace LabMedico.Models
{
    public class Sucursal
    {
        public Sucursal()
        {
            AnalisisSucursal = new HashSet<AnalisisSucursal>();
            Tecnicos = new HashSet<Tecnico>();
            Usuarios = new HashSet<LaboratorioUser>();
        }

        [Key]
        public int SucursalId { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Nombre de Sucursal")]
        [StringLength(100, ErrorMessage = "Error de extensión de caracteres.", MinimumLength = 3)]
        [DataType(DataType.Text)]
        public string Nombre { get; set; } = "";

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Calle")]
        [StringLength(100, ErrorMessage = "Error de extensión de caracteres.", MinimumLength = 3)]
        [DataType(DataType.Text)]
        public string Calle { get; set; } = "";

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Numero Interior")]
        public int? NumeroInterior { get; set; } = 0;

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Numero Exterior")]
        public int? NumeroExterior { get; set; } = 0;

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Colonia")]
        [StringLength(100, ErrorMessage = "Error de extensión de caracteres.", MinimumLength = 3)]
        [DataType(DataType.Text)]
        public string Colonia { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Delegacion o Municipio")]
        [StringLength(100, ErrorMessage = "Error de extensión de caracteres.", MinimumLength = 3)]
        [DataType(DataType.Text)]
        public string DelegacionMunicipio { get; set; } = "";

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Codigo Postal")]
        [DataType(DataType.PostalCode)]
        public int? CodigoPostal { get; set; } = 0;

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Telefono")]
        [StringLength(100, ErrorMessage = "Error de extensión de caracteres.", MinimumLength = 5)]
        [DataType(DataType.PhoneNumber)]
        public string Telefono { get; set; } = "";

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Horario")]
        [StringLength(100, ErrorMessage = "Error de extensión de caracteres.", MinimumLength = 3)]
        [DataType(DataType.Text)]
        public string Horario { get; set; } = "";

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Estatus")]
        [StringLength(3, ErrorMessage = "Error de extensión de caracteres.")]
        [DataType(DataType.Text)]
        public string Estatus { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Zona")]
        public int ZonaId { get; set; }

        public virtual ICollection<AnalisisSucursal> AnalisisSucursal { get; set; }
        public virtual ICollection<Tecnico> Tecnicos { get; set; }
        public virtual ICollection<LaboratorioUser> Usuarios { get; set; }
    }
}