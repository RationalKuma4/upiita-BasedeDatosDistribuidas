using System.ComponentModel.DataAnnotations;

namespace LabMedico.ViewModels.ManageViewModels
{
    public class ChangePasswordViewModel
    {
        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Contraseña actual")]
        public string OldPassword { get; set; }

        [Required]
        [StringLength(100, ErrorMessage = "{0} debe tener al menos {2} caracteres de longitud.", MinimumLength = 6)]
        [DataType(DataType.Password)]
        [Display(Name = "Contraseña nueva")]
        public string NewPassword { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "Confirme la contraseña nueva")]
        [Compare("NewPassword", ErrorMessage = "La contraseña nueva y la contraseña de confirmación no coinciden.")]
        public string ConfirmPassword { get; set; }
    }
}