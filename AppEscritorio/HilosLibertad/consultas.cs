using System;
using System.Collections.Generic;
using System.Data;              // Necesario para el DataTable
using System.Data.SqlClient;    // Necesario para el SqlDataAdapter
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HilosLibertad
{
    public class Consultas
    {
        // Creamos el objeto de la clase Conexion y la instanciamos
        Conexion cn = new Conexion();

        public DataTable mostrarCantidadDeHorasPorMaquina(string STRING_FECHA_DESDE, string STRING_FECHA_HASTA, string STRING_LISTA_idMaquina)
        {
            string consulta1 = "SELECT f1.numMaqUSUARIO AS '# Máq.', f1.nomMaqUSUARIO AS 'Máquina', SUM(HL.f_getMinutosEncendida (f1.FH_Rini, f1.FH_Rfin, " + STRING_FECHA_DESDE + ", " + STRING_FECHA_HASTA + ")) AS 'Minutos encendida', HL.f_transformarMinutosEnHoras	(SUM(HL.f_getMinutosEncendida (f1.FH_Rini, f1.FH_Rfin, " + STRING_FECHA_DESDE + ", " + STRING_FECHA_HASTA + "))) AS 'Horas encendida' FROM (SELECT r.idRegistro AS 'idReg', m.idMaquina AS 'idMaq', m.numeroMaquinaUSUARIO AS 'numMaqUSUARIO', m.nombreMaquinaUSUARIO AS 'nomMaqUSUARIO', r.fechaHoraEncendida AS 'FH_Rini', r.fechaHoraUltimoRegistroEncendida AS 'FH_Rfin' FROM HL.registros r JOIN HL.maquinas m ON (r.idMaquina = m.idMaquina) WHERE (r.idMaquina IN " + STRING_LISTA_idMaquina + ") AND (r.fechaHoraUltimoRegistroEncendida > " + STRING_FECHA_DESDE + "AND r.fechaHoraEncendida < " + STRING_FECHA_HASTA + ") ) AS f1 GROUP BY f1.numMaqUSUARIO, f1.nomMaqUSUARIO";
            SqlDataAdapter da1 = new SqlDataAdapter(consulta1, cn.LeerCadena());
            DataTable dt1 = new DataTable();
            da1.Fill(dt1);
            return (dt1);
            
        }
        

        public DataTable mostrarCantidadDeHorasPorSector(string STRING_FECHA_DESDE, string STRING_FECHA_HASTA)
        {
            string consulta2 = "SELECT f2.nomSec AS 'Sector', SUM(HL.f_getMinutosEncendida (f2.FH_Rini, f2.FH_Rfin, " + STRING_FECHA_DESDE + ", " + STRING_FECHA_HASTA + ")) AS 'Minutos encendida', HL.f_transformarMinutosEnHoras (SUM(HL.f_getMinutosEncendida (f2.FH_Rini, f2.FH_Rfin, " + STRING_FECHA_DESDE + ", " + STRING_FECHA_HASTA + "))) AS 'Horas encendida' FROM (SELECT r.idRegistro AS 'idReg', m.idMaquina AS 'idMaq', s.nombreSectorUSUARIO AS 'nomSec', m.numeroMaquinaUSUARIO AS 'numMaqUSUARIO', m.nombreMaquinaUSUARIO AS 'nomMaqUSUARIO', r.fechaHoraEncendida AS 'FH_Rini', r.fechaHoraUltimoRegistroEncendida AS 'FH_Rfin' FROM HL.sectores s JOIN HL.maquinas m ON (s.idSector = m.idSector) JOIN HL.registros r ON (m.idMaquina = r.idMaquina) WHERE (r.fechaHoraUltimoRegistroEncendida > " + STRING_FECHA_DESDE + " AND r.fechaHoraEncendida < " + STRING_FECHA_HASTA + ")) AS f2 GROUP BY f2.nomSec";
            //string consulta2 = "SELECT f2.nomSec AS 'Sector', SUM(HL.f_getMinutosEncendida (f2.FH_Rini, f2.FH_Rfin, " + STRING_FECHA_DESDE + ", " + STRING_FECHA_HASTA + ")) AS 'Minutos encendida' FROM (SELECT r.idRegistro AS 'idReg', m.idMaquina AS 'idMaq', s.nombreSectorUSUARIO AS 'nomSec', m.numeroMaquinaUSUARIO AS 'numMaqUSUARIO', m.nombreMaquinaUSUARIO AS 'nomMaqUSUARIO', r.fechaHoraEncendida AS 'FH_Rini', r.fechaHoraUltimoRegistroEncendida AS 'FH_Rfin' FROM HL.sectores s JOIN HL.maquinas m ON (s.idSector = m.idSector) JOIN HL.registros r ON (m.idMaquina = r.idMaquina) WHERE (r.fechaHoraUltimoRegistroEncendida > " + STRING_FECHA_DESDE + " AND r.fechaHoraEncendida < " + STRING_FECHA_HASTA + ")) AS f2 GROUP BY f2.nomSec";
            SqlDataAdapter da2 = new SqlDataAdapter(consulta2, cn.LeerCadena());
            DataTable dt2 = new DataTable();
            da2.Fill(dt2);
            return (dt2);
        }

        public DataTable mostrarCantidadDeHorasDeTodasLasMaquinas(string STRING_FECHA_DESDE, string STRING_FECHA_HASTA)
        {
            string consulta3 = "SELECT SUM(HL.f_getMinutosEncendida (f3.FH_Rini, f3.FH_Rfin, " + STRING_FECHA_DESDE + ", " + STRING_FECHA_HASTA + ")) AS 'Minutos encendida', HL.f_transformarMinutosEnHoras (SUM(HL.f_getMinutosEncendida (f3.FH_Rini, f3.FH_Rfin, " + STRING_FECHA_DESDE + ", " + STRING_FECHA_HASTA + "))) AS 'Horas encendida' FROM (SELECT r.idRegistro AS 'idReg', m.idMaquina AS 'idMaq', s.nombreSectorUSUARIO AS 'nomSec', m.numeroMaquinaUSUARIO AS 'numMaqUSUARIO', m.nombreMaquinaUSUARIO AS 'nomMaqUSUARIO', r.fechaHoraEncendida AS 'FH_Rini', r.fechaHoraUltimoRegistroEncendida AS 'FH_Rfin' FROM HL.sectores s JOIN HL.maquinas m ON (s.idSector = m.idSector) JOIN HL.registros r ON (m.idMaquina = r.idMaquina) WHERE (r.fechaHoraUltimoRegistroEncendida > " + STRING_FECHA_DESDE + " AND r.fechaHoraEncendida < " + STRING_FECHA_HASTA + ")) AS f3";
            //string consulta3 = "SELECT SUM(HL.f_getMinutosEncendida (f3.FH_Rini, f3.FH_Rfin, " + STRING_FECHA_DESDE + ", " + STRING_FECHA_HASTA + ")) AS 'Minutos encendida' FROM (SELECT r.idRegistro AS 'idReg', m.idMaquina AS 'idMaq', s.nombreSectorUSUARIO AS 'nomSec', m.numeroMaquinaUSUARIO AS 'numMaqUSUARIO', m.nombreMaquinaUSUARIO AS 'nomMaqUSUARIO', r.fechaHoraEncendida AS 'FH_Rini', r.fechaHoraUltimoRegistroEncendida AS 'FH_Rfin' FROM HL.sectores s JOIN HL.maquinas m ON (s.idSector = m.idSector) JOIN HL.registros r ON (m.idMaquina = r.idMaquina) WHERE (r.fechaHoraUltimoRegistroEncendida > " + STRING_FECHA_DESDE + " AND r.fechaHoraEncendida < " + STRING_FECHA_HASTA + ")) AS f3";
            SqlDataAdapter da3 = new SqlDataAdapter(consulta3, cn.LeerCadena());
            DataTable dt3 = new DataTable();
            da3.Fill(dt3);
            return (dt3);
        }
    }
}
