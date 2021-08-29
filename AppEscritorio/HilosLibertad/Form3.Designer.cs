
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
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle2 = new System.Windows.Forms.DataGridViewCellStyle();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frm_EdicionDeMaquinas));
            this.lbl_EdicionDeMaquinas = new System.Windows.Forms.Label();
            this.cmb_Maquina = new System.Windows.Forms.ComboBox();
            this.lbl_ElegirMaquinaAEditar = new System.Windows.Forms.Label();
            this.grp_EdicionDeLaMaquina = new System.Windows.Forms.GroupBox();
            this.txt_ID = new System.Windows.Forms.TextBox();
            this.lbl_ID = new System.Windows.Forms.Label();
            this.txt_Numero = new System.Windows.Forms.TextBox();
            this.lbl_Numero = new System.Windows.Forms.Label();
            this.btn_GuardarCambios = new System.Windows.Forms.Button();
            this.lbl_MaquinasAhoraGuardadas = new System.Windows.Forms.Label();
            this.dgv_Maquinas = new System.Windows.Forms.DataGridView();
            this.txt_Nombre = new System.Windows.Forms.TextBox();
            this.lbl_Nombre = new System.Windows.Forms.Label();
            this.txt_Descripcion = new System.Windows.Forms.TextBox();
            this.lbl_Descripcion = new System.Windows.Forms.Label();
            this.grp_EdicionDeLaMaquina.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_Maquinas)).BeginInit();
            this.SuspendLayout();
            // 
            // lbl_EdicionDeMaquinas
            // 
            this.lbl_EdicionDeMaquinas.AutoSize = true;
            this.lbl_EdicionDeMaquinas.Font = new System.Drawing.Font("Segoe UI Semibold", 15.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_EdicionDeMaquinas.Location = new System.Drawing.Point(42, 24);
            this.lbl_EdicionDeMaquinas.Name = "lbl_EdicionDeMaquinas";
            this.lbl_EdicionDeMaquinas.Size = new System.Drawing.Size(210, 30);
            this.lbl_EdicionDeMaquinas.TabIndex = 0;
            this.lbl_EdicionDeMaquinas.Text = "Edición de Máquinas";
            // 
            // cmb_Maquina
            // 
            this.cmb_Maquina.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmb_Maquina.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmb_Maquina.FormattingEnabled = true;
            this.cmb_Maquina.Location = new System.Drawing.Point(195, 78);
            this.cmb_Maquina.Name = "cmb_Maquina";
            this.cmb_Maquina.Size = new System.Drawing.Size(137, 25);
            this.cmb_Maquina.TabIndex = 2;
            this.cmb_Maquina.SelectedIndexChanged += new System.EventHandler(this.cmb_Maquina_SelectedIndexChanged);
            // 
            // lbl_ElegirMaquinaAEditar
            // 
            this.lbl_ElegirMaquinaAEditar.AutoSize = true;
            this.lbl_ElegirMaquinaAEditar.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_ElegirMaquinaAEditar.Location = new System.Drawing.Point(42, 81);
            this.lbl_ElegirMaquinaAEditar.Name = "lbl_ElegirMaquinaAEditar";
            this.lbl_ElegirMaquinaAEditar.Size = new System.Drawing.Size(151, 17);
            this.lbl_ElegirMaquinaAEditar.TabIndex = 1;
            this.lbl_ElegirMaquinaAEditar.Text = "Elija la máquina a editar:";
            // 
            // grp_EdicionDeLaMaquina
            // 
            this.grp_EdicionDeLaMaquina.Controls.Add(this.txt_Descripcion);
            this.grp_EdicionDeLaMaquina.Controls.Add(this.lbl_Descripcion);
            this.grp_EdicionDeLaMaquina.Controls.Add(this.txt_Nombre);
            this.grp_EdicionDeLaMaquina.Controls.Add(this.lbl_Nombre);
            this.grp_EdicionDeLaMaquina.Controls.Add(this.txt_ID);
            this.grp_EdicionDeLaMaquina.Controls.Add(this.lbl_ID);
            this.grp_EdicionDeLaMaquina.Controls.Add(this.txt_Numero);
            this.grp_EdicionDeLaMaquina.Controls.Add(this.lbl_Numero);
            this.grp_EdicionDeLaMaquina.Controls.Add(this.btn_GuardarCambios);
            this.grp_EdicionDeLaMaquina.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.grp_EdicionDeLaMaquina.Location = new System.Drawing.Point(45, 119);
            this.grp_EdicionDeLaMaquina.Name = "grp_EdicionDeLaMaquina";
            this.grp_EdicionDeLaMaquina.Size = new System.Drawing.Size(287, 218);
            this.grp_EdicionDeLaMaquina.TabIndex = 3;
            this.grp_EdicionDeLaMaquina.TabStop = false;
            this.grp_EdicionDeLaMaquina.Text = "Edición de la Máquina";
            // 
            // txt_ID
            // 
            this.txt_ID.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.txt_ID.ForeColor = System.Drawing.SystemColors.InactiveCaption;
            this.txt_ID.Location = new System.Drawing.Point(96, 30);
            this.txt_ID.MaxLength = 255;
            this.txt_ID.Name = "txt_ID";
            this.txt_ID.ReadOnly = true;
            this.txt_ID.Size = new System.Drawing.Size(170, 25);
            this.txt_ID.TabIndex = 5;
            // 
            // lbl_ID
            // 
            this.lbl_ID.AutoSize = true;
            this.lbl_ID.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_ID.ForeColor = System.Drawing.SystemColors.AppWorkspace;
            this.lbl_ID.Location = new System.Drawing.Point(71, 33);
            this.lbl_ID.Name = "lbl_ID";
            this.lbl_ID.Size = new System.Drawing.Size(23, 17);
            this.lbl_ID.TabIndex = 4;
            this.lbl_ID.Text = "ID:";
            // 
            // txt_Numero
            // 
            this.txt_Numero.Location = new System.Drawing.Point(96, 63);
            this.txt_Numero.MaxLength = 255;
            this.txt_Numero.Name = "txt_Numero";
            this.txt_Numero.Size = new System.Drawing.Size(170, 25);
            this.txt_Numero.TabIndex = 7;
            // 
            // lbl_Numero
            // 
            this.lbl_Numero.AutoSize = true;
            this.lbl_Numero.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_Numero.Location = new System.Drawing.Point(35, 66);
            this.lbl_Numero.Name = "lbl_Numero";
            this.lbl_Numero.Size = new System.Drawing.Size(59, 17);
            this.lbl_Numero.TabIndex = 6;
            this.lbl_Numero.Text = "Número:";
            // 
            // btn_GuardarCambios
            // 
            this.btn_GuardarCambios.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_GuardarCambios.Location = new System.Drawing.Point(133, 167);
            this.btn_GuardarCambios.Name = "btn_GuardarCambios";
            this.btn_GuardarCambios.Size = new System.Drawing.Size(133, 34);
            this.btn_GuardarCambios.TabIndex = 12;
            this.btn_GuardarCambios.Text = "Guardar cambios";
            this.btn_GuardarCambios.UseVisualStyleBackColor = true;
            this.btn_GuardarCambios.Click += new System.EventHandler(this.btn_GuardarCambios_Click);
            // 
            // lbl_MaquinasAhoraGuardadas
            // 
            this.lbl_MaquinasAhoraGuardadas.AutoSize = true;
            this.lbl_MaquinasAhoraGuardadas.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_MaquinasAhoraGuardadas.Location = new System.Drawing.Point(365, 24);
            this.lbl_MaquinasAhoraGuardadas.Name = "lbl_MaquinasAhoraGuardadas";
            this.lbl_MaquinasAhoraGuardadas.Size = new System.Drawing.Size(173, 17);
            this.lbl_MaquinasAhoraGuardadas.TabIndex = 13;
            this.lbl_MaquinasAhoraGuardadas.Text = "Máquinas ahora guardadas:";
            // 
            // dgv_Maquinas
            // 
            this.dgv_Maquinas.AllowUserToAddRows = false;
            this.dgv_Maquinas.AllowUserToDeleteRows = false;
            dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle1.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgv_Maquinas.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
            this.dgv_Maquinas.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgv_Maquinas.Location = new System.Drawing.Point(366, 44);
            this.dgv_Maquinas.Name = "dgv_Maquinas";
            this.dgv_Maquinas.ReadOnly = true;
            dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle2.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle2.Font = new System.Drawing.Font("Segoe UI Semibold", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle2.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle2.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle2.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgv_Maquinas.RowHeadersDefaultCellStyle = dataGridViewCellStyle2;
            this.dgv_Maquinas.RowHeadersVisible = false;
            this.dgv_Maquinas.RowHeadersWidthSizeMode = System.Windows.Forms.DataGridViewRowHeadersWidthSizeMode.DisableResizing;
            this.dgv_Maquinas.Size = new System.Drawing.Size(369, 540);
            this.dgv_Maquinas.TabIndex = 14;
            // 
            // txt_Nombre
            // 
            this.txt_Nombre.Location = new System.Drawing.Point(96, 96);
            this.txt_Nombre.MaxLength = 255;
            this.txt_Nombre.Name = "txt_Nombre";
            this.txt_Nombre.Size = new System.Drawing.Size(170, 25);
            this.txt_Nombre.TabIndex = 9;
            // 
            // lbl_Nombre
            // 
            this.lbl_Nombre.AutoSize = true;
            this.lbl_Nombre.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_Nombre.Location = new System.Drawing.Point(34, 99);
            this.lbl_Nombre.Name = "lbl_Nombre";
            this.lbl_Nombre.Size = new System.Drawing.Size(60, 17);
            this.lbl_Nombre.TabIndex = 8;
            this.lbl_Nombre.Text = "Nombre:";
            // 
            // txt_Descripcion
            // 
            this.txt_Descripcion.Location = new System.Drawing.Point(96, 129);
            this.txt_Descripcion.MaxLength = 255;
            this.txt_Descripcion.Name = "txt_Descripcion";
            this.txt_Descripcion.Size = new System.Drawing.Size(170, 25);
            this.txt_Descripcion.TabIndex = 11;
            // 
            // lbl_Descripcion
            // 
            this.lbl_Descripcion.AutoSize = true;
            this.lbl_Descripcion.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_Descripcion.Location = new System.Drawing.Point(15, 132);
            this.lbl_Descripcion.Name = "lbl_Descripcion";
            this.lbl_Descripcion.Size = new System.Drawing.Size(79, 17);
            this.lbl_Descripcion.TabIndex = 10;
            this.lbl_Descripcion.Text = "Descripción:";
            // 
            // frm_EdicionDeMaquinas
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(772, 615);
            this.Controls.Add(this.cmb_Maquina);
            this.Controls.Add(this.lbl_ElegirMaquinaAEditar);
            this.Controls.Add(this.grp_EdicionDeLaMaquina);
            this.Controls.Add(this.lbl_MaquinasAhoraGuardadas);
            this.Controls.Add(this.dgv_Maquinas);
            this.Controls.Add(this.lbl_EdicionDeMaquinas);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "frm_EdicionDeMaquinas";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Hilos Libertad · Edición de Máquinas";
            this.Load += new System.EventHandler(this.frm_EdicionDeMaquinas_Load);
            this.grp_EdicionDeLaMaquina.ResumeLayout(false);
            this.grp_EdicionDeLaMaquina.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_Maquinas)).EndInit();
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
    }
}