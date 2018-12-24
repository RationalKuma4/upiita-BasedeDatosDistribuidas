using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace LabMedico.Models
{
    public class Cliente
    {
        public Cliente()
        {
            Citas = new HashSet<Cita>();
        }

        [Key]
        public int ClienteId { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Nombre")]
        [StringLength(100, ErrorMessage = "Error de extensión de caracteres.", MinimumLength = 3)]
        [DataType(DataType.Text)]
        public string Nombre { get; set; } = "";

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Apellido Paterno")]
        [StringLength(100, ErrorMessage = "Error de extensión de caracteres.", MinimumLength = 3)]
        [DataType(DataType.Text)]
        public string ApellidoPaterno { get; set; } = "";

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Apellido Materno")]
        [StringLength(100, ErrorMessage = "Error de extensión de caracteres.", MinimumLength = 3)]
        [DataType(DataType.Text)]
        public string ApellidoMaterno { get; set; } = "";

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Telefono local")]
        [StringLength(100, ErrorMessage = "Error de extensión de caracteres.", MinimumLength = 3)]
        [DataType(DataType.PhoneNumber)]
        public string Telefono { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Telefono celular")]
        [StringLength(100, ErrorMessage = "Error de extensión de caracteres.", MinimumLength = 3)]
        [DataType(DataType.PhoneNumber)]
        public string Celular { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Calle")]
        [StringLength(100, ErrorMessage = "Error de extensión de caracteres.", MinimumLength = 3)]
        [DataType(DataType.Text)]
        public string Calle { get; set; }

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
        public string Colonia { get; set; } = "";

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
        [Display(Name = "Sexo")]
        [StringLength(1, ErrorMessage = "Error de extensión de caracteres.")]
        [DataType(DataType.Text)]
        public string Sexo { get; set; } = "";

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Peso")]
        public decimal? Peso { get; set; } = 0;

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Edad")]
        public int? Edad { get; set; } = 0;

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Estatus")]
        [StringLength(3, ErrorMessage = "Error de extensión de caracteres.")]
        [DataType(DataType.Text)]
        public string Estatus { get; set; } = "";

        [ScaffoldColumn(false)]
        public string NombreCompleto
        {
            get { return $@"{Nombre} {ApellidoPaterno} {ApellidoMaterno}"; }
        }

        public virtual ICollection<Cita> Citas { get; set; }
    }
}