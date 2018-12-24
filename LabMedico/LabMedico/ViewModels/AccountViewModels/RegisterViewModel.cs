using System.ComponentModel.DataAnnotations;

namespace LabMedico.ViewModels.AccountViewModels
{
    public class RegisterViewModel
    {
        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Usuario")]
        [StringLength(80, ErrorMessage = "El número de caracteres de {0} debe ser al menos {2}.", MinimumLength = 2)]
        public string Usuario { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Nombre")]
        [StringLength(80, ErrorMessage = "El número de caracteres de {0} debe ser al menos {2}.", MinimumLength = 2)]
        public string Nombre { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Apellido Paterno")]
        [StringLength(80, ErrorMessage = "El número de caracteres de {0} debe ser al menos {2}.", MinimumLength = 2)]
        public string ApellidoPaterno { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Apellido Materno")]
        [StringLength(80, ErrorMessage = "El número de caracteres de {0} debe ser al menos {2}.", MinimumLength = 2)]
        public string ApellidoMaterno { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Calle")]
        [StringLength(80, ErrorMessage = "El número de caracteres de {0} debe ser al menos {2}.", MinimumLength = 2)]
        public string Calle { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Numero Interior")]
        public int? NumeroInterior { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Numero Exterior")]
        public int? NumeroExterior { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Colonia")]
        [StringLength(80, ErrorMessage = "El número de caracteres de {0} debe ser al menos {2}.", MinimumLength = 2)]
        public string Colonia { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Delegacion o Municipio")]
        [StringLength(80, ErrorMessage = "El número de caracteres de {0} debe ser al menos {2}.", MinimumLength = 2)]
        public string DelegacionMunicipio { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Codigo Postal")]
        [DataType(DataType.PostalCode)]
        public int? CodigoPostal { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Estado")]
        [StringLength(80, ErrorMessage = "El número de caracteres de {0} debe ser al menos {2}.", MinimumLength = 2)]
        public string Estado { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Edad")]
        public int? Edad { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Sexo")]
        [StringLength(1, ErrorMessage = "Solo se permite una letra.")]
        public string Sexo { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Notas")]
        [StringLength(800, ErrorMessage = "El número de caracteres de {0} debe ser al menos {2}.", MinimumLength = 2)]
        [DataType(DataType.MultilineText)]
        public string Notas { get; set; }

        [Required]
        public int? SucursalId { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "No se permiten campos vacios.")]
        [Display(Name = "Estatus")]
        public string Estatus { get; set; }

        [Required]
        [Display(Name = "Tipo de Usuario")]
        public int? Rol { get; set; }

        [Required]
        [EmailAddress]
        [Display(Name = "Correo electrónico")]
        public string Email { get; set; }

        [Required]
        [StringLength(100, ErrorMessage = "El número de caracteres de {0} debe ser al menos {2}.", MinimumLength = 6)]
        [DataType(DataType.Password)]
        [Display(Name = "Contraseña")]
        public string Password { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "Confirmar contraseña")]
        [Compare("Password", ErrorMessage = "La contraseña y la contraseña de confirmación no coinciden.")]
        public string ConfirmPassword { get; set; }
    }
}