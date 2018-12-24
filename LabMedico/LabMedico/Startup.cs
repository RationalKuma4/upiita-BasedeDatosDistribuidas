using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(LabMedico.Startup))]
namespace LabMedico
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
