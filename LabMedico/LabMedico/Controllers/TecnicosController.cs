using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using LabMedico.Models;

namespace LabMedico.Controllers
{
    [Authorize(Roles = "Administrador")]
    public class TecnicosController : Controller
    {
        private LaboratorioDbContext _db = new LaboratorioDbContext();
        //private readonly LaboratorioDbContext _db;
        /*public TecnicosController(LaboratorioDbContext db)
        {
            _db = db;
        }*/
        // GET: Tecnicos
        public ActionResult Index(string searchString)
        {
            var tecnicoes = _db.Tecnicoes.Include(t => t.Estudios).Include(t => t.Sucursales);
            if (!string.IsNullOrWhiteSpace(searchString))
                return View(tecnicoes.Where(t => t.Nombre.Contains(searchString)).ToList());
            else
                return View(tecnicoes.ToList());

            //return View(tecnicoes.ToList());
        }

        // GET: Tecnicos/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Tecnico tecnico = _db.Tecnicoes.Find(id);
            if (tecnico == null)
            {
                return HttpNotFound();
            }
            return View(tecnico);
        }

        // GET: Tecnicos/Create
        public ActionResult Create()
        {
            ViewBag.EstudioId = new SelectList(_db.Estudios, "EstudioId", "Nombre");
            ViewBag.SucursalId = new SelectList(_db.Sucursals, "SucursalId", "Nombre");
            ViewBag.Estatus = Constantes.estatus;
            return View();
        }

        // POST: Tecnicos/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "TecnicoId,Nombre,ApellidoPaterno,ApellidoMaterno,Calle,NumeroInterior,NumeroExterior,Colonia,DelegacionMunicipio,CodigoPostal,Estado,Edad,Sexo,Notas,Estatus,SucursalId,EstudioId")] Tecnico tecnico)
        {
            if (ModelState.IsValid)
            {
                _db.Tecnicoes.Add(tecnico);
                _db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.EstudioId = new SelectList(_db.Estudios, "EstudioId", "Nombre", tecnico.EstudioId);
            ViewBag.SucursalId = new SelectList(_db.Sucursals, "SucursalId", "Nombre", tecnico.SucursalId);
            return View(tecnico);
        }

        // GET: Tecnicos/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Tecnico tecnico = _db.Tecnicoes.Find(id);
            if (tecnico == null)
            {
                return HttpNotFound();
            }
            ViewBag.EstudioId = new SelectList(_db.Estudios, "EstudioId", "Nombre", tecnico.EstudioId);
            ViewBag.SucursalId = new SelectList(_db.Sucursals, "SucursalId", "Nombre", tecnico.SucursalId);
            ViewBag.Estatus = Constantes.estatus;
            return View(tecnico);
        }

        // POST: Tecnicos/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "TecnicoId,Nombre,ApellidoPaterno,ApellidoMaterno,Calle,NumeroInterior,NumeroExterior,Colonia,DelegacionMunicipio,CodigoPostal,Estado,Edad,Sexo,Notas,Estatus,SucursalId,EstudioId")] Tecnico tecnico)
        {
            if (ModelState.IsValid)
            {
                _db.Entry(tecnico).State = EntityState.Modified;
                _db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.EstudioId = new SelectList(_db.Estudios, "EstudioId", "Nombre", tecnico.EstudioId);
            ViewBag.SucursalId = new SelectList(_db.Sucursals, "SucursalId", "Nombre", tecnico.SucursalId);
            return View(tecnico);
        }

        // GET: Tecnicos/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Tecnico tecnico = _db.Tecnicoes.Find(id);
            if (tecnico == null)
            {
                return HttpNotFound();
            }
            return View(tecnico);
        }

        // POST: Tecnicos/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Tecnico tecnico = _db.Tecnicoes.Find(id);
            _db.Tecnicoes.Remove(tecnico);
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
