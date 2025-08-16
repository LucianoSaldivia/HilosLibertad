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

            grp_EdicionDeLaMaquina.Enabled = false;
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

        public int ID_MAQUINA_SELECCIONADA;

        /*
         * cont cuenta la cantidad de veces que un valor del txt_Numero sufre un cambio tras ser seleccionado desde el cmb_Maquina.
         * Cuando se selecciona un ítem del cmb_Maquina, se pone en 0 (se reinicia). Incrementará su valor en 1 por cada vez que el txt_Numero sufra una modificación.
         * numeroMaquinaRegistrado contiene el numeroMaquinaUSUARIO asociado al ítem seleccionado del combo.
         * Su valor es actualizado al seleccionarse un ítem del cmb_Maquina y se mantendrá igual mientras no se haya seleccionado otro ítem de dicho comboBox.
         */
        public int cont = 0;
        public string numeroMaquinaRegistrado = "";
        

        private void cmb_Maquina_SelectedIndexChanged(object sender, EventArgs e)
        {
            grp_EdicionDeLaMaquina.Enabled = true;

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

            cont = 0;
            numeroMaquinaRegistrado = txt_Numero.Text;
        }

        private void txt_Numero_TextChanged(object sender, EventArgs e)
        {
            cont = cont + 1;

            string consulta_string = "SELECT COUNT(*) AS 'Q' FROM (SELECT m.numeroMaquinaUSUARIO FROM HL.maquinas m EXCEPT SELECT m.numeroMaquinaUSUARIO FROM HL.maquinas m WHERE m.numeroMaquinaUSUARIO = '" + numeroMaquinaRegistrado + "') w WHERE w.numeroMaquinaUSUARIO = '" + txt_Numero.Text + "'";
            // Cantidad de máquinas que hay en la tabla con el mismo número del textBox

            //string consulta_string = "SELECT COUNT(*) AS 'Q' FROM HL.maquinas m WHERE m.numeroMaquinaUSUARIO = '" + Convert.ToInt32(txt_Numero.Text) + "'";
            // no anda

            //string consulta_string = "SELECT COUNT(*) AS 'Q' FROM (SELECT m.numeroMaquinaUSUARIO AS col_1 FROM HL.maquinas m UNION ALL SELECT '" + txt_Numero.Text + "') x WHERE x.col_1 = '" + txt_Numero.Text + "'";
            // ?

            //string consulta_string = "SELECT COUNT(*) AS 'Q' FROM (SELECT '" + Convert.ToInt32(txt_Numero.Text) + "' AS col_1 UNION ALL SELECT m.numeroMaquinaUSUARIO FROM HL.maquinas m) x WHERE x.col_1 = '" + Convert.ToInt32(txt_Numero.Text) + "'";
            // no anda

            int CANTIDAD = 0;
            SqlCommand c = new SqlCommand(consulta_string, cn.LeerCadena());
            SqlDataReader dr = c.ExecuteReader();

            if (dr.Read()) CANTIDAD = Convert.ToInt32(dr["Q"]);

            if (CANTIDAD >= 1 && cont >= 2) // Si en la tabla Maquinas hay más de un número con el mismo valor que el del textBox (CANTIDAD >= 1) y el número ingresado en el textBox se cambió al menos una vez (cont >= 2), entonces...
            {
                // número ocupado: ya hay una máquina con ese número
                pintarNumeroMaquinaDeColor(Color.Crimson);

                lbl_Nombre.Enabled = false;
                txt_Nombre.Enabled = false;
                lbl_MetrosPorMinuto.Enabled = false;
                txt_MetrosPorMinuto.Enabled = false;
                lbl_Descripcion.Enabled = false;
                txt_Descripcion.Enabled = false;
                lbl_Sector.Enabled = false;
                cmb_Sector.Enabled = false;
                btn_GuardarCambios.Enabled = false;
            }
            else
            {
                // número disponible: ninguna máquina tiene ese número por el momento
                pintarNumeroMaquinaDeColor(Color.Black);

                lbl_Nombre.Enabled = true;
                txt_Nombre.Enabled = true;
                lbl_MetrosPorMinuto.Enabled = true;
                txt_MetrosPorMinuto.Enabled = true;
                lbl_Descripcion.Enabled = true;
                txt_Descripcion.Enabled = true;
                lbl_Sector.Enabled = true;
                cmb_Sector.Enabled = true;
                btn_GuardarCambios.Enabled = true;
            }

        }
        private void txt_Nombre_TextChanged(object sender, EventArgs e)
        {
            string consulta_string = "SELECT COUNT(*) AS 'Q' FROM HL.maquinas m WHERE m.nombreMaquinaUSUARIO = '" + txt_Nombre.Text + "' AND m.nombreMaquinaUSUARIO <> '" + cmb_Maquina.Text + "'";  // Cantidad de máquinas que hay en la tabla con el mismo nombre del textBox
            int CANTIDAD = 0;
            SqlCommand c = new SqlCommand(consulta_string, cn.LeerCadena());
            SqlDataReader dr = c.ExecuteReader();

            if (dr.Read()) CANTIDAD = Convert.ToInt32(dr["Q"]);

            if (CANTIDAD >= 1) // nombre ocupado: ya hay un sector con ese nombre
            {
                pintarNombreMaquinaDeColor(Color.Crimson);

                lbl_Numero.Enabled = false;
                txt_Numero.Enabled = false; 
                lbl_MetrosPorMinuto.Enabled = false;
                txt_MetrosPorMinuto.Enabled = false;
                lbl_Descripcion.Enabled = false;
                txt_Descripcion.Enabled = false;
                lbl_Sector.Enabled = false;
                cmb_Sector.Enabled = false;
                btn_GuardarCambios.Enabled = false;
            }
            else // nombre disponible: ningún sector tiene ese nombre por el momento
            {
                pintarNombreMaquinaDeColor(Color.Black);

                lbl_Numero.Enabled = true;
                txt_Numero.Enabled = true;
                lbl_MetrosPorMinuto.Enabled = true;
                txt_MetrosPorMinuto.Enabled = true;
                lbl_Descripcion.Enabled = true;
                txt_Descripcion.Enabled = true;
                lbl_Sector.Enabled = true;
                cmb_Sector.Enabled = true;
                btn_GuardarCambios.Enabled = true;
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


        private void pintarNumeroMaquinaDeColor(Color c)      // Red o ControlText, por ejemplo
        {
            lbl_Numero.ForeColor = c; 
            txt_Numero.ForeColor = c;            
        }

        private void pintarNombreMaquinaDeColor(Color c)      // Red o ControlText, por ejemplo
        {
            lbl_Nombre.ForeColor = c; 
            txt_Nombre.ForeColor = c;            
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
