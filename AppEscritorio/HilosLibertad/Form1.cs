using System;
using System.Drawing;
using System.Windows.Forms;

namespace HilosLibertad
{
    public partial class frm_Home : Form
    {
        public frm_Home()
        {
            InitializeComponent();
        }

        
        private void FormularioPrincipal_Load(object sender, EventArgs e)
        {
            // Carga inicial de fechas: desde hoy a las 00:00 hasta mañana a las 00:00 (24 horas de duración)
            dtp_FechaInicial.Value = DateTime.Today;
            dtp_FechaFinal.Value = DateTime.Today.AddDays(1);
            cmb_HoraInicial.SelectedIndex = 0;
            cmb_MinutoInicial.SelectedIndex = 0;
            cmb_HoraFinal.SelectedIndex = 00;
            cmb_MinutoFinal.SelectedIndex = 0;

            // Carga inicial de máquinas: todas las máquinas
            setCheckButtons("todos", true);

            dgv_TiemposPorMaquina.ClipboardCopyMode = DataGridViewClipboardCopyMode.EnableAlwaysIncludeHeaderText;
            dgv_TiemposPorSector.ClipboardCopyMode = DataGridViewClipboardCopyMode.EnableWithAutoHeaderText;
            dgv_TiemposTotales.ClipboardCopyMode = DataGridViewClipboardCopyMode.EnableWithoutHeaderText;

        }


        private void btn_Mostrar_Click(object sender, EventArgs e) 
        {
            int int_YYYYMMDD_INI = getYYYYMMDDentero_fromDtp(dtp_FechaInicial);
            int int_YYYYMMDD_FIN = getYYYYMMDDentero_fromDtp(dtp_FechaFinal);
            int int_HHMM_INI = getHHMMentero_from2Cmb(cmb_HoraInicial, cmb_MinutoInicial);
            int int_HHMM_FIN = getHHMMentero_from2Cmb(cmb_HoraFinal, cmb_MinutoFinal);
            string str_LISTA_IDMAQUINAS = getStringFiltroMaquinas();
            string str_FyH_INI = "'" + getStringYYYYMMDDHHMMfromdtp2cmb(dtp_FechaInicial, cmb_HoraInicial, cmb_MinutoInicial) + "'";
            string str_FyH_FIN = "'" + getStringYYYYMMDDHHMMfromdtp2cmb(dtp_FechaFinal, cmb_HoraFinal, cmb_MinutoFinal) + "'";
            string str_F_INI = getStringFromDTPconFormato(dtp_FechaInicial, "yyyy-MM-dd");
            string str_F_FIN = getStringFromDTPconFormato(dtp_FechaFinal, "yyyy-MM-dd");
            string str_H_INI = getStringFrom2CMB(cmb_HoraInicial, cmb_MinutoInicial);
            string str_H_FIN = getStringFrom2CMB(cmb_HoraFinal, cmb_MinutoFinal);
                        
            bool LAS_FECHAS_SON_IGUALES = int_YYYYMMDD_INI == int_YYYYMMDD_FIN;
            bool ENTRE_LAS_FECHAS_HAY_UN_UNICO_DIA_DE_DIFERENCIA = (int_YYYYMMDD_FIN - int_YYYYMMDD_INI == 1);
            bool LOS_HORARIOS_SON_IGUALES = int_HHMM_FIN == int_HHMM_INI;
            bool EL_HORARIO_FINAL_ES_ANTERIOR_AL_HORARIO_INICIAL = int_HHMM_FIN < int_HHMM_INI;
            bool EL_HORARIO_FINAL_ES_POSTERIOR_AL_HORARIO_INICIAL = int_HHMM_FIN > int_HHMM_INI;
            bool LA_FECHA_FINAL_ES_POSTERIOR_A_LA_FECHA_INICIAL = int_YYYYMMDD_FIN > int_YYYYMMDD_INI;

            if (LAS_FECHAS_SON_IGUALES) {
                if (LOS_HORARIOS_SON_IGUALES || EL_HORARIO_FINAL_ES_ANTERIOR_AL_HORARIO_INICIAL) {
                    MessageBox.Show("Cuando las fechas inicial y final son iguales, el horario final debe ser posterior al horario inicial.\n", "Inconsistencia en la franja horaria", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    limpiarTablas();
                }
                else {
                    llenarTablas_casoVERDE(str_FyH_INI, str_FyH_FIN, str_LISTA_IDMAQUINAS);
                    acomodarFormatoDGVs();
                }
            }
            else {
                if (LA_FECHA_FINAL_ES_POSTERIOR_A_LA_FECHA_INICIAL) {
                    if (LOS_HORARIOS_SON_IGUALES) {
                        llenarTablas_casoVERDE(str_FyH_INI, str_FyH_FIN, str_LISTA_IDMAQUINAS);
                        acomodarFormatoDGVs();
                    }
                    else
                    {
                        if (EL_HORARIO_FINAL_ES_POSTERIOR_AL_HORARIO_INICIAL) {
                            llenarTablas_casoAZUL(str_F_INI, str_F_FIN, str_H_INI, str_H_FIN, str_LISTA_IDMAQUINAS);
                            acomodarFormatoDGVs();
                        }
                        else {
                            if (ENTRE_LAS_FECHAS_HAY_UN_UNICO_DIA_DE_DIFERENCIA) {
                                llenarTablas_casoVERDE(str_FyH_INI, str_FyH_FIN, str_LISTA_IDMAQUINAS);
                                acomodarFormatoDGVs();
                            }
                            else {
                                llenarTablas_casoAZUL(str_F_INI, str_F_FIN, str_H_INI, str_H_FIN, str_LISTA_IDMAQUINAS);
                                acomodarFormatoDGVs();
                            }
                        }
                    }
                }
                else {
                    MessageBox.Show("La fecha final debe ser posterior a la fecha inicial.\n", "Inconsistencia de fechas", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    limpiarTablas();
                }
            }    
        }

        public void acomodarFormatoDGVs() {
            dgv_TiemposPorMaquina.Columns["#"].DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight;
            dgv_TiemposPorMaquina.Columns["TIEMPO ENCENDIDA"].DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight;
            dgv_TiemposPorMaquina.Columns["% APAGADA"].DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight;
            dgv_TiemposPorMaquina.AutoResizeColumns();
            dgv_TiemposPorMaquina.ClearSelection();

            dgv_TiemposPorSector.Columns["TIEMPO ENCENDIDO"].DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight;
            dgv_TiemposPorSector.AutoResizeColumns();
            dgv_TiemposPorSector.ClearSelection();

            dgv_TiemposTotales.Columns["TIEMPO ENCENDIDAS"].DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight;
            dgv_TiemposTotales.AutoResizeColumns();
            dgv_TiemposTotales.ClearSelection();
        }


        // Se llenan los tres DataGridView de acuerdo al caso VERDE (ver cuadro)
        public void llenarTablas_casoVERDE(string S_FyH_INI, string S_FyH_FIN, string S_LISTA_IDMAQ)
        {
            Consultas con = new Consultas();
            dgv_TiemposPorMaquina.DataSource = con.llenarTabla_UnUnicoIntervalo_TiemposPorMaquina(S_FyH_INI, S_FyH_FIN, S_LISTA_IDMAQ);
            dgv_TiemposPorSector.DataSource = con.llenarTabla_UnUnicoIntervalo_TiemposPorSector(S_FyH_INI, S_FyH_FIN, S_LISTA_IDMAQ);
            dgv_TiemposTotales.DataSource = con.llenarTabla_UnUnicoIntervalo_TiemposTotales(S_FyH_INI, S_FyH_FIN, S_LISTA_IDMAQ);
        }

        // Se llenan los tres DataGridView de acuerdo al caso AZUL (ver cuadro)
        public void llenarTablas_casoAZUL(string S_F_INI, string S_F_FIN, string S_H_INI, string S_H_FIN, string S_LISTA_IDMAQ)
        {
            Consultas con = new Consultas();
            dgv_TiemposPorMaquina.DataSource = con.llenarTabla_Nintervalos_TiemposPorMaquina(S_F_INI, S_F_FIN, S_H_INI, S_H_FIN, S_LISTA_IDMAQ);
            dgv_TiemposPorSector.DataSource = con.llenarTabla_Nintervalos_TiemposPorSector(S_F_INI, S_F_FIN, S_H_INI, S_H_FIN, S_LISTA_IDMAQ);
            dgv_TiemposTotales.DataSource = con.llenarTabla_Nintervalos_TiemposTotales(S_F_INI, S_F_FIN, S_H_INI, S_H_FIN, S_LISTA_IDMAQ);
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

        // Dados un DateTimePicker y dos ComboBox, devuelve la FECHAyHORARIO YYYYMMDDHHMM en formato int
        public int getYYYYMMDDHHMM_from1dtp2cmb(DateTimePicker dtp, ComboBox cmb_h, ComboBox cmb_m)
        {
            int YYYYMMDD = getYYYYMMDDentero_fromDtp(dtp);
            int HHMM = getHHMMentero_from2Cmb(cmb_h, cmb_m);
            int YYYYMMDDHHMM = YYYYMMDD * 10000 + HHMM;
            return YYYYMMDDHHMM;

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

            return YYYYMMDD;
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

        

        



        // Devuelve el string utilizado para el filtro del WHERE de las consultas SELECT
        public string getStringFiltroMaquinas()
        {
            string retorno;
            string filtroLatente = " ";

            if (chk_Telar1.Checked) filtroLatente = filtroLatente + "1, ";
            if (chk_Telar2.Checked) filtroLatente = filtroLatente + "2, ";
            if (chk_Telar3.Checked) filtroLatente = filtroLatente + "3, ";
            if (chk_Telar4.Checked) filtroLatente = filtroLatente + "4, ";
            if (chk_Telar5.Checked) filtroLatente = filtroLatente + "5, ";
            if (chk_Telar6.Checked) filtroLatente = filtroLatente + "6, ";
            if (chk_Telar7.Checked) filtroLatente = filtroLatente + "7, ";
            if (chk_Telar8.Checked) filtroLatente = filtroLatente + "8, ";
            if (chk_Telar9.Checked) filtroLatente = filtroLatente + "9, ";
            if (chk_Urdidora.Checked) filtroLatente = filtroLatente + "10, ";

            if (chk_Cordonera1.Checked) filtroLatente = filtroLatente + "11, ";
            if (chk_Cordonera2.Checked) filtroLatente = filtroLatente + "12, ";
            if (chk_Cordonera3.Checked) filtroLatente = filtroLatente + "13, ";
            if (chk_Cordonera4.Checked) filtroLatente = filtroLatente + "14, ";
            if (chk_Cordonera5.Checked) filtroLatente = filtroLatente + "15, ";
            if (chk_Cordonera6.Checked) filtroLatente = filtroLatente + "16, ";
            if (chk_Cordonera7.Checked) filtroLatente = filtroLatente + "17, ";
            if (chk_Cordonera8.Checked) filtroLatente = filtroLatente + "18, ";
            if (chk_Cordonera9.Checked) filtroLatente = filtroLatente + "19, ";

            if (chk_Terminacion1.Checked) filtroLatente = filtroLatente + "20, ";
            if (chk_Terminacion2.Checked) filtroLatente = filtroLatente + "21, ";
            if (chk_Terminacion3.Checked) filtroLatente = filtroLatente + "22, ";

            retorno = filtroLatente + "0";

            return retorno;
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



        
        private void btn_SeleccionSectorTelares_Click(object sender, EventArgs e)
        {
            accionarSeleccionSectores("telares");
        }

        private void btn_SeleccionSectorCordoneras_Click(object sender, EventArgs e)
        {
            accionarSeleccionSectores("cordoneras");
        }

        private void btn_SeleccionSectorTerminacion_Click(object sender, EventArgs e)
        {
            accionarSeleccionSectores("terminación");
        }

        // Contadores usados para alternar estados de selección/deselección de filtros
        public int contBtnTelares = 1;
        public int contBtnCordoneras = 1;
        public int contBtnTerminacion = 1;
        public int contBtnGeneral = 1;

        // Función usada para alternar selección de los tres sectores
        private void accionarSeleccionSectores(string sector)
        {
            switch (sector)
            {
                case "telares":
                    if (contBtnTelares % 2 == 0)
                    {
                        btn_SeleccionSectorTelares.Text = "Deseleccionar\ntodo el sector";
                        setCheckButtons("telares", true);
                    }
                    else
                    {
                        btn_SeleccionSectorTelares.Text = "Seleccionar\ntodo el sector";
                        setCheckButtons("telares", false);
                    }
                    contBtnTelares++;
                    break;

                case "cordoneras":
                    if (contBtnCordoneras % 2 == 0)
                    {
                        btn_SeleccionSectorCordoneras.Text = "Deseleccionar\ntodo el sector";
                        setCheckButtons("cordoneras", true);
                    }
                    else
                    {
                        btn_SeleccionSectorCordoneras.Text = "Seleccionar\ntodo el sector";
                        setCheckButtons("cordoneras", false);
                    }
                    contBtnCordoneras++;
                    break;

                case "terminación":
                    if (contBtnTerminacion % 2 == 0)
                    {
                        btn_SeleccionSectorTerminacion.Text = "Deseleccionar\ntodo el sector";
                        setCheckButtons("terminación", true);
                    }
                    else
                    {
                        btn_SeleccionSectorTerminacion.Text = "Seleccionar\ntodo el sector";
                        setCheckButtons("terminación", false);
                    }
                    contBtnTerminacion++;
                    break;
            }
        }

        // Se setean TODOS los CheckBox en TRUE
        private void btn_SeleccionarTodo_Click(object sender, EventArgs e)
        {
            setCheckButtons("todos", true);
            contBtnTelares = 0;
            accionarSeleccionSectores("telares");
            contBtnCordoneras = 0;
            accionarSeleccionSectores("cordoneras");
            contBtnTerminacion = 0;
            accionarSeleccionSectores("terminación");
        }

        // Se setean TODOS los CheckBox en FALSE
        private void btn_ResetearTodo_Click(object sender, EventArgs e)
        {
            setCheckButtons("todos", false);
            contBtnTelares = 1;
            accionarSeleccionSectores("telares");
            contBtnCordoneras = 1;
            accionarSeleccionSectores("cordoneras");
            contBtnTerminacion = 1;
            accionarSeleccionSectores("terminación");
        }

        // Dado un string correspondiente al sector y un valor booleano, setea el valor booleano a todos los CheckBox de ese sector
        private void setCheckButtons(string sector, bool valor)
        {
            switch (sector)
            {
                case "telares":
                    chk_Telar1.Checked = valor;
                    chk_Telar2.Checked = valor;
                    chk_Telar3.Checked = valor;
                    chk_Telar4.Checked = valor;
                    chk_Telar5.Checked = valor;
                    chk_Telar6.Checked = valor;
                    chk_Telar7.Checked = valor;
                    chk_Telar8.Checked = valor;
                    chk_Telar9.Checked = valor;
                    chk_Urdidora.Checked = valor;
                    break;
                case "cordoneras":
                    chk_Cordonera1.Checked = valor;
                    chk_Cordonera2.Checked = valor;
                    chk_Cordonera3.Checked = valor;
                    chk_Cordonera4.Checked = valor;
                    chk_Cordonera5.Checked = valor;
                    chk_Cordonera6.Checked = valor;
                    chk_Cordonera7.Checked = valor;
                    chk_Cordonera8.Checked = valor;
                    chk_Cordonera9.Checked = valor;
                    break;
                case "terminación":
                    chk_Terminacion1.Checked = valor;
                    chk_Terminacion2.Checked = valor;
                    chk_Terminacion3.Checked = valor;
                    break;
                case "todos":
                    setCheckButtons("telares", valor);
                    setCheckButtons("cordoneras", valor);
                    setCheckButtons("terminación", valor);
                    break;
            }
        }



        Form2 frm_EditarSectores = new Form2();
        //Form3 frm_EditarMaquinas = new Form3();

        private void editarSectoresToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frm_EditarSectores.Show();
        }

        private void editarMáquinasToolStripMenuItem_Click(object sender, EventArgs e)
        {
            //frm_EditarMaquinas.Show();
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

    }
}
