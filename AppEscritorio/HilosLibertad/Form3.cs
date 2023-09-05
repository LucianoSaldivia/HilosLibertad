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
                txt_Descripcion.Text = dr["descripcionMaquinaUSUARIO"].ToString();
            }
        }

        private void btn_GuardarCambios_Click(object sender, EventArgs e)
        {
            ID_MAQUINA_SELECCIONADA = get_idMaquina_from_nombreMaquinaUSUARIO(cmb_Maquina.GetItemText(cmb_Maquina.SelectedItem));
            //Console.WriteLine("\ncmb_Maquina.GetItemText(cmb_Maquina.SelectedItem): " + cmb_Maquina.GetItemText(cmb_Maquina.SelectedItem));
            //Console.WriteLine("ID_MAQUINA_SELECCIONADA: " + ID_MAQUINA_SELECCIONADA);

            //ID_MAQUINA_SELECCIONADA = cmb_Maquina.SelectedIndex + 1;      // El índice del ComboBox empieza el 0, pero el idSector empieza en 1: por eso se agrega el 1.
            string NUMERO_MAQUINA = txt_Numero.Text;
            string NOMBRE_MAQUINA = txt_Nombre.Text;
            string DESCRIPCION_MAQUINA = txt_Descripcion.Text;

            string consulta = "EXECUTE HL.sp_actualizarMaquina " + ID_MAQUINA_SELECCIONADA + ", '" + NUMERO_MAQUINA + "', '" + NOMBRE_MAQUINA + "', '" + DESCRIPCION_MAQUINA + "'";
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
