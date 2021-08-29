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

        public int ID_MAQUINA_SELECCIONADA;
        private void cmb_Maquina_SelectedIndexChanged(object sender, EventArgs e)
        {
            ID_MAQUINA_SELECCIONADA = cmb_Maquina.SelectedIndex + 1;      // El índice del ComboBox empieza el 0, pero el idSector empieza en 1: por eso se agrega el 1.
            string consulta = "SELECT m.idMaquina, m.numeroMaquinaUSUARIO, m.nombreMaquinaUSUARIO, m.descripcionMaquinaUSUARIO FROM HL.maquinas m WHERE m.idMaquina = " + ID_MAQUINA_SELECCIONADA + "";
            SqlCommand c = new SqlCommand(consulta, cn.LeerCadena());
            SqlDataReader dr = c.ExecuteReader();
            if (dr.Read())
            {
                txt_ID.Text = dr["idMaquina"].ToString();
                txt_Numero.Text = dr["numeroMaquinaUSUARIO"].ToString();
                txt_Nombre.Text = dr["nombreMaquinaUSUARIO"].ToString();
                txt_Descripcion.Text = dr["descripcionMaquinaUSUARIO"].ToString();
            }
        }
    }
}
