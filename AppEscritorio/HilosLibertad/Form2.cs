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
    public partial class frm_EdicionDeSectores : Form
    {
        public frm_EdicionDeSectores()
        {
            InitializeComponent();
        }

        Consultas con = new Consultas();
        private void Form2_Load(object sender, EventArgs e)
        {
            dgv_Sectores.DataSource = con.llenarDataGridView_Sectores();
            dgv_Sectores.ClearSelection();

            cmb_Sector.DataSource = con.llenarComboBox_Sectores();
            cmb_Sector.DisplayMember = "nombreSectorUSUARIO";
            cmb_Sector.ValueMember = "idSector";
        }
                
        private void btn_MostrarSectores_Click(object sender, EventArgs e)
        {
            //
        }

        private void cmb_Sector_SelectedIndexChanged(object sender, EventArgs e)
        {
            //SqlDataReader
            
            string consulta = "SELECT idSector, nombreSectorUSUARIO FROM HL.sectores WHERE nombreSectorUSUARIO = '" + cmb_Sector.SelectedItem.ToString() + "'";
        }
    }
}
