using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using LabMedico.Models;

namespace LabMedico.Controllers
{
    [Authorize(Roles = "Administrador")]
    public class AnalisisController : Controller
    {
        private LaboratorioDbContext _db = new LaboratorioDbContext();
        //private readonly LaboratorioDbContext _db;
        /*public AnalisisController(LaboratorioDbContext db)
        {
            _db = db;
        }*/
        // GET: Analisis
        public ActionResult Index(string searchString)
        {
            var analisis = _db.Analisis.Include(a => a.Estudios);
            if (!string.IsNullOrWhiteSpace(searchString))
                return View(analisis.Where(a => a.Nombre.Contains(searchString)));
            else
                return View(analisis.ToList());
        }

        // GET: Analisis/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Analisis analisis = _db.Analisis.Find(id);
            if (analisis == null)
            {
                return HttpNotFound();
            }
            return View(analisis);
        }

        // GET: Analisis/Create
        public ActionResult Create()
        {
            ViewBag.EstudioId = new SelectList(_db.Estudios, "EstudioId", "Nombre");
            ViewBag.Estatus = Constantes.estatus;
            return View();
        }

        // POST: Analisis/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "AnalisisId,Nombre,Descripcion,Requisitos,Estatus,EstudioId")] Analisis analisis)
        {
            if (ModelState.IsValid)
            {
                _db.Analisis.Add(analisis);
                _db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.EstudioId = new SelectList(_db.Estudios, "EstudioId", "Nombre", analisis.EstudioId);
            return View(analisis);
        }

        // GET: Analisis/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Analisis analisis = _db.Analisis.Find(id);
            if (analisis == null)
            {
                return HttpNotFound();
            }
            ViewBag.EstudioId = new SelectList(_db.Estudios, "EstudioId", "Nombre", analisis.EstudioId);
            ViewBag.Estatus = Constantes.estatus;
            return View(analisis);
        }

        // POST: Analisis/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "AnalisisId,Nombre,Descripcion,Requisitos,Estatus,EstudioId")] Analisis analisis)
        {
            if (ModelState.IsValid)
            {
                _db.Entry(analisis).State = EntityState.Modified;
                _db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.EstudioId = new SelectList(_db.Estudios, "EstudioId", "Nombre", analisis.EstudioId);
            return View(analisis);
        }

        // GET: Analisis/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Analisis analisis = _db.Analisis.Find(id);
            if (analisis == null)
            {
                return HttpNotFound();
            }
            return View(analisis);
        }

        // POST: Analisis/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Analisis analisis = _db.Analisis.Find(id);
            _db.Analisis.Remove(analisis);
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
