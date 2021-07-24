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
    public partial class FormularioPrincipal : Form
    {
        public FormularioPrincipal()
        {
            InitializeComponent();
        }

        private void FormularioPrincipal_Load(object sender, EventArgs e)
        {
            // Conexión con la base de datos
            conexionConBaseDeDatos conexion = new conexionConBaseDeDatos();
            conexion.abrir();


            // Datos predeterminados
            
            dateTimePicker_Desde.Value = DateTime.Today;
            dateTimePicker_Hasta.Value = DateTime.Today.AddDays(1);

            comboBox_HoraDesde.SelectedIndex = 0;
            comboBox_MinutoDesde.SelectedIndex = 0;
            comboBox_HoraHasta.SelectedIndex = 12;
            comboBox_MinutoHasta.SelectedIndex = 0;

        }

        private void checkBox_SectorTelares_CheckedChanged(object sender, EventArgs e)
        {
            if (checkBox_SectorTelares.Checked)
            {
                checkBox_Telar1.Checked = true;
                checkBox_Telar2.Checked = true;
                checkBox_Telar3.Checked = true;
                checkBox_Telar4.Checked = true;
                checkBox_Telar5.Checked = true;
                checkBox_Telar6.Checked = true;
                checkBox_Telar7.Checked = true;
                checkBox_Telar8.Checked = true;
                checkBox_Telar9.Checked = true;
                checkBox_Urdidora.Checked = true;
            }
            else {
                checkBox_Telar1.Checked = false;
                checkBox_Telar2.Checked = false;
                checkBox_Telar3.Checked = false;
                checkBox_Telar4.Checked = false;
                checkBox_Telar5.Checked = false;
                checkBox_Telar6.Checked = false;
                checkBox_Telar7.Checked = false;
                checkBox_Telar8.Checked = false;
                checkBox_Telar9.Checked = false;
                checkBox_Urdidora.Checked = false;
            }
            
        }

        private void checkBox_SectorCordoneras_CheckedChanged(object sender, EventArgs e)
        {
            if (checkBox_SectorCordoneras.Checked)
            {
                checkBox_Cordonera1.Checked = true;
                checkBox_Cordonera2.Checked = true;
                checkBox_Cordonera3.Checked = true;
                checkBox_Cordonera4.Checked = true;
                checkBox_Cordonera5.Checked = true;
                checkBox_Cordonera6.Checked = true;
                checkBox_Cordonera7.Checked = true;
                checkBox_Cordonera8.Checked = true;
                checkBox_Cordonera9.Checked = true;
            }
            else
            {
                checkBox_Cordonera1.Checked = false;
                checkBox_Cordonera2.Checked = false;
                checkBox_Cordonera3.Checked = false;
                checkBox_Cordonera4.Checked = false;
                checkBox_Cordonera5.Checked = false;
                checkBox_Cordonera6.Checked = false;
                checkBox_Cordonera7.Checked = false;
                checkBox_Cordonera8.Checked = false;
                checkBox_Cordonera9.Checked = false;
            }
        }

        private void checkBox_SectorTerminacion_CheckedChanged(object sender, EventArgs e)
        {
            if (checkBox_SectorTerminacion.Checked)
            {
                checkBox_Terminacion1.Checked = true;
                checkBox_Terminacion2.Checked = true;
                checkBox_Terminacion3.Checked = true;
            }
            else {
                checkBox_Terminacion1.Checked = false;
                checkBox_Terminacion2.Checked = false;
                checkBox_Terminacion3.Checked = false;
            }
        }

        private void button_ResetearFiltros_Click(object sender, EventArgs e)
        {
            checkBox_SectorTelares.Checked = false;
            checkBox_Telar1.Checked = false;
            checkBox_Telar2.Checked = false;
            checkBox_Telar3.Checked = false;
            checkBox_Telar4.Checked = false;
            checkBox_Telar5.Checked = false;
            checkBox_Telar6.Checked = false;
            checkBox_Telar7.Checked = false;
            checkBox_Telar8.Checked = false;
            checkBox_Telar9.Checked = false;
            checkBox_Urdidora.Checked = false;

            checkBox_SectorCordoneras.Checked = false;
            checkBox_Cordonera1.Checked = false;
            checkBox_Cordonera2.Checked = false;
            checkBox_Cordonera3.Checked = false;
            checkBox_Cordonera4.Checked = false;
            checkBox_Cordonera5.Checked = false;
            checkBox_Cordonera6.Checked = false;
            checkBox_Cordonera7.Checked = false;
            checkBox_Cordonera8.Checked = false;
            checkBox_Cordonera9.Checked = false;

            checkBox_SectorTerminacion.Checked = false;
            checkBox_Terminacion1.Checked = false;
            checkBox_Terminacion2.Checked = false;
            checkBox_Terminacion3.Checked = false;
        }
    }
}
