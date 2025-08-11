using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Globalization;
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

            cmb_Sector.DataSource = con.llenarComboBox_Sectores();
            cmb_Sector.DisplayMember = "nombreSectorUSUARIO";
            cmb_Sector.ValueMember = "idSector";

            txt_Numero.ReadOnly = true;
            txt_Nombre.ReadOnly = true;
            txt_MetrosPorMinuto.ReadOnly = true;
            txt_Descripcion.ReadOnly = true;
            cmb_Sector.Enabled = false;
        }

        // Se crea una función para obtener, a partir de numeroMaquinaUSUARIO, la idMaquina
        public int get_idMaquina_from_nombreMaquinaUSUARIO(string nomMaq)
        {
            string cons = "SELECT m.idMaquina AS 'nmq'" +
                          "FROM HL.maquinas m " +
                          "WHERE m.nombreMaquinaUSUARIO = '" + nomMaq + "'";
            SqlConnection sql_con = cn.LeerCadena();
            SqlCommand comm = new SqlCommand(cons, sql_con);
            SqlDataReader dr = comm.ExecuteReader();
            int w = 0;
            if (dr.Read())
            {
                w = int.Parse(dr["nmq"].ToString());
            }
            cn.cerrarConexion(sql_con);
            return w;
        }

        public int ID_MAQUINA_SELECCIONADA;
        private void cmb_Maquina_SelectedIndexChanged(object sender, EventArgs e)
        {
            txt_Numero.ReadOnly = false;
            txt_Nombre.ReadOnly = false;
            txt_MetrosPorMinuto.ReadOnly = false;
            txt_Descripcion.ReadOnly = false;
            cmb_Sector.Enabled = true;

            ID_MAQUINA_SELECCIONADA = get_idMaquina_from_nombreMaquinaUSUARIO(cmb_Maquina.GetItemText(cmb_Maquina.SelectedItem));
            //Console.WriteLine("\ncmb_Maquina.GetItemText(cmb_Maquina.SelectedItem): " + cmb_Maquina.GetItemText(cmb_Maquina.SelectedItem));
            //Console.WriteLine("ID_MAQUINA_SELECCIONADA: " + ID_MAQUINA_SELECCIONADA);

            string consulta = "EXECUTE HL.sp_cargarTXTmaquinas " + ID_MAQUINA_SELECCIONADA + "";
            SqlCommand c = new SqlCommand(consulta, cn.LeerCadena());
            SqlDataReader dr = c.ExecuteReader();
            if (dr.Read())
            {
                txt_ID.Text = dr["idMaquina"].ToString();
                txt_Numero.Text = dr["numeroMaquinaUSUARIO"].ToString();
                txt_Nombre.Text = dr["nombreMaquinaUSUARIO"].ToString();
                txt_MetrosPorMinuto.Text = dr["metrosPorMinutoProducidosUSUARIO"].ToString();
                txt_Descripcion.Text = dr["descripcionMaquinaUSUARIO"].ToString();           
            }

            cmb_Sector.SelectedIndex = cmb_Sector.FindStringExact(getNombreSectorFromIdMaquina(ID_MAQUINA_SELECCIONADA));
        }

        public string getNombreSectorFromIdMaquina(int idMaq)
        {
            string cons = "SELECT s.nombreSectorUSUARIO AS 'nse' " +
                          "FROM HL.maquinas m JOIN HL.sectores s ON (m.idSector = s.idSector) " +
                          "WHERE m.idMaquina = " + idMaq;
            SqlConnection sql_con = cn.LeerCadena();
            SqlCommand comm = new SqlCommand(cons, sql_con);
            SqlDataReader dr = comm.ExecuteReader();
            string w = "";
            if (dr.Read())
            {
                w = dr["nse"].ToString();
            }
            cn.cerrarConexion(sql_con);
            return w;
        }

        private void btn_GuardarCambios_Click(object sender, EventArgs e)
        {
            ID_MAQUINA_SELECCIONADA = get_idMaquina_from_nombreMaquinaUSUARIO(cmb_Maquina.GetItemText(cmb_Maquina.SelectedItem));
            //Console.WriteLine("\ncmb_Maquina.GetItemText(cmb_Maquina.SelectedItem): " + cmb_Maquina.GetItemText(cmb_Maquina.SelectedItem));
            //Console.WriteLine("ID_MAQUINA_SELECCIONADA: " + ID_MAQUINA_SELECCIONADA);

            //ID_MAQUINA_SELECCIONADA = cmb_Maquina.SelectedIndex + 1;      // El índice del ComboBox empieza el 0, pero el idSector empieza en 1: por eso se agrega el 1.
            string NUMERO_MAQUINA = txt_Numero.Text;
            string NOMBRE_MAQUINA = txt_Nombre.Text;
            int METROS_POR_MINUTO = int.Parse(txt_MetrosPorMinuto.Text, CultureInfo.InvariantCulture.NumberFormat);
            string DESCRIPCION_MAQUINA = txt_Descripcion.Text;
            string SECTOR_MAQUINA = cmb_Sector.GetItemText(cmb_Sector.SelectedItem);


            string consulta = "EXECUTE HL.sp_actualizarMaquina " + ID_MAQUINA_SELECCIONADA + ", '" + NUMERO_MAQUINA + "', '" + NOMBRE_MAQUINA + "', '" + METROS_POR_MINUTO + "', '" + DESCRIPCION_MAQUINA + "', '" + SECTOR_MAQUINA + "'";
            SqlCommand c = new SqlCommand(consulta, cn.LeerCadena());
            SqlDataReader dr = c.ExecuteReader();

            dgv_Maquinas.DataSource = con.llenarDataGridView_Maquinas();
            dgv_Maquinas.ClearSelection();

            cmb_Maquina.DataSource = con.llenarComboBox_Maquinas();
        }

        // Se permite únicamente el ingreso de números, junto con el backspace y el delete.
        private void txt_Numero_KeyPress(object sender, KeyPressEventArgs e)
        {
            bool ES_UN_NUMERO = e.KeyChar >= 48 && e.KeyChar <= 57;     // Código ASCII de los NÚMEROS 0 a 9: desde 48 hasta 57
            bool ES_UN_BACKSPACE = e.KeyChar == 8;                      // Código ASCII del BACKSPACE o RETROCESO: 8
            bool ES_UN_DELETE = e.KeyChar == 127;                       // Código ASCII del DELETE o SUPRIMIR: 127
            if (!ES_UN_NUMERO && !ES_UN_BACKSPACE && !ES_UN_DELETE) {
                MessageBox.Show("Este campo solamente acepta números, de hasta 4 cifras inclusive.", "Solamente números", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                e.Handled = true;
                return;
            }
        }
    }
}
