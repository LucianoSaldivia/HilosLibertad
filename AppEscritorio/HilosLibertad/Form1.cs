using System;
using System.Windows.Forms;

namespace HilosLibertad
{
    public partial class frm_Home : Form
    {
        public frm_Home()
        {
            InitializeComponent();
        }

        // Contadores usados para alternar estados de selección/deselección de filtros
        public int contBtnTelares = 1;
        public int contBtnCordoneras = 1;
        public int contBtnTerminacion = 1;
        public int contBtnGeneral = 1;

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
        }


        // Funciones para obtener una fecha como string a partir de un dateTimePicker, y ...
        // ... funciones para obtener un horario como string a partir de 2 objetos comboBox
        public string getStringYYYYMMDDHHMMfromdtp2cmb(DateTimePicker dtp, ComboBox cmb_h , ComboBox cmb_m)   // recibe 1 dtp y 2 cmb
        {
            string YYYYDDMM = getStringYYYYDDMMfromdtp(dtp);
            string HHMM00 = getStringHHMMfrom2cmb(cmb_h, cmb_m);
            
            string YYYYMMDD_HHMM00 = YYYYDDMM + " " + HHMM00;

            return YYYYMMDD_HHMM00;
        }

        public DateTimePicker incrementarDiaAdtp (DateTimePicker dtp, int valor)
        {
            DateTimePicker dtp_retorno = dtp;
            dtp_retorno.Value = dtp.Value.AddDays(valor); 
            return dtp_retorno;
        }

        public string getStringYYYYDDMMfromdtp(DateTimePicker dtp)    // recibe 1 dtp
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

        public string getStringHHMMfrom2cmb(ComboBox cmb_horas, ComboBox cmb_minutos)   // recibe 2 cmb: uno de la hora y otro del minuto
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

        /*
        public string getYYYYMMDDHHMM(DateTime dt, string hora, string mins)   // recibe un dtp.Value, un cmb.Text y un cmb_Text
        {
            // Fuerzo el doble dígito en Mes, Día, Hora y Minuto
            string mes_MM = (dt.Month >= 10) ? dt.Month.ToString() : ("0" + dt.Month.ToString());
            string dia_DD = (dt.Day >= 10) ? dt.Day.ToString() : ("0" + dt.Day.ToString());
            string hora_HH = (Convert.ToInt32(hora) >= 10) ? hora : ("0" + hora);
            string mins_MM = (Convert.ToInt32(mins) >= 10) ? mins : ("0" + mins);

            // Formo el string completo con el formato "YYYY-DD-MM HH:MM:00"
            string hora_fecha = dt.Year.ToString() + "-" + dia_DD + "-" + mes_MM + " " + hora_HH + ":" + mins_MM + ":00";

            return hora_fecha;
        }
                       
        public string getYYYYDDMM (DateTime dt)    // recibe un dtp.Value
        {
            // Fuerzo el doble dígito en Mes y Día
            string mes_MM = (dt.Month >= 10) ? dt.Month.ToString() : ("0" + dt.Month.ToString());
            string dia_DD = (dt.Day >= 10) ? dt.Day.ToString() : ("0" + dt.Day.ToString());

            // Formo el string completo con el formato "YYYY-DD-MM"
            string hora_fecha = dt.Year.ToString() + "-" + dia_DD + "-" + mes_MM;
            
            return hora_fecha;
        }

        public string getHHMM(string hora, string mins)   // recibe un cmb.Text y un cmb_Text
        {
            // Fuerzo el doble dígito en Hora y Minuto
            string hora_HH = (Convert.ToInt32(hora) >= 10) ? hora : ("0" + hora);
            string mins_MM = (Convert.ToInt32(mins) >= 10) ? mins : ("0" + mins);

            // Formo el string completo con el formato "HH:MM:00"
            string horario = hora_HH + ":" + mins_MM + ":00";

            return horario;
        }
        */

        public int getYYYYMMDDentero_fromDtp (DateTimePicker dtp)   //Dado un dateTimePicker, se arma un entero YYYYMMDD
        {
            int YYYYMMDD = dtp.Value.Year * 10000 + dtp.Value.Month * 100 + dtp.Value.Day;
            return YYYYMMDD;
        }

        
        public int getHHMMentero_from2Cmb(ComboBox cmb_h, ComboBox cmb_m)   //Dado el paquete de comboBox (horas y minutos), se arma un entero HHMM
        {
            int HHMM = Convert.ToInt32(cmb_h.Text) * 100 + Convert.ToInt32(cmb_m.Text);
            return HHMM;
        }

        private void btn_Mostrar_Click(object sender, EventArgs e)
        {
            //Console.WriteLine(obtenerStringFiltroMaquinas());
            int YYYYMMDD_ini_S = getYYYYMMDDentero_fromDtp(dtp_FechaInicial);
            int YYYYMMDD_fin_S = getYYYYMMDDentero_fromDtp(dtp_FechaFinal);
            int HHMM_ini_S = getHHMMentero_from2Cmb(cmb_HoraInicial, cmb_MinutoInicial);
            int HHMM_fin_S = getHHMMentero_from2Cmb(cmb_HoraFinal, cmb_MinutoFinal);
            

            // Días de diferencia entre las dos fechas
            int N = YYYYMMDD_fin_S - YYYYMMDD_ini_S;

            Consultas con = new Consultas();
            //dgv_CantHorasPorMaquina.DataSource = con.mostrarFiltroPorMaquinas(obtenerStringFiltroMaquinas());

            string STRING_LISTA_idMaquina = getStringFiltroMaquinas();
            string STRING_FECHAyHORARIO_INICIAL = "'" + getStringYYYYMMDDHHMMfromdtp2cmb(dtp_FechaInicial, cmb_HoraInicial, cmb_MinutoInicial) + "'";
            string STRING_FECHAyHORARIO_FINAL = "'" + getStringYYYYMMDDHHMMfromdtp2cmb(dtp_FechaFinal, cmb_HoraFinal, cmb_MinutoFinal) + "'";

            string STRING_FECHA_INICIAL = getStringFromDTPconFormato(dtp_FechaInicial, "yyyy-MM-dd");
            string STRING_FECHA_FINAL = getStringFromDTPconFormato(dtp_FechaFinal, "yyyy-MM-dd");
            string STRING_HORARIO_INICIAL = getStringFrom2CMB(cmb_HoraInicial, cmb_MinutoInicial);
            string STRING_HORARIO_FINAL = getStringFrom2CMB(cmb_HoraFinal, cmb_MinutoFinal);

            if (YYYYMMDD_ini_S == YYYYMMDD_fin_S)       // Fila 2
            {
                if (HHMM_fin_S <= HHMM_ini_S)           // Columna 2, Columna 3, Columna 4
                {
                    // CASO INVÁLIDO [POSIBLE], NARANJA --> INCONSISTENCIA DE HORARIOS
                    MessageBox.Show("Como las fechas inicial y final son iguales, el horario final debe ser posterior al horario inicial.\n", "Inconsistencia de horarios: horario final anterior al horario inicial", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                else                                    // Columna 1
                {
                    // CASO VERDE --> UN ÚNICO INTERVALO (la franja horaria es entre 15min y 23h45min)
                    dgv_CantHorasPorMaquina.DataSource = con.casoUnicoIntervalo_mostrarCantidadDeHorasPorMaquina(STRING_FECHAyHORARIO_INICIAL, STRING_FECHAyHORARIO_FINAL, STRING_LISTA_idMaquina);
                    dgv_CantHorasPorSector.DataSource = con.casoUnicoIntervalo_mostrarCantidadDeHorasPorSector(STRING_FECHAyHORARIO_INICIAL, STRING_FECHAyHORARIO_FINAL, STRING_LISTA_idMaquina);
                    dgv_CantTotalHorasMaquina.DataSource = con.casoUnicoIntervalo_mostrarCantidadDeHorasDeTodasLasMaquinas(STRING_FECHAyHORARIO_INICIAL, STRING_FECHAyHORARIO_FINAL, STRING_LISTA_idMaquina);
                }
            }
            else
            {
                if (YYYYMMDD_fin_S > YYYYMMDD_ini_S)    // Fila 1
                {
                    if (HHMM_fin_S == HHMM_ini_S)       // Columna 2
                    {
                        // CASO VERDE --> UN ÚNICO INTERVALO (la franja horaria es múltiplo de 24 horas)
                        dgv_CantHorasPorMaquina.DataSource = con.casoUnicoIntervalo_mostrarCantidadDeHorasPorMaquina(STRING_FECHAyHORARIO_INICIAL, STRING_FECHAyHORARIO_FINAL, STRING_LISTA_idMaquina);
                        dgv_CantHorasPorSector.DataSource = con.casoUnicoIntervalo_mostrarCantidadDeHorasPorSector(STRING_FECHAyHORARIO_INICIAL, STRING_FECHAyHORARIO_FINAL, STRING_LISTA_idMaquina);
                        dgv_CantTotalHorasMaquina.DataSource = con.casoUnicoIntervalo_mostrarCantidadDeHorasDeTodasLasMaquinas(STRING_FECHAyHORARIO_INICIAL, STRING_FECHAyHORARIO_FINAL, STRING_LISTA_idMaquina);
                    }
                    else
                    {
                        if (HHMM_fin_S > HHMM_ini_S)    // Columna 1
                        {
                            // CASO AZUL --> N INTERVALOS (franja horaria días parciales: es entre 15min y 23h45min)
                            dgv_CantHorasPorMaquina.DataSource = con.casoNintervalos_mostrarCantidadDeHorasPorMaquina(STRING_FECHA_INICIAL, STRING_FECHA_FINAL, STRING_HORARIO_INICIAL, STRING_HORARIO_FINAL, STRING_LISTA_idMaquina);
                            dgv_CantHorasPorSector.DataSource = con.casoNintervalos_mostrarCantidadDeHorasPorSector(STRING_FECHA_INICIAL, STRING_FECHA_FINAL, STRING_HORARIO_INICIAL, STRING_HORARIO_FINAL, STRING_LISTA_idMaquina);
                            dgv_CantTotalHorasMaquina.DataSource = con.casoNintervalos_mostrarCantidadDeHorasDeTodasLasMaquinas(STRING_FECHA_INICIAL, STRING_FECHA_FINAL, STRING_HORARIO_INICIAL, STRING_HORARIO_FINAL, STRING_LISTA_idMaquina);

                            Console.WriteLine("00000000000000000000000000000000");
                        }
                        else
                        {
                            if (N == 1)                 // Columna 3
                            {
                                // CASO VERDE --> UN ÚNICO INTERVALO (la franja horaria entre 15min y 23h45min)
                                dgv_CantHorasPorMaquina.DataSource = con.casoUnicoIntervalo_mostrarCantidadDeHorasPorMaquina(STRING_FECHAyHORARIO_INICIAL, STRING_FECHAyHORARIO_FINAL, STRING_LISTA_idMaquina);
                                dgv_CantHorasPorSector.DataSource = con.casoUnicoIntervalo_mostrarCantidadDeHorasPorSector(STRING_FECHAyHORARIO_INICIAL, STRING_FECHAyHORARIO_FINAL, STRING_LISTA_idMaquina);
                                dgv_CantTotalHorasMaquina.DataSource = con.casoUnicoIntervalo_mostrarCantidadDeHorasDeTodasLasMaquinas(STRING_FECHAyHORARIO_INICIAL, STRING_FECHAyHORARIO_FINAL, STRING_LISTA_idMaquina);
                            }
                            else                        // Columna 4
                            {
                                // CASO AZUL --> N INTERVALOS (franja horaria trasnoches: es entre 15min y 23h45min)
                                dgv_CantHorasPorMaquina.DataSource = con.casoNintervalos_mostrarCantidadDeHorasPorMaquina(STRING_FECHA_INICIAL, STRING_FECHA_FINAL, STRING_HORARIO_INICIAL, STRING_HORARIO_FINAL, STRING_LISTA_idMaquina);
                                dgv_CantHorasPorSector.DataSource = con.casoNintervalos_mostrarCantidadDeHorasPorSector(STRING_FECHA_INICIAL, STRING_FECHA_FINAL, STRING_HORARIO_INICIAL, STRING_HORARIO_FINAL, STRING_LISTA_idMaquina);
                                dgv_CantTotalHorasMaquina.DataSource = con.casoNintervalos_mostrarCantidadDeHorasDeTodasLasMaquinas(STRING_FECHA_INICIAL, STRING_FECHA_FINAL, STRING_HORARIO_INICIAL, STRING_HORARIO_FINAL, STRING_LISTA_idMaquina);
                                
                                Console.WriteLine("0000                        0000");
                            }
                        }

                    }
                }
                else                                    // Fila 3: Columna 1, Columna 2, Columna 3, Columna 4
                {
                    // CASO INVÁLIDO [IMPOSIBLE], ROJO --> INCONSISTENCIA DE FECHAS
                    MessageBox.Show("La fecha final debe ser posterior a la fecha inicial.\n", "Inconsistencia de fechas: fecha final anterior a fecha inicial", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }

        }








        public string getStringFiltroMaquinas()
        {
            string retorno;
            string filtroLatente = "";

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


        
        public string getStringFromDTPconFormato(DateTimePicker dtp, string formato)
        {
            // La variable formato puede ser, por ejemplo, "yyyy-dd-MM" o "yyyy-MM-dd"
            return "'" + dtp.Value.ToString(formato) + "'";
        }

        public string getStringFrom2CMB(ComboBox cmb_h, ComboBox cmb_m)
        {
            string HH;
            if (Convert.ToInt32(cmb_h.SelectedItem) >= 0 && Convert.ToInt32(cmb_h.SelectedItem) <= 9)
            {
                HH = "0" + cmb_h.SelectedItem.ToString();
            }
            else
            {
                HH = cmb_h.SelectedItem.ToString();
            }
            
            string MM = cmb_m.SelectedItem.ToString();
            return "'" + HH + ":" + MM + "'";
        }
        


        public string getStringFiltroFechaHoraInicial()
        {
            string f_d = dtp_FechaInicial.Value.ToString("yyyy-dd-MM");    // formato de fecha útil (YYYY-DD-MM) para las consultas a la DB

            string h_d; //
            if (Convert.ToInt32(cmb_HoraInicial.SelectedItem) >= 0 && Convert.ToInt32(cmb_HoraInicial.SelectedItem) <= 9)
            {
                h_d = "0" + cmb_HoraInicial.SelectedItem.ToString();
            }
            else
            {
                h_d = cmb_HoraInicial.SelectedItem.ToString();

            }

            string m_d = cmb_MinutoInicial.SelectedItem.ToString();

            string FHM_desde = "'" + f_d + " " + h_d + ":" + m_d + ":00'";

            return FHM_desde;
        }

        public string getStringFiltroFechaHoraFinal()
        {
            string f_h = dtp_FechaFinal.Value.ToString("yyyy-dd-MM");    // formato de fecha útil (YYYY-DD-MM) para las consultas a la DB

            string h_h = cmb_HoraFinal.Text;
            if (Convert.ToInt32(cmb_HoraFinal.SelectedItem) >= 0 && Convert.ToInt32(cmb_HoraFinal.SelectedItem) <= 9)
            {
                h_h = "0" + cmb_HoraFinal.SelectedItem.ToString();
            }
            else
            {
                h_h = cmb_HoraFinal.SelectedItem.ToString();
            }


            string m_h = cmb_MinutoFinal.SelectedItem.ToString();

            string FHM_hasta = "'" + f_h + " " + h_h + ":" + m_h + ":00'";

            return FHM_hasta;
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




        private void dtp_FechaInicial_ValueChanged(object sender, EventArgs e)
        {
            asegurarConsistenciaEnFechaHasta_TrasCambiosEnFechaDesde(); 
        }

        public void asegurarConsistenciaEnFechaHasta_TrasCambiosEnFechaDesde()
        {
            // acá se cambia el FECHA_HASTA
            if (dtp_FechaFinal.Value < dtp_FechaInicial.Value)  // Si la FECHA_HASTA es anterior a la FECHA_DESDE, entonces...
            {
                //MessageBox.Show("La fecha inicial debe ser anterior a la fecha final.\nPara evitar inconsistencias, se actualiza la fecha inicial.", "Inconsistencia de fechas", MessageBoxButtons.OK, MessageBoxIcon.Information);
                dtp_FechaFinal.Value = dtp_FechaInicial.Value;  // ... la FECHA_HASTA será igual a la FECHA_DESDE.
            }
            else if (dtp_FechaFinal.Value == dtp_FechaInicial.Value) // Si FECHA_HASTA y FECHA_DESDE son la misma fecha, entonces...
            {
                int h_desde_int = Convert.ToInt32(cmb_HoraInicial.SelectedItem);
                int m_desde_int = Convert.ToInt32(cmb_MinutoInicial.SelectedItem);
                int hsmins_desde_int = h_desde_int * 100 + m_desde_int;
                int h_hasta_int = Convert.ToInt32(cmb_HoraFinal.SelectedItem);
                int m_hasta_int = Convert.ToInt32(cmb_MinutoFinal.SelectedItem);
                int hsmins_hasta_int = h_hasta_int * 100 + m_hasta_int;

                if (hsmins_hasta_int < hsmins_desde_int)    // ... si el HORARIO_HASTA es anterior al HORARIO_DESDE, entonces el HORARIO_HASTA será igual al HORARIO_DESDE
                {
                    MessageBox.Show("El horario inicial debe ser anterior al horario final.\nPara evitar inconsistencias, se actualiza el horario final.", "Inconsistencia de horarios", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    cmb_HoraFinal.SelectedItem = cmb_HoraInicial.SelectedItem;
                    cmb_MinutoFinal.SelectedItem = cmb_MinutoInicial.SelectedItem;
                }
            }
        }


        private void dtp_FechaFinal_ValueChanged(object sender, EventArgs e)
        {
            asegurarConsistenciaEnFechaDesde_TrasCambiosEnFechaHasta();
        }

        public void asegurarConsistenciaEnFechaDesde_TrasCambiosEnFechaHasta()
        {
            if (dtp_FechaInicial.Value > dtp_FechaFinal.Value)  // Si la FECHA_DESDE es posterior a la FECHA_HASTA, entonces...
            {
                //MessageBox.Show("La fecha final debe ser posterior a la fecha inicial.\nPara evitar inconsistencias, se actualiza la fecha final.", "Inconsistencia de fechas", MessageBoxButtons.OK, MessageBoxIcon.Information);
                dtp_FechaInicial.Value = dtp_FechaFinal.Value;  // ... la FECHA_DESDE será igual a la FECHA_HASTA.
            }
            else if (dtp_FechaInicial.Value == dtp_FechaFinal.Value) // Si FECHA_DESDE y FECHA_HASTA son la misma fecha, entonces...
            {
                int h_desde_int = Convert.ToInt32(cmb_HoraInicial.SelectedItem);
                int m_desde_int = Convert.ToInt32(cmb_MinutoInicial.SelectedItem);
                int hsmins_desde_int = h_desde_int * 100 + m_desde_int;
                int h_hasta_int = Convert.ToInt32(cmb_HoraFinal.SelectedItem);
                int m_hasta_int = Convert.ToInt32(cmb_MinutoFinal.SelectedItem);
                int hsmins_hasta_int = h_hasta_int * 100 + m_hasta_int;

                if (hsmins_desde_int > hsmins_hasta_int)    // ... si el HORARIO_DESDE es posterior al HORARIO_HASTA, entonces el HORARIO_DESDE será igual al HORARIO_HASTA
                {
                    MessageBox.Show("El horario final debe ser posterior al horario inicial.\nPara evitar inconsistencias, se actualiza el horario inicial.", "Inconsistencia de horarios", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    cmb_HoraInicial.SelectedItem = cmb_HoraFinal.SelectedItem;
                    cmb_MinutoInicial.SelectedItem = cmb_MinutoFinal.SelectedItem;
                }
            }
        }




        private void button1_Click(object sender, EventArgs e)
        {
            Console.WriteLine("Fecha inicial:\t" + getStringFromDTPconFormato(dtp_FechaInicial, "yyyy-MM-dd"));
            //Console.WriteLine("Fecha inicial:\t" + getStringFromDTPconFormato(dtp_FechaInicial, "yyyy-dd-MM"));
            Console.WriteLine("Horario inicial:\t" + getStringFrom2CMB(cmb_HoraInicial, cmb_MinutoInicial));
        }
    }
}
