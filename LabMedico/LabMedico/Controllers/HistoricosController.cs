using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using LabMedico.Models;
using Microsoft.Reporting.WebForms;
using LabMedico.ReportRepository;
using System;
using System.Net.Mime;

namespace LabMedico.Controllers
{
    [Authorize(Roles = "Administrador")]
    public class HistoricosController : Controller
    {
        private LaboratorioDbContext _db = new LaboratorioDbContext();
        //private readonly LaboratorioDbContext _db;
        /*public HistoricosController(LaboratorioDbContext db)
        {
            _db = db;
        }*/
        // GET: Historicos
        public ActionResult Index()
        {
            var historicoes = _db.Historicoes.Include(h => h.Citas);
            ViewBag.Sucursales = new SelectList(_db.Sucursals, "SucursalId", "Nombre");
            return View(historicoes.ToList());
        }

        // GET: Historicos/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Historico historico = _db.Historicoes.Find(id);
            if (historico == null)
            {
                return HttpNotFound();
            }
            return View(historico);
        }

        // GET: Historicos/Create
        public ActionResult Create()
        {
            ViewBag.CitaId = new SelectList(_db.Citas, "CitaId", "HoraAplicacion");
            return View();
        }

        // POST: Historicos/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "HistoricoId,CitaId,FechaRegistro,Monto")] Historico historico)
        {
            if (ModelState.IsValid)
            {
                _db.Historicoes.Add(historico);
                _db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.CitaId = new SelectList(_db.Citas, "CitaId", "HoraAplicacion", historico.CitaId);
            return View(historico);
        }

        // GET: Historicos/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Historico historico = _db.Historicoes.Find(id);
            if (historico == null)
            {
                return HttpNotFound();
            }
            ViewBag.CitaId = new SelectList(_db.Citas, "CitaId", "HoraAplicacion", historico.CitaId);
            return View(historico);
        }

        // POST: Historicos/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "HistoricoId,CitaId,FechaRegistro,Monto")] Historico historico)
        {
            if (ModelState.IsValid)
            {
                _db.Entry(historico).State = EntityState.Modified;
                _db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.CitaId = new SelectList(_db.Citas, "CitaId", "HoraAplicacion", historico.CitaId);
            return View(historico);
        }

        // GET: Historicos/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Historico historico = _db.Historicoes.Find(id);
            if (historico == null)
            {
                return HttpNotFound();
            }
            return View(historico);
        }

        // POST: Historicos/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Historico historico = _db.Historicoes.Find(id);
            _db.Historicoes.Remove(historico);
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

        public FileResult ReportexSucursal(int id)
        {
            using (var local = new LocalReport())
            {
                var historicoInfo = (new HistoricosRepository()).HistoricoxSucursal(id);
                local.ReportPath = "Reports\\HistoricoxSucursal.rdlc";
                local.DisplayName = "HistoricoxSucursal";
                local.DataSources.Add(new ReportDataSource("Historico", historicoInfo));
                var tituloParameter = new ReportParameter
                {
                    Name = "Titulo",
                    Values = { "Informe Historico por Sucursal" }
                };
                local.SetParameters(tituloParameter);
                local.Refresh();
                var reporte = local.Render("pdf");
                return File(reporte, MediaTypeNames.Application.Octet, "HistoricoxSucursal" + DateTime.Now.ToShortDateString() + ".pdf");
            }
        }

        public FileResult ReporteAnual()
        {
            using (var local = new LocalReport())
            {
                var historicoInfo = (new HistoricosRepository()).HistoricoAnual();
                local.ReportPath = "Reports\\HistoricoxSucursal.rdlc";
                local.DisplayName = "HistoricoxSucursal";
                local.DataSources.Add(new ReportDataSource("Historico", historicoInfo));
                var tituloParameter = new ReportParameter
                {
                    Name = "Titulo",
                    Values = { "Informe Historico Anual" }
                };
                local.SetParameters(tituloParameter);
                local.Refresh();
                var reporte = local.Render("pdf");
                return File(reporte, MediaTypeNames.Application.Octet, "HistoricoxAnual" + DateTime.Now.ToShortDateString() + ".pdf");
            }
        }
    }
}
