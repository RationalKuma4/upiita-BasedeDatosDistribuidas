using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using LabMedico.Models;

namespace LabMedico.Controllers
{
    [Authorize(Roles = "Recepcionista")]
    public class ClientesController : Controller
    {
        private LaboratorioDbContext _db = new LaboratorioDbContext();
        //private readonly LaboratorioDbContext _db;
        /*public ClientesController(LaboratorioDbContext db)
        {
            _db = db;
        }*/
        // GET: Clientes
        /*public ActionResult Index()
        {
            return View(_db.Clientes.ToList());
        }*/

        public ActionResult Index(string searchString)
        {
            if (!string.IsNullOrWhiteSpace(searchString))
                return View(_db.Clientes.Where(c => c.Nombre.Contains(searchString)).ToList());
            else
                return View(_db.Clientes.ToList());
        }
        // GET: Clientes/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Cliente cliente = _db.Clientes.Find(id);
            if (cliente == null)
            {
                return HttpNotFound();
            }
            return View(cliente);
        }

        // GET: Clientes/Create
        public ActionResult Create()
        {
            ViewBag.Estatus = Constantes.estatus;
            return View();
        }

        // POST: Clientes/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ClienteId,Nombre,ApellidoPaterno,ApellidoMaterno,Telefono,Celular,Calle,NumeroInterior,NumeroExterior,Colonia,DelegacionMunicipio,CodigoPostal,Sexo,Peso,Edad,Estatus")] Cliente cliente)
        {
            if (ModelState.IsValid)
            {
                _db.Clientes.Add(cliente);
                _db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(cliente);
        }

        // GET: Clientes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Cliente cliente = _db.Clientes.Find(id);
            ViewBag.Estatus = Constantes.estatus;
            if (cliente == null)
            {
                return HttpNotFound();
            }
            return View(cliente);
        }

        // POST: Clientes/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ClienteId,Nombre,ApellidoPaterno,ApellidoMaterno,Telefono,Celular,Calle,NumeroInterior,NumeroExterior,Colonia,DelegacionMunicipio,CodigoPostal,Sexo,Peso,Edad,Estatus")] Cliente cliente)
        {
            if (ModelState.IsValid)
            {
                _db.Entry(cliente).State = EntityState.Modified;
                _db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(cliente);
        }

        // GET: Clientes/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Cliente cliente = _db.Clientes.Find(id);
            if (cliente == null)
            {
                return HttpNotFound();
            }
            return View(cliente);
        }

        // POST: Clientes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Cliente cliente = _db.Clientes.Find(id);
            _db.Clientes.Remove(cliente);
            _db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                _db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
