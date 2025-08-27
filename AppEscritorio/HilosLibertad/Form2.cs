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
        
        private void Form2_Load(object sender, EventArgs e)
        {
            dgv_Sectores.DataSource = con.llenarDataGridView_Sectores();
            dgv_Sectores.ClearSelection();

            cmb_Sector.DataSource = con.llenarComboBox_Sectores();
            cmb_Sector.DisplayMember = "nombreSectorUSUARIO";
            cmb_Sector.ValueMember = "idSector";

            grp_EdicionDelSector.Enabled = false;
        }
        
        public int ID_SECTOR_SELECCIONADO;

        /*
         * cont cuenta la cantidad de veces que un valor del txt_Numero sufre un cambio tras ser seleccionado desde el cmb_Sector.
         * Cuando se selecciona un ítem del cmb_Sector, se pone en 0 (se reinicia). Incrementará su valor en 1 por cada vez que el txt_Numero sufra una modificación.
         */
        public int cont = 0;

        private void cmb_Sector_SelectedIndexChanged(object sender, EventArgs e)
        {
            ID_SECTOR_SELECCIONADO = cmb_Sector.SelectedIndex + 1;      // El índice del ComboBox empieza el 0, pero el idSector empieza en 1: por eso se agrega el 1.
            string consulta = "EXECUTE HL.sp_cargarTXTsectores " + ID_SECTOR_SELECCIONADO + "";
            SqlCommand c = new SqlCommand(consulta, cn.LeerCadena());
            SqlDataReader dr = c.ExecuteReader();
            if (dr.Read()) {
                txt_ID.Text = dr["idSector"].ToString();
                txt_Nombre.Text = dr["nombreSectorUSUARIO"].ToString();
            }

            grp_EdicionDelSector.Enabled = true;

            cont = 0;
        }

        private void txt_Nombre_TextChanged(object sender, EventArgs e)
        {
            cont = cont + 1;
            
            string consulta_string = "SELECT COUNT(*) AS 'Q' FROM HL.sectores s WHERE s.nombreSectorUSUARIO = '" + txt_Nombre.Text + "' AND s.nombreSectorUSUARIO <> '" + cmb_Sector.Text + "'";  // Cantidad de sectores que hay en la tabla con el nombre que del textBox
            int CANTIDAD = 0; 
            SqlCommand c = new SqlCommand(consulta_string, cn.LeerCadena());
            SqlDataReader dr = c.ExecuteReader();

            if (dr.Read()) CANTIDAD = Convert.ToInt32(dr["Q"]);
            
            if (CANTIDAD >= 1 && cont >= 2)  // Si en la tabla Sectores hay más de un nombre con el mismo valor que el del textBox (CANTIDAD >= 1) y el nombre ingresado en el textBox se cambió al menos una vez (cont >= 2), entonces...
            {
                // nombre ocupado: ya hay un sector con ese nombre
                pintarNombreSectorDeColor(Color.Crimson);
                btn_GuardarCambios.Enabled = false;
            }
            else
            {
                // nombre disponible: ningún sector tiene ese nombre por el momento
                pintarNombreSectorDeColor(Color.Black);
                btn_GuardarCambios.Enabled = true;
            }
        }

        private void btn_GuardarCambios_Click(object sender, EventArgs e)
        {
            ID_SECTOR_SELECCIONADO = cmb_Sector.SelectedIndex + 1;      // El índice del ComboBox empieza el 0, pero el idSector empieza en 1: por eso se agrega el 1.
            string NOMBRE_SECTOR = txt_Nombre.Text;

            string consulta = "EXECUTE HL.sp_actualizarSector " + ID_SECTOR_SELECCIONADO + ", " + NOMBRE_SECTOR + "";
            SqlCommand c = new SqlCommand(consulta, cn.LeerCadena());
            SqlDataReader dr = c.ExecuteReader();

            dgv_Sectores.DataSource = con.llenarDataGridView_Sectores();
            dgv_Sectores.ClearSelection();

            cmb_Sector.DataSource = con.llenarComboBox_Sectores();
        }


        private void pintarNombreSectorDeColor(Color c)      // Red o ControlText, por ejemplo
        {
            txt_Nombre.ForeColor = c;
            lab_Nombre.ForeColor = c;
        }
                
    }
}
