
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
            this.grp_Telares = new System.Windows.Forms.GroupBox();
            this.btn_SeleccionSectorTelares = new System.Windows.Forms.Button();
            this.chk_Telar5 = new System.Windows.Forms.CheckBox();
            this.chk_Telar1 = new System.Windows.Forms.CheckBox();
            this.chk_Telar4 = new System.Windows.Forms.CheckBox();
            this.chk_Telar2 = new System.Windows.Forms.CheckBox();
            this.chk_Urdidora = new System.Windows.Forms.CheckBox();
            this.chk_Telar3 = new System.Windows.Forms.CheckBox();
            this.chk_Telar9 = new System.Windows.Forms.CheckBox();
            this.chk_Telar6 = new System.Windows.Forms.CheckBox();
            this.chk_Telar8 = new System.Windows.Forms.CheckBox();
            this.chk_Telar7 = new System.Windows.Forms.CheckBox();
            this.dgv_TiemposPorMaquina = new System.Windows.Forms.DataGridView();
            this.grp_Cordoneras = new System.Windows.Forms.GroupBox();
            this.btn_SeleccionSectorCordoneras = new System.Windows.Forms.Button();
            this.chk_Cordonera7 = new System.Windows.Forms.CheckBox();
            this.chk_Cordonera8 = new System.Windows.Forms.CheckBox();
            this.chk_Cordonera9 = new System.Windows.Forms.CheckBox();
            this.chk_Cordonera4 = new System.Windows.Forms.CheckBox();
            this.chk_Cordonera5 = new System.Windows.Forms.CheckBox();
            this.chk_Cordonera6 = new System.Windows.Forms.CheckBox();
            this.chk_Cordonera1 = new System.Windows.Forms.CheckBox();
            this.chk_Cordonera2 = new System.Windows.Forms.CheckBox();
            this.chk_Cordonera3 = new System.Windows.Forms.CheckBox();
            this.grp_Terminacion = new System.Windows.Forms.GroupBox();
            this.btn_SeleccionSectorTerminacion = new System.Windows.Forms.Button();
            this.chk_Terminacion3 = new System.Windows.Forms.CheckBox();
            this.chk_Terminacion2 = new System.Windows.Forms.CheckBox();
            this.chk_Terminacion1 = new System.Windows.Forms.CheckBox();
            this.dgv_TiemposPorSector = new System.Windows.Forms.DataGridView();
            this.btn_Mostrar = new System.Windows.Forms.Button();
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
            this.btn_DeseleccionarTodo = new System.Windows.Forms.Button();
            this.btn_SeleccionarTodo = new System.Windows.Forms.Button();
            this.grp_FiltroFranjaHoraria = new System.Windows.Forms.GroupBox();
            this.lbl_HorarioFinal = new System.Windows.Forms.Label();
            this.lbl_HorarioInicial = new System.Windows.Forms.Label();
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.editarSectoresToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.editarMáquinasToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.btn_CopiarAlPortapapeles_TiemposPorMaquina = new System.Windows.Forms.Button();
            this.btn_CopiarAlPortapapeles_TiemposPorSector = new System.Windows.Forms.Button();
            this.btn_CopiarAlPortapapeles_TiemposDeTodasLasMaquinas = new System.Windows.Forms.Button();
            this.grp_Telares.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_TiemposPorMaquina)).BeginInit();
            this.grp_Cordoneras.SuspendLayout();
            this.grp_Terminacion.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_TiemposPorSector)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_TiemposTotales)).BeginInit();
            this.grp_FiltroFecha.SuspendLayout();
            this.grp_FiltroMaquinasSectores.SuspendLayout();
            this.grp_FiltroFranjaHoraria.SuspendLayout();
            this.menuStrip1.SuspendLayout();
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
            // 
            // grp_Telares
            // 
            this.grp_Telares.Controls.Add(this.btn_SeleccionSectorTelares);
            this.grp_Telares.Controls.Add(this.chk_Telar5);
            this.grp_Telares.Controls.Add(this.chk_Telar1);
            this.grp_Telares.Controls.Add(this.chk_Telar4);
            this.grp_Telares.Controls.Add(this.chk_Telar2);
            this.grp_Telares.Controls.Add(this.chk_Urdidora);
            this.grp_Telares.Controls.Add(this.chk_Telar3);
            this.grp_Telares.Controls.Add(this.chk_Telar9);
            this.grp_Telares.Controls.Add(this.chk_Telar6);
            this.grp_Telares.Controls.Add(this.chk_Telar8);
            this.grp_Telares.Controls.Add(this.chk_Telar7);
            this.grp_Telares.Font = new System.Drawing.Font("Segoe UI Semibold", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.grp_Telares.Location = new System.Drawing.Point(12, 26);
            this.grp_Telares.Name = "grp_Telares";
            this.grp_Telares.Size = new System.Drawing.Size(105, 310);
            this.grp_Telares.TabIndex = 5;
            this.grp_Telares.TabStop = false;
            this.grp_Telares.Text = "Telares";
            // 
            // btn_SeleccionSectorTelares
            // 
            this.btn_SeleccionSectorTelares.Font = new System.Drawing.Font("Segoe UI", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_SeleccionSectorTelares.Location = new System.Drawing.Point(6, 263);
            this.btn_SeleccionSectorTelares.Name = "btn_SeleccionSectorTelares";
            this.btn_SeleccionSectorTelares.Size = new System.Drawing.Size(93, 40);
            this.btn_SeleccionSectorTelares.TabIndex = 17;
            this.btn_SeleccionSectorTelares.Text = "Deseleccionar\r\ntodo el sector";
            this.btn_SeleccionSectorTelares.UseVisualStyleBackColor = true;
            this.btn_SeleccionSectorTelares.Click += new System.EventHandler(this.btn_SeleccionSectorTelares_Click);
            // 
            // chk_Telar5
            // 
            this.chk_Telar5.AutoSize = true;
            this.chk_Telar5.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.chk_Telar5.Location = new System.Drawing.Point(17, 118);
            this.chk_Telar5.Name = "chk_Telar5";
            this.chk_Telar5.Size = new System.Drawing.Size(59, 19);
            this.chk_Telar5.TabIndex = 11;
            this.chk_Telar5.Text = "Telar 5";
            this.chk_Telar5.UseVisualStyleBackColor = true;
            // 
            // chk_Telar1
            // 
            this.chk_Telar1.AutoSize = true;
            this.chk_Telar1.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.chk_Telar1.Location = new System.Drawing.Point(17, 26);
            this.chk_Telar1.Name = "chk_Telar1";
            this.chk_Telar1.Size = new System.Drawing.Size(59, 19);
            this.chk_Telar1.TabIndex = 7;
            this.chk_Telar1.Text = "Telar 1";
            this.chk_Telar1.UseVisualStyleBackColor = true;
            // 
            // chk_Telar4
            // 
            this.chk_Telar4.AutoSize = true;
            this.chk_Telar4.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.chk_Telar4.Location = new System.Drawing.Point(17, 95);
            this.chk_Telar4.Name = "chk_Telar4";
            this.chk_Telar4.Size = new System.Drawing.Size(59, 19);
            this.chk_Telar4.TabIndex = 10;
            this.chk_Telar4.Text = "Telar 4";
            this.chk_Telar4.UseVisualStyleBackColor = true;
            // 
            // chk_Telar2
            // 
            this.chk_Telar2.AutoSize = true;
            this.chk_Telar2.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.chk_Telar2.Location = new System.Drawing.Point(17, 49);
            this.chk_Telar2.Name = "chk_Telar2";
            this.chk_Telar2.Size = new System.Drawing.Size(59, 19);
            this.chk_Telar2.TabIndex = 8;
            this.chk_Telar2.Text = "Telar 2";
            this.chk_Telar2.UseVisualStyleBackColor = true;
            // 
            // chk_Urdidora
            // 
            this.chk_Urdidora.AutoSize = true;
            this.chk_Urdidora.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.chk_Urdidora.Location = new System.Drawing.Point(17, 233);
            this.chk_Urdidora.Name = "chk_Urdidora";
            this.chk_Urdidora.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.chk_Urdidora.Size = new System.Drawing.Size(72, 19);
            this.chk_Urdidora.TabIndex = 16;
            this.chk_Urdidora.Text = "Urdidora";
            this.chk_Urdidora.UseVisualStyleBackColor = true;
            // 
            // chk_Telar3
            // 
            this.chk_Telar3.AutoSize = true;
            this.chk_Telar3.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.chk_Telar3.Location = new System.Drawing.Point(17, 72);
            this.chk_Telar3.Name = "chk_Telar3";
            this.chk_Telar3.Size = new System.Drawing.Size(59, 19);
            this.chk_Telar3.TabIndex = 9;
            this.chk_Telar3.Text = "Telar 3";
            this.chk_Telar3.UseVisualStyleBackColor = true;
            // 
            // chk_Telar9
            // 
            this.chk_Telar9.AutoSize = true;
            this.chk_Telar9.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.chk_Telar9.Location = new System.Drawing.Point(17, 210);
            this.chk_Telar9.Name = "chk_Telar9";
            this.chk_Telar9.Size = new System.Drawing.Size(59, 19);
            this.chk_Telar9.TabIndex = 15;
            this.chk_Telar9.Text = "Telar 9";
            this.chk_Telar9.UseVisualStyleBackColor = true;
            // 
            // chk_Telar6
            // 
            this.chk_Telar6.AutoSize = true;
            this.chk_Telar6.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.chk_Telar6.Location = new System.Drawing.Point(17, 141);
            this.chk_Telar6.Name = "chk_Telar6";
            this.chk_Telar6.Size = new System.Drawing.Size(59, 19);
            this.chk_Telar6.TabIndex = 12;
            this.chk_Telar6.Text = "Telar 6";
            this.chk_Telar6.UseVisualStyleBackColor = true;
            // 
            // chk_Telar8
            // 
            this.chk_Telar8.AutoSize = true;
            this.chk_Telar8.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.chk_Telar8.Location = new System.Drawing.Point(17, 187);
            this.chk_Telar8.Name = "chk_Telar8";
            this.chk_Telar8.Size = new System.Drawing.Size(59, 19);
            this.chk_Telar8.TabIndex = 14;
            this.chk_Telar8.Text = "Telar 8";
            this.chk_Telar8.UseVisualStyleBackColor = true;
            // 
            // chk_Telar7
            // 
            this.chk_Telar7.AutoSize = true;
            this.chk_Telar7.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.chk_Telar7.Location = new System.Drawing.Point(17, 164);
            this.chk_Telar7.Name = "chk_Telar7";
            this.chk_Telar7.Size = new System.Drawing.Size(59, 19);
            this.chk_Telar7.TabIndex = 13;
            this.chk_Telar7.Text = "Telar 7";
            this.chk_Telar7.UseVisualStyleBackColor = true;
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
            this.dgv_TiemposPorMaquina.Location = new System.Drawing.Point(464, 63);
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
            this.dgv_TiemposPorMaquina.Size = new System.Drawing.Size(456, 509);
            this.dgv_TiemposPorMaquina.TabIndex = 6;
            // 
            // grp_Cordoneras
            // 
            this.grp_Cordoneras.Controls.Add(this.btn_SeleccionSectorCordoneras);
            this.grp_Cordoneras.Controls.Add(this.chk_Cordonera7);
            this.grp_Cordoneras.Controls.Add(this.chk_Cordonera8);
            this.grp_Cordoneras.Controls.Add(this.chk_Cordonera9);
            this.grp_Cordoneras.Controls.Add(this.chk_Cordonera4);
            this.grp_Cordoneras.Controls.Add(this.chk_Cordonera5);
            this.grp_Cordoneras.Controls.Add(this.chk_Cordonera6);
            this.grp_Cordoneras.Controls.Add(this.chk_Cordonera1);
            this.grp_Cordoneras.Controls.Add(this.chk_Cordonera2);
            this.grp_Cordoneras.Controls.Add(this.chk_Cordonera3);
            this.grp_Cordoneras.Font = new System.Drawing.Font("Segoe UI Semibold", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.grp_Cordoneras.Location = new System.Drawing.Point(126, 26);
            this.grp_Cordoneras.Name = "grp_Cordoneras";
            this.grp_Cordoneras.Size = new System.Drawing.Size(125, 310);
            this.grp_Cordoneras.TabIndex = 18;
            this.grp_Cordoneras.TabStop = false;
            this.grp_Cordoneras.Text = "Cordoneras";
            // 
            // btn_SeleccionSectorCordoneras
            // 
            this.btn_SeleccionSectorCordoneras.Font = new System.Drawing.Font("Segoe UI", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_SeleccionSectorCordoneras.Location = new System.Drawing.Point(6, 263);
            this.btn_SeleccionSectorCordoneras.Name = "btn_SeleccionSectorCordoneras";
            this.btn_SeleccionSectorCordoneras.Size = new System.Drawing.Size(113, 40);
            this.btn_SeleccionSectorCordoneras.TabIndex = 27;
            this.btn_SeleccionSectorCordoneras.Text = "Deseleccionar\r\ntodo el sector";
            this.btn_SeleccionSectorCordoneras.UseVisualStyleBackColor = true;
            this.btn_SeleccionSectorCordoneras.Click += new System.EventHandler(this.btn_SeleccionSectorCordoneras_Click);
            // 
            // chk_Cordonera7
            // 
            this.chk_Cordonera7.AutoSize = true;
            this.chk_Cordonera7.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.chk_Cordonera7.Location = new System.Drawing.Point(17, 164);
            this.chk_Cordonera7.Name = "chk_Cordonera7";
            this.chk_Cordonera7.Size = new System.Drawing.Size(91, 19);
            this.chk_Cordonera7.TabIndex = 24;
            this.chk_Cordonera7.Text = "Cordonera 7";
            this.chk_Cordonera7.UseVisualStyleBackColor = true;
            // 
            // chk_Cordonera8
            // 
            this.chk_Cordonera8.AutoSize = true;
            this.chk_Cordonera8.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.chk_Cordonera8.Location = new System.Drawing.Point(17, 187);
            this.chk_Cordonera8.Name = "chk_Cordonera8";
            this.chk_Cordonera8.Size = new System.Drawing.Size(91, 19);
            this.chk_Cordonera8.TabIndex = 25;
            this.chk_Cordonera8.Text = "Cordonera 8";
            this.chk_Cordonera8.UseVisualStyleBackColor = true;
            // 
            // chk_Cordonera9
            // 
            this.chk_Cordonera9.AutoSize = true;
            this.chk_Cordonera9.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.chk_Cordonera9.Location = new System.Drawing.Point(17, 210);
            this.chk_Cordonera9.Name = "chk_Cordonera9";
            this.chk_Cordonera9.Size = new System.Drawing.Size(91, 19);
            this.chk_Cordonera9.TabIndex = 26;
            this.chk_Cordonera9.Text = "Cordonera 9";
            this.chk_Cordonera9.UseVisualStyleBackColor = true;
            // 
            // chk_Cordonera4
            // 
            this.chk_Cordonera4.AutoSize = true;
            this.chk_Cordonera4.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.chk_Cordonera4.Location = new System.Drawing.Point(17, 95);
            this.chk_Cordonera4.Name = "chk_Cordonera4";
            this.chk_Cordonera4.Size = new System.Drawing.Size(91, 19);
            this.chk_Cordonera4.TabIndex = 21;
            this.chk_Cordonera4.Text = "Cordonera 4";
            this.chk_Cordonera4.UseVisualStyleBackColor = true;
            // 
            // chk_Cordonera5
            // 
            this.chk_Cordonera5.AutoSize = true;
            this.chk_Cordonera5.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.chk_Cordonera5.Location = new System.Drawing.Point(17, 118);
            this.chk_Cordonera5.Name = "chk_Cordonera5";
            this.chk_Cordonera5.Size = new System.Drawing.Size(91, 19);
            this.chk_Cordonera5.TabIndex = 22;
            this.chk_Cordonera5.Text = "Cordonera 5";
            this.chk_Cordonera5.UseVisualStyleBackColor = true;
            // 
            // chk_Cordonera6
            // 
            this.chk_Cordonera6.AutoSize = true;
            this.chk_Cordonera6.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.chk_Cordonera6.Location = new System.Drawing.Point(17, 141);
            this.chk_Cordonera6.Name = "chk_Cordonera6";
            this.chk_Cordonera6.Size = new System.Drawing.Size(91, 19);
            this.chk_Cordonera6.TabIndex = 23;
            this.chk_Cordonera6.Text = "Cordonera 6";
            this.chk_Cordonera6.UseVisualStyleBackColor = true;
            // 
            // chk_Cordonera1
            // 
            this.chk_Cordonera1.AutoSize = true;
            this.chk_Cordonera1.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.chk_Cordonera1.Location = new System.Drawing.Point(17, 26);
            this.chk_Cordonera1.Name = "chk_Cordonera1";
            this.chk_Cordonera1.Size = new System.Drawing.Size(91, 19);
            this.chk_Cordonera1.TabIndex = 18;
            this.chk_Cordonera1.Text = "Cordonera 1";
            this.chk_Cordonera1.UseVisualStyleBackColor = true;
            // 
            // chk_Cordonera2
            // 
            this.chk_Cordonera2.AutoSize = true;
            this.chk_Cordonera2.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.chk_Cordonera2.Location = new System.Drawing.Point(17, 49);
            this.chk_Cordonera2.Name = "chk_Cordonera2";
            this.chk_Cordonera2.Size = new System.Drawing.Size(91, 19);
            this.chk_Cordonera2.TabIndex = 19;
            this.chk_Cordonera2.Text = "Cordonera 2";
            this.chk_Cordonera2.UseVisualStyleBackColor = true;
            // 
            // chk_Cordonera3
            // 
            this.chk_Cordonera3.AutoSize = true;
            this.chk_Cordonera3.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.chk_Cordonera3.Location = new System.Drawing.Point(17, 72);
            this.chk_Cordonera3.Name = "chk_Cordonera3";
            this.chk_Cordonera3.Size = new System.Drawing.Size(91, 19);
            this.chk_Cordonera3.TabIndex = 20;
            this.chk_Cordonera3.Text = "Cordonera 3";
            this.chk_Cordonera3.UseVisualStyleBackColor = true;
            // 
            // grp_Terminacion
            // 
            this.grp_Terminacion.Controls.Add(this.btn_SeleccionSectorTerminacion);
            this.grp_Terminacion.Controls.Add(this.chk_Terminacion3);
            this.grp_Terminacion.Controls.Add(this.chk_Terminacion2);
            this.grp_Terminacion.Controls.Add(this.chk_Terminacion1);
            this.grp_Terminacion.Font = new System.Drawing.Font("Segoe UI Semibold", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.grp_Terminacion.Location = new System.Drawing.Point(260, 26);
            this.grp_Terminacion.Name = "grp_Terminacion";
            this.grp_Terminacion.Size = new System.Drawing.Size(135, 310);
            this.grp_Terminacion.TabIndex = 22;
            this.grp_Terminacion.TabStop = false;
            this.grp_Terminacion.Text = "Terminación";
            // 
            // btn_SeleccionSectorTerminacion
            // 
            this.btn_SeleccionSectorTerminacion.Font = new System.Drawing.Font("Segoe UI", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_SeleccionSectorTerminacion.Location = new System.Drawing.Point(6, 263);
            this.btn_SeleccionSectorTerminacion.Name = "btn_SeleccionSectorTerminacion";
            this.btn_SeleccionSectorTerminacion.Size = new System.Drawing.Size(123, 40);
            this.btn_SeleccionSectorTerminacion.TabIndex = 31;
            this.btn_SeleccionSectorTerminacion.Text = "Deseleccionar\r\ntodo el sector";
            this.btn_SeleccionSectorTerminacion.UseVisualStyleBackColor = true;
            this.btn_SeleccionSectorTerminacion.Click += new System.EventHandler(this.btn_SeleccionSectorTerminacion_Click);
            // 
            // chk_Terminacion3
            // 
            this.chk_Terminacion3.AutoSize = true;
            this.chk_Terminacion3.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.chk_Terminacion3.Location = new System.Drawing.Point(17, 72);
            this.chk_Terminacion3.Name = "chk_Terminacion3";
            this.chk_Terminacion3.Size = new System.Drawing.Size(100, 19);
            this.chk_Terminacion3.TabIndex = 30;
            this.chk_Terminacion3.Text = "Terminación 3";
            this.chk_Terminacion3.UseVisualStyleBackColor = true;
            // 
            // chk_Terminacion2
            // 
            this.chk_Terminacion2.AutoSize = true;
            this.chk_Terminacion2.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.chk_Terminacion2.Location = new System.Drawing.Point(17, 49);
            this.chk_Terminacion2.Name = "chk_Terminacion2";
            this.chk_Terminacion2.Size = new System.Drawing.Size(100, 19);
            this.chk_Terminacion2.TabIndex = 29;
            this.chk_Terminacion2.Text = "Terminación 2";
            this.chk_Terminacion2.UseVisualStyleBackColor = true;
            // 
            // chk_Terminacion1
            // 
            this.chk_Terminacion1.AutoSize = true;
            this.chk_Terminacion1.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.chk_Terminacion1.Location = new System.Drawing.Point(17, 26);
            this.chk_Terminacion1.Name = "chk_Terminacion1";
            this.chk_Terminacion1.Size = new System.Drawing.Size(100, 19);
            this.chk_Terminacion1.TabIndex = 28;
            this.chk_Terminacion1.Text = "Terminación 1";
            this.chk_Terminacion1.UseVisualStyleBackColor = true;
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
            this.dgv_TiemposPorSector.Location = new System.Drawing.Point(464, 619);
            this.dgv_TiemposPorSector.Name = "dgv_TiemposPorSector";
            this.dgv_TiemposPorSector.ReadOnly = true;
            this.dgv_TiemposPorSector.RowHeadersVisible = false;
            this.dgv_TiemposPorSector.RowHeadersWidthSizeMode = System.Windows.Forms.DataGridViewRowHeadersWidthSizeMode.DisableResizing;
            this.dgv_TiemposPorSector.Size = new System.Drawing.Size(227, 91);
            this.dgv_TiemposPorSector.TabIndex = 23;
            // 
            // btn_Mostrar
            // 
            this.btn_Mostrar.Font = new System.Drawing.Font("Segoe UI Semibold", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_Mostrar.Location = new System.Drawing.Point(22, 654);
            this.btn_Mostrar.Name = "btn_Mostrar";
            this.btn_Mostrar.Size = new System.Drawing.Size(411, 56);
            this.btn_Mostrar.TabIndex = 100;
            this.btn_Mostrar.Text = "Mostrar";
            this.btn_Mostrar.UseVisualStyleBackColor = true;
            this.btn_Mostrar.Click += new System.EventHandler(this.btn_Mostrar_Click);
            // 
            // lbl_CantidadHorasPorMaquina
            // 
            this.lbl_CantidadHorasPorMaquina.AutoSize = true;
            this.lbl_CantidadHorasPorMaquina.Font = new System.Drawing.Font("Segoe UI Semibold", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_CantidadHorasPorMaquina.Location = new System.Drawing.Point(461, 40);
            this.lbl_CantidadHorasPorMaquina.Name = "lbl_CantidadHorasPorMaquina";
            this.lbl_CantidadHorasPorMaquina.Size = new System.Drawing.Size(89, 17);
            this.lbl_CantidadHorasPorMaquina.TabIndex = 28;
            this.lbl_CantidadHorasPorMaquina.Text = "Por Máquina:";
            // 
            // lbl_CantidadHorasPorSector
            // 
            this.lbl_CantidadHorasPorSector.AutoSize = true;
            this.lbl_CantidadHorasPorSector.Font = new System.Drawing.Font("Segoe UI Semibold", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_CantidadHorasPorSector.Location = new System.Drawing.Point(461, 596);
            this.lbl_CantidadHorasPorSector.Name = "lbl_CantidadHorasPorSector";
            this.lbl_CantidadHorasPorSector.Size = new System.Drawing.Size(75, 17);
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
            this.dgv_TiemposTotales.Location = new System.Drawing.Point(721, 637);
            this.dgv_TiemposTotales.Name = "dgv_TiemposTotales";
            this.dgv_TiemposTotales.ReadOnly = true;
            this.dgv_TiemposTotales.RowHeadersVisible = false;
            this.dgv_TiemposTotales.RowHeadersWidthSizeMode = System.Windows.Forms.DataGridViewRowHeadersWidthSizeMode.DisableResizing;
            this.dgv_TiemposTotales.Size = new System.Drawing.Size(157, 47);
            this.dgv_TiemposTotales.TabIndex = 30;
            // 
            // lbl_CantidadTotalHorasMaquina
            // 
            this.lbl_CantidadTotalHorasMaquina.Font = new System.Drawing.Font("Segoe UI Semibold", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_CantidadTotalHorasMaquina.Location = new System.Drawing.Point(718, 596);
            this.lbl_CantidadTotalHorasMaquina.Name = "lbl_CantidadTotalHorasMaquina";
            this.lbl_CantidadTotalHorasMaquina.Size = new System.Drawing.Size(118, 39);
            this.lbl_CantidadTotalHorasMaquina.TabIndex = 31;
            this.lbl_CantidadTotalHorasMaquina.Text = "Todas las Máquinas:";
            // 
            // grp_FiltroFecha
            // 
            this.grp_FiltroFecha.Controls.Add(this.lbl_FechaFinal);
            this.grp_FiltroFecha.Controls.Add(this.lbl_FechaInicial);
            this.grp_FiltroFecha.Controls.Add(this.dtp_FechaFinal);
            this.grp_FiltroFecha.Controls.Add(this.dtp_FechaInicial);
            this.grp_FiltroFecha.Font = new System.Drawing.Font("Segoe UI Semibold", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.grp_FiltroFecha.Location = new System.Drawing.Point(22, 39);
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
            // 
            // cmb_HoraInicial
            // 
            this.cmb_HoraInicial.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmb_HoraInicial.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
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
            // 
            // grp_FiltroMaquinasSectores
            // 
            this.grp_FiltroMaquinasSectores.Controls.Add(this.btn_DeseleccionarTodo);
            this.grp_FiltroMaquinasSectores.Controls.Add(this.btn_SeleccionarTodo);
            this.grp_FiltroMaquinasSectores.Controls.Add(this.grp_Telares);
            this.grp_FiltroMaquinasSectores.Controls.Add(this.grp_Cordoneras);
            this.grp_FiltroMaquinasSectores.Controls.Add(this.grp_Terminacion);
            this.grp_FiltroMaquinasSectores.Font = new System.Drawing.Font("Segoe UI Semibold", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.grp_FiltroMaquinasSectores.Location = new System.Drawing.Point(23, 239);
            this.grp_FiltroMaquinasSectores.Name = "grp_FiltroMaquinasSectores";
            this.grp_FiltroMaquinasSectores.Size = new System.Drawing.Size(409, 398);
            this.grp_FiltroMaquinasSectores.TabIndex = 40;
            this.grp_FiltroMaquinasSectores.TabStop = false;
            this.grp_FiltroMaquinasSectores.Text = "Filtro por Máquinas y Sectores";
            // 
            // btn_DeseleccionarTodo
            // 
            this.btn_DeseleccionarTodo.Font = new System.Drawing.Font("Segoe UI", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_DeseleccionarTodo.Location = new System.Drawing.Point(12, 344);
            this.btn_DeseleccionarTodo.Name = "btn_DeseleccionarTodo";
            this.btn_DeseleccionarTodo.Size = new System.Drawing.Size(172, 40);
            this.btn_DeseleccionarTodo.TabIndex = 32;
            this.btn_DeseleccionarTodo.Text = "Deseleccionar todo";
            this.btn_DeseleccionarTodo.UseVisualStyleBackColor = true;
            this.btn_DeseleccionarTodo.Click += new System.EventHandler(this.btn_ResetearTodo_Click);
            // 
            // btn_SeleccionarTodo
            // 
            this.btn_SeleccionarTodo.Font = new System.Drawing.Font("Segoe UI", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_SeleccionarTodo.Location = new System.Drawing.Point(190, 344);
            this.btn_SeleccionarTodo.Name = "btn_SeleccionarTodo";
            this.btn_SeleccionarTodo.Size = new System.Drawing.Size(205, 40);
            this.btn_SeleccionarTodo.TabIndex = 33;
            this.btn_SeleccionarTodo.Text = "Seleccionar todo";
            this.btn_SeleccionarTodo.UseVisualStyleBackColor = true;
            this.btn_SeleccionarTodo.Click += new System.EventHandler(this.btn_SeleccionarTodo_Click);
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
            this.grp_FiltroFranjaHoraria.Location = new System.Drawing.Point(23, 153);
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
            this.lbl_HorarioFinal.Location = new System.Drawing.Point(213, 33);
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
            this.lbl_HorarioInicial.Location = new System.Drawing.Point(22, 33);
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
            this.menuStrip1.Size = new System.Drawing.Size(944, 25);
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
            this.btn_CopiarAlPortapapeles_TiemposPorMaquina.Location = new System.Drawing.Point(870, 40);
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
            this.btn_CopiarAlPortapapeles_TiemposPorSector.Location = new System.Drawing.Point(641, 596);
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
            this.btn_CopiarAlPortapapeles_TiemposDeTodasLasMaquinas.Location = new System.Drawing.Point(828, 614);
            this.btn_CopiarAlPortapapeles_TiemposDeTodasLasMaquinas.Name = "btn_CopiarAlPortapapeles_TiemposDeTodasLasMaquinas";
            this.btn_CopiarAlPortapapeles_TiemposDeTodasLasMaquinas.Size = new System.Drawing.Size(51, 23);
            this.btn_CopiarAlPortapapeles_TiemposDeTodasLasMaquinas.TabIndex = 105;
            this.btn_CopiarAlPortapapeles_TiemposDeTodasLasMaquinas.Text = "Copiar";
            this.btn_CopiarAlPortapapeles_TiemposDeTodasLasMaquinas.UseVisualStyleBackColor = true;
            this.btn_CopiarAlPortapapeles_TiemposDeTodasLasMaquinas.Click += new System.EventHandler(this.btn_CopiarAlPortapapeles_TiemposDeTodasLasMaquinas_Click);
            // 
            // frm_Home
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(944, 732);
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
            this.Controls.Add(this.btn_Mostrar);
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
            this.grp_Telares.ResumeLayout(false);
            this.grp_Telares.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_TiemposPorMaquina)).EndInit();
            this.grp_Cordoneras.ResumeLayout(false);
            this.grp_Cordoneras.PerformLayout();
            this.grp_Terminacion.ResumeLayout(false);
            this.grp_Terminacion.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_TiemposPorSector)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_TiemposTotales)).EndInit();
            this.grp_FiltroFecha.ResumeLayout(false);
            this.grp_FiltroFecha.PerformLayout();
            this.grp_FiltroMaquinasSectores.ResumeLayout(false);
            this.grp_FiltroFranjaHoraria.ResumeLayout(false);
            this.grp_FiltroFranjaHoraria.PerformLayout();
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.DateTimePicker dtp_FechaInicial;
        private System.Windows.Forms.GroupBox grp_Telares;
        private System.Windows.Forms.DataGridView dgv_TiemposPorMaquina;
        private System.Windows.Forms.CheckBox chk_Telar5;
        private System.Windows.Forms.CheckBox chk_Telar1;
        private System.Windows.Forms.CheckBox chk_Telar4;
        private System.Windows.Forms.CheckBox chk_Telar2;
        private System.Windows.Forms.CheckBox chk_Urdidora;
        private System.Windows.Forms.CheckBox chk_Telar3;
        private System.Windows.Forms.CheckBox chk_Telar9;
        private System.Windows.Forms.CheckBox chk_Telar6;
        private System.Windows.Forms.CheckBox chk_Telar8;
        private System.Windows.Forms.CheckBox chk_Telar7;
        private System.Windows.Forms.GroupBox grp_Cordoneras;
        private System.Windows.Forms.CheckBox chk_Cordonera7;
        private System.Windows.Forms.CheckBox chk_Cordonera8;
        private System.Windows.Forms.CheckBox chk_Cordonera9;
        private System.Windows.Forms.CheckBox chk_Cordonera4;
        private System.Windows.Forms.CheckBox chk_Cordonera5;
        private System.Windows.Forms.CheckBox chk_Cordonera6;
        private System.Windows.Forms.CheckBox chk_Cordonera1;
        private System.Windows.Forms.CheckBox chk_Cordonera2;
        private System.Windows.Forms.CheckBox chk_Cordonera3;
        private System.Windows.Forms.GroupBox grp_Terminacion;
        private System.Windows.Forms.CheckBox chk_Terminacion3;
        private System.Windows.Forms.CheckBox chk_Terminacion2;
        private System.Windows.Forms.CheckBox chk_Terminacion1;
        private System.Windows.Forms.DataGridView dgv_TiemposPorSector;
        private System.Windows.Forms.Button btn_Mostrar;
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
        private System.Windows.Forms.Button btn_SeleccionSectorTelares;
        private System.Windows.Forms.Button btn_SeleccionSectorCordoneras;
        private System.Windows.Forms.Button btn_SeleccionSectorTerminacion;
        private System.Windows.Forms.Button btn_SeleccionarTodo;
        private System.Windows.Forms.Button btn_DeseleccionarTodo;
        private System.Windows.Forms.GroupBox grp_FiltroFranjaHoraria;
        private System.Windows.Forms.Label lbl_HorarioFinal;
        private System.Windows.Forms.Label lbl_HorarioInicial;
        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem editarSectoresToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem editarMáquinasToolStripMenuItem;
        private System.Windows.Forms.Button btn_CopiarAlPortapapeles_TiemposPorMaquina;
        private System.Windows.Forms.Button btn_CopiarAlPortapapeles_TiemposPorSector;
        private System.Windows.Forms.Button btn_CopiarAlPortapapeles_TiemposDeTodasLasMaquinas;
    }
}

