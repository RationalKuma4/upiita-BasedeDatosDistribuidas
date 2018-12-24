using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using LabMedico.Models;
using LabMedico.ViewModels;

namespace LabMedico.Controllers
{
    [Authorize(Roles = "Administrador")]
    public class SucursalesController : Controller
    {
        private LaboratorioDbContext _db = new LaboratorioDbContext();
        //private readonly LaboratorioDbContext _db;
        /*public SucursalesController(LaboratorioDbContext db)
        {
            _db = db;
        }*/
        // GET: Sucursales
        public ActionResult Index(string searchString)
        {
            //return View(_db.Sucursals.ToList());
            IEnumerable<SucursalViewModel> sucursales = null;
            if (!string.IsNullOrWhiteSpace(searchString))
                sucursales = SucursalesResulset().Where(s => s.Nombre.Contains(searchString));
            else
                sucursales = SucursalesResulset();
            return View(sucursales.ToList());
        }

        // GET: Sucursales/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Sucursal sucursal = _db.Sucursals.Find(id);
            if (sucursal == null)
            {
                return HttpNotFound();
            }
            return View(sucursal);
        }

        // GET: Sucursales/Create
        public ActionResult Create()
        {
            ViewBag.Estatus = Constantes.estatus;
            ViewBag.Zonas = new SelectList(_db.Zonas, "ZonaId", "ZonaNombre");
            return View();
        }

        // POST: Sucursales/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "SucursalId,Nombre,Calle,NumeroInterior,NumeroExterior,Colonia,DelegacionMunicipio,CodigoPostal,Telefono,Horario,Estatus,ZonaId")] Sucursal sucursal)
        {
            if (ModelState.IsValid)
            {
                _db.Sucursals.Add(sucursal);
                _db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(sucursal);
        }

        // GET: Sucursales/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Sucursal sucursal = _db.Sucursals.Find(id);
            ViewBag.Zonas = new SelectList(_db.Zonas, "ZonaId", "ZonaNombre", sucursal.ZonaId);
            ViewBag.Estatus = Constantes.estatus;
            if (sucursal == null)
            {
                return HttpNotFound();
            }
            return View(sucursal);
        }

        // POST: Sucursales/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "SucursalId,Nombre,Calle,NumeroInterior,NumeroExterior,Colonia,DelegacionMunicipio,CodigoPostal,Telefono,Horario,Estatus,ZonaId")] Sucursal sucursal)
        {
            if (ModelState.IsValid)
            {
                _db.Entry(sucursal).State = EntityState.Modified;
                _db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(sucursal);
        }

        // GET: Sucursales/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Sucursal sucursal = _db.Sucursals.Find(id);
            if (sucursal == null)
            {
                return HttpNotFound();
            }
            return View(sucursal);
        }

        // POST: Sucursales/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Sucursal sucursal = _db.Sucursals.Find(id);
            _db.Sucursals.Remove(sucursal);
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

        private List<SucursalViewModel> SucursalesResulset()
        {
            var result =
                from s in _db.Sucursals
                join z in _db.Zonas on s.ZonaId equals z.ZonaId
                into resulSet
                from r in resulSet.DefaultIfEmpty()
                select new
                {
                    SucursalId = s.SucursalId,
                    Nombre = s.Nombre,
                    DelegacionMunicipio = s.DelegacionMunicipio,
                    CodigoPostal = s.CodigoPostal,
                    Telefono = s.Telefono,
                    Horario = s.Horario,
                    ZonaNombre = r.ZonaNombre
                };

            List<SucursalViewModel> sucursales = new List<SucursalViewModel>();

            foreach (var item in result.ToList())
            {
                var sucursal = new SucursalViewModel
                {
                    SucursalId = item.SucursalId,
                    Nombre = item.Nombre,
                    DelegacionMunicipio = item.DelegacionMunicipio,
                    CodigoPostal = item.CodigoPostal,
                    Telefono = item.Telefono,
                    Horario = item.Horario,
                    ZonaNombre = item.ZonaNombre
                };

                sucursales.Add(sucursal);
            }

            return sucursales;
        }
    }
}
