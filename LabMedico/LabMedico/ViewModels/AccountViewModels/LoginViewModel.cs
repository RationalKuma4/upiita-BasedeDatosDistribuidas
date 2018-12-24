using System.ComponentModel.DataAnnotations;

namespace LabMedico.ViewModels.AccountViewModels
{
    public class LoginViewModel
    {
        [Required]
        [Display(Name = "Usuario")]
        public string UserName { get; set; }
        //[Required]
        [Display(Name = "Correo electrónico")]
        [EmailAddress]
        public string Email { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Contraseña")]
        public string Password { get; set; }

        [Display(Name = "¿Recordar cuenta?")]
        public bool RememberMe { get; set; }
    }
}