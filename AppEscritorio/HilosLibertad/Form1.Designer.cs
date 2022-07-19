
namespace HilosLibertad
{
    partial class frm_Home
    {
        /// <summary>
        /// Variable del diseñador necesaria.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Limpiar los recursos que se estén usando.
        /// </summary>
        /// <param name="disposing">true si los recursos administrados se deben desechar; false en caso contrario.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Código generado por el Diseñador de Windows Forms

        /// <summary>
        /// Método necesario para admitir el Diseñador. No se puede modificar
        /// el contenido de este método con el editor de código.
        /// </summary>
        private void InitializeComponent()
        {
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle2 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle3 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle4 = new System.Windows.Forms.DataGridViewCellStyle();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frm_Home));
            this.dtp_FechaInicial = new System.Windows.Forms.DateTimePicker();
            this.dgv_TiemposPorMaquina = new System.Windows.Forms.DataGridView();
            this.dgv_TiemposPorSector = new System.Windows.Forms.DataGridView();
            this.lbl_CantidadHorasPorMaquina = new System.Windows.Forms.Label();
            this.lbl_CantidadHorasPorSector = new System.Windows.Forms.Label();
            this.dgv_TiemposTotales = new System.Windows.Forms.DataGridView();
            this.lbl_CantidadTotalHorasMaquina = new System.Windows.Forms.Label();
            this.grp_FiltroFecha = new System.Windows.Forms.GroupBox();
            this.lbl_FechaFinal = new System.Windows.Forms.Label();
            this.lbl_FechaInicial = new System.Windows.Forms.Label();
            this.dtp_FechaFinal = new System.Windows.Forms.DateTimePicker();
            this.cmb_MinutoFinal = new System.Windows.Forms.ComboBox();
            this.cmb_MinutoInicial = new System.Windows.Forms.ComboBox();
            this.cmb_HoraFinal = new System.Windows.Forms.ComboBox();
            this.cmb_HoraInicial = new System.Windows.Forms.ComboBox();
            this.grp_FiltroMaquinasSectores = new System.Windows.Forms.GroupBox();
            this.txt_NumeroDeLaMaquina = new System.Windows.Forms.TextBox();
            this.txt_NombreDeLaMaquina = new System.Windows.Forms.TextBox();
            this.txt_NombreDelSector = new System.Windows.Forms.TextBox();
            this.lbl_NumeroDeLaMaquina = new System.Windows.Forms.Label();
            this.lbl_NombreDeLaMaquina = new System.Windows.Forms.Label();
            this.lbl_NombreDelSector = new System.Windows.Forms.Label();
            this.grp_FiltroFranjaHoraria = new System.Windows.Forms.GroupBox();
            this.lbl_HorarioFinal = new System.Windows.Forms.Label();
            this.lbl_HorarioInicial = new System.Windows.Forms.Label();
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.editarSectoresToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.editarMáquinasToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.btn_CopiarAlPortapapeles_TiemposPorMaquina = new System.Windows.Forms.Button();
            this.btn_CopiarAlPortapapeles_TiemposPorSector = new System.Windows.Forms.Button();
            this.btn_CopiarAlPortapapeles_TiemposDeTodasLasMaquinas = new System.Windows.Forms.Button();
            this.lbl_Linea = new System.Windows.Forms.Label();
            this.pic_logo = new System.Windows.Forms.PictureBox();
            this.btn_CopiarAlPortapapeles_TiemposMaqSec = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_TiemposPorMaquina)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_TiemposPorSector)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_TiemposTotales)).BeginInit();
            this.grp_FiltroFecha.SuspendLayout();
            this.grp_FiltroMaquinasSectores.SuspendLayout();
            this.grp_FiltroFranjaHoraria.SuspendLayout();
            this.menuStrip1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pic_logo)).BeginInit();
            this.SuspendLayout();
            // 
            // dtp_FechaInicial
            // 
            this.dtp_FechaInicial.CalendarFont = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.dtp_FechaInicial.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.dtp_FechaInicial.Location = new System.Drawing.Point(117, 30);
            this.dtp_FechaInicial.Name = "dtp_FechaInicial";
            this.dtp_FechaInicial.Size = new System.Drawing.Size(265, 25);
            this.dtp_FechaInicial.TabIndex = 1;
            this.dtp_FechaInicial.ValueChanged += new System.EventHandler(this.dtp_FechaInicial_ValueChanged);
            // 
            // dgv_TiemposPorMaquina
            // 
            this.dgv_TiemposPorMaquina.AllowUserToAddRows = false;
            this.dgv_TiemposPorMaquina.AllowUserToDeleteRows = false;
            dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle1.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle1.ForeColor = System.Drawing.Color.Blue;
            dataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
            this.dgv_TiemposPorMaquina.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
            this.dgv_TiemposPorMaquina.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgv_TiemposPorMaquina.Location = new System.Drawing.Point(479, 55);
            this.dgv_TiemposPorMaquina.Name = "dgv_TiemposPorMaquina";
            this.dgv_TiemposPorMaquina.ReadOnly = true;
            dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle2.BackColor = System.Drawing.SystemColors.GradientActiveCaption;
            dataGridViewCellStyle2.Font = new System.Drawing.Font("Segoe UI Semibold", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle2.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle2.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle2.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgv_TiemposPorMaquina.RowHeadersDefaultCellStyle = dataGridViewCellStyle2;
            this.dgv_TiemposPorMaquina.RowHeadersVisible = false;
            this.dgv_TiemposPorMaquina.RowHeadersWidthSizeMode = System.Windows.Forms.DataGridViewRowHeadersWidthSizeMode.DisableResizing;
            this.dgv_TiemposPorMaquina.Size = new System.Drawing.Size(529, 487);
            this.dgv_TiemposPorMaquina.TabIndex = 6;
            // 
            // dgv_TiemposPorSector
            // 
            this.dgv_TiemposPorSector.AllowUserToAddRows = false;
            this.dgv_TiemposPorSector.AllowUserToDeleteRows = false;
            dataGridViewCellStyle3.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle3.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle3.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle3.ForeColor = System.Drawing.SystemColors.HotTrack;
            dataGridViewCellStyle3.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle3.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle3.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
            this.dgv_TiemposPorSector.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle3;
            this.dgv_TiemposPorSector.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgv_TiemposPorSector.Location = new System.Drawing.Point(479, 575);
            this.dgv_TiemposPorSector.Name = "dgv_TiemposPorSector";
            this.dgv_TiemposPorSector.ReadOnly = true;
            this.dgv_TiemposPorSector.RowHeadersVisible = false;
            this.dgv_TiemposPorSector.RowHeadersWidthSizeMode = System.Windows.Forms.DataGridViewRowHeadersWidthSizeMode.DisableResizing;
            this.dgv_TiemposPorSector.Size = new System.Drawing.Size(226, 113);
            this.dgv_TiemposPorSector.TabIndex = 23;
            // 
            // lbl_CantidadHorasPorMaquina
            // 
            this.lbl_CantidadHorasPorMaquina.AutoSize = true;
            this.lbl_CantidadHorasPorMaquina.Font = new System.Drawing.Font("Segoe UI Semibold", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_CantidadHorasPorMaquina.Location = new System.Drawing.Point(476, 32);
            this.lbl_CantidadHorasPorMaquina.Name = "lbl_CantidadHorasPorMaquina";
            this.lbl_CantidadHorasPorMaquina.Size = new System.Drawing.Size(89, 17);
            this.lbl_CantidadHorasPorMaquina.TabIndex = 28;
            this.lbl_CantidadHorasPorMaquina.Text = "Por Máquina:";
            // 
            // lbl_CantidadHorasPorSector
            // 
            this.lbl_CantidadHorasPorSector.AutoSize = true;
            this.lbl_CantidadHorasPorSector.Font = new System.Drawing.Font("Segoe UI Semibold", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_CantidadHorasPorSector.Location = new System.Drawing.Point(476, 552);
            this.lbl_CantidadHorasPorSector.Name = "lbl_CantidadHorasPorSector";
            this.lbl_CantidadHorasPorSector.Size = new System.Drawing.Size(74, 17);
            this.lbl_CantidadHorasPorSector.TabIndex = 29;
            this.lbl_CantidadHorasPorSector.Text = "Por Sector:";
            // 
            // dgv_TiemposTotales
            // 
            this.dgv_TiemposTotales.AllowUserToAddRows = false;
            this.dgv_TiemposTotales.AllowUserToDeleteRows = false;
            dataGridViewCellStyle4.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle4.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle4.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle4.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle4.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle4.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle4.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
            this.dgv_TiemposTotales.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle4;
            this.dgv_TiemposTotales.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgv_TiemposTotales.Location = new System.Drawing.Point(807, 582);
            this.dgv_TiemposTotales.Name = "dgv_TiemposTotales";
            this.dgv_TiemposTotales.ReadOnly = true;
            this.dgv_TiemposTotales.RowHeadersVisible = false;
            this.dgv_TiemposTotales.RowHeadersWidthSizeMode = System.Windows.Forms.DataGridViewRowHeadersWidthSizeMode.DisableResizing;
            this.dgv_TiemposTotales.Size = new System.Drawing.Size(210, 47);
            this.dgv_TiemposTotales.TabIndex = 30;
            // 
            // lbl_CantidadTotalHorasMaquina
            // 
            this.lbl_CantidadTotalHorasMaquina.Font = new System.Drawing.Font("Segoe UI Semibold", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_CantidadTotalHorasMaquina.Location = new System.Drawing.Point(804, 558);
            this.lbl_CantidadTotalHorasMaquina.Name = "lbl_CantidadTotalHorasMaquina";
            this.lbl_CantidadTotalHorasMaquina.Size = new System.Drawing.Size(142, 23);
            this.lbl_CantidadTotalHorasMaquina.TabIndex = 31;
            this.lbl_CantidadTotalHorasMaquina.Text = "Todas las Máquinas:";
            this.lbl_CantidadTotalHorasMaquina.Click += new System.EventHandler(this.lbl_CantidadTotalHorasMaquina_Click);
            // 
            // grp_FiltroFecha
            // 
            this.grp_FiltroFecha.Controls.Add(this.lbl_FechaFinal);
            this.grp_FiltroFecha.Controls.Add(this.lbl_FechaInicial);
            this.grp_FiltroFecha.Controls.Add(this.dtp_FechaFinal);
            this.grp_FiltroFecha.Controls.Add(this.dtp_FechaInicial);
            this.grp_FiltroFecha.Font = new System.Drawing.Font("Segoe UI Semibold", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.grp_FiltroFecha.Location = new System.Drawing.Point(22, 315);
            this.grp_FiltroFecha.Name = "grp_FiltroFecha";
            this.grp_FiltroFecha.Size = new System.Drawing.Size(409, 104);
            this.grp_FiltroFecha.TabIndex = 33;
            this.grp_FiltroFecha.TabStop = false;
            this.grp_FiltroFecha.Text = "Filtro por Fecha";
            // 
            // lbl_FechaFinal
            // 
            this.lbl_FechaFinal.AutoSize = true;
            this.lbl_FechaFinal.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_FechaFinal.ForeColor = System.Drawing.Color.Black;
            this.lbl_FechaFinal.Location = new System.Drawing.Point(40, 65);
            this.lbl_FechaFinal.Name = "lbl_FechaFinal";
            this.lbl_FechaFinal.Size = new System.Drawing.Size(74, 17);
            this.lbl_FechaFinal.TabIndex = 39;
            this.lbl_FechaFinal.Text = "Fecha Final:";
            this.lbl_FechaFinal.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // lbl_FechaInicial
            // 
            this.lbl_FechaInicial.AutoSize = true;
            this.lbl_FechaInicial.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_FechaInicial.Location = new System.Drawing.Point(35, 34);
            this.lbl_FechaInicial.Name = "lbl_FechaInicial";
            this.lbl_FechaInicial.Size = new System.Drawing.Size(80, 17);
            this.lbl_FechaInicial.TabIndex = 38;
            this.lbl_FechaInicial.Text = "Fecha Inicial:";
            this.lbl_FechaInicial.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // dtp_FechaFinal
            // 
            this.dtp_FechaFinal.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.dtp_FechaFinal.Location = new System.Drawing.Point(117, 61);
            this.dtp_FechaFinal.Name = "dtp_FechaFinal";
            this.dtp_FechaFinal.Size = new System.Drawing.Size(265, 25);
            this.dtp_FechaFinal.TabIndex = 2;
            this.dtp_FechaFinal.ValueChanged += new System.EventHandler(this.dtp_FechaFinal_ValueChanged);
            // 
            // cmb_MinutoFinal
            // 
            this.cmb_MinutoFinal.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmb_MinutoFinal.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmb_MinutoFinal.FormattingEnabled = true;
            this.cmb_MinutoFinal.Items.AddRange(new object[] {
            "00",
            "15",
            "30",
            "45"});
            this.cmb_MinutoFinal.Location = new System.Drawing.Point(342, 29);
            this.cmb_MinutoFinal.Name = "cmb_MinutoFinal";
            this.cmb_MinutoFinal.Size = new System.Drawing.Size(40, 23);
            this.cmb_MinutoFinal.TabIndex = 6;
            this.cmb_MinutoFinal.SelectedIndexChanged += new System.EventHandler(this.cmb_MinutoFinal_SelectedIndexChanged);
            // 
            // cmb_MinutoInicial
            // 
            this.cmb_MinutoInicial.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmb_MinutoInicial.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmb_MinutoInicial.FormattingEnabled = true;
            this.cmb_MinutoInicial.Items.AddRange(new object[] {
            "00",
            "15",
            "30",
            "45"});
            this.cmb_MinutoInicial.Location = new System.Drawing.Point(156, 29);
            this.cmb_MinutoInicial.Name = "cmb_MinutoInicial";
            this.cmb_MinutoInicial.Size = new System.Drawing.Size(40, 23);
            this.cmb_MinutoInicial.TabIndex = 4;
            this.cmb_MinutoInicial.SelectedIndexChanged += new System.EventHandler(this.cmb_MinutoInicial_SelectedIndexChanged);
            // 
            // cmb_HoraFinal
            // 
            this.cmb_HoraFinal.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmb_HoraFinal.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmb_HoraFinal.FormattingEnabled = true;
            this.cmb_HoraFinal.Items.AddRange(new object[] {
            "0",
            "1",
            "2",
            "3",
            "4",
            "5",
            "6",
            "7",
            "8",
            "9",
            "10",
            "11",
            "12",
            "13",
            "14",
            "15",
            "16",
            "17",
            "18",
            "19",
            "20",
            "21",
            "22",
            "23"});
            this.cmb_HoraFinal.Location = new System.Drawing.Point(303, 29);
            this.cmb_HoraFinal.Name = "cmb_HoraFinal";
            this.cmb_HoraFinal.Size = new System.Drawing.Size(40, 23);
            this.cmb_HoraFinal.TabIndex = 5;
            this.cmb_HoraFinal.SelectedIndexChanged += new System.EventHandler(this.cmb_HoraFinal_SelectedIndexChanged);
            // 
            // cmb_HoraInicial
            // 
            this.cmb_HoraInicial.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmb_HoraInicial.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmb_HoraInicial.ForeColor = System.Drawing.SystemColors.ControlText;
            this.cmb_HoraInicial.FormattingEnabled = true;
            this.cmb_HoraInicial.Items.AddRange(new object[] {
            "0",
            "1",
            "2",
            "3",
            "4",
            "5",
            "6",
            "7",
            "8",
            "9",
            "10",
            "11",
            "12",
            "13",
            "14",
            "15",
            "16",
            "17",
            "18",
            "19",
            "20",
            "21",
            "22",
            "23"});
            this.cmb_HoraInicial.Location = new System.Drawing.Point(117, 29);
            this.cmb_HoraInicial.Name = "cmb_HoraInicial";
            this.cmb_HoraInicial.Size = new System.Drawing.Size(40, 23);
            this.cmb_HoraInicial.TabIndex = 3;
            this.cmb_HoraInicial.Tag = "";
            this.cmb_HoraInicial.SelectedIndexChanged += new System.EventHandler(this.cmb_HoraInicial_SelectedIndexChanged);
            // 
            // grp_FiltroMaquinasSectores
            // 
            this.grp_FiltroMaquinasSectores.Controls.Add(this.txt_NumeroDeLaMaquina);
            this.grp_FiltroMaquinasSectores.Controls.Add(this.txt_NombreDeLaMaquina);
            this.grp_FiltroMaquinasSectores.Controls.Add(this.txt_NombreDelSector);
            this.grp_FiltroMaquinasSectores.Controls.Add(this.lbl_NumeroDeLaMaquina);
            this.grp_FiltroMaquinasSectores.Controls.Add(this.lbl_NombreDeLaMaquina);
            this.grp_FiltroMaquinasSectores.Controls.Add(this.lbl_NombreDelSector);
            this.grp_FiltroMaquinasSectores.Font = new System.Drawing.Font("Segoe UI Semibold", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.grp_FiltroMaquinasSectores.Location = new System.Drawing.Point(23, 533);
            this.grp_FiltroMaquinasSectores.Name = "grp_FiltroMaquinasSectores";
            this.grp_FiltroMaquinasSectores.Size = new System.Drawing.Size(409, 153);
            this.grp_FiltroMaquinasSectores.TabIndex = 40;
            this.grp_FiltroMaquinasSectores.TabStop = false;
            this.grp_FiltroMaquinasSectores.Text = "Filtro por Máquinas y Sectores";
            // 
            // txt_NumeroDeLaMaquina
            // 
            this.txt_NumeroDeLaMaquina.Location = new System.Drawing.Point(179, 37);
            this.txt_NumeroDeLaMaquina.MaxLength = 255;
            this.txt_NumeroDeLaMaquina.Name = "txt_NumeroDeLaMaquina";
            this.txt_NumeroDeLaMaquina.Size = new System.Drawing.Size(202, 25);
            this.txt_NumeroDeLaMaquina.TabIndex = 7;
            this.txt_NumeroDeLaMaquina.TextChanged += new System.EventHandler(this.txt_NumeroDeLaMaquina_TextChanged);
            // 
            // txt_NombreDeLaMaquina
            // 
            this.txt_NombreDeLaMaquina.Location = new System.Drawing.Point(179, 71);
            this.txt_NombreDeLaMaquina.MaxLength = 255;
            this.txt_NombreDeLaMaquina.Name = "txt_NombreDeLaMaquina";
            this.txt_NombreDeLaMaquina.Size = new System.Drawing.Size(202, 25);
            this.txt_NombreDeLaMaquina.TabIndex = 8;
            this.txt_NombreDeLaMaquina.TextChanged += new System.EventHandler(this.txt_NombreDeLaMaquina_TextChanged);
            // 
            // txt_NombreDelSector
            // 
            this.txt_NombreDelSector.Location = new System.Drawing.Point(179, 106);
            this.txt_NombreDelSector.MaxLength = 255;
            this.txt_NombreDelSector.Name = "txt_NombreDelSector";
            this.txt_NombreDelSector.Size = new System.Drawing.Size(202, 25);
            this.txt_NombreDelSector.TabIndex = 9;
            this.txt_NombreDelSector.TextChanged += new System.EventHandler(this.txt_NombreDelSector_TextChanged);
            // 
            // lbl_NumeroDeLaMaquina
            // 
            this.lbl_NumeroDeLaMaquina.AutoSize = true;
            this.lbl_NumeroDeLaMaquina.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_NumeroDeLaMaquina.Location = new System.Drawing.Point(29, 40);
            this.lbl_NumeroDeLaMaquina.Name = "lbl_NumeroDeLaMaquina";
            this.lbl_NumeroDeLaMaquina.Size = new System.Drawing.Size(147, 17);
            this.lbl_NumeroDeLaMaquina.TabIndex = 42;
            this.lbl_NumeroDeLaMaquina.Text = "Número de la Máquina:";
            this.lbl_NumeroDeLaMaquina.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // lbl_NombreDeLaMaquina
            // 
            this.lbl_NombreDeLaMaquina.AutoSize = true;
            this.lbl_NombreDeLaMaquina.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_NombreDeLaMaquina.Location = new System.Drawing.Point(28, 74);
            this.lbl_NombreDeLaMaquina.Name = "lbl_NombreDeLaMaquina";
            this.lbl_NombreDeLaMaquina.Size = new System.Drawing.Size(148, 17);
            this.lbl_NombreDeLaMaquina.TabIndex = 41;
            this.lbl_NombreDeLaMaquina.Text = "Nombre de la Máquina:";
            this.lbl_NombreDeLaMaquina.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // lbl_NombreDelSector
            // 
            this.lbl_NombreDelSector.AutoSize = true;
            this.lbl_NombreDelSector.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_NombreDelSector.Location = new System.Drawing.Point(53, 109);
            this.lbl_NombreDelSector.Name = "lbl_NombreDelSector";
            this.lbl_NombreDelSector.Size = new System.Drawing.Size(123, 17);
            this.lbl_NombreDelSector.TabIndex = 40;
            this.lbl_NombreDelSector.Text = "Nombre del Sector:";
            this.lbl_NombreDelSector.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // grp_FiltroFranjaHoraria
            // 
            this.grp_FiltroFranjaHoraria.Controls.Add(this.lbl_HorarioFinal);
            this.grp_FiltroFranjaHoraria.Controls.Add(this.lbl_HorarioInicial);
            this.grp_FiltroFranjaHoraria.Controls.Add(this.cmb_MinutoInicial);
            this.grp_FiltroFranjaHoraria.Controls.Add(this.cmb_MinutoFinal);
            this.grp_FiltroFranjaHoraria.Controls.Add(this.cmb_HoraInicial);
            this.grp_FiltroFranjaHoraria.Controls.Add(this.cmb_HoraFinal);
            this.grp_FiltroFranjaHoraria.Font = new System.Drawing.Font("Segoe UI Semibold", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.grp_FiltroFranjaHoraria.ForeColor = System.Drawing.SystemColors.ControlText;
            this.grp_FiltroFranjaHoraria.Location = new System.Drawing.Point(23, 440);
            this.grp_FiltroFranjaHoraria.Name = "grp_FiltroFranjaHoraria";
            this.grp_FiltroFranjaHoraria.Size = new System.Drawing.Size(409, 73);
            this.grp_FiltroFranjaHoraria.TabIndex = 40;
            this.grp_FiltroFranjaHoraria.TabStop = false;
            this.grp_FiltroFranjaHoraria.Text = "Filtro por Franja Horaria";
            // 
            // lbl_HorarioFinal
            // 
            this.lbl_HorarioFinal.AutoSize = true;
            this.lbl_HorarioFinal.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_HorarioFinal.Location = new System.Drawing.Point(214, 32);
            this.lbl_HorarioFinal.Name = "lbl_HorarioFinal";
            this.lbl_HorarioFinal.Size = new System.Drawing.Size(86, 17);
            this.lbl_HorarioFinal.TabIndex = 39;
            this.lbl_HorarioFinal.Text = "Horario Final:";
            this.lbl_HorarioFinal.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // lbl_HorarioInicial
            // 
            this.lbl_HorarioInicial.AutoSize = true;
            this.lbl_HorarioInicial.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_HorarioInicial.Location = new System.Drawing.Point(22, 32);
            this.lbl_HorarioInicial.Name = "lbl_HorarioInicial";
            this.lbl_HorarioInicial.Size = new System.Drawing.Size(92, 17);
            this.lbl_HorarioInicial.TabIndex = 38;
            this.lbl_HorarioInicial.Text = "Horario Inicial:";
            this.lbl_HorarioInicial.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // menuStrip1
            // 
            this.menuStrip1.BackColor = System.Drawing.Color.GhostWhite;
            this.menuStrip1.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.editarSectoresToolStripMenuItem,
            this.editarMáquinasToolStripMenuItem});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Size = new System.Drawing.Size(1044, 25);
            this.menuStrip1.TabIndex = 101;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // editarSectoresToolStripMenuItem
            // 
            this.editarSectoresToolStripMenuItem.Name = "editarSectoresToolStripMenuItem";
            this.editarSectoresToolStripMenuItem.Size = new System.Drawing.Size(108, 21);
            this.editarSectoresToolStripMenuItem.Text = "Editar Sectores";
            this.editarSectoresToolStripMenuItem.Click += new System.EventHandler(this.editarSectoresToolStripMenuItem_Click);
            // 
            // editarMáquinasToolStripMenuItem
            // 
            this.editarMáquinasToolStripMenuItem.Name = "editarMáquinasToolStripMenuItem";
            this.editarMáquinasToolStripMenuItem.Size = new System.Drawing.Size(115, 21);
            this.editarMáquinasToolStripMenuItem.Text = "Editar Máquinas";
            this.editarMáquinasToolStripMenuItem.Click += new System.EventHandler(this.editarMáquinasToolStripMenuItem_Click);
            // 
            // btn_CopiarAlPortapapeles_TiemposPorMaquina
            // 
            this.btn_CopiarAlPortapapeles_TiemposPorMaquina.Font = new System.Drawing.Font("Segoe UI", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_CopiarAlPortapapeles_TiemposPorMaquina.Location = new System.Drawing.Point(963, 32);
            this.btn_CopiarAlPortapapeles_TiemposPorMaquina.Name = "btn_CopiarAlPortapapeles_TiemposPorMaquina";
            this.btn_CopiarAlPortapapeles_TiemposPorMaquina.Size = new System.Drawing.Size(51, 23);
            this.btn_CopiarAlPortapapeles_TiemposPorMaquina.TabIndex = 103;
            this.btn_CopiarAlPortapapeles_TiemposPorMaquina.Text = "Copiar";
            this.btn_CopiarAlPortapapeles_TiemposPorMaquina.UseVisualStyleBackColor = true;
            this.btn_CopiarAlPortapapeles_TiemposPorMaquina.Click += new System.EventHandler(this.btn_CopiarAlPortapapeles_TiemposPorMaquina_Click);
            // 
            // btn_CopiarAlPortapapeles_TiemposPorSector
            // 
            this.btn_CopiarAlPortapapeles_TiemposPorSector.Font = new System.Drawing.Font("Segoe UI", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_CopiarAlPortapapeles_TiemposPorSector.Location = new System.Drawing.Point(656, 552);
            this.btn_CopiarAlPortapapeles_TiemposPorSector.Name = "btn_CopiarAlPortapapeles_TiemposPorSector";
            this.btn_CopiarAlPortapapeles_TiemposPorSector.Size = new System.Drawing.Size(51, 23);
            this.btn_CopiarAlPortapapeles_TiemposPorSector.TabIndex = 104;
            this.btn_CopiarAlPortapapeles_TiemposPorSector.Text = "Copiar";
            this.btn_CopiarAlPortapapeles_TiemposPorSector.UseVisualStyleBackColor = true;
            this.btn_CopiarAlPortapapeles_TiemposPorSector.Click += new System.EventHandler(this.btn_CopiarAlPortapapeles_TiemposPorSector_Click);
            // 
            // btn_CopiarAlPortapapeles_TiemposDeTodasLasMaquinas
            // 
            this.btn_CopiarAlPortapapeles_TiemposDeTodasLasMaquinas.Font = new System.Drawing.Font("Segoe UI", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_CopiarAlPortapapeles_TiemposDeTodasLasMaquinas.Location = new System.Drawing.Point(967, 558);
            this.btn_CopiarAlPortapapeles_TiemposDeTodasLasMaquinas.Name = "btn_CopiarAlPortapapeles_TiemposDeTodasLasMaquinas";
            this.btn_CopiarAlPortapapeles_TiemposDeTodasLasMaquinas.Size = new System.Drawing.Size(51, 23);
            this.btn_CopiarAlPortapapeles_TiemposDeTodasLasMaquinas.TabIndex = 105;
            this.btn_CopiarAlPortapapeles_TiemposDeTodasLasMaquinas.Text = "Copiar";
            this.btn_CopiarAlPortapapeles_TiemposDeTodasLasMaquinas.UseVisualStyleBackColor = true;
            this.btn_CopiarAlPortapapeles_TiemposDeTodasLasMaquinas.Click += new System.EventHandler(this.btn_CopiarAlPortapapeles_TiemposDeTodasLasMaquinas_Click);
            // 
            // lbl_Linea
            // 
            this.lbl_Linea.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.lbl_Linea.Location = new System.Drawing.Point(456, 46);
            this.lbl_Linea.Name = "lbl_Linea";
            this.lbl_Linea.Size = new System.Drawing.Size(2, 640);
            this.lbl_Linea.TabIndex = 107;
            // 
            // pic_logo
            // 
            this.pic_logo.Image = global::HilosLibertad.Properties.Resources.logoNUEVO_7_blanco_por_fuera_RECORTE_MÁS1;
            this.pic_logo.InitialImage = null;
            this.pic_logo.Location = new System.Drawing.Point(22, 46);
            this.pic_logo.Name = "pic_logo";
            this.pic_logo.Size = new System.Drawing.Size(410, 241);
            this.pic_logo.SizeMode = System.Windows.Forms.PictureBoxSizeMode.CenterImage;
            this.pic_logo.TabIndex = 106;
            this.pic_logo.TabStop = false;
            // 
            // btn_CopiarAlPortapapeles_TiemposMaqSec
            // 
            this.btn_CopiarAlPortapapeles_TiemposMaqSec.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_CopiarAlPortapapeles_TiemposMaqSec.Location = new System.Drawing.Point(713, 548);
            this.btn_CopiarAlPortapapeles_TiemposMaqSec.Name = "btn_CopiarAlPortapapeles_TiemposMaqSec";
            this.btn_CopiarAlPortapapeles_TiemposMaqSec.Size = new System.Drawing.Size(69, 61);
            this.btn_CopiarAlPortapapeles_TiemposMaqSec.TabIndex = 108;
            this.btn_CopiarAlPortapapeles_TiemposMaqSec.Text = "Copiar";
            this.btn_CopiarAlPortapapeles_TiemposMaqSec.UseVisualStyleBackColor = true;
            this.btn_CopiarAlPortapapeles_TiemposMaqSec.Click += new System.EventHandler(this.btn_CopiarAlPortapapeles_TiemposMaqSec_Click);
            // 
            // frm_Home
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1044, 702);
            this.Controls.Add(this.btn_CopiarAlPortapapeles_TiemposMaqSec);
            this.Controls.Add(this.lbl_Linea);
            this.Controls.Add(this.pic_logo);
            this.Controls.Add(this.btn_CopiarAlPortapapeles_TiemposDeTodasLasMaquinas);
            this.Controls.Add(this.btn_CopiarAlPortapapeles_TiemposPorSector);
            this.Controls.Add(this.btn_CopiarAlPortapapeles_TiemposPorMaquina);
            this.Controls.Add(this.grp_FiltroFranjaHoraria);
            this.Controls.Add(this.grp_FiltroMaquinasSectores);
            this.Controls.Add(this.grp_FiltroFecha);
            this.Controls.Add(this.lbl_CantidadTotalHorasMaquina);
            this.Controls.Add(this.dgv_TiemposTotales);
            this.Controls.Add(this.lbl_CantidadHorasPorSector);
            this.Controls.Add(this.lbl_CantidadHorasPorMaquina);
            this.Controls.Add(this.dgv_TiemposPorSector);
            this.Controls.Add(this.dgv_TiemposPorMaquina);
            this.Controls.Add(this.menuStrip1);
            this.Cursor = System.Windows.Forms.Cursors.Default;
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MainMenuStrip = this.menuStrip1;
            this.Name = "frm_Home";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Hilos Libertad";
            this.Load += new System.EventHandler(this.FormularioPrincipal_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgv_TiemposPorMaquina)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_TiemposPorSector)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_TiemposTotales)).EndInit();
            this.grp_FiltroFecha.ResumeLayout(false);
            this.grp_FiltroFecha.PerformLayout();
            this.grp_FiltroMaquinasSectores.ResumeLayout(false);
            this.grp_FiltroMaquinasSectores.PerformLayout();
            this.grp_FiltroFranjaHoraria.ResumeLayout(false);
            this.grp_FiltroFranjaHoraria.PerformLayout();
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pic_logo)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.DateTimePicker dtp_FechaInicial;
        private System.Windows.Forms.DataGridView dgv_TiemposPorMaquina;
        private System.Windows.Forms.DataGridView dgv_TiemposPorSector;
        private System.Windows.Forms.Label lbl_CantidadHorasPorMaquina;
        private System.Windows.Forms.Label lbl_CantidadHorasPorSector;
        private System.Windows.Forms.DataGridView dgv_TiemposTotales;
        private System.Windows.Forms.Label lbl_CantidadTotalHorasMaquina;
        private System.Windows.Forms.GroupBox grp_FiltroFecha;
        private System.Windows.Forms.ComboBox cmb_HoraInicial;
        private System.Windows.Forms.ComboBox cmb_HoraFinal;
        private System.Windows.Forms.DateTimePicker dtp_FechaFinal;
        private System.Windows.Forms.ComboBox cmb_MinutoFinal;
        private System.Windows.Forms.ComboBox cmb_MinutoInicial;
        private System.Windows.Forms.Label lbl_FechaFinal;
        private System.Windows.Forms.Label lbl_FechaInicial;
        private System.Windows.Forms.GroupBox grp_FiltroMaquinasSectores;
        private System.Windows.Forms.GroupBox grp_FiltroFranjaHoraria;
        private System.Windows.Forms.Label lbl_HorarioFinal;
        private System.Windows.Forms.Label lbl_HorarioInicial;
        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem editarSectoresToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem editarMáquinasToolStripMenuItem;
        private System.Windows.Forms.Button btn_CopiarAlPortapapeles_TiemposPorMaquina;
        private System.Windows.Forms.Button btn_CopiarAlPortapapeles_TiemposPorSector;
        private System.Windows.Forms.Button btn_CopiarAlPortapapeles_TiemposDeTodasLasMaquinas;
        private System.Windows.Forms.Label lbl_NumeroDeLaMaquina;
        private System.Windows.Forms.Label lbl_NombreDeLaMaquina;
        private System.Windows.Forms.Label lbl_NombreDelSector;
        private System.Windows.Forms.TextBox txt_NombreDelSector;
        private System.Windows.Forms.TextBox txt_NumeroDeLaMaquina;
        private System.Windows.Forms.TextBox txt_NombreDeLaMaquina;
        private System.Windows.Forms.PictureBox pic_logo;
        private System.Windows.Forms.Label lbl_Linea;
        private System.Windows.Forms.Button btn_CopiarAlPortapapeles_TiemposMaqSec;
    }
}

