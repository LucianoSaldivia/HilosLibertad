
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
            this.dtp_Desde = new System.Windows.Forms.DateTimePicker();
            this.pic_logoEmpresa = new System.Windows.Forms.PictureBox();
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
            this.dgv_CantHorasPorMaquina = new System.Windows.Forms.DataGridView();
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
            this.dgv_CantHorasPorSector = new System.Windows.Forms.DataGridView();
            this.btn_Mostrar = new System.Windows.Forms.Button();
            this.lbl_CantidadHorasPorMaquina = new System.Windows.Forms.Label();
            this.lbl_CantidadHorasPorSector = new System.Windows.Forms.Label();
            this.dgv_CantTotalHorasMaquina = new System.Windows.Forms.DataGridView();
            this.lbl_CantidadTotalHorasMaquina = new System.Windows.Forms.Label();
            this.grp_FiltroFechaHora = new System.Windows.Forms.GroupBox();
            this.lbl_Hasta = new System.Windows.Forms.Label();
            this.lbl_Desde = new System.Windows.Forms.Label();
            this.cmb_MinutoHasta = new System.Windows.Forms.ComboBox();
            this.cmb_MinutoDesde = new System.Windows.Forms.ComboBox();
            this.cmb_HoraHasta = new System.Windows.Forms.ComboBox();
            this.dtp_Hasta = new System.Windows.Forms.DateTimePicker();
            this.cmb_HoraDesde = new System.Windows.Forms.ComboBox();
            this.grp_FiltroSectoresMaquinas = new System.Windows.Forms.GroupBox();
            this.btn_DeseleccionarTodo = new System.Windows.Forms.Button();
            this.btn_SeleccionarTodo = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.pic_logoEmpresa)).BeginInit();
            this.grp_Telares.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_CantHorasPorMaquina)).BeginInit();
            this.grp_Cordoneras.SuspendLayout();
            this.grp_Terminacion.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_CantHorasPorSector)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_CantTotalHorasMaquina)).BeginInit();
            this.grp_FiltroFechaHora.SuspendLayout();
            this.grp_FiltroSectoresMaquinas.SuspendLayout();
            this.SuspendLayout();
            // 
            // dtp_Desde
            // 
            this.dtp_Desde.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.dtp_Desde.Location = new System.Drawing.Point(24, 42);
            this.dtp_Desde.Name = "dtp_Desde";
            this.dtp_Desde.Size = new System.Drawing.Size(269, 22);
            this.dtp_Desde.TabIndex = 1;
            this.dtp_Desde.ValueChanged += new System.EventHandler(this.dtp_Desde_ValueChanged);
            // 
            // pic_logoEmpresa
            // 
            this.pic_logoEmpresa.Image = global::HilosLibertad.Properties.Resources.logoEmpresa;
            this.pic_logoEmpresa.Location = new System.Drawing.Point(453, 23);
            this.pic_logoEmpresa.Name = "pic_logoEmpresa";
            this.pic_logoEmpresa.Size = new System.Drawing.Size(390, 60);
            this.pic_logoEmpresa.SizeMode = System.Windows.Forms.PictureBoxSizeMode.AutoSize;
            this.pic_logoEmpresa.TabIndex = 2;
            this.pic_logoEmpresa.TabStop = false;
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
            this.grp_Telares.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.grp_Telares.Location = new System.Drawing.Point(12, 26);
            this.grp_Telares.Name = "grp_Telares";
            this.grp_Telares.Size = new System.Drawing.Size(105, 310);
            this.grp_Telares.TabIndex = 5;
            this.grp_Telares.TabStop = false;
            this.grp_Telares.Text = "Telares";
            // 
            // btn_SeleccionSectorTelares
            // 
            this.btn_SeleccionSectorTelares.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_SeleccionSectorTelares.Location = new System.Drawing.Point(6, 263);
            this.btn_SeleccionSectorTelares.Name = "btn_SeleccionSectorTelares";
            this.btn_SeleccionSectorTelares.Size = new System.Drawing.Size(93, 40);
            this.btn_SeleccionSectorTelares.TabIndex = 18;
            this.btn_SeleccionSectorTelares.Text = "Deseleccionar\r\ntodo el sector";
            this.btn_SeleccionSectorTelares.UseVisualStyleBackColor = true;
            this.btn_SeleccionSectorTelares.Click += new System.EventHandler(this.btn_SeleccionSectorTelares_Click);
            // 
            // chk_Telar5
            // 
            this.chk_Telar5.AutoSize = true;
            this.chk_Telar5.Location = new System.Drawing.Point(17, 118);
            this.chk_Telar5.Name = "chk_Telar5";
            this.chk_Telar5.Size = new System.Drawing.Size(64, 19);
            this.chk_Telar5.TabIndex = 17;
            this.chk_Telar5.Text = "Telar 5";
            this.chk_Telar5.UseVisualStyleBackColor = true;
            // 
            // chk_Telar1
            // 
            this.chk_Telar1.AutoSize = true;
            this.chk_Telar1.Location = new System.Drawing.Point(17, 26);
            this.chk_Telar1.Name = "chk_Telar1";
            this.chk_Telar1.Size = new System.Drawing.Size(64, 19);
            this.chk_Telar1.TabIndex = 7;
            this.chk_Telar1.Text = "Telar 1";
            this.chk_Telar1.UseVisualStyleBackColor = true;
            // 
            // chk_Telar4
            // 
            this.chk_Telar4.AutoSize = true;
            this.chk_Telar4.Location = new System.Drawing.Point(17, 95);
            this.chk_Telar4.Name = "chk_Telar4";
            this.chk_Telar4.Size = new System.Drawing.Size(64, 19);
            this.chk_Telar4.TabIndex = 16;
            this.chk_Telar4.Text = "Telar 4";
            this.chk_Telar4.UseVisualStyleBackColor = true;
            // 
            // chk_Telar2
            // 
            this.chk_Telar2.AutoSize = true;
            this.chk_Telar2.Location = new System.Drawing.Point(17, 49);
            this.chk_Telar2.Name = "chk_Telar2";
            this.chk_Telar2.Size = new System.Drawing.Size(64, 19);
            this.chk_Telar2.TabIndex = 8;
            this.chk_Telar2.Text = "Telar 2";
            this.chk_Telar2.UseVisualStyleBackColor = true;
            // 
            // chk_Urdidora
            // 
            this.chk_Urdidora.AutoSize = true;
            this.chk_Urdidora.Location = new System.Drawing.Point(17, 233);
            this.chk_Urdidora.Name = "chk_Urdidora";
            this.chk_Urdidora.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.chk_Urdidora.Size = new System.Drawing.Size(74, 19);
            this.chk_Urdidora.TabIndex = 14;
            this.chk_Urdidora.Text = "Urdidora";
            this.chk_Urdidora.UseVisualStyleBackColor = true;
            // 
            // chk_Telar3
            // 
            this.chk_Telar3.AutoSize = true;
            this.chk_Telar3.Location = new System.Drawing.Point(17, 72);
            this.chk_Telar3.Name = "chk_Telar3";
            this.chk_Telar3.Size = new System.Drawing.Size(64, 19);
            this.chk_Telar3.TabIndex = 9;
            this.chk_Telar3.Text = "Telar 3";
            this.chk_Telar3.UseVisualStyleBackColor = true;
            // 
            // chk_Telar9
            // 
            this.chk_Telar9.AutoSize = true;
            this.chk_Telar9.Location = new System.Drawing.Point(17, 210);
            this.chk_Telar9.Name = "chk_Telar9";
            this.chk_Telar9.Size = new System.Drawing.Size(64, 19);
            this.chk_Telar9.TabIndex = 13;
            this.chk_Telar9.Text = "Telar 9";
            this.chk_Telar9.UseVisualStyleBackColor = true;
            // 
            // chk_Telar6
            // 
            this.chk_Telar6.AutoSize = true;
            this.chk_Telar6.Location = new System.Drawing.Point(17, 141);
            this.chk_Telar6.Name = "chk_Telar6";
            this.chk_Telar6.Size = new System.Drawing.Size(64, 19);
            this.chk_Telar6.TabIndex = 10;
            this.chk_Telar6.Text = "Telar 6";
            this.chk_Telar6.UseVisualStyleBackColor = true;
            // 
            // chk_Telar8
            // 
            this.chk_Telar8.AutoSize = true;
            this.chk_Telar8.Location = new System.Drawing.Point(17, 187);
            this.chk_Telar8.Name = "chk_Telar8";
            this.chk_Telar8.Size = new System.Drawing.Size(64, 19);
            this.chk_Telar8.TabIndex = 12;
            this.chk_Telar8.Text = "Telar 8";
            this.chk_Telar8.UseVisualStyleBackColor = true;
            // 
            // chk_Telar7
            // 
            this.chk_Telar7.AutoSize = true;
            this.chk_Telar7.Location = new System.Drawing.Point(17, 164);
            this.chk_Telar7.Name = "chk_Telar7";
            this.chk_Telar7.Size = new System.Drawing.Size(64, 19);
            this.chk_Telar7.TabIndex = 11;
            this.chk_Telar7.Text = "Telar 7";
            this.chk_Telar7.UseVisualStyleBackColor = true;
            // 
            // dgv_CantHorasPorMaquina
            // 
            this.dgv_CantHorasPorMaquina.AllowUserToAddRows = false;
            this.dgv_CantHorasPorMaquina.AllowUserToDeleteRows = false;
            this.dgv_CantHorasPorMaquina.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgv_CantHorasPorMaquina.Location = new System.Drawing.Point(453, 140);
            this.dgv_CantHorasPorMaquina.Name = "dgv_CantHorasPorMaquina";
            this.dgv_CantHorasPorMaquina.ReadOnly = true;
            this.dgv_CantHorasPorMaquina.Size = new System.Drawing.Size(390, 206);
            this.dgv_CantHorasPorMaquina.TabIndex = 6;
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
            this.grp_Cordoneras.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.grp_Cordoneras.Location = new System.Drawing.Point(126, 26);
            this.grp_Cordoneras.Name = "grp_Cordoneras";
            this.grp_Cordoneras.Size = new System.Drawing.Size(125, 310);
            this.grp_Cordoneras.TabIndex = 18;
            this.grp_Cordoneras.TabStop = false;
            this.grp_Cordoneras.Text = "Cordoneras";
            // 
            // btn_SeleccionSectorCordoneras
            // 
            this.btn_SeleccionSectorCordoneras.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_SeleccionSectorCordoneras.Location = new System.Drawing.Point(6, 263);
            this.btn_SeleccionSectorCordoneras.Name = "btn_SeleccionSectorCordoneras";
            this.btn_SeleccionSectorCordoneras.Size = new System.Drawing.Size(113, 40);
            this.btn_SeleccionSectorCordoneras.TabIndex = 19;
            this.btn_SeleccionSectorCordoneras.Text = "Deseleccionar\r\ntodo el sector";
            this.btn_SeleccionSectorCordoneras.UseVisualStyleBackColor = true;
            this.btn_SeleccionSectorCordoneras.Click += new System.EventHandler(this.btn_SeleccionSectorCordoneras_Click);
            // 
            // chk_Cordonera7
            // 
            this.chk_Cordonera7.AutoSize = true;
            this.chk_Cordonera7.Location = new System.Drawing.Point(17, 164);
            this.chk_Cordonera7.Name = "chk_Cordonera7";
            this.chk_Cordonera7.Size = new System.Drawing.Size(94, 19);
            this.chk_Cordonera7.TabIndex = 19;
            this.chk_Cordonera7.Text = "Cordonera 7";
            this.chk_Cordonera7.UseVisualStyleBackColor = true;
            // 
            // chk_Cordonera8
            // 
            this.chk_Cordonera8.AutoSize = true;
            this.chk_Cordonera8.Location = new System.Drawing.Point(17, 187);
            this.chk_Cordonera8.Name = "chk_Cordonera8";
            this.chk_Cordonera8.Size = new System.Drawing.Size(94, 19);
            this.chk_Cordonera8.TabIndex = 20;
            this.chk_Cordonera8.Text = "Cordonera 8";
            this.chk_Cordonera8.UseVisualStyleBackColor = true;
            // 
            // chk_Cordonera9
            // 
            this.chk_Cordonera9.AutoSize = true;
            this.chk_Cordonera9.Location = new System.Drawing.Point(17, 210);
            this.chk_Cordonera9.Name = "chk_Cordonera9";
            this.chk_Cordonera9.Size = new System.Drawing.Size(94, 19);
            this.chk_Cordonera9.TabIndex = 21;
            this.chk_Cordonera9.Text = "Cordonera 9";
            this.chk_Cordonera9.UseVisualStyleBackColor = true;
            // 
            // chk_Cordonera4
            // 
            this.chk_Cordonera4.AutoSize = true;
            this.chk_Cordonera4.Location = new System.Drawing.Point(17, 95);
            this.chk_Cordonera4.Name = "chk_Cordonera4";
            this.chk_Cordonera4.Size = new System.Drawing.Size(94, 19);
            this.chk_Cordonera4.TabIndex = 10;
            this.chk_Cordonera4.Text = "Cordonera 4";
            this.chk_Cordonera4.UseVisualStyleBackColor = true;
            // 
            // chk_Cordonera5
            // 
            this.chk_Cordonera5.AutoSize = true;
            this.chk_Cordonera5.Location = new System.Drawing.Point(17, 118);
            this.chk_Cordonera5.Name = "chk_Cordonera5";
            this.chk_Cordonera5.Size = new System.Drawing.Size(94, 19);
            this.chk_Cordonera5.TabIndex = 11;
            this.chk_Cordonera5.Text = "Cordonera 5";
            this.chk_Cordonera5.UseVisualStyleBackColor = true;
            // 
            // chk_Cordonera6
            // 
            this.chk_Cordonera6.AutoSize = true;
            this.chk_Cordonera6.Location = new System.Drawing.Point(17, 141);
            this.chk_Cordonera6.Name = "chk_Cordonera6";
            this.chk_Cordonera6.Size = new System.Drawing.Size(94, 19);
            this.chk_Cordonera6.TabIndex = 12;
            this.chk_Cordonera6.Text = "Cordonera 6";
            this.chk_Cordonera6.UseVisualStyleBackColor = true;
            // 
            // chk_Cordonera1
            // 
            this.chk_Cordonera1.AutoSize = true;
            this.chk_Cordonera1.Location = new System.Drawing.Point(17, 26);
            this.chk_Cordonera1.Name = "chk_Cordonera1";
            this.chk_Cordonera1.Size = new System.Drawing.Size(94, 19);
            this.chk_Cordonera1.TabIndex = 7;
            this.chk_Cordonera1.Text = "Cordonera 1";
            this.chk_Cordonera1.UseVisualStyleBackColor = true;
            // 
            // chk_Cordonera2
            // 
            this.chk_Cordonera2.AutoSize = true;
            this.chk_Cordonera2.Location = new System.Drawing.Point(17, 49);
            this.chk_Cordonera2.Name = "chk_Cordonera2";
            this.chk_Cordonera2.Size = new System.Drawing.Size(94, 19);
            this.chk_Cordonera2.TabIndex = 8;
            this.chk_Cordonera2.Text = "Cordonera 2";
            this.chk_Cordonera2.UseVisualStyleBackColor = true;
            // 
            // chk_Cordonera3
            // 
            this.chk_Cordonera3.AutoSize = true;
            this.chk_Cordonera3.Location = new System.Drawing.Point(17, 72);
            this.chk_Cordonera3.Name = "chk_Cordonera3";
            this.chk_Cordonera3.Size = new System.Drawing.Size(94, 19);
            this.chk_Cordonera3.TabIndex = 9;
            this.chk_Cordonera3.Text = "Cordonera 3";
            this.chk_Cordonera3.UseVisualStyleBackColor = true;
            // 
            // grp_Terminacion
            // 
            this.grp_Terminacion.Controls.Add(this.btn_SeleccionSectorTerminacion);
            this.grp_Terminacion.Controls.Add(this.chk_Terminacion3);
            this.grp_Terminacion.Controls.Add(this.chk_Terminacion2);
            this.grp_Terminacion.Controls.Add(this.chk_Terminacion1);
            this.grp_Terminacion.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.grp_Terminacion.Location = new System.Drawing.Point(260, 26);
            this.grp_Terminacion.Name = "grp_Terminacion";
            this.grp_Terminacion.Size = new System.Drawing.Size(135, 310);
            this.grp_Terminacion.TabIndex = 22;
            this.grp_Terminacion.TabStop = false;
            this.grp_Terminacion.Text = "Terminación";
            // 
            // btn_SeleccionSectorTerminacion
            // 
            this.btn_SeleccionSectorTerminacion.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_SeleccionSectorTerminacion.Location = new System.Drawing.Point(6, 263);
            this.btn_SeleccionSectorTerminacion.Name = "btn_SeleccionSectorTerminacion";
            this.btn_SeleccionSectorTerminacion.Size = new System.Drawing.Size(123, 40);
            this.btn_SeleccionSectorTerminacion.TabIndex = 22;
            this.btn_SeleccionSectorTerminacion.Text = "Deseleccionar\r\ntodo el sector";
            this.btn_SeleccionSectorTerminacion.UseVisualStyleBackColor = true;
            this.btn_SeleccionSectorTerminacion.Click += new System.EventHandler(this.btn_SeleccionSectorTerminacion_Click);
            // 
            // chk_Terminacion3
            // 
            this.chk_Terminacion3.AutoSize = true;
            this.chk_Terminacion3.Location = new System.Drawing.Point(17, 72);
            this.chk_Terminacion3.Name = "chk_Terminacion3";
            this.chk_Terminacion3.Size = new System.Drawing.Size(105, 19);
            this.chk_Terminacion3.TabIndex = 19;
            this.chk_Terminacion3.Text = "Terminación 3";
            this.chk_Terminacion3.UseVisualStyleBackColor = true;
            // 
            // chk_Terminacion2
            // 
            this.chk_Terminacion2.AutoSize = true;
            this.chk_Terminacion2.Location = new System.Drawing.Point(17, 49);
            this.chk_Terminacion2.Name = "chk_Terminacion2";
            this.chk_Terminacion2.Size = new System.Drawing.Size(105, 19);
            this.chk_Terminacion2.TabIndex = 10;
            this.chk_Terminacion2.Text = "Terminación 2";
            this.chk_Terminacion2.UseVisualStyleBackColor = true;
            // 
            // chk_Terminacion1
            // 
            this.chk_Terminacion1.AutoSize = true;
            this.chk_Terminacion1.Location = new System.Drawing.Point(17, 26);
            this.chk_Terminacion1.Name = "chk_Terminacion1";
            this.chk_Terminacion1.Size = new System.Drawing.Size(105, 19);
            this.chk_Terminacion1.TabIndex = 7;
            this.chk_Terminacion1.Text = "Terminación 1";
            this.chk_Terminacion1.UseVisualStyleBackColor = true;
            // 
            // dgv_CantHorasPorSector
            // 
            this.dgv_CantHorasPorSector.AllowUserToAddRows = false;
            this.dgv_CantHorasPorSector.AllowUserToDeleteRows = false;
            this.dgv_CantHorasPorSector.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgv_CantHorasPorSector.Location = new System.Drawing.Point(453, 370);
            this.dgv_CantHorasPorSector.Name = "dgv_CantHorasPorSector";
            this.dgv_CantHorasPorSector.ReadOnly = true;
            this.dgv_CantHorasPorSector.Size = new System.Drawing.Size(390, 85);
            this.dgv_CantHorasPorSector.TabIndex = 23;
            // 
            // btn_Mostrar
            // 
            this.btn_Mostrar.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_Mostrar.Location = new System.Drawing.Point(18, 565);
            this.btn_Mostrar.Name = "btn_Mostrar";
            this.btn_Mostrar.Size = new System.Drawing.Size(409, 40);
            this.btn_Mostrar.TabIndex = 24;
            this.btn_Mostrar.Text = "Mostrar";
            this.btn_Mostrar.UseVisualStyleBackColor = true;
            this.btn_Mostrar.Click += new System.EventHandler(this.btn_Mostrar_Click);
            // 
            // lbl_CantidadHorasPorMaquina
            // 
            this.lbl_CantidadHorasPorMaquina.AutoSize = true;
            this.lbl_CantidadHorasPorMaquina.Location = new System.Drawing.Point(456, 124);
            this.lbl_CantidadHorasPorMaquina.Name = "lbl_CantidadHorasPorMaquina";
            this.lbl_CantidadHorasPorMaquina.Size = new System.Drawing.Size(160, 13);
            this.lbl_CantidadHorasPorMaquina.TabIndex = 28;
            this.lbl_CantidadHorasPorMaquina.Text = "Cantidad de Horas por Máquina:";
            // 
            // lbl_CantidadHorasPorSector
            // 
            this.lbl_CantidadHorasPorSector.AutoSize = true;
            this.lbl_CantidadHorasPorSector.Location = new System.Drawing.Point(456, 354);
            this.lbl_CantidadHorasPorSector.Name = "lbl_CantidadHorasPorSector";
            this.lbl_CantidadHorasPorSector.Size = new System.Drawing.Size(150, 13);
            this.lbl_CantidadHorasPorSector.TabIndex = 29;
            this.lbl_CantidadHorasPorSector.Text = "Cantidad de Horas por Sector:";
            // 
            // dgv_CantTotalHorasMaquina
            // 
            this.dgv_CantTotalHorasMaquina.AllowUserToAddRows = false;
            this.dgv_CantTotalHorasMaquina.AllowUserToDeleteRows = false;
            this.dgv_CantTotalHorasMaquina.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgv_CantTotalHorasMaquina.Location = new System.Drawing.Point(453, 484);
            this.dgv_CantTotalHorasMaquina.Name = "dgv_CantTotalHorasMaquina";
            this.dgv_CantTotalHorasMaquina.ReadOnly = true;
            this.dgv_CantTotalHorasMaquina.Size = new System.Drawing.Size(390, 71);
            this.dgv_CantTotalHorasMaquina.TabIndex = 30;
            // 
            // lbl_CantidadTotalHorasMaquina
            // 
            this.lbl_CantidadTotalHorasMaquina.AutoSize = true;
            this.lbl_CantidadTotalHorasMaquina.Location = new System.Drawing.Point(456, 468);
            this.lbl_CantidadTotalHorasMaquina.Name = "lbl_CantidadTotalHorasMaquina";
            this.lbl_CantidadTotalHorasMaquina.Size = new System.Drawing.Size(211, 13);
            this.lbl_CantidadTotalHorasMaquina.TabIndex = 31;
            this.lbl_CantidadTotalHorasMaquina.Text = "Cantidad de Horas de Todas las Máquinas:";
            // 
            // grp_FiltroFechaHora
            // 
            this.grp_FiltroFechaHora.Controls.Add(this.lbl_Hasta);
            this.grp_FiltroFechaHora.Controls.Add(this.lbl_Desde);
            this.grp_FiltroFechaHora.Controls.Add(this.cmb_MinutoHasta);
            this.grp_FiltroFechaHora.Controls.Add(this.cmb_MinutoDesde);
            this.grp_FiltroFechaHora.Controls.Add(this.cmb_HoraHasta);
            this.grp_FiltroFechaHora.Controls.Add(this.dtp_Hasta);
            this.grp_FiltroFechaHora.Controls.Add(this.cmb_HoraDesde);
            this.grp_FiltroFechaHora.Controls.Add(this.dtp_Desde);
            this.grp_FiltroFechaHora.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.grp_FiltroFechaHora.Location = new System.Drawing.Point(18, 18);
            this.grp_FiltroFechaHora.Name = "grp_FiltroFechaHora";
            this.grp_FiltroFechaHora.Size = new System.Drawing.Size(409, 128);
            this.grp_FiltroFechaHora.TabIndex = 33;
            this.grp_FiltroFechaHora.TabStop = false;
            this.grp_FiltroFechaHora.Text = "Filtro por Fecha/Hora";
            // 
            // lbl_Hasta
            // 
            this.lbl_Hasta.AutoSize = true;
            this.lbl_Hasta.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_Hasta.Location = new System.Drawing.Point(21, 70);
            this.lbl_Hasta.Name = "lbl_Hasta";
            this.lbl_Hasta.Size = new System.Drawing.Size(42, 15);
            this.lbl_Hasta.TabIndex = 39;
            this.lbl_Hasta.Text = "Hasta:";
            this.lbl_Hasta.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // lbl_Desde
            // 
            this.lbl_Desde.AutoSize = true;
            this.lbl_Desde.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_Desde.Location = new System.Drawing.Point(21, 23);
            this.lbl_Desde.Name = "lbl_Desde";
            this.lbl_Desde.Size = new System.Drawing.Size(46, 15);
            this.lbl_Desde.TabIndex = 38;
            this.lbl_Desde.Text = "Desde:";
            this.lbl_Desde.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // cmb_MinutoHasta
            // 
            this.cmb_MinutoHasta.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmb_MinutoHasta.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmb_MinutoHasta.FormattingEnabled = true;
            this.cmb_MinutoHasta.Items.AddRange(new object[] {
            "00",
            "15",
            "30",
            "45"});
            this.cmb_MinutoHasta.Location = new System.Drawing.Point(343, 89);
            this.cmb_MinutoHasta.Name = "cmb_MinutoHasta";
            this.cmb_MinutoHasta.Size = new System.Drawing.Size(40, 23);
            this.cmb_MinutoHasta.TabIndex = 11;
            this.cmb_MinutoHasta.SelectedIndexChanged += new System.EventHandler(this.cmb_MinutoHasta_SelectedIndexChanged);
            // 
            // cmb_MinutoDesde
            // 
            this.cmb_MinutoDesde.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmb_MinutoDesde.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmb_MinutoDesde.FormattingEnabled = true;
            this.cmb_MinutoDesde.Items.AddRange(new object[] {
            "00",
            "15",
            "30",
            "45"});
            this.cmb_MinutoDesde.Location = new System.Drawing.Point(343, 42);
            this.cmb_MinutoDesde.Name = "cmb_MinutoDesde";
            this.cmb_MinutoDesde.Size = new System.Drawing.Size(40, 23);
            this.cmb_MinutoDesde.TabIndex = 9;
            this.cmb_MinutoDesde.SelectedIndexChanged += new System.EventHandler(this.cmb_MinutoDesde_SelectedIndexChanged);
            // 
            // cmb_HoraHasta
            // 
            this.cmb_HoraHasta.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmb_HoraHasta.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmb_HoraHasta.FormattingEnabled = true;
            this.cmb_HoraHasta.Items.AddRange(new object[] {
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
            this.cmb_HoraHasta.Location = new System.Drawing.Point(299, 89);
            this.cmb_HoraHasta.Name = "cmb_HoraHasta";
            this.cmb_HoraHasta.Size = new System.Drawing.Size(40, 23);
            this.cmb_HoraHasta.TabIndex = 7;
            this.cmb_HoraHasta.SelectedIndexChanged += new System.EventHandler(this.cmb_HoraHasta_SelectedIndexChanged);
            // 
            // dtp_Hasta
            // 
            this.dtp_Hasta.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.dtp_Hasta.Location = new System.Drawing.Point(24, 89);
            this.dtp_Hasta.Name = "dtp_Hasta";
            this.dtp_Hasta.Size = new System.Drawing.Size(269, 22);
            this.dtp_Hasta.TabIndex = 5;
            this.dtp_Hasta.ValueChanged += new System.EventHandler(this.dtp_Hasta_ValueChanged);
            // 
            // cmb_HoraDesde
            // 
            this.cmb_HoraDesde.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmb_HoraDesde.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmb_HoraDesde.FormattingEnabled = true;
            this.cmb_HoraDesde.Items.AddRange(new object[] {
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
            this.cmb_HoraDesde.Location = new System.Drawing.Point(299, 42);
            this.cmb_HoraDesde.Name = "cmb_HoraDesde";
            this.cmb_HoraDesde.Size = new System.Drawing.Size(40, 23);
            this.cmb_HoraDesde.TabIndex = 3;
            this.cmb_HoraDesde.SelectedIndexChanged += new System.EventHandler(this.cmb_HoraDesde_SelectedIndexChanged);
            // 
            // grp_FiltroSectoresMaquinas
            // 
            this.grp_FiltroSectoresMaquinas.Controls.Add(this.btn_DeseleccionarTodo);
            this.grp_FiltroSectoresMaquinas.Controls.Add(this.btn_SeleccionarTodo);
            this.grp_FiltroSectoresMaquinas.Controls.Add(this.grp_Telares);
            this.grp_FiltroSectoresMaquinas.Controls.Add(this.grp_Cordoneras);
            this.grp_FiltroSectoresMaquinas.Controls.Add(this.grp_Terminacion);
            this.grp_FiltroSectoresMaquinas.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.grp_FiltroSectoresMaquinas.Location = new System.Drawing.Point(18, 165);
            this.grp_FiltroSectoresMaquinas.Name = "grp_FiltroSectoresMaquinas";
            this.grp_FiltroSectoresMaquinas.Size = new System.Drawing.Size(409, 390);
            this.grp_FiltroSectoresMaquinas.TabIndex = 40;
            this.grp_FiltroSectoresMaquinas.TabStop = false;
            this.grp_FiltroSectoresMaquinas.Text = "Filtro por Sectores/Máquinas";
            // 
            // btn_DeseleccionarTodo
            // 
            this.btn_DeseleccionarTodo.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_DeseleccionarTodo.Location = new System.Drawing.Point(12, 344);
            this.btn_DeseleccionarTodo.Name = "btn_DeseleccionarTodo";
            this.btn_DeseleccionarTodo.Size = new System.Drawing.Size(172, 34);
            this.btn_DeseleccionarTodo.TabIndex = 24;
            this.btn_DeseleccionarTodo.Text = "Deseleccionar todo";
            this.btn_DeseleccionarTodo.UseVisualStyleBackColor = true;
            this.btn_DeseleccionarTodo.Click += new System.EventHandler(this.btn_ResetearTodo_Click);
            // 
            // btn_SeleccionarTodo
            // 
            this.btn_SeleccionarTodo.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_SeleccionarTodo.Location = new System.Drawing.Point(190, 344);
            this.btn_SeleccionarTodo.Name = "btn_SeleccionarTodo";
            this.btn_SeleccionarTodo.Size = new System.Drawing.Size(205, 34);
            this.btn_SeleccionarTodo.TabIndex = 23;
            this.btn_SeleccionarTodo.Text = "Seleccionar todo";
            this.btn_SeleccionarTodo.UseVisualStyleBackColor = true;
            this.btn_SeleccionarTodo.Click += new System.EventHandler(this.btn_SeleccionarTodo_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.ForeColor = System.Drawing.SystemColors.Highlight;
            this.label1.Location = new System.Drawing.Point(456, 566);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(350, 39);
            this.label1.TabIndex = 41;
            this.label1.Text = "En los tres casos, la columna correspondiente a los minutos está de más:\r\n- Solam" +
    "ente se requieren las horas, no los minutos.\r\n- Los minutos se muestran únicamen" +
    "te para comprobar tiempos.";
            // 
            // frm_Home
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(863, 624);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.grp_FiltroSectoresMaquinas);
            this.Controls.Add(this.grp_FiltroFechaHora);
            this.Controls.Add(this.lbl_CantidadTotalHorasMaquina);
            this.Controls.Add(this.dgv_CantTotalHorasMaquina);
            this.Controls.Add(this.lbl_CantidadHorasPorSector);
            this.Controls.Add(this.lbl_CantidadHorasPorMaquina);
            this.Controls.Add(this.btn_Mostrar);
            this.Controls.Add(this.dgv_CantHorasPorSector);
            this.Controls.Add(this.dgv_CantHorasPorMaquina);
            this.Controls.Add(this.pic_logoEmpresa);
            this.Cursor = System.Windows.Forms.Cursors.Default;
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Name = "frm_Home";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Hilos Libertad";
            this.Load += new System.EventHandler(this.FormularioPrincipal_Load);
            ((System.ComponentModel.ISupportInitialize)(this.pic_logoEmpresa)).EndInit();
            this.grp_Telares.ResumeLayout(false);
            this.grp_Telares.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_CantHorasPorMaquina)).EndInit();
            this.grp_Cordoneras.ResumeLayout(false);
            this.grp_Cordoneras.PerformLayout();
            this.grp_Terminacion.ResumeLayout(false);
            this.grp_Terminacion.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_CantHorasPorSector)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_CantTotalHorasMaquina)).EndInit();
            this.grp_FiltroFechaHora.ResumeLayout(false);
            this.grp_FiltroFechaHora.PerformLayout();
            this.grp_FiltroSectoresMaquinas.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.DateTimePicker dtp_Desde;
        private System.Windows.Forms.PictureBox pic_logoEmpresa;
        private System.Windows.Forms.GroupBox grp_Telares;
        private System.Windows.Forms.DataGridView dgv_CantHorasPorMaquina;
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
        private System.Windows.Forms.DataGridView dgv_CantHorasPorSector;
        private System.Windows.Forms.Button btn_Mostrar;
        private System.Windows.Forms.Label lbl_CantidadHorasPorMaquina;
        private System.Windows.Forms.Label lbl_CantidadHorasPorSector;
        private System.Windows.Forms.DataGridView dgv_CantTotalHorasMaquina;
        private System.Windows.Forms.Label lbl_CantidadTotalHorasMaquina;
        private System.Windows.Forms.GroupBox grp_FiltroFechaHora;
        private System.Windows.Forms.ComboBox cmb_HoraDesde;
        private System.Windows.Forms.ComboBox cmb_HoraHasta;
        private System.Windows.Forms.DateTimePicker dtp_Hasta;
        private System.Windows.Forms.ComboBox cmb_MinutoHasta;
        private System.Windows.Forms.ComboBox cmb_MinutoDesde;
        private System.Windows.Forms.Label lbl_Hasta;
        private System.Windows.Forms.Label lbl_Desde;
        private System.Windows.Forms.GroupBox grp_FiltroSectoresMaquinas;
        private System.Windows.Forms.Button btn_SeleccionSectorTelares;
        private System.Windows.Forms.Button btn_SeleccionSectorCordoneras;
        private System.Windows.Forms.Button btn_SeleccionSectorTerminacion;
        private System.Windows.Forms.Button btn_SeleccionarTodo;
        private System.Windows.Forms.Button btn_DeseleccionarTodo;
        private System.Windows.Forms.Label label1;
    }
}

