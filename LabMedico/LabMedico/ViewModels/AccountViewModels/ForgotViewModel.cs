using System.ComponentModel.DataAnnotations;

namespace LabMedico.ViewModels.AccountViewModels
{
    public class ForgotViewModel
    {
        [Required]
        [Display(Name = "Correo electrónico")]
        public string Email { get; set; }
    }
}