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
            if (chk_SectorTelares.CheckState == CheckState.Checked)
            {
                setCheckButtonsTelares(true);
            }
            else {
                setCheckButtonsTelares(false);
            }
            
        }

        private void checkBox_SectorCordoneras_CheckedChanged(object sender, EventArgs e)
        {
            if (chk_SectorCordoneras.CheckState == CheckState.Checked)
            {
                setCheckButtonsCordoneras(true);
            }
            else
            {
                setCheckButtonsCordoneras(false);
            }
        }

        private void checkBox_SectorTerminacion_CheckedChanged(object sender, EventArgs e)
        {
            if (chk_SectorTerminacion.CheckState == CheckState.Checked)
            {
                setCheckButtonsTerminacion(true);
            }
            else {
                setCheckButtonsTerminacion(false);
            }
        }

        private void button_ResetearFiltros_Click(object sender, EventArgs e)
        {
            setCheckButtonSectorTelares(false);
            setCheckButtonsTelares(false);
            setCheckButtonSectorCordoneras(false);
            setCheckButtonsCordoneras(false);
            setCheckButtonSectorTerminacion(false);
            setCheckButtonsTerminacion(false);
        }

        private void setCheckButtonSectorTelares(bool valor) {
            chk_SectorTelares.Checked = valor;
        }

        private void setCheckButtonSectorCordoneras(bool valor)
        {
            chk_SectorCordoneras.Checked = valor;
        }

        private void setCheckButtonSectorTerminacion(bool valor)
        {
            chk_SectorTerminacion.Checked = valor;
        }


        private void setCheckButtonsTelares(bool valor) {
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
        }

        private void setCheckButtonsCordoneras(bool valor) {
            chk_Cordonera1.Checked = valor;
            chk_Cordonera2.Checked = valor;
            chk_Cordonera3.Checked = valor;
            chk_Cordonera4.Checked = valor;
            chk_Cordonera5.Checked = valor;
            chk_Cordonera6.Checked = valor;
            chk_Cordonera7.Checked = valor;
            chk_Cordonera8.Checked = valor;
            chk_Cordonera9.Checked = valor;
        }
        
        private void setCheckButtonsTerminacion(bool valor)
        {
            chk_Terminacion1.Checked = valor;
            chk_Terminacion2.Checked = valor;
            chk_Terminacion3.Checked = valor;
        }


        /*
        private bool estanTildadosTodosLosTelares() {
            if (chk_Telar1.Checked && chk_Telar2.Checked && chk_Telar3.Checked && chk_Telar4.Checked && chk_Telar5.Checked && chk_Telar6.Checked && chk_Telar7.Checked && chk_Telar8.Checked && chk_Telar9.Checked)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        private bool estanDestildadosTodosLosTelares()
        {
            if (!chk_Telar1.Checked && !chk_Telar2.Checked && !chk_Telar3.Checked && !chk_Telar4.Checked && !chk_Telar5.Checked && !chk_Telar6.Checked && !chk_Telar7.Checked && !chk_Telar8.Checked && !chk_Telar9.Checked)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        */

        // CORREGIR ESTA VALIDACIÓN Y AGREGAR LAS OTRAS DOS

        /*
        public void validarCheckButtonSectorTelares() {

            // if (!estanTildadosTodosLosTelares() && !estanDestildadosTodosLosTelares()) chk_SectorTelares.CheckState = CheckState.Indeterminate;

            
            if (estanTildadosTodosLosTelares()) 
            {
                chk_SectorTelares.CheckState = CheckState.Checked;
            }
            else
            {
                if (estanDestildadosTodosLosTelares())
                {
                    chk_SectorTelares.CheckState = CheckState.Unchecked;
                }
                else
                {
                    chk_SectorTelares.CheckState = CheckState.Indeterminate;
                }
            }
            
        }
        */


        private void chk_Telar1_CheckedChanged(object sender, EventArgs e)
        {
            //validarCheckButtonSectorTelares();
        }

        private void chk_Cordonera1_CheckedChanged(object sender, EventArgs e)
        {
            //
        }

        private void btn_Mostrar_Click(object sender, EventArgs e)
        {
            //
        }
    }
}
