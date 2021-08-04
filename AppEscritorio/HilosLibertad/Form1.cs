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
            /*
            // Conexión con la base de datos
            conexionConBaseDeDatos conexion = new conexionConBaseDeDatos();
            conexion.abrir();
            */


            Consultas con = new Consultas();

            

            // Datos predeterminados
            dgv_CantHorasPorMaquina.DataSource = con.mostrarCantidadDeHorasPorMaquina();
            
            dtp_Desde.Value = DateTime.Today;
            dtp_Hasta.Value = DateTime.Today.AddDays(1);

            cmb_HoraDesde.SelectedIndex = 0;
            cmb_MinutoDesde.SelectedIndex = 0;
            cmb_HoraHasta.SelectedIndex = 12;
            cmb_MinutoHasta.SelectedIndex = 0;


            
        
            setCheckButtons("todos", true);
        }

       
        private void setCheckButtons(string sector, bool valor) { 
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

        private void chk_Telar1_CheckedChanged(object sender, EventArgs e)
        {
            //MessageBox.Show("Muestra");
        }
        private void chk_Telar2_CheckedChanged(object sender, EventArgs e)
        {

        }
        private void chk_Telar3_CheckedChanged(object sender, EventArgs e)
        {

        }
        private void chk_Telar4_CheckedChanged(object sender, EventArgs e)
        {

        }
        private void chk_Telar5_CheckedChanged(object sender, EventArgs e)
        {

        }
        private void chk_Telar6_CheckedChanged(object sender, EventArgs e)
        {

        }
        private void chk_Telar7_CheckedChanged(object sender, EventArgs e)
        {

        }
        private void chk_Telar8_CheckedChanged(object sender, EventArgs e)
        {

        }
        private void chk_Telar9_CheckedChanged(object sender, EventArgs e)
        {

        }
        private void chk_Urdidora_CheckedChanged(object sender, EventArgs e)
        {

        }
        private void chk_Cordonera1_CheckedChanged(object sender, EventArgs e)
        {
            
        }
        private void chk_Cordonera2_CheckedChanged(object sender, EventArgs e)
        {

        }
        private void chk_Cordonera3_CheckedChanged(object sender, EventArgs e)
        {

        }
        private void chk_Cordonera4_CheckedChanged(object sender, EventArgs e)
        {

        }
        private void chk_Cordonera5_CheckedChanged(object sender, EventArgs e)
        {

        }
        private void chk_Cordonera6_CheckedChanged(object sender, EventArgs e)
        {

        }
        private void chk_Cordonera7_CheckedChanged(object sender, EventArgs e)
        {

        }
        private void chk_Cordonera8_CheckedChanged(object sender, EventArgs e)
        {

        }
        private void chk_Cordonera9_CheckedChanged(object sender, EventArgs e)
        {

        }
        private void chk_Terminacion1_CheckedChanged(object sender, EventArgs e)
        {
            //
        }
        private void chk_Terminacion2_CheckedChanged(object sender, EventArgs e)
        {
            //
        }
        private void chk_Terminacion3_CheckedChanged(object sender, EventArgs e)
        {
            //
        }
        private void btn_Mostrar_Click(object sender, EventArgs e)
        {
            //
        }

        
        
        

        private void accionarSeleccionSectores (string sector)
        {
            switch(sector)
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
    }
}
