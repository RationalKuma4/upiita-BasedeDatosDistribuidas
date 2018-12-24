using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using LabMedico.Models;

namespace LabMedico.Controllers
{
    public class TecnicoCitasController : Controller
    {
        private LaboratorioDbContext _db = new LaboratorioDbContext();
        //private readonly LaboratorioDbContext _db;
        /*public TecnicoCitasController(LaboratorioDbContext db)
        {
            _db = db;
        }*/

        // GET: TecnicoCitas
        public ActionResult Index()
        {
            var tecnicoCitas = _db.TecnicoCitas.Include(t => t.Tecnico);
            return View(tecnicoCitas.ToList());
        }

        // GET: TecnicoCitas/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TecnicoCitas tecnicoCitas = _db.TecnicoCitas.Find(id);
            if (tecnicoCitas == null)
            {
                return HttpNotFound();
            }
            return View(tecnicoCitas);
        }

        // GET: TecnicoCitas/Create
        public ActionResult Create()
        {
            ViewBag.TecnicoId = new SelectList(_db.Tecnicoes, "TecnicoId", "Nombre");
            ViewBag.Estatus = Constantes.estatus;
            return View();
        }

        // POST: TecnicoCitas/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "TecnicoCitasId,TecnicoId,CitaId")] TecnicoCitas tecnicoCitas)
        {
            if (ModelState.IsValid)
            {
                _db.TecnicoCitas.Add(tecnicoCitas);
                _db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.TecnicoId = new SelectList(_db.Tecnicoes, "TecnicoId", "Nombre", tecnicoCitas.TecnicoId);
            return View(tecnicoCitas);
        }

        // GET: TecnicoCitas/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TecnicoCitas tecnicoCitas = _db.TecnicoCitas.Find(id);
            if (tecnicoCitas == null)
            {
                return HttpNotFound();
            }
            ViewBag.Estatus = Constantes.estatus;
            ViewBag.TecnicoId = new SelectList(_db.Tecnicoes, "TecnicoId", "Nombre", tecnicoCitas.TecnicoId);
            return View(tecnicoCitas);
        }

        // POST: TecnicoCitas/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "TecnicoCitasId,TecnicoId,CitaId")] TecnicoCitas tecnicoCitas)
        {
            if (ModelState.IsValid)
            {
                _db.Entry(tecnicoCitas).State = EntityState.Modified;
                _db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.TecnicoId = new SelectList(_db.Tecnicoes, "TecnicoId", "Nombre", tecnicoCitas.TecnicoId);
            return View(tecnicoCitas);
        }

        // GET: TecnicoCitas/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TecnicoCitas tecnicoCitas = _db.TecnicoCitas.Find(id);
            if (tecnicoCitas == null)
            {
                return HttpNotFound();
            }
            return View(tecnicoCitas);
        }

        // POST: TecnicoCitas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            TecnicoCitas tecnicoCitas = _db.TecnicoCitas.Find(id);
            _db.TecnicoCitas.Remove(tecnicoCitas);
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
