using Microsoft.Practices.Unity;
using Microsoft.Practices.Unity.Mvc;
using System.Web.Mvc;
using LabMedico.Controllers;

namespace LabMedico.Models
{
    public class Bootstrapper
    {
        public static IUnityContainer Initialise()
        {
            var container = BuildUnityContainer();
            DependencyResolver.SetResolver(new UnityDependencyResolver(container));
            return container;
        }

        private static IUnityContainer BuildUnityContainer()
        {
            var container = new UnityContainer();
            RegisterTypes(container);
            return container;
        }

        private static void RegisterTypes(UnityContainer container)
        {
            container.RegisterType<LaboratorioDbContext>();
        }
    }
}