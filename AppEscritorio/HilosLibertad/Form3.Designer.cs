
namespace HilosLibertad
{
    partial class frm_EdicionDeMaquinas
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frm_EdicionDeMaquinas));
            this.lbl_EdicionDeMaquinas = new System.Windows.Forms.Label();
            this.cmb_Maquina = new System.Windows.Forms.ComboBox();
            this.lbl_ElegirMaquinaAEditar = new System.Windows.Forms.Label();
            this.grp_EdicionDeLaMaquina = new System.Windows.Forms.GroupBox();
            this.cmb_Sector = new System.Windows.Forms.ComboBox();
            this.lbl_Sector = new System.Windows.Forms.Label();
            this.txt_MetrosPorMinuto = new System.Windows.Forms.TextBox();
            this.lbl_MetrosPorMinuto = new System.Windows.Forms.Label();
            this.txt_Descripcion = new System.Windows.Forms.TextBox();
            this.lbl_Descripcion = new System.Windows.Forms.Label();
            this.txt_Nombre = new System.Windows.Forms.TextBox();
            this.lbl_Nombre = new System.Windows.Forms.Label();
            this.txt_Numero = new System.Windows.Forms.TextBox();
            this.lbl_Numero = new System.Windows.Forms.Label();
            this.btn_GuardarCambios = new System.Windows.Forms.Button();
            this.txt_ID = new System.Windows.Forms.TextBox();
            this.lbl_ID = new System.Windows.Forms.Label();
            this.lbl_MaquinasAhoraGuardadas = new System.Windows.Forms.Label();
            this.dgv_Maquinas = new System.Windows.Forms.DataGridView();
            this.grp_MaquinasActuales = new System.Windows.Forms.GroupBox();
            this.grp_EdicionDeLaMaquina.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_Maquinas)).BeginInit();
            this.grp_MaquinasActuales.SuspendLayout();
            this.SuspendLayout();
            // 
            // lbl_EdicionDeMaquinas
            // 
            this.lbl_EdicionDeMaquinas.AutoSize = true;
            this.lbl_EdicionDeMaquinas.Font = new System.Drawing.Font("Segoe UI Semibold", 15.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_EdicionDeMaquinas.Location = new System.Drawing.Point(992, 545);
            this.lbl_EdicionDeMaquinas.Name = "lbl_EdicionDeMaquinas";
            this.lbl_EdicionDeMaquinas.Size = new System.Drawing.Size(210, 30);
            this.lbl_EdicionDeMaquinas.TabIndex = 99;
            this.lbl_EdicionDeMaquinas.Text = "Edición de Máquinas";
            this.lbl_EdicionDeMaquinas.Visible = false;
            // 
            // cmb_Maquina
            // 
            this.cmb_Maquina.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmb_Maquina.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmb_Maquina.FormattingEnabled = true;
            this.cmb_Maquina.Location = new System.Drawing.Point(220, 22);
            this.cmb_Maquina.Name = "cmb_Maquina";
            this.cmb_Maquina.Size = new System.Drawing.Size(211, 25);
            this.cmb_Maquina.TabIndex = 2;
            this.cmb_Maquina.SelectedIndexChanged += new System.EventHandler(this.cmb_Maquina_SelectedIndexChanged);
            // 
            // lbl_ElegirMaquinaAEditar
            // 
            this.lbl_ElegirMaquinaAEditar.AutoSize = true;
            this.lbl_ElegirMaquinaAEditar.Font = new System.Drawing.Font("Segoe UI Semibold", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_ElegirMaquinaAEditar.Location = new System.Drawing.Point(103, 26);
            this.lbl_ElegirMaquinaAEditar.Name = "lbl_ElegirMaquinaAEditar";
            this.lbl_ElegirMaquinaAEditar.Size = new System.Drawing.Size(115, 17);
            this.lbl_ElegirMaquinaAEditar.TabIndex = 1;
            this.lbl_ElegirMaquinaAEditar.Text = "Máquina a editar:";
            // 
            // grp_EdicionDeLaMaquina
            // 
            this.grp_EdicionDeLaMaquina.Controls.Add(this.cmb_Sector);
            this.grp_EdicionDeLaMaquina.Controls.Add(this.lbl_Sector);
            this.grp_EdicionDeLaMaquina.Controls.Add(this.txt_MetrosPorMinuto);
            this.grp_EdicionDeLaMaquina.Controls.Add(this.lbl_MetrosPorMinuto);
            this.grp_EdicionDeLaMaquina.Controls.Add(this.txt_Descripcion);
            this.grp_EdicionDeLaMaquina.Controls.Add(this.lbl_Descripcion);
            this.grp_EdicionDeLaMaquina.Controls.Add(this.txt_Nombre);
            this.grp_EdicionDeLaMaquina.Controls.Add(this.lbl_Nombre);
            this.grp_EdicionDeLaMaquina.Controls.Add(this.txt_Numero);
            this.grp_EdicionDeLaMaquina.Controls.Add(this.lbl_Numero);
            this.grp_EdicionDeLaMaquina.Controls.Add(this.btn_GuardarCambios);
            this.grp_EdicionDeLaMaquina.Font = new System.Drawing.Font("Segoe UI Semibold", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.grp_EdicionDeLaMaquina.Location = new System.Drawing.Point(20, 63);
            this.grp_EdicionDeLaMaquina.Name = "grp_EdicionDeLaMaquina";
            this.grp_EdicionDeLaMaquina.Size = new System.Drawing.Size(411, 235);
            this.grp_EdicionDeLaMaquina.TabIndex = 3;
            this.grp_EdicionDeLaMaquina.TabStop = false;
            this.grp_EdicionDeLaMaquina.Text = "Edición de la Máquina";
            // 
            // cmb_Sector
            // 
            this.cmb_Sector.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmb_Sector.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmb_Sector.FormattingEnabled = true;
            this.cmb_Sector.Location = new System.Drawing.Point(200, 152);
            this.cmb_Sector.Name = "cmb_Sector";
            this.cmb_Sector.Size = new System.Drawing.Size(202, 25);
            this.cmb_Sector.TabIndex = 13;
            // 
            // lbl_Sector
            // 
            this.lbl_Sector.AutoSize = true;
            this.lbl_Sector.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_Sector.Location = new System.Drawing.Point(146, 155);
            this.lbl_Sector.Name = "lbl_Sector";
            this.lbl_Sector.Size = new System.Drawing.Size(48, 17);
            this.lbl_Sector.TabIndex = 12;
            this.lbl_Sector.Text = "Sector:";
            // 
            // txt_MetrosPorMinuto
            // 
            this.txt_MetrosPorMinuto.Location = new System.Drawing.Point(200, 90);
            this.txt_MetrosPorMinuto.MaxLength = 255;
            this.txt_MetrosPorMinuto.Name = "txt_MetrosPorMinuto";
            this.txt_MetrosPorMinuto.Size = new System.Drawing.Size(202, 25);
            this.txt_MetrosPorMinuto.TabIndex = 9;
            // 
            // lbl_MetrosPorMinuto
            // 
            this.lbl_MetrosPorMinuto.AutoSize = true;
            this.lbl_MetrosPorMinuto.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_MetrosPorMinuto.Location = new System.Drawing.Point(8, 93);
            this.lbl_MetrosPorMinuto.Name = "lbl_MetrosPorMinuto";
            this.lbl_MetrosPorMinuto.Size = new System.Drawing.Size(188, 17);
            this.lbl_MetrosPorMinuto.TabIndex = 8;
            this.lbl_MetrosPorMinuto.Text = "Metros fabricados por minuto:";
            // 
            // txt_Descripcion
            // 
            this.txt_Descripcion.Location = new System.Drawing.Point(200, 121);
            this.txt_Descripcion.MaxLength = 255;
            this.txt_Descripcion.Name = "txt_Descripcion";
            this.txt_Descripcion.Size = new System.Drawing.Size(202, 25);
            this.txt_Descripcion.TabIndex = 11;
            // 
            // lbl_Descripcion
            // 
            this.lbl_Descripcion.AutoSize = true;
            this.lbl_Descripcion.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_Descripcion.Location = new System.Drawing.Point(115, 124);
            this.lbl_Descripcion.Name = "lbl_Descripcion";
            this.lbl_Descripcion.Size = new System.Drawing.Size(79, 17);
            this.lbl_Descripcion.TabIndex = 10;
            this.lbl_Descripcion.Text = "Descripción:";
            // 
            // txt_Nombre
            // 
            this.txt_Nombre.Location = new System.Drawing.Point(200, 59);
            this.txt_Nombre.MaxLength = 255;
            this.txt_Nombre.Name = "txt_Nombre";
            this.txt_Nombre.Size = new System.Drawing.Size(202, 25);
            this.txt_Nombre.TabIndex = 7;
            this.txt_Nombre.TextChanged += new System.EventHandler(this.txt_Nombre_TextChanged);
            // 
            // lbl_Nombre
            // 
            this.lbl_Nombre.AutoSize = true;
            this.lbl_Nombre.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_Nombre.Location = new System.Drawing.Point(136, 62);
            this.lbl_Nombre.Name = "lbl_Nombre";
            this.lbl_Nombre.Size = new System.Drawing.Size(60, 17);
            this.lbl_Nombre.TabIndex = 6;
            this.lbl_Nombre.Text = "Nombre:";
            // 
            // txt_Numero
            // 
            this.txt_Numero.Location = new System.Drawing.Point(200, 28);
            this.txt_Numero.MaxLength = 4;
            this.txt_Numero.Name = "txt_Numero";
            this.txt_Numero.Size = new System.Drawing.Size(202, 25);
            this.txt_Numero.TabIndex = 5;
            this.txt_Numero.TextChanged += new System.EventHandler(this.txt_Numero_TextChanged);
            this.txt_Numero.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txt_Numero_KeyPress);
            // 
            // lbl_Numero
            // 
            this.lbl_Numero.AutoSize = true;
            this.lbl_Numero.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_Numero.Location = new System.Drawing.Point(137, 31);
            this.lbl_Numero.Name = "lbl_Numero";
            this.lbl_Numero.Size = new System.Drawing.Size(59, 17);
            this.lbl_Numero.TabIndex = 4;
            this.lbl_Numero.Text = "Número:";
            // 
            // btn_GuardarCambios
            // 
            this.btn_GuardarCambios.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_GuardarCambios.Location = new System.Drawing.Point(200, 194);
            this.btn_GuardarCambios.Name = "btn_GuardarCambios";
            this.btn_GuardarCambios.Size = new System.Drawing.Size(205, 34);
            this.btn_GuardarCambios.TabIndex = 14;
            this.btn_GuardarCambios.Text = "Guardar cambios";
            this.btn_GuardarCambios.UseVisualStyleBackColor = true;
            this.btn_GuardarCambios.Click += new System.EventHandler(this.btn_GuardarCambios_Click);
            // 
            // txt_ID
            // 
            this.txt_ID.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.txt_ID.ForeColor = System.Drawing.SystemColors.InactiveCaption;
            this.txt_ID.Location = new System.Drawing.Point(1018, 517);
            this.txt_ID.MaxLength = 255;
            this.txt_ID.Name = "txt_ID";
            this.txt_ID.ReadOnly = true;
            this.txt_ID.Size = new System.Drawing.Size(202, 20);
            this.txt_ID.TabIndex = 98;
            this.txt_ID.Visible = false;
            // 
            // lbl_ID
            // 
            this.lbl_ID.AutoSize = true;
            this.lbl_ID.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_ID.ForeColor = System.Drawing.SystemColors.AppWorkspace;
            this.lbl_ID.Location = new System.Drawing.Point(1050, 488);
            this.lbl_ID.Name = "lbl_ID";
            this.lbl_ID.Size = new System.Drawing.Size(23, 17);
            this.lbl_ID.TabIndex = 96;
            this.lbl_ID.Text = "ID:";
            this.lbl_ID.Visible = false;
            // 
            // lbl_MaquinasAhoraGuardadas
            // 
            this.lbl_MaquinasAhoraGuardadas.AutoSize = true;
            this.lbl_MaquinasAhoraGuardadas.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_MaquinasAhoraGuardadas.Location = new System.Drawing.Point(994, 575);
            this.lbl_MaquinasAhoraGuardadas.Name = "lbl_MaquinasAhoraGuardadas";
            this.lbl_MaquinasAhoraGuardadas.Size = new System.Drawing.Size(173, 17);
            this.lbl_MaquinasAhoraGuardadas.TabIndex = 97;
            this.lbl_MaquinasAhoraGuardadas.Text = "Máquinas ahora guardadas:";
            this.lbl_MaquinasAhoraGuardadas.Visible = false;
            // 
            // dgv_Maquinas
            // 
            this.dgv_Maquinas.AllowUserToAddRows = false;
            this.dgv_Maquinas.AllowUserToDeleteRows = false;
            dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle1.Font = new System.Drawing.Font("Segoe UI Semibold", 9.75F, System.Drawing.FontStyle.Bold);
            dataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgv_Maquinas.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
            this.dgv_Maquinas.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgv_Maquinas.Location = new System.Drawing.Point(6, 24);
            this.dgv_Maquinas.Name = "dgv_Maquinas";
            this.dgv_Maquinas.ReadOnly = true;
            this.dgv_Maquinas.RowHeadersVisible = false;
            this.dgv_Maquinas.RowHeadersWidth = 51;
            this.dgv_Maquinas.RowHeadersWidthSizeMode = System.Windows.Forms.DataGridViewRowHeadersWidthSizeMode.DisableResizing;
            this.dgv_Maquinas.Size = new System.Drawing.Size(701, 567);
            this.dgv_Maquinas.TabIndex = 16;
            // 
            // grp_MaquinasActuales
            // 
            this.grp_MaquinasActuales.Controls.Add(this.dgv_Maquinas);
            this.grp_MaquinasActuales.Font = new System.Drawing.Font("Segoe UI Semibold", 9.75F, System.Drawing.FontStyle.Bold);
            this.grp_MaquinasActuales.Location = new System.Drawing.Point(447, 22);
            this.grp_MaquinasActuales.Name = "grp_MaquinasActuales";
            this.grp_MaquinasActuales.Size = new System.Drawing.Size(713, 597);
            this.grp_MaquinasActuales.TabIndex = 15;
            this.grp_MaquinasActuales.TabStop = false;
            this.grp_MaquinasActuales.Text = "Máquinas actuales";
            // 
            // frm_EdicionDeMaquinas
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1176, 633);
            this.Controls.Add(this.grp_MaquinasActuales);
            this.Controls.Add(this.cmb_Maquina);
            this.Controls.Add(this.lbl_ElegirMaquinaAEditar);
            this.Controls.Add(this.grp_EdicionDeLaMaquina);
            this.Controls.Add(this.lbl_MaquinasAhoraGuardadas);
            this.Controls.Add(this.lbl_EdicionDeMaquinas);
            this.Controls.Add(this.txt_ID);
            this.Controls.Add(this.lbl_ID);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "frm_EdicionDeMaquinas";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Hilos Libertad · Edición de Máquinas";
            this.Load += new System.EventHandler(this.frm_EdicionDeMaquinas_Load);
            this.grp_EdicionDeLaMaquina.ResumeLayout(false);
            this.grp_EdicionDeLaMaquina.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_Maquinas)).EndInit();
            this.grp_MaquinasActuales.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lbl_EdicionDeMaquinas;
        private System.Windows.Forms.ComboBox cmb_Maquina;
        private System.Windows.Forms.Label lbl_ElegirMaquinaAEditar;
        private System.Windows.Forms.GroupBox grp_EdicionDeLaMaquina;
        private System.Windows.Forms.TextBox txt_ID;
        private System.Windows.Forms.Label lbl_ID;
        private System.Windows.Forms.TextBox txt_Numero;
        private System.Windows.Forms.Label lbl_Numero;
        private System.Windows.Forms.Button btn_GuardarCambios;
        private System.Windows.Forms.Label lbl_MaquinasAhoraGuardadas;
        private System.Windows.Forms.DataGridView dgv_Maquinas;
        private System.Windows.Forms.TextBox txt_Descripcion;
        private System.Windows.Forms.Label lbl_Descripcion;
        private System.Windows.Forms.TextBox txt_Nombre;
        private System.Windows.Forms.Label lbl_Nombre;
        private System.Windows.Forms.TextBox txt_MetrosPorMinuto;
        private System.Windows.Forms.Label lbl_MetrosPorMinuto;
        private System.Windows.Forms.ComboBox cmb_Sector;
        private System.Windows.Forms.Label lbl_Sector;
        private System.Windows.Forms.GroupBox grp_MaquinasActuales;
    }
}