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

        public DataTable mostrarFiltroPorMaquinas(string STRING_LISTA_idMaquina)
        {
            string consulta0 = "SELECT m.idMaquina AS 'MAQ_ID', " +
                                      "m.numeroMaquinaUSUARIO AS 'MAQ_NUM', " +
                                      "m.nombreMaquinaUSUARIO AS 'MAQ_NOM', " +
                                      "s.nombreSectorUSUARIO AS 'MAQ_SEC', " +
                                      "r.fechaHoraEncendida AS 'FH_ENC', " +
                                      "r.fechaHoraUltimoRegistroEncendida AS 'FH_URE', " +
                                      "DATEDIFF(MINUTE, r.fechaHoraEncendida, r.fechaHoraUltimoRegistroEncendida) AS 'MINS_ON', " +
                                      "DATEDIFF(MINUTE, r.fechaHoraEncendida, r.fechaHoraUltimoRegistroEncendida) / 60.0 AS 'HRS_ON' " +
                                "FROM HL.sectores s " +
                                "JOIN HL.maquinas m ON(s.idSector = m.idSector) " +
                                "JOIN HL.registros r ON(m.idMaquina = r.idMaquina) " +
                                "WHERE r.idMaquina IN (" + STRING_LISTA_idMaquina + ")";

            SqlDataAdapter da0 = new SqlDataAdapter(consulta0, cn.LeerCadena());
            DataTable dt0 = new DataTable();
            da0.Fill(dt0);
            return (dt0);
        }

        
        public DataTable casoUnicoIntervalo_mostrarCantidadDeHorasPorMaquina(string STRING_FECHA_INICIAL, string STRING_FECHA_FINAL, string STRING_LISTA_idMaquina)
        {
            string c1_caso24hs = "SELECT f0.MAQ_ID, " +
                                        "f0.MAQ_NUM, " +
                                        "f0.MAQ_NOM, " +
                                        "f0.MAQ_SEC, " +
                                        "SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, " + STRING_FECHA_INICIAL + ", " + STRING_FECHA_FINAL + ")) AS 'MINS_ON', " +
                                        "SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, " + STRING_FECHA_INICIAL + ", " + STRING_FECHA_FINAL + ")) / 60.0 AS 'HRS_ON' " +
                                 "FROM " +
                                       "(" +
                                        "SELECT r.idMaquina AS 'MAQ_ID', " +
                                               "m.numeroMaquinaUSUARIO AS 'MAQ_NUM', " +
                                               "m.nombreMaquinaUSUARIO AS 'MAQ_NOM', " +
                                               "s.nombreSectorUSUARIO AS 'MAQ_SEC', " +
                                               "r.fechaHoraEncendida AS 'FH_ENC', " +
                                               "r.fechaHoraUltimoRegistroEncendida AS 'FH_URE' " +
                                        "FROM HL.sectores s " +
                                        "JOIN HL.maquinas m ON (s.idSector = m.idSector) " +
                                        "JOIN HL.registros r ON (m.idMaquina = r.idMaquina) " +
                                        "WHERE (r.idMaquina IN (" + STRING_LISTA_idMaquina + "))" +
                                       ") " +
                                         "AS f0 " +
                               "GROUP BY f0.MAQ_ID, f0.MAQ_NUM, f0.MAQ_NOM, f0.MAQ_SEC " +
                               "HAVING SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, " + STRING_FECHA_INICIAL + ", " + STRING_FECHA_FINAL + ")) > 0 " +
                               "ORDER BY f0.MAQ_SEC, f0.MAQ_NUM";

            SqlDataAdapter da_c1_caso24hs = new SqlDataAdapter(c1_caso24hs, cn.LeerCadena());
            DataTable dt_c1 = new DataTable();
            da_c1_caso24hs.Fill(dt_c1);
            return (dt_c1);
        }

        public DataTable casoUnicoIntervalo_mostrarCantidadDeHorasPorSector(string STRING_FECHA_INICIAL, string STRING_FECHA_FINAL, string STRING_LISTA_idMaquina)
        {
            string c2_caso24hs = "SELECT f0.MAQ_SEC, " +
                                        "SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, " + STRING_FECHA_INICIAL + ", " + STRING_FECHA_FINAL + ")) AS 'MINS_ON', " +
                                        "SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, " + STRING_FECHA_INICIAL + ", " + STRING_FECHA_FINAL + ")) / 60.0 AS 'HRS_ON' " +
                                 "FROM " +
                                       "(" +
                                        "SELECT r.idMaquina AS 'MAQ_ID', " +
                                               "m.numeroMaquinaUSUARIO AS 'MAQ_NUM', " +
                                               "m.nombreMaquinaUSUARIO AS 'MAQ_NOM', " +
                                               "s.nombreSectorUSUARIO AS 'MAQ_SEC', " +
                                               "r.fechaHoraEncendida AS 'FH_ENC', " +
                                               "r.fechaHoraUltimoRegistroEncendida AS 'FH_URE' " +
                                        "FROM HL.sectores s " +
                                        "JOIN HL.maquinas m ON (s.idSector = m.idSector) " +
                                        "JOIN HL.registros r ON (m.idMaquina = r.idMaquina) " +
                                        "WHERE (r.idMaquina IN (" + STRING_LISTA_idMaquina + "))" +
                                       ") " +
                                         "AS f0 " +
                               "GROUP BY f0.MAQ_SEC " +
                               "HAVING SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, " + STRING_FECHA_INICIAL + ", " + STRING_FECHA_FINAL + ")) > 0" +
                               "ORDER BY f0.MAQ_SEC";

            SqlDataAdapter da_c2_caso24hs = new SqlDataAdapter(c2_caso24hs, cn.LeerCadena());
            DataTable dt_c2 = new DataTable();
            da_c2_caso24hs.Fill(dt_c2);
            return (dt_c2);
        }

        public DataTable casoUnicoIntervalo_mostrarCantidadDeHorasDeTodasLasMaquinas(string STRING_FECHA_INICIAL, string STRING_FECHA_FINAL, string STRING_LISTA_idMaquina)
        {
            string c3_caso24hs = "SELECT SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, " + STRING_FECHA_INICIAL + ", " + STRING_FECHA_FINAL + ")) AS 'MINS_ON', " +
                                        "SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, " + STRING_FECHA_INICIAL + ", " + STRING_FECHA_FINAL + ")) / 60.0 AS 'HRS_ON' " +
                                 "FROM " +
                                       "(" +
                                        "SELECT r.idMaquina AS 'MAQ_ID', " +
                                               "m.numeroMaquinaUSUARIO AS 'MAQ_NUM', " +
                                               "m.nombreMaquinaUSUARIO AS 'MAQ_NOM', " +
                                               "s.nombreSectorUSUARIO AS 'MAQ_SEC', " +
                                               "r.fechaHoraEncendida AS 'FH_ENC', " +
                                               "r.fechaHoraUltimoRegistroEncendida AS 'FH_URE' " +
                                        "FROM HL.sectores s " +
                                        "JOIN HL.maquinas m ON (s.idSector = m.idSector) " +
                                        "JOIN HL.registros r ON (m.idMaquina = r.idMaquina) " +
                                        "WHERE (r.idMaquina IN (" + STRING_LISTA_idMaquina + "))" +
                                       ") " +
                                         "AS f0 ";

            SqlDataAdapter da_c3_caso24hs = new SqlDataAdapter(c3_caso24hs, cn.LeerCadena());
            DataTable dt_c3 = new DataTable();
            da_c3_caso24hs.Fill(dt_c3);
            return (dt_c3);
        }




        /*
        public DataTable anterior_mostrarCantidadDeHorasPorMaquina(string STRING_FECHA_INICIAL, string STRING_FECHA_FINAL, string STRING_LISTA_idMaquina)
        {
            // consulta del requerimiento anterior
            string consulta11 = "SELECT f1.numMaqUSUARIO AS '# Máq.', " +
                                      "f1.nomMaqUSUARIO AS 'Máquina', " +
                                      "SUM(HL.f_getMinutosEncendida (f1.FH_Rini, f1.FH_Rfin, " + STRING_FECHA_INICIAL + ", " + STRING_FECHA_FINAL + ")) AS 'Minutos encendida', " +
                                      "HL.f_transformarMinutosEnHoras (SUM(HL.f_getMinutosEncendida (f1.FH_Rini, f1.FH_Rfin, " + STRING_FECHA_INICIAL + ", " + STRING_FECHA_INICIAL + "))) AS 'Horas encendida'" +
                               "FROM (SELECT r.idRegistro AS 'idReg', " +
                                            "m.idMaquina AS 'idMaq', " +
                                            "m.numeroMaquinaUSUARIO AS 'numMaqUSUARIO', " +
                                            "m.nombreMaquinaUSUARIO AS 'nomMaqUSUARIO', " +
                                            "r.fechaHoraEncendida AS 'FH_Rini', " +
                                            "r.fechaHoraUltimoRegistroEncendida AS 'FH_Rfin' " +
                                     "FROM HL.registros r " +
                                     "JOIN HL.maquinas m ON (r.idMaquina = m.idMaquina) " +
                                     "WHERE (r.idMaquina IN " + STRING_LISTA_idMaquina + ") " +
                                       "AND (r.fechaHoraUltimoRegistroEncendida >= " + STRING_FECHA_INICIAL + "AND r.fechaHoraEncendida <= " + STRING_FECHA_FINAL + ") ) AS f1 " +
                                "GROUP BY f1.numMaqUSUARIO, f1.nomMaqUSUARIO";
            
            SqlDataAdapter da1 = new SqlDataAdapter(consulta1, cn.LeerCadena());
            DataTable dt1 = new DataTable();
            da1.Fill(dt1);
            return (dt1);  
        }
        */

        public DataTable anterior_mostrarCantidadDeHorasPorSector(string STRING_FECHA_INICIAL, string STRING_FECHA_FINAL)
        {
            string consulta2 = "";

            //string consulta2 = "SELECT f2.nomSec AS 'Sector', SUM(HL.f_getMinutosEncendida (f2.FH_Rini, f2.FH_Rfin, " + STRING_FECHA_DESDE + ", " + STRING_FECHA_HASTA + ")) AS 'Minutos encendida', HL.f_transformarMinutosEnHoras (SUM(HL.f_getMinutosEncendida (f2.FH_Rini, f2.FH_Rfin, " + STRING_FECHA_DESDE + ", " + STRING_FECHA_HASTA + "))) AS 'Horas encendida' FROM (SELECT r.idRegistro AS 'idReg', m.idMaquina AS 'idMaq', s.nombreSectorUSUARIO AS 'nomSec', m.numeroMaquinaUSUARIO AS 'numMaqUSUARIO', m.nombreMaquinaUSUARIO AS 'nomMaqUSUARIO', r.fechaHoraEncendida AS 'FH_Rini', r.fechaHoraUltimoRegistroEncendida AS 'FH_Rfin' FROM HL.sectores s JOIN HL.maquinas m ON (s.idSector = m.idSector) JOIN HL.registros r ON (m.idMaquina = r.idMaquina) WHERE (r.fechaHoraUltimoRegistroEncendida > " + STRING_FECHA_DESDE + " AND r.fechaHoraEncendida < " + STRING_FECHA_HASTA + ")) AS f2 GROUP BY f2.nomSec";
            
            SqlDataAdapter da2 = new SqlDataAdapter(consulta2, cn.LeerCadena());
            DataTable dt2 = new DataTable();
            da2.Fill(dt2);
            return (dt2);
        }

        public DataTable anterior_mostrarCantidadDeHorasDeTodasLasMaquinas(string STRING_FECHA_DESDE, string STRING_FECHA_HASTA)
        {
            string consulta3 = "";

            //string consulta3 = "SELECT SUM(HL.f_getMinutosEncendida (f3.FH_Rini, f3.FH_Rfin, " + STRING_FECHA_DESDE + ", " + STRING_FECHA_HASTA + ")) AS 'Minutos encendida', HL.f_transformarMinutosEnHoras (SUM(HL.f_getMinutosEncendida (f3.FH_Rini, f3.FH_Rfin, " + STRING_FECHA_DESDE + ", " + STRING_FECHA_HASTA + "))) AS 'Horas encendida' FROM (SELECT r.idRegistro AS 'idReg', m.idMaquina AS 'idMaq', s.nombreSectorUSUARIO AS 'nomSec', m.numeroMaquinaUSUARIO AS 'numMaqUSUARIO', m.nombreMaquinaUSUARIO AS 'nomMaqUSUARIO', r.fechaHoraEncendida AS 'FH_Rini', r.fechaHoraUltimoRegistroEncendida AS 'FH_Rfin' FROM HL.sectores s JOIN HL.maquinas m ON (s.idSector = m.idSector) JOIN HL.registros r ON (m.idMaquina = r.idMaquina) WHERE (r.fechaHoraUltimoRegistroEncendida > " + STRING_FECHA_DESDE + " AND r.fechaHoraEncendida < " + STRING_FECHA_HASTA + ")) AS f3";

            SqlDataAdapter da3 = new SqlDataAdapter(consulta3, cn.LeerCadena());
            DataTable dt3 = new DataTable();
            da3.Fill(dt3);
            return (dt3);
        }
    }
}
