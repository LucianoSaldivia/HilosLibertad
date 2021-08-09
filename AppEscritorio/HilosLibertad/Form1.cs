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
            // Carga inicial de fechas: desde un mes antes de hoy a las 00:00 hasta hoy a las 0:00
            dtp_Desde.Value = DateTime.Today.AddMonths(-1);
            dtp_Hasta.Value = DateTime.Today;
            cmb_HoraDesde.SelectedIndex = 0;
            cmb_MinutoDesde.SelectedIndex = 0;
            cmb_HoraHasta.SelectedIndex = 0;
            cmb_MinutoHasta.SelectedIndex = 0;
            // Carga inicial de máquinas: todas las máquinas
            setCheckButtons("todos", true);
        }


        private void btn_Mostrar_Click(object sender, EventArgs e)
        {
            string FILTRO_FECHA_INICIAL = obtenerStringFiltroFechaInicial();
            string FILTRO_FECHA_FINAL = obtenerStringFiltroFechaFinal();
            string FILTRO_MAQUINAS = obtenerStringFiltroMaquinas();

            Consultas con = new Consultas();
            // CONSULTA 1 - CANTIDAD DE HORAS POR MÁQUINA
            dgv_CantHorasPorMaquina.DataSource = con.mostrarCantidadDeHorasPorMaquina(FILTRO_FECHA_INICIAL, FILTRO_FECHA_FINAL, FILTRO_MAQUINAS);

            // CONSULTA 2 - CANTIDAD DE HORAS POR SECTOR
            dgv_CantHorasPorSector.DataSource = con.mostrarCantidadDeHorasPorSector(FILTRO_FECHA_INICIAL, FILTRO_FECHA_FINAL);

            // CONSULTA 3 - CANTIDAD DE HORAS DE TODAS LAS MÁQUINAS
            dgv_CantTotalHorasMaquina.DataSource = con.mostrarCantidadDeHorasDeTodasLasMaquinas(FILTRO_FECHA_INICIAL, FILTRO_FECHA_FINAL);
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





        public string obtenerStringFiltroMaquinas()
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
            
            retorno = "(000, " + filtroLatente + "000)";
            
            return retorno;
        }


        public string obtenerStringFiltroFechaInicial()
        {
            string f_d = dtp_Desde.Value.ToString("yyyy-dd-MM");    // formato de fecha útil (YYYY-DD-MM) para las consultas a la DB

            string h_d; //
            if (Convert.ToInt32(cmb_HoraDesde.SelectedItem) >= 0 && Convert.ToInt32(cmb_HoraDesde.SelectedItem) <= 9)
            {
                h_d = "0" + cmb_HoraDesde.SelectedItem.ToString();
            }
            else
            {
                h_d = cmb_HoraDesde.SelectedItem.ToString();
                
            }

            string m_d = cmb_MinutoDesde.SelectedItem.ToString();

            string FHM_desde = "'" + f_d + " " + h_d + ":" + m_d + ":00'";
            
            return FHM_desde;
        }

        public string obtenerStringFiltroFechaFinal()
        {
            string f_h = dtp_Hasta.Value.ToString("yyyy-dd-MM");    // formato de fecha útil (YYYY-DD-MM) para las consultas a la DB

            string h_h = cmb_HoraHasta.Text;
            if (Convert.ToInt32(cmb_HoraHasta.SelectedItem) >= 0 && Convert.ToInt32(cmb_HoraHasta.SelectedItem) <= 9)
            {
                h_h = "0" + cmb_HoraHasta.SelectedItem.ToString();
            }
            else
            {
                h_h = cmb_HoraHasta.SelectedItem.ToString();
            }


            string m_h = cmb_MinutoHasta.SelectedItem.ToString();

            string FHM_hasta = "'" + f_h + " " + h_h + ":" + m_h + ":00'";

            return FHM_hasta;
        }


        
        public void asegurarConsistenciaEnFechaDesde_TrasCambiosEnFechaHasta()
        {
            if (dtp_Desde.Value > dtp_Hasta.Value)  // Si la FECHA_DESDE es posterior a la FECHA_HASTA, entonces...
            {
                MessageBox.Show("La fecha final debe ser posterior a la fecha inicial.\nPara evitar inconsistencias, se actualiza la fecha final.", "Inconsistencia de fechas", MessageBoxButtons.OK, MessageBoxIcon.Information);
                dtp_Desde.Value = dtp_Hasta.Value;  // ... la FECHA_DESDE será igual a la FECHA_HASTA.
            }
            else if (dtp_Desde.Value == dtp_Hasta.Value) // Si FECHA_DESDE y FECHA_HASTA son la misma fecha, entonces...
            {
                int h_desde_int = Convert.ToInt32(cmb_HoraDesde.SelectedItem);
                int m_desde_int = Convert.ToInt32(cmb_MinutoDesde.SelectedItem);
                int hsmins_desde_int = h_desde_int * 100 + m_desde_int;
                int h_hasta_int = Convert.ToInt32(cmb_HoraHasta.SelectedItem);
                int m_hasta_int = Convert.ToInt32(cmb_MinutoHasta.SelectedItem);
                int hsmins_hasta_int = h_hasta_int * 100 + m_hasta_int;

                if (hsmins_desde_int > hsmins_hasta_int)    // ... si el HORARIO_DESDE es posterior al HORARIO_HASTA, entonces el HORARIO_DESDE será igual al HORARIO_HASTA
                {
                    MessageBox.Show("El horario final debe ser posterior al horario inicial.\nPara evitar inconsistencias, se actualiza el horario inicial.", "Inconsistencia de horarios", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    cmb_HoraDesde.SelectedItem = cmb_HoraHasta.SelectedItem;
                    cmb_MinutoDesde.SelectedItem = cmb_MinutoHasta.SelectedItem;
                }
            }
        }

        public void asegurarConsistenciaEnFechaHasta_TrasCambiosEnFechaDesde()
        {
            // acá se cambia el FECHA_HASTA
            if (dtp_Hasta.Value < dtp_Desde.Value)  // Si la FECHA_HASTA es anterior a la FECHA_DESDE, entonces...
            {
                MessageBox.Show("La fecha inicial debe ser anterior a la fecha final.\nPara evitar inconsistencias, se actualiza la fecha inicial.", "Inconsistencia de fechas", MessageBoxButtons.OK, MessageBoxIcon.Information);
                dtp_Hasta.Value = dtp_Desde.Value;  // ... la FECHA_HASTA será igual a la FECHA_DESDE.
            }
            else if (dtp_Hasta.Value == dtp_Desde.Value) // Si FECHA_HASTA y FECHA_DESDE son la misma fecha, entonces...
            {
                int h_desde_int = Convert.ToInt32(cmb_HoraDesde.SelectedItem);
                int m_desde_int = Convert.ToInt32(cmb_MinutoDesde.SelectedItem);
                int hsmins_desde_int = h_desde_int * 100 + m_desde_int;
                int h_hasta_int = Convert.ToInt32(cmb_HoraHasta.SelectedItem);
                int m_hasta_int = Convert.ToInt32(cmb_MinutoHasta.SelectedItem);
                int hsmins_hasta_int = h_hasta_int * 100 + m_hasta_int;

                if (hsmins_hasta_int < hsmins_desde_int)    // ... si el HORARIO_HASTA es anterior al HORARIO_DESDE, entonces el HORARIO_HASTA será igual al HORARIO_DESDE
                {
                    MessageBox.Show("El horario inicial debe ser anterior al horario final.\nPara evitar inconsistencias, se actualiza el horario final.", "Inconsistencia de horarios", MessageBoxButtons.OK, MessageBoxIcon.Information); 
                    cmb_HoraHasta.SelectedItem = cmb_HoraDesde.SelectedItem;
                    cmb_MinutoHasta.SelectedItem = cmb_MinutoDesde.SelectedItem;
                }
            }
        }



        private void dtp_Desde_ValueChanged(object sender, EventArgs e)
        {
            asegurarConsistenciaEnFechaHasta_TrasCambiosEnFechaDesde(); 
        }

        private void cmb_HoraDesde_SelectedIndexChanged(object sender, EventArgs e)
        {
            asegurarConsistenciaEnFechaHasta_TrasCambiosEnFechaDesde();
        }

        private void cmb_MinutoDesde_SelectedIndexChanged(object sender, EventArgs e)
        {
            asegurarConsistenciaEnFechaHasta_TrasCambiosEnFechaDesde();
        }

        private void dtp_Hasta_ValueChanged(object sender, EventArgs e)
        {
            asegurarConsistenciaEnFechaDesde_TrasCambiosEnFechaHasta();
        }

        private void cmb_HoraHasta_SelectedIndexChanged(object sender, EventArgs e)
        {
            asegurarConsistenciaEnFechaDesde_TrasCambiosEnFechaHasta();
        }

        private void cmb_MinutoHasta_SelectedIndexChanged(object sender, EventArgs e)
        {
            asegurarConsistenciaEnFechaDesde_TrasCambiosEnFechaHasta();
        }
    }
}
