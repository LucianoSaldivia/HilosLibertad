using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace HilosLibertad
{
    public partial class frm_EdicionDeMaquinas : Form
    {
        public frm_EdicionDeMaquinas()
        {
            InitializeComponent();
        }

        Consultas con = new Consultas();

        // Creamos el objeto de la clase Conexion y la instanciamos
        Conexion cn = new Conexion();

        private void frm_EdicionDeMaquinas_Load(object sender, EventArgs e)
        {
            dgv_Maquinas.DataSource = con.llenarDataGridView_Maquinas();
            dgv_Maquinas.Columns["#"].DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight;
            dgv_Maquinas.Columns["NÚMERO"].DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleRight;
            dgv_Maquinas.AutoResizeColumns();
            dgv_Maquinas.ClearSelection();

            cmb_Maquina.DataSource = con.llenarComboBox_Maquinas();
            cmb_Maquina.DisplayMember = "nombreMaquinaUSUARIO";
            cmb_Maquina.ValueMember = "idMaquina";
        }

        private void cmb_Maquina_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
