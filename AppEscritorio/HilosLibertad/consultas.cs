﻿using System;
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

        
        public DataTable casoUnicoIntervalo_mostrarCantidadDeHorasPorMaquina(string STRING_FECHAyHORARIO_INICIAL, string STRING_FECHAyHORARIO_FINAL, string STRING_LISTA_idMaquina)
        {
            string c1_casoUnicoIntervalo = "SELECT f0.MAQ_ID, " +
                                                  "f0.MAQ_NUM, " +
                                                  "f0.MAQ_NOM, " +
                                                  "f0.MAQ_SEC, " +
                                                  "SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, " + STRING_FECHAyHORARIO_INICIAL + ", " + STRING_FECHAyHORARIO_FINAL + ")) AS 'MINS_ON', " +
                                                  "SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, " + STRING_FECHAyHORARIO_INICIAL + ", " + STRING_FECHAyHORARIO_FINAL + ")) / 60.0 AS 'HRS_ON' " +
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
                                           "HAVING SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, " + STRING_FECHAyHORARIO_INICIAL + ", " + STRING_FECHAyHORARIO_FINAL + ")) > 0 " +
                                           "ORDER BY f0.MAQ_SEC, f0.MAQ_NUM";

            SqlDataAdapter da_c1_casoUnicoIntervalo = new SqlDataAdapter(c1_casoUnicoIntervalo, cn.LeerCadena());
            DataTable dt_c1_casoUnicoIntervalo = new DataTable();
            da_c1_casoUnicoIntervalo.Fill(dt_c1_casoUnicoIntervalo);
            return (dt_c1_casoUnicoIntervalo);
        }

        public DataTable casoUnicoIntervalo_mostrarCantidadDeHorasPorSector(string STRING_FECHAyHORARIO_INICIAL, string STRING_FECHAyHORARIO_FINAL, string STRING_LISTA_idMaquina)
        {
            string c2_casoUnicoIntervalo = "SELECT f0.MAQ_SEC, " +
                                                  "SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, " + STRING_FECHAyHORARIO_INICIAL + ", " + STRING_FECHAyHORARIO_FINAL + ")) AS 'MINS_ON', " +
                                                  "SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, " + STRING_FECHAyHORARIO_INICIAL + ", " + STRING_FECHAyHORARIO_FINAL + ")) / 60.0 AS 'HRS_ON' " +
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
                                           "HAVING SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, " + STRING_FECHAyHORARIO_INICIAL + ", " + STRING_FECHAyHORARIO_FINAL + ")) > 0" +
                                           "ORDER BY f0.MAQ_SEC";

            SqlDataAdapter da_c2_casoUnicoIntervalo = new SqlDataAdapter(c2_casoUnicoIntervalo, cn.LeerCadena());
            DataTable dt_c2_casoUnicoIntervalo = new DataTable();
            da_c2_casoUnicoIntervalo.Fill(dt_c2_casoUnicoIntervalo);
            return (dt_c2_casoUnicoIntervalo);
        }

        public DataTable casoUnicoIntervalo_mostrarCantidadDeHorasDeTodasLasMaquinas(string STRING_FECHAyHORARIO_INICIAL, string STRING_FECHAyHORARIO_FINAL, string STRING_LISTA_idMaquina)
        {
            string c3_casoUnicoIntervalo = "SELECT SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, " + STRING_FECHAyHORARIO_INICIAL + ", " + STRING_FECHAyHORARIO_FINAL + ")) AS 'MINS_ON', " +
                                                  "SUM(HL.f_getMinsON_formatoFecha(f0.FH_ENC, f0.FH_URE, " + STRING_FECHAyHORARIO_INICIAL + ", " + STRING_FECHAyHORARIO_FINAL + ")) / 60.0 AS 'HRS_ON' " +
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

            SqlDataAdapter da_c3_casoUnicoIntervalo = new SqlDataAdapter(c3_casoUnicoIntervalo, cn.LeerCadena());
            DataTable dt_c3_casoUnicoIntervalo = new DataTable();
            da_c3_casoUnicoIntervalo.Fill(dt_c3_casoUnicoIntervalo);
            return (dt_c3_casoUnicoIntervalo);
        }



        public DataTable casoNintervalos_mostrarCantidadDeHorasPorMaquina (string STRING_FECHA_INICIAL, string STRING_FECHA_FINAL, string STRING_HORARIO_INICIAL, string STRING_HORARIO_FINAL, string STRING_LISTA_idMaquina)
        {

            string c1_casoNintervalos = "SELECT f0.MAQ_ID, " +
                                               "f0.MAQ_NUM, " +
                                               "f0.MAQ_NOM, " +
                                               "f0.MAQ_SEC, " +
                                               "SUM(HL.f_getMinsON_formatoFecha_Nintervalos(" + STRING_FECHA_INICIAL + ", " + STRING_FECHA_FINAL + ", " + STRING_HORARIO_INICIAL + ", " + STRING_HORARIO_FINAL + ", f0.FH_ENC, f0.FH_URE)) AS 'MINS_ON', " +
                                               "SUM(HL.f_getMinsON_formatoFecha_Nintervalos(" + STRING_FECHA_INICIAL + ", " + STRING_FECHA_FINAL + ", " + STRING_HORARIO_INICIAL + ", " + STRING_HORARIO_FINAL + ", f0.FH_ENC, f0.FH_URE)) / 60.0 AS 'HRS_ON' " +
                                        "FROM (" +
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
                                              ") AS f0 " +
                                        "GROUP BY f0.MAQ_ID, f0.MAQ_NUM, f0.MAQ_NOM, f0.MAQ_SEC " +
                                        "HAVING SUM(HL.f_getMinsON_formatoFecha_Nintervalos(" + STRING_FECHA_INICIAL + ", " + STRING_FECHA_FINAL + ", " + STRING_HORARIO_INICIAL + ", " + STRING_HORARIO_FINAL + ", f0.FH_ENC, f0.FH_URE)) > 0 " +
                                        "ORDER BY f0.MAQ_SEC, f0.MAQ_NUM";

            SqlDataAdapter da_c1_casoNintervalos = new SqlDataAdapter(c1_casoNintervalos, cn.LeerCadena());
            DataTable dt_c1_casoNintervalos = new DataTable();
            da_c1_casoNintervalos.Fill(dt_c1_casoNintervalos);
            return (dt_c1_casoNintervalos);
        }

        public DataTable casoNintervalos_mostrarCantidadDeHorasPorSector(string STRING_FECHA_INICIAL, string STRING_FECHA_FINAL, string STRING_HORARIO_INICIAL, string STRING_HORARIO_FINAL, string STRING_LISTA_idMaquina)
        {
            string c2_casoNintervalos = "SELECT f0.MAQ_SEC, " +
                                               "SUM(HL.f_getMinsON_formatoFecha_Nintervalos(" + STRING_FECHA_INICIAL + ", " + STRING_FECHA_FINAL + ", " + STRING_HORARIO_INICIAL + ", " + STRING_HORARIO_FINAL + ", f0.FH_ENC, f0.FH_URE)) AS 'MINS_ON', " +
                                               "SUM(HL.f_getMinsON_formatoFecha_Nintervalos(" + STRING_FECHA_INICIAL + ", " + STRING_FECHA_FINAL + ", " + STRING_HORARIO_INICIAL + ", " + STRING_HORARIO_FINAL + ", f0.FH_ENC, f0.FH_URE)) / 60.0 AS 'HRS_ON' " +
                                        "FROM (" +
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
                                              ") AS f0 " +
                                        "GROUP BY f0.MAQ_SEC " +
                                        "HAVING SUM(HL.f_getMinsON_formatoFecha_Nintervalos(" + STRING_FECHA_INICIAL + ", " + STRING_FECHA_FINAL + ", " + STRING_HORARIO_INICIAL + ", " + STRING_HORARIO_FINAL + ", f0.FH_ENC, f0.FH_URE)) > 0 " +
                                        "ORDER BY f0.MAQ_SEC";

            SqlDataAdapter da_c2_casoNintervalos = new SqlDataAdapter(c2_casoNintervalos, cn.LeerCadena());
            DataTable dt_c2_casoNintervalos = new DataTable();
            da_c2_casoNintervalos.Fill(dt_c2_casoNintervalos);
            return (dt_c2_casoNintervalos);
        }

        public DataTable casoNintervalos_mostrarCantidadDeHorasDeTodasLasMaquinas(string STRING_FECHA_INICIAL, string STRING_FECHA_FINAL, string STRING_HORARIO_INICIAL, string STRING_HORARIO_FINAL, string STRING_LISTA_idMaquina)
        {
            string c3_casoNintervalos = "SELECT SUM(HL.f_getMinsON_formatoFecha_Nintervalos(" + STRING_FECHA_INICIAL + ", " + STRING_FECHA_FINAL + ", " + STRING_HORARIO_INICIAL + ", " + STRING_HORARIO_FINAL + ", f0.FH_ENC, f0.FH_URE)) AS 'MINS_ON', " +
                                               "SUM(HL.f_getMinsON_formatoFecha_Nintervalos(" + STRING_FECHA_INICIAL + ", " + STRING_FECHA_FINAL + ", " + STRING_HORARIO_INICIAL + ", " + STRING_HORARIO_FINAL + ", f0.FH_ENC, f0.FH_URE)) / 60.0 AS 'HRS_ON' " +
                                        "FROM (" +
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
                                              ") AS f0";

            SqlDataAdapter da_c3_casoNintervalos = new SqlDataAdapter(c3_casoNintervalos, cn.LeerCadena());
            DataTable dt_c3_casoNintervalos = new DataTable();
            da_c3_casoNintervalos.Fill(dt_c3_casoNintervalos);
            return (dt_c3_casoNintervalos);
        }
    }
}
