using System;
using System.ComponentModel;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace HilosLibertad
{
    public partial class frm_Home : Form
    {
        public frm_Home()
        {
            InitializeComponent();
        }

        Consultas con = new Consultas();
        // Creamos el objeto de la clase Conexion y la instanciamos
        Conexion cn = new Conexion();

        public bool yaSeSetearonInicialmenteLasFechasYFranjasHorarias = false;

        private void FormularioPrincipal_Load(object sender, EventArgs e)
        {
            // Carga inicial de fechas: desde hoy a las 00:00 hasta mañana a las 00:00 (24 horas de duración)
            dtp_FechaInicial.Value = DateTime.Today;
            dtp_FechaFinal.Value = DateTime.Today.AddDays(1);
            cmb_HoraInicial.SelectedIndex = 0;
            cmb_MinutoInicial.SelectedIndex = 0;
            cmb_HoraFinal.SelectedIndex = 00;
            cmb_MinutoFinal.SelectedIndex = 0;
            yaSeSetearonInicialmenteLasFechasYFranjasHorarias = true;

            dgv_TiemposPorMaquina.ClipboardCopyMode = DataGridViewClipboardCopyMode.EnableAlwaysIncludeHeaderText;
            dgv_TiemposPorSector.ClipboardCopyMode = DataGridViewClipboardCopyMode.EnableWithAutoHeaderText;
            dgv_TiemposTotales.ClipboardCopyMode = DataGridViewClipboardCopyMode.EnableWithoutHeaderText;

            actualizarTablas();
        }



        // Ante un cambio en cualquier fecha (cualquiera de los 2 DateTimePicker), se da orden de "ejecutar"
        private void dtp_FechaInicial_ValueChanged(object sender, EventArgs e)
        {
            ejecutar();
        }

        private void dtp_FechaFinal_ValueChanged(object sender, EventArgs e)
        {
            ejecutar();
        }


        // Ante un cambio en cualquier horario o franja horaria (cualquiera de los 4 ComboBox), se da orden de "ejecutar"
        private void cmb_HoraInicial_SelectedIndexChanged(object sender, EventArgs e)
        {
            ejecutar();
        }

        private void cmb_MinutoInicial_SelectedIndexChanged(object sender, EventArgs e)
        {
            ejecutar();
        }

        private void cmb_HoraFinal_SelectedIndexChanged(object sender, EventArgs e)
        {
            ejecutar();
        }

        private void cmb_MinutoFinal_SelectedIndexChanged(object sender, EventArgs e)
        {
            ejecutar();
        }


        // Ante un cambio en cualquier filtro por máquina y/o sector (cualquiera de los 3 TextBox), se da orden de "ejecutar"
        private void txt_NumeroDeLaMaquina_TextChanged(object sender, EventArgs e)
        {
            ejecutar();
        }

        private void txt_NombreDeLaMaquina_TextChanged(object sender, EventArgs e)
        {
            ejecutar();
        }

        private void txt_NombreDelSector_TextChanged(object sender, EventArgs e)
        {
            ejecutar();
        }


        /*/ Lo que hace "Ejecutar" depende de si ya fueron seteadas inicialmente las fechas y franjas horarias:
         *      - si ya fueron setearon, se da orden de actualizar las tablas.
         *      - si aún no fueron seteadas, no se hace nada.
         */
        private void ejecutar()
        {
            if (yaSeSetearonInicialmenteLasFechasYFranjasHorarias)
            {
                //cambiarColoresAElementosSiEsNecesario();
                actualizarTablas();
            }
        }















        private void actualizarTablas()
        {
            int int_YYYYMMDD_INI = getYYYYMMDDentero_fromDtp(dtp_FechaInicial);
            int int_YYYYMMDD_FIN = getYYYYMMDDentero_fromDtp(dtp_FechaFinal);
            int int_HHMM_INI = getHHMMentero_from2Cmb(cmb_HoraInicial, cmb_MinutoInicial);
            int int_HHMM_FIN = getHHMMentero_from2Cmb(cmb_HoraFinal, cmb_MinutoFinal);
            string str_FyH_INI = "'" + getStringYYYYMMDDHHMMfromdtp2cmb(dtp_FechaInicial, cmb_HoraInicial, cmb_MinutoInicial) + "'";
            string str_FyH_FIN = "'" + getStringYYYYMMDDHHMMfromdtp2cmb(dtp_FechaFinal, cmb_HoraFinal, cmb_MinutoFinal) + "'";
            string str_F_INI = getStringFromDTPconFormato(dtp_FechaInicial, "yyyy-MM-dd");
            string str_F_FIN = getStringFromDTPconFormato(dtp_FechaFinal, "yyyy-MM-dd");
            string str_H_INI = getStringFrom2CMB(cmb_HoraInicial, cmb_MinutoInicial);
            string str_H_FIN = getStringFrom2CMB(cmb_HoraFinal, cmb_MinutoFinal);

            string str_FILTRO_NOMBRE_MAQUINA = txt_NombreDeLaMaquina.Text;
            string str_FILTRO_NUMERO_MAQUINA = txt_NumeroDeLaMaquina.Text;
            string str_FILTRO_NOMBRE_SECTOR = txt_NombreDelSector.Text;

            bool LAS_FECHAS_SON_IGUALES = int_YYYYMMDD_INI == int_YYYYMMDD_FIN;
            bool ENTRE_LAS_FECHAS_HAY_UN_UNICO_DIA_DE_DIFERENCIA = (int_YYYYMMDD_FIN - int_YYYYMMDD_INI == 1);
            bool LOS_HORARIOS_SON_IGUALES = int_HHMM_FIN == int_HHMM_INI;
            bool EL_HORARIO_FINAL_ES_ANTERIOR_AL_HORARIO_INICIAL = int_HHMM_FIN < int_HHMM_INI;
            bool EL_HORARIO_FINAL_ES_POSTERIOR_AL_HORARIO_INICIAL = int_HHMM_FIN > int_HHMM_INI;
            bool LA_FECHA_FINAL_ES_POSTERIOR_A_LA_FECHA_INICIAL = int_YYYYMMDD_FIN > int_YYYYMMDD_INI;

            

            if (LAS_FECHAS_SON_IGUALES)
            {
                if (LOS_HORARIOS_SON_IGUALES || EL_HORARIO_FINAL_ES_ANTERIOR_AL_HORARIO_INICIAL)
                {
                    // FRANJA HORARIA NO VÁLIDA: CUANDO LAS FECHAS INICIAL Y FINAL SON IGUALES, EL HORARIO FINAL DEBE SER POSTERIOR AL HORARIO INICIAL
                    pintarObjetosDeHorariosDeColor(Color.Crimson);
                    pintarObjetosDeFechasDeColor(Color.Black);
                    limpiarTablas();
                }
                else
                {
                    pintarTodosLosObjetosDeColor(Color.Black);
                    llenarTablas_casoVERDE(str_FyH_INI, str_FyH_FIN, str_FILTRO_NUMERO_MAQUINA, str_FILTRO_NOMBRE_MAQUINA, str_FILTRO_NOMBRE_SECTOR);
                    dgv_TiemposPorMaquina.Sort(dgv_TiemposPorMaquina.Columns["SECTOR"], ListSortDirection.Ascending); 
                    acomodarFormatoDGVs();
                }
            }
            else
            {
                if (LA_FECHA_FINAL_ES_POSTERIOR_A_LA_FECHA_INICIAL)
                {
                    if (LOS_HORARIOS_SON_IGUALES)
                    {
                        pintarTodosLosObjetosDeColor(Color.Black); 
                        llenarTablas_casoVERDE(str_FyH_INI, str_FyH_FIN, str_FILTRO_NUMERO_MAQUINA, str_FILTRO_NOMBRE_MAQUINA, str_FILTRO_NOMBRE_SECTOR);
                        dgv_TiemposPorMaquina.Sort(dgv_TiemposPorMaquina.Columns["SECTOR"], ListSortDirection.Ascending); 
                        acomodarFormatoDGVs();                        
                    }
                    else
                    {
                        if (EL_HORARIO_FINAL_ES_POSTERIOR_AL_HORARIO_INICIAL)
                        {
                            pintarTodosLosObjetosDeColor(Color.Black);
                            llenarTablas_casoAZUL(str_F_INI, str_F_FIN, str_H_INI, str_H_FIN, str_FILTRO_NUMERO_MAQUINA, str_FILTRO_NOMBRE_MAQUINA, str_FILTRO_NOMBRE_SECTOR);
                            dgv_TiemposPorMaquina.Sort(dgv_TiemposPorMaquina.Columns["SECTOR"], ListSortDirection.Ascending); 
                            acomodarFormatoDGVs();                            
                        }
                        else
                        {
                            if (ENTRE_LAS_FECHAS_HAY_UN_UNICO_DIA_DE_DIFERENCIA)
                            {
                                pintarTodosLosObjetosDeColor(Color.Black);
                                llenarTablas_casoVERDE(str_FyH_INI, str_FyH_FIN, str_FILTRO_NUMERO_MAQUINA, str_FILTRO_NOMBRE_MAQUINA, str_FILTRO_NOMBRE_SECTOR);
                                dgv_TiemposPorMaquina.Sort(dgv_TiemposPorMaquina.Columns["SECTOR"], ListSortDirection.Ascending); 
                                acomodarFormatoDGVs();
                            }
                            else
                            {
                                pintarTodosLosObjetosDeColor(Color.Black);
                                llenarTablas_casoAZUL(str_F_INI, str_F_FIN, str_H_INI, str_H_FIN, str_FILTRO_NUMERO_MAQUINA, str_FILTRO_NOMBRE_MAQUINA, str_FILTRO_NOMBRE_SECTOR);
                                dgv_TiemposPorMaquina.Sort(dgv_TiemposPorMaquina.Columns["SECTOR"], ListSortDirection.Ascending); 
                                acomodarFormatoDGVs();
                            }
                        }
                    }
                }
                else
                {
                    // FECHAS NO VÁLIDAS: LA FECHA FINAL DEBE SER POSTERIOR A LA FECHA INICIAL
                    pintarObjetosDeFechasDeColor(Color.Crimson);
                    pintarObjetosDeHorariosDeColor(Color.Black);
                    limpiarTablas();
                }
            }
        }


        private void pintarObjetosDeFechasDeColor(Color c)      // Red o ControlText, por ejemplo
        {
            grp_FiltroFecha.ForeColor = c;
            lbl_FechaInicial.ForeColor = c;
            lbl_FechaFinal.ForeColor = c;
        }
        private void pintarObjetosDeHorariosDeColor(Color c)      // Red o ControlText, por ejemplo
        {
            grp_FiltroFranjaHoraria.ForeColor = c;
            lbl_HorarioInicial.ForeColor = c;
            lbl_HorarioFinal.ForeColor = c;
        }

        private void pintarTodosLosObjetosDeColor(Color c)    //Red o ControlText, por ejemplo
        {
            pintarObjetosDeFechasDeColor(c);
            pintarObjetosDeHorariosDeColor(c);
        }












        // Se acomoda el formato de los DataGridView para su correcta disposición
        public void acomodarFormatoDGVs() {
            dgv_TiemposPorMaquina.Columns["#"].DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight;
            dgv_TiemposPorMaquina.Columns["TIEMPO ENCENDIDA"].DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight;
            //dgv_TiemposPorMaquina.Columns["% APAGADA"].DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight;
            dgv_TiemposPorMaquina.Columns["% ENCENDIDA"].DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight;
            dgv_TiemposPorMaquina.AutoResizeColumns();
            dgv_TiemposPorMaquina.ClearSelection();
            cambiarColorDGVMaq(dgv_TiemposPorMaquina);

            dgv_TiemposPorSector.Columns["TIEMPO ENCENDIDO"].DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight;
            dgv_TiemposPorSector.AutoResizeColumns();
            dgv_TiemposPorSector.ClearSelection();

            dgv_TiemposTotales.Columns["TIEMPO ENCENDIDAS"].DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight;
            dgv_TiemposTotales.AutoResizeColumns();
            dgv_TiemposTotales.ClearSelection();
        }




        // Se llenan los tres DataGridView de acuerdo al caso VERDE (ver cuadro)
        public void llenarTablas_casoVERDE(string S_FyH_INI, string S_FyH_FIN, string S_MAQ_NUMERO, string S_MAQ_NOMBRE, string S_SEC_NOMBRE)
        {
            Consultas con = new Consultas();
            dgv_TiemposPorMaquina.DataSource = con.llenarTabla_UnUnicoIntervalo_TiemposPorMaquina(S_FyH_INI, S_FyH_FIN, S_MAQ_NUMERO, S_MAQ_NOMBRE, S_SEC_NOMBRE);
            dgv_TiemposPorSector.DataSource = con.llenarTabla_UnUnicoIntervalo_TiemposPorSector(S_FyH_INI, S_FyH_FIN, S_MAQ_NUMERO, S_MAQ_NOMBRE, S_SEC_NOMBRE);
            dgv_TiemposTotales.DataSource = con.llenarTabla_UnUnicoIntervalo_TiemposTotales(S_FyH_INI, S_FyH_FIN, S_MAQ_NUMERO, S_MAQ_NOMBRE, S_SEC_NOMBRE);
        }

        // Se llenan los tres DataGridView de acuerdo al caso AZUL (ver cuadro)
        public void llenarTablas_casoAZUL(string S_F_INI, string S_F_FIN, string S_H_INI, string S_H_FIN, string S_MAQ_NUMERO, string S_MAQ_NOMBRE, string S_SEC_NOMBRE)
        {
            Consultas con = new Consultas();
            dgv_TiemposPorMaquina.DataSource = con.llenarTabla_Nintervalos_TiemposPorMaquina(S_F_INI, S_F_FIN, S_H_INI, S_H_FIN, S_MAQ_NUMERO, S_MAQ_NOMBRE, S_SEC_NOMBRE);
            dgv_TiemposPorSector.DataSource = con.llenarTabla_Nintervalos_TiemposPorSector(S_F_INI, S_F_FIN, S_H_INI, S_H_FIN, S_MAQ_NUMERO, S_MAQ_NOMBRE, S_SEC_NOMBRE);
            dgv_TiemposTotales.DataSource = con.llenarTabla_Nintervalos_TiemposTotales(S_F_INI, S_F_FIN, S_H_INI, S_H_FIN, S_MAQ_NUMERO, S_MAQ_NOMBRE, S_SEC_NOMBRE);
        }

        // Se deja de mostrar el contenido de las tablas
        public void limpiarTablas()
        {
            Consultas con = new Consultas();
            dgv_TiemposPorMaquina.DataSource = con.limpiarTabla();
            dgv_TiemposPorSector.DataSource = con.limpiarTabla();
            dgv_TiemposTotales.DataSource = con.limpiarTabla();
        }


        // Dado un DateTimePicker, devuelve la fecha YYYYMMDD en formato int
        public int getYYYYMMDDentero_fromDtp(DateTimePicker dtp)
        {
            int YYYYMMDD = dtp.Value.Year * 10000 + dtp.Value.Month * 100 + dtp.Value.Day;
            return YYYYMMDD;
        }

        // Dados dos ComboBox, devuelve el horario HHMM en formato int
        public int getHHMMentero_from2Cmb(ComboBox cmb_h, ComboBox cmb_m)
        {
            int HHMM = Convert.ToInt32(cmb_h.Text) * 100 + Convert.ToInt32(cmb_m.Text);
            return HHMM;
        }

        // Dados un DateTimePicker y dos ComboBox, devuelve el string de la fecha y el horario "YYYY-DD-MM HH:MM:00"
        public string getStringYYYYMMDDHHMMfromdtp2cmb(DateTimePicker dtp, ComboBox cmb_h , ComboBox cmb_m)   
        {
            string YYYYDDMM = getStringYYYYDDMMfromdtp(dtp);
            string HHMM00 = getStringHHMMfrom2cmb(cmb_h, cmb_m);
            string YYYYMMDD_HHMM00 = YYYYDDMM + " " + HHMM00;
            return YYYYMMDD_HHMM00;
        }
                
        // Dado un DateTimePicker, devuelve el string de la fecha "YYYY-DD-MM"
        public string getStringYYYYDDMMfromdtp(DateTimePicker dtp)    
        {
            string YYYY = dtp.Value.Year.ToString();
            int MM_int = dtp.Value.Month;
            int DD_int = dtp.Value.Day;

            // Fuerzo el doble dígito en Mes y Día
            string MM = (MM_int >= 10) ? (MM_int.ToString()) : ("0" + MM_int.ToString());
            string DD = (DD_int >= 10) ? (DD_int.ToString()) : ("0" + DD_int.ToString());

            // Formo el string completo con el formato "YYYY-DD-MM"
            string YYYYMMDD = YYYY + "-" + DD + "-" + MM;

            return YYYYMMDD;      // "2021-23-09" ejemplo

            
        }

        // Dado un DateTimePicker, devuelve el string del horario "HH:MM:00"
        public string getStringHHMMfrom2cmb(ComboBox cmb_horas, ComboBox cmb_minutos)   
        {
            string HORAS_INT = cmb_horas.Text;
            string MINUTOS_INT = cmb_minutos.Text;

            // Fuerzo el doble dígito en Hora y Minuto
            string HH = (Convert.ToInt32(HORAS_INT) >= 10) ? HORAS_INT : ("0" + HORAS_INT);
            //string MM = (Convert.ToInt32(MINUTOS_INT) >= 10) ? MINUTOS_INT : ("0" + MINUTOS_INT); //innecesario, ya viene con 2 dígitos.
            string MM = MINUTOS_INT;

            // Formo el string completo con el formato "HH:MM:00"
            string HHMM00 = HH + ":" + MM + ":00";

            return HHMM00;
        }
        
        // Dado un DateTimePicker y un formato en particular (string), devuelve la fecha del DateTimePicker de acuerdo al formato recibido (el cual puede ser, por ejemplo, "yyyy-dd-MM" o "yyyy-MM-dd")
        public string getStringFromDTPconFormato(DateTimePicker dtp, string formato)
        {
            return "'" + dtp.Value.ToString(formato) + "'";
        }

        // Dados dos ComboBox, devuelve el string del horario "'HH:MM'"
        public string getStringFrom2CMB(ComboBox cmb_h, ComboBox cmb_m)
        {
            string HH;
            if (Convert.ToInt32(cmb_h.SelectedItem) >= 0 && Convert.ToInt32(cmb_h.SelectedItem) <= 9) {
                HH = "0" + cmb_h.SelectedItem.ToString();
            }
            else {
                HH = cmb_h.SelectedItem.ToString();
            }
            
            string MM = cmb_m.SelectedItem.ToString();
            return "'" + HH + ":" + MM + "'";
        }


        // Funciones para copiar al portapapeles todo el contenido de cada tabla, incluyendo encabezados
        private void btn_CopiarAlPortapapeles_TiemposPorMaquina_Click(object sender, EventArgs e)
        {
            dgv_TiemposPorMaquina.SelectAll();
            copiarAlPortapapeles(dgv_TiemposPorMaquina);
            dgv_TiemposPorMaquina.ClearSelection();
        }
        
        private void btn_CopiarAlPortapapeles_TiemposPorSector_Click(object sender, EventArgs e)
        {
            dgv_TiemposPorSector.SelectAll();
            copiarAlPortapapeles(dgv_TiemposPorSector);
            dgv_TiemposPorSector.ClearSelection();
        }

        private void btn_CopiarAlPortapapeles_TiemposDeTodasLasMaquinas_Click(object sender, EventArgs e)
        {
            dgv_TiemposTotales.SelectAll();
            copiarAlPortapapeles(dgv_TiemposTotales);
            dgv_TiemposTotales.ClearSelection();
        }

        // Función para copiar al portapapeles todo el contenido de un DataGridView
        private void copiarAlPortapapeles(DataGridView dgv)
        {
            dgv.ClipboardCopyMode = DataGridViewClipboardCopyMode.EnableAlwaysIncludeHeaderText;
            DataObject dataObj = dgv.GetClipboardContent();
            if (dataObj != null)
                Clipboard.SetDataObject(dataObj);
        }


        // Mostrar otros formularios
        private void editarSectoresToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frm_EdicionDeSectores frm_eS = new frm_EdicionDeSectores();
            frm_eS.Show();
        }

        private void editarMáquinasToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frm_EdicionDeMaquinas frm_eM = new frm_EdicionDeMaquinas();
            frm_eM.Show();
        }

        private void lbl_CantidadTotalHorasMaquina_Click(object sender, EventArgs e)
        {

        }

        private void btn_CopiarAlPortapapeles_TiemposMaqSec_Click(object sender, EventArgs e)
        {
            /*
            IDataObject clips = new DataObject();
            clips.SetData(dgv_TiemposPorMaquina.GetClipboardContent());
            clips.SetData(dgv_TiemposPorSector.GetClipboardContent());
            //clips.SetData(DataFormats.Text, dgv_TiemposPorMaquina);
            //clips.SetData(DataFormats.Rtf, dgv_TiemposPorSector);
            Clipboard.SetDataObject(clips, true);
            */


            /*
            dgv.ClipboardCopyMode = DataGridViewClipboardCopyMode.EnableAlwaysIncludeHeaderText;
            DataObject dataObj = dgv.GetClipboardContent();
            if (dataObj != null)
                Clipboard.SetDataObject(dataObj);
            */


            /*
            IDataObject clips = new DataObject();
            clips.SetData(DataFormats.Text, MyString);
            clips.SetData(DataFormats.Rtf, MyRtf);
            Clipboard.SetDataObject(clips, true);
            */

        }

        // Se cambian los colores de las filas del DataGridView de las máquinas.
        // El criterio es el tiempo transcurrido en minutos desde el último registro de encendido.
        // Si ese lapso es menor o igual a 5 minutos, entonces la fila se pinta de verde.
        // Si ese lapso es mayor a 5 minutos, entonces la fila se pinta de rojo.
        public void cambiarColorDGVMaq(DataGridView dgv)
        {
            int cantFilas = dgv.Rows.Count;       // cantidad de filas del dataGridView
            for (int i = 0; i < cantFilas; i++)
            {
                int mins = getMinsONtilNow_NumMaq(i + 1);

                if (mins <= 5)  // "Cells[0]" --> la primera columna
                {
                    dgv.Rows[i].DefaultCellStyle.BackColor = Color.FromArgb(185, 248, 218);   // fondo verde claro
                    dgv.Rows[i].DefaultCellStyle.ForeColor = Color.FromArgb(11, 117, 66);     // texto verde oscuro
                }
                else
                {
                    dgv.Rows[i].DefaultCellStyle.BackColor = Color.FromArgb(247, 215, 212);   // fondo rojo claro
                    dgv.Rows[i].DefaultCellStyle.ForeColor = Color.FromArgb(194, 49, 36);     // texto rojo oscuro
                }
            }
        }

        // Se crea nueva función para obtener la cantidad de minutos...
        public int getMinsONtilNow_NumMaq(int numMaq)
        {
            string cons = "SELECT HL.f_getMinsONSinceLastReg(" + numMaq + ") AS 'mm'";
            SqlConnection sql_con = cn.LeerCadena();
            SqlCommand comm = new SqlCommand(cons, sql_con);
            SqlDataReader dr = comm.ExecuteReader();
            int w = 0;
            if (dr.Read())
            {
                w = int.Parse(dr["mm"].ToString());
            }
            cn.cerrarConexion(sql_con);
            return w;
        }

        private void dgv_TiemposPorMaquina_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void dgv_TiemposPorMaquina_Sorted(object sender, EventArgs e)
        {
            cambiarColorDGVMaq(dgv_TiemposPorMaquina);
        }
    }
}
