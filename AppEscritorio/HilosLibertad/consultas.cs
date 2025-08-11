using System;
using System.Collections.Generic;
using System.Data;              // Necesario para el DataTable
using System.Data.SqlClient;    // Necesario para el SqlDataAdapter
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace HilosLibertad
{
    public class Consultas
    {
        // Creamos el objeto de la clase Conexion y la instanciamos
        Conexion cn = new Conexion();

        // 
        public DataTable limpiarTabla ()
        {
            DataTable dt = new DataTable();
            dt.Clear();
            return dt;
        }


        // UN ÚNICO INTERVALO · TIEMPOS POR MÁQUINA
        public DataTable llenarTabla_UnUnicoIntervalo_TiemposPorMaquina(string STRING_FECHAyHORARIO_INICIAL, string STRING_FECHAyHORARIO_FINAL, string STRING_MAQUINA_NUMERO, string STRING_MAQUINA_NOMBRE, string STRING_SECTOR_NOMBRE)
        {
            string c1_casoUnicoIntervalo = "EXECUTE HL.sp_mostrarTiemposPorMaquina_1intervalo " + 
                                                            STRING_FECHAyHORARIO_INICIAL + ", " + 
                                                            STRING_FECHAyHORARIO_FINAL + ", " +
                                                            "'" + STRING_MAQUINA_NUMERO + "' , " +
                                                            "'" + STRING_MAQUINA_NOMBRE + "' , " +
                                                            "'" + STRING_SECTOR_NOMBRE + "'";
            SqlDataAdapter da = new SqlDataAdapter(c1_casoUnicoIntervalo, cn.LeerCadena());
            DataTable dt = new DataTable();
            da.Fill(dt);
            return dt;
        }

        // UN ÚNICO INTERVALO · TIEMPOS POR SECTOR
        public DataTable llenarTabla_UnUnicoIntervalo_TiemposPorSector(string STRING_FECHAyHORARIO_INICIAL, string STRING_FECHAyHORARIO_FINAL, string STRING_MAQUINA_NUMERO, string STRING_MAQUINA_NOMBRE, string STRING_SECTOR_NOMBRE)
        {
            string c2_casoUnicoIntervalo = "EXECUTE HL.sp_mostrarTiemposPorSector_1intervalo " +
                                                            STRING_FECHAyHORARIO_INICIAL + ", " +
                                                            STRING_FECHAyHORARIO_FINAL + ", " +
                                                            "'" + STRING_MAQUINA_NUMERO + "' , " +
                                                            "'" + STRING_MAQUINA_NOMBRE + "' , " +
                                                            "'" + STRING_SECTOR_NOMBRE + "'";

            SqlDataAdapter da = new SqlDataAdapter(c2_casoUnicoIntervalo, cn.LeerCadena());
            DataTable dt = new DataTable();
            da.Fill(dt);
            return dt;
        }

        // UN ÚNICO INTERVALO · TIEMPOS TOTALES
        public DataTable llenarTabla_UnUnicoIntervalo_TiemposTotales(string STRING_FECHAyHORARIO_INICIAL, string STRING_FECHAyHORARIO_FINAL, string STRING_MAQUINA_NUMERO, string STRING_MAQUINA_NOMBRE, string STRING_SECTOR_NOMBRE)
        {
            string c3_casoUnicoIntervalo = "EXECUTE HL.sp_mostrarTiemposTotales_1intervalo " +
                                                            STRING_FECHAyHORARIO_INICIAL + ", " +
                                                            STRING_FECHAyHORARIO_FINAL + ", " +
                                                            "'" + STRING_MAQUINA_NUMERO + "' , " +
                                                            "'" + STRING_MAQUINA_NOMBRE + "' , " +
                                                            "'" + STRING_SECTOR_NOMBRE + "'";

            SqlDataAdapter da = new SqlDataAdapter(c3_casoUnicoIntervalo, cn.LeerCadena());
            DataTable dt = new DataTable();
            da.Fill(dt);
            return dt;
        }

        // N INTERVALOS · TIEMPOS POR MÁQUINA
        public DataTable llenarTabla_Nintervalos_TiemposPorMaquina (string STRING_FECHA_INICIAL, string STRING_FECHA_FINAL, string STRING_HORARIO_INICIAL, string STRING_HORARIO_FINAL, string STRING_MAQUINA_NUMERO, string STRING_MAQUINA_NOMBRE, string STRING_SECTOR_NOMBRE)
        {
            string c1_casoNintervalos = "EXECUTE HL.sp_mostrarTiemposPorMaquina_Nintervalos " +
                                                            STRING_FECHA_INICIAL + ", " +
                                                            STRING_FECHA_FINAL + ", " +
                                                            STRING_HORARIO_INICIAL + ", " +
                                                            STRING_HORARIO_FINAL + ", " +
                                                            "'" + STRING_MAQUINA_NUMERO + "' , " +
                                                            "'" + STRING_MAQUINA_NOMBRE + "' , " +
                                                            "'" + STRING_SECTOR_NOMBRE + "'";
            SqlDataAdapter da = new SqlDataAdapter(c1_casoNintervalos, cn.LeerCadena());
            DataTable dt = new DataTable();
            da.Fill(dt);
            return dt;
        }

        // N INTERVALOS · TIEMPOS POR SECTOR
        public DataTable llenarTabla_Nintervalos_TiemposPorSector(string STRING_FECHA_INICIAL, string STRING_FECHA_FINAL, string STRING_HORARIO_INICIAL, string STRING_HORARIO_FINAL, string STRING_MAQUINA_NUMERO, string STRING_MAQUINA_NOMBRE, string STRING_SECTOR_NOMBRE)
        {
            string c2_casoNintervalos = "EXECUTE HL.sp_mostrarTiemposPorSector_Nintervalos " +
                                                            STRING_FECHA_INICIAL + ", " +
                                                            STRING_FECHA_FINAL + ", " +
                                                            STRING_HORARIO_INICIAL + ", " +
                                                            STRING_HORARIO_FINAL + ", " +
                                                            "'" + STRING_MAQUINA_NUMERO + "' , " +
                                                            "'" + STRING_MAQUINA_NOMBRE + "' , " +
                                                            "'" + STRING_SECTOR_NOMBRE + "'";
            SqlDataAdapter da = new SqlDataAdapter(c2_casoNintervalos, cn.LeerCadena());
            DataTable dt = new DataTable();
            da.Fill(dt);
            return dt;
        }

        // N INTERVALOS · TIEMPOS TOTALES
        public DataTable llenarTabla_Nintervalos_TiemposTotales(string STRING_FECHA_INICIAL, string STRING_FECHA_FINAL, string STRING_HORARIO_INICIAL, string STRING_HORARIO_FINAL, string STRING_MAQUINA_NUMERO, string STRING_MAQUINA_NOMBRE, string STRING_SECTOR_NOMBRE)
        {
            string c3_casoNintervalos = "EXECUTE HL.sp_mostrarTiemposTotales_Nintervalos " +
                                                            STRING_FECHA_INICIAL + ", " +
                                                            STRING_FECHA_FINAL + ", " +
                                                            STRING_HORARIO_INICIAL + ", " +
                                                            STRING_HORARIO_FINAL + ", " +
                                                            "'" + STRING_MAQUINA_NUMERO + "' , " +
                                                            "'" + STRING_MAQUINA_NOMBRE + "' , " +
                                                            "'" + STRING_SECTOR_NOMBRE + "'";
            SqlDataAdapter da = new SqlDataAdapter(c3_casoNintervalos, cn.LeerCadena());
            DataTable dt = new DataTable();
            da.Fill(dt);
            //
            return dt;
        }


        // Llena el label con el tiempo total seleccionado
        // CREAR QUERY PARA CARGAR EL TIEMPO TOTAL SELECCIONADO
        // string consulta = "SELECT HL.";




        // Llena el DataGridView con los Sectores (solamente el nombre)
        public DataTable llenarDataGridView_Sectores() {
            string consulta = "EXECUTE HL.sp_llenarDGVsectores";
            SqlDataAdapter da = new SqlDataAdapter(consulta, cn.LeerCadena());
            DataTable dt = new DataTable();
            da.Fill(dt);
            return dt;
        }

        // Llena el DataGridView con las Máquinas (número, nombre y descripción)
        public DataTable llenarDataGridView_Maquinas()
        {
            string consulta = "EXECUTE HL.sp_llenarDGVmaquinas";
            SqlDataAdapter da = new SqlDataAdapter(consulta, cn.LeerCadena());
            DataTable dt = new DataTable();
            da.Fill(dt);
            return dt;
        }


        // Llena el ComboBox de los Sectores para su selección y posterior modificación
        public DataTable llenarComboBox_Sectores()
        {
            string consulta = "EXECUTE HL.sp_llenarCMBsectores";
            //string consulta = "SELECT s.idSector, s.nombreSectorUSUARIO FROM HL.sectores s ORDER BY s.idSector";
            SqlDataAdapter da = new SqlDataAdapter(consulta, cn.LeerCadena());
            DataTable dt = new DataTable();
            da.Fill(dt);
            return dt;
        }


        public DataTable llenarComboBox_Maquinas()
        {
            string consulta = "EXECUTE HL.sp_llenarCMBmaquinas";
            SqlDataAdapter da = new SqlDataAdapter(consulta, cn.LeerCadena());
            DataTable dt = new DataTable();
            da.Fill(dt);
            return dt;
        }




        public void llenarTextBox_Sectores(ComboBox cmb, TextBox txt_id, TextBox txt_nombre)
        {
            string consulta = "SELECT idSector, nombreSectorUSUARIO FROM HL.sectores WHERE nombreSectorUSUARIO = '" + cmb.SelectedItem.ToString() + "'";
            SqlDataAdapter da = new SqlDataAdapter(consulta, cn.LeerCadena());
            DataTable dt = new DataTable();
            da.Fill(dt);

            foreach (DataRow dr in dt.Rows)
            {
                txt_id.Text = dr["idSector"].ToString();
                txt_nombre.Text = dr["nombreSectorUSUARIO"].ToString();
            }

        }

    }
}
