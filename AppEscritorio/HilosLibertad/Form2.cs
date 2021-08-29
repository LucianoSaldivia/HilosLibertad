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
    public partial class frm_EdicionDeSectores : Form
    {
        public frm_EdicionDeSectores()
        {
            InitializeComponent();
        }

        Consultas con = new Consultas();

        // Creamos el objeto de la clase Conexion y la instanciamos
        Conexion cn = new Conexion();

        public int ID_SECTOR_SELECCIONADO;

        private void Form2_Load(object sender, EventArgs e)
        {
            dgv_Sectores.DataSource = con.llenarDataGridView_Sectores();
            dgv_Sectores.ClearSelection();

            cmb_Sector.DataSource = con.llenarComboBox_Sectores();
            cmb_Sector.DisplayMember = "nombreSectorUSUARIO";
            cmb_Sector.ValueMember = "idSector";

        }
                
        private void btn_GuardarCambios_Click(object sender, EventArgs e)
        {
            //
        }


        int ID_SECTOR;

        private void cmb_Sector_SelectedIndexChanged(object sender, EventArgs e)
        {
            ID_SECTOR_SELECCIONADO = cmb_Sector.SelectedIndex + 1;      // El índice del ComboBox empieza el 0, pero el idSector empieza en 1: por eso se agrega el 1.
            string consulta = "SELECT s.idSector, s.nombreSectorUSUARIO FROM HL.sectores s WHERE s.idSector = " + ID_SECTOR_SELECCIONADO + "";
            SqlCommand c = new SqlCommand(consulta, cn.LeerCadena());
            SqlDataReader dr = c.ExecuteReader();
            if (dr.Read()) {
                ID_SECTOR = Convert.ToInt32(dr["idSector"]);
                txt_ID.Text = dr["idSector"].ToString();
                txt_Nombre.Text = dr["nombreSectorUSUARIO"].ToString();
            }
                        
        }
    }
}
