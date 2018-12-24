using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using LabMedico.Models;

namespace LabMedico.Controllers
{
    [Authorize(Roles = "Administrador")]
    public class ZonasController : Controller
    {
        private LaboratorioDbContext _db = new LaboratorioDbContext();
        //private readonly LaboratorioDbContext _db;
        /*public ZonasController(LaboratorioDbContext db)
        {
            _db = db;
        }*/
        // GET: Zonas
        public ActionResult Index()
        {
            return View(_db.Zonas.ToList());
        }

        // GET: Zonas/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Zona zona = _db.Zonas.Find(id);
            if (zona == null)
            {
                return HttpNotFound();
            }
            return View(zona);
        }

        // GET: Zonas/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Zonas/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ZonaId,ZonaNombre,Descripcion")] Zona zona)
        {
            if (ModelState.IsValid)
            {
                _db.Zonas.Add(zona);
                _db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(zona);
        }

        // GET: Zonas/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Zona zona = _db.Zonas.Find(id);
            if (zona == null)
            {
                return HttpNotFound();
            }
            return View(zona);
        }

        // POST: Zonas/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ZonaId,ZonaNombre,Descripcion")] Zona zona)
        {
            if (ModelState.IsValid)
            {
                _db.Entry(zona).State = EntityState.Modified;
                _db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(zona);
        }

        // GET: Zonas/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Zona zona = _db.Zonas.Find(id);
            if (zona == null)
            {
                return HttpNotFound();
            }
            return View(zona);
        }

        // POST: Zonas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Zona zona = _db.Zonas.Find(id);
            _db.Zonas.Remove(zona);
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
