using System.ComponentModel.DataAnnotations;

namespace LabMedico.ViewModels.AccountViewModels
{
    public class ForgotPasswordViewModel
    {
        [Required]
        [EmailAddress]
        [Display(Name = "Correo electrónico")]
        public string Email { get; set; }
    }
}