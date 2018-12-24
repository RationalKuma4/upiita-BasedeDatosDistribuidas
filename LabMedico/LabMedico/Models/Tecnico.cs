using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace LabMedico.Models
{
    public class Tecnico
    {
        public Tecnico()
        {
            Citas = new HashSet<Cita>();
        }

        [Key]
        public int TecnicoId { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Nombre de Tecnico")]
        [StringLength(100, ErrorMessage = "Error de extensión de caracteres.", MinimumLength = 2)]
        [DataType(DataType.Text)]
        public string Nombre { get; set; } = "";

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Apellido Paterno")]
        [StringLength(100, ErrorMessage = "Error de extensión de caracteres.", MinimumLength = 2)]
        [DataType(DataType.Text)]
        public string ApellidoPaterno { get; set; } = "";

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Apellido Materno")]
        [StringLength(100, ErrorMessage = "Error de extensión de caracteres.", MinimumLength = 2)]
        [DataType(DataType.Text)]
        public string ApellidoMaterno { get; set; } = "";

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Calle")]
        [StringLength(100, ErrorMessage = "Error de extensión de caracteres.", MinimumLength = 2)]
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
        [StringLength(100, ErrorMessage = "Error de extensión de caracteres.", MinimumLength = 2)]
        [DataType(DataType.Text)]
        public string Colonia { get; set; } = "";

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Delegacion o Municipio")]
        [StringLength(100, ErrorMessage = "Error de extensión de caracteres.", MinimumLength = 2)]
        [DataType(DataType.Text)]
        public string DelegacionMunicipio { get; set; } = "";

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Codigo Postal")]
        [DataType(DataType.PostalCode)]
        public int? CodigoPostal { get; set; } = 0;

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Estado")]
        [StringLength(100, ErrorMessage = "Error de extensión de caracteres.", MinimumLength = 2)]
        [DataType(DataType.Text)]
        public string Estado { get; set; } = "";

        [Required]
        [Display(Name = "Edad")]
        public int? Edad { get; set; } = 0;

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Sexo")]
        [StringLength(1, ErrorMessage = "Error de extensión de caracteres.")]
        [DataType(DataType.Text)]
        public string Sexo { get; set; } = "";

        [DataType(DataType.MultilineText)]
        public string Notas { get; set; } = "";

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Estatus")]
        [StringLength(3, ErrorMessage = "Error de extensión de caracteres.")]
        [DataType(DataType.Text)]
        public string Estatus { get; set; }

        [Required]
        [Display(Name = "Sucursal")]
        public int SucursalId { get; set; }

        [Required]
        [Display(Name = "Estudio")]
        public int EstudioId { get; set; }


        public virtual ICollection<Cita> Citas { get; set; }
        public virtual Estudio Estudios { get; set; }
        public virtual Sucursal Sucursales { get; set; }
    }
}