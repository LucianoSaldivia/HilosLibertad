using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
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

        }

        private void checkBox_SectorTelares_CheckedChanged(object sender, EventArgs e)
        {
            if (chk_SectorTelares.Checked)
            {
                chk_Telar1.Checked = true;
                chk_Telar2.Checked = true;
                chk_Telar3.Checked = true;
                chk_Telar4.Checked = true;
                chk_Telar5.Checked = true;
                chk_Telar6.Checked = true;
                chk_Telar7.Checked = true;
                chk_Telar8.Checked = true;
                chk_Telar9.Checked = true;
                chk_Urdidora.Checked = true;
            }
            else {
                chk_Telar1.Checked = false;
                chk_Telar2.Checked = false;
                chk_Telar3.Checked = false;
                chk_Telar4.Checked = false;
                chk_Telar5.Checked = false;
                chk_Telar6.Checked = false;
                chk_Telar7.Checked = false;
                chk_Telar8.Checked = false;
                chk_Telar9.Checked = false;
                chk_Urdidora.Checked = false;
            }
            
        }

        private void checkBox_SectorCordoneras_CheckedChanged(object sender, EventArgs e)
        {
            if (chk_SectorCordoneras.Checked)
            {
                chk_Cordonera1.Checked = true;
                chk_Cordonera2.Checked = true;
                chk_Cordonera3.Checked = true;
                chk_Cordonera4.Checked = true;
                chk_Cordonera5.Checked = true;
                chk_Cordonera6.Checked = true;
                chk_Cordonera7.Checked = true;
                chk_Cordonera8.Checked = true;
                chk_Cordonera9.Checked = true;
            }
            else
            {
                chk_Cordonera1.Checked = false;
                chk_Cordonera2.Checked = false;
                chk_Cordonera3.Checked = false;
                chk_Cordonera4.Checked = false;
                chk_Cordonera5.Checked = false;
                chk_Cordonera6.Checked = false;
                chk_Cordonera7.Checked = false;
                chk_Cordonera8.Checked = false;
                chk_Cordonera9.Checked = false;
            }
        }

        private void checkBox_SectorTerminacion_CheckedChanged(object sender, EventArgs e)
        {
            if (chk_SectorTerminacion.Checked)
            {
                chk_Terminacion1.Checked = true;
                chk_Terminacion2.Checked = true;
                chk_Terminacion3.Checked = true;
            }
            else {
                chk_Terminacion1.Checked = false;
                chk_Terminacion2.Checked = false;
                chk_Terminacion3.Checked = false;
            }
        }

        private void button_ResetearFiltros_Click(object sender, EventArgs e)
        {
            chk_SectorTelares.Checked = false;
            chk_Telar1.Checked = false;
            chk_Telar2.Checked = false;
            chk_Telar3.Checked = false;
            chk_Telar4.Checked = false;
            chk_Telar5.Checked = false;
            chk_Telar6.Checked = false;
            chk_Telar7.Checked = false;
            chk_Telar8.Checked = false;
            chk_Telar9.Checked = false;
            chk_Urdidora.Checked = false;

            chk_SectorCordoneras.Checked = false;
            chk_Cordonera1.Checked = false;
            chk_Cordonera2.Checked = false;
            chk_Cordonera3.Checked = false;
            chk_Cordonera4.Checked = false;
            chk_Cordonera5.Checked = false;
            chk_Cordonera6.Checked = false;
            chk_Cordonera7.Checked = false;
            chk_Cordonera8.Checked = false;
            chk_Cordonera9.Checked = false;

            chk_SectorTerminacion.Checked = false;
            chk_Terminacion1.Checked = false;
            chk_Terminacion2.Checked = false;
            chk_Terminacion3.Checked = false;
        }
    }
}
