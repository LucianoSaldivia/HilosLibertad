
namespace HilosLibertad
{
    partial class frm_EdicionDeSectores
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frm_EdicionDeSectores));
            this.dgv_Sectores = new System.Windows.Forms.DataGridView();
            this.lbl_SectoresAhoraGuardados = new System.Windows.Forms.Label();
            this.btn_GuardarCambios = new System.Windows.Forms.Button();
            this.cmb_Sector = new System.Windows.Forms.ComboBox();
            this.lbl_ElegirSectorAEditar = new System.Windows.Forms.Label();
            this.lab_Nombre = new System.Windows.Forms.Label();
            this.grp_EdicionDelSector = new System.Windows.Forms.GroupBox();
            this.txt_Nombre = new System.Windows.Forms.TextBox();
            this.txt_ID = new System.Windows.Forms.TextBox();
            this.lbl_ID = new System.Windows.Forms.Label();
            this.lbl_EdicionDeSectores = new System.Windows.Forms.Label();
            this.grp_SectoresActuales = new System.Windows.Forms.GroupBox();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_Sectores)).BeginInit();
            this.grp_EdicionDelSector.SuspendLayout();
            this.grp_SectoresActuales.SuspendLayout();
            this.SuspendLayout();
            // 
            // dgv_Sectores
            // 
            this.dgv_Sectores.AllowUserToAddRows = false;
            this.dgv_Sectores.AllowUserToDeleteRows = false;
            dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle1.Font = new System.Drawing.Font("Segoe UI Semibold", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgv_Sectores.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
            this.dgv_Sectores.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgv_Sectores.Location = new System.Drawing.Point(8, 30);
            this.dgv_Sectores.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.dgv_Sectores.Name = "dgv_Sectores";
            this.dgv_Sectores.ReadOnly = true;
            this.dgv_Sectores.RowHeadersVisible = false;
            this.dgv_Sectores.RowHeadersWidth = 51;
            this.dgv_Sectores.RowHeadersWidthSizeMode = System.Windows.Forms.DataGridViewRowHeadersWidthSizeMode.DisableResizing;
            this.dgv_Sectores.Size = new System.Drawing.Size(147, 142);
            this.dgv_Sectores.TabIndex = 8;
            // 
            // lbl_SectoresAhoraGuardados
            // 
            this.lbl_SectoresAhoraGuardados.AutoSize = true;
            this.lbl_SectoresAhoraGuardados.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_SectoresAhoraGuardados.Location = new System.Drawing.Point(485, 174);
            this.lbl_SectoresAhoraGuardados.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.lbl_SectoresAhoraGuardados.Name = "lbl_SectoresAhoraGuardados";
            this.lbl_SectoresAhoraGuardados.Size = new System.Drawing.Size(213, 23);
            this.lbl_SectoresAhoraGuardados.TabIndex = 95;
            this.lbl_SectoresAhoraGuardados.Text = "Sectores ahora guardados:";
            this.lbl_SectoresAhoraGuardados.Visible = false;
            // 
            // btn_GuardarCambios
            // 
            this.btn_GuardarCambios.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_GuardarCambios.Location = new System.Drawing.Point(131, 85);
            this.btn_GuardarCambios.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.btn_GuardarCambios.Name = "btn_GuardarCambios";
            this.btn_GuardarCambios.Size = new System.Drawing.Size(199, 42);
            this.btn_GuardarCambios.TabIndex = 6;
            this.btn_GuardarCambios.Text = "Guardar cambios";
            this.btn_GuardarCambios.UseVisualStyleBackColor = true;
            this.btn_GuardarCambios.Click += new System.EventHandler(this.btn_GuardarCambios_Click);
            // 
            // cmb_Sector
            // 
            this.cmb_Sector.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmb_Sector.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmb_Sector.FormattingEnabled = true;
            this.cmb_Sector.Location = new System.Drawing.Point(161, 27);
            this.cmb_Sector.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.cmb_Sector.Name = "cmb_Sector";
            this.cmb_Sector.Size = new System.Drawing.Size(201, 29);
            this.cmb_Sector.TabIndex = 2;
            this.cmb_Sector.SelectedIndexChanged += new System.EventHandler(this.cmb_Sector_SelectedIndexChanged);
            // 
            // lbl_ElegirSectorAEditar
            // 
            this.lbl_ElegirSectorAEditar.AutoSize = true;
            this.lbl_ElegirSectorAEditar.Font = new System.Drawing.Font("Segoe UI Semibold", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_ElegirSectorAEditar.Location = new System.Drawing.Point(23, 31);
            this.lbl_ElegirSectorAEditar.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.lbl_ElegirSectorAEditar.Name = "lbl_ElegirSectorAEditar";
            this.lbl_ElegirSectorAEditar.Size = new System.Drawing.Size(126, 23);
            this.lbl_ElegirSectorAEditar.TabIndex = 1;
            this.lbl_ElegirSectorAEditar.Text = "Sector a editar:";
            // 
            // lab_Nombre
            // 
            this.lab_Nombre.AutoSize = true;
            this.lab_Nombre.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lab_Nombre.Location = new System.Drawing.Point(51, 39);
            this.lab_Nombre.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.lab_Nombre.Name = "lab_Nombre";
            this.lab_Nombre.Size = new System.Drawing.Size(77, 23);
            this.lab_Nombre.TabIndex = 4;
            this.lab_Nombre.Text = "Nombre:";
            // 
            // grp_EdicionDelSector
            // 
            this.grp_EdicionDelSector.Controls.Add(this.btn_GuardarCambios);
            this.grp_EdicionDelSector.Controls.Add(this.txt_Nombre);
            this.grp_EdicionDelSector.Controls.Add(this.lab_Nombre);
            this.grp_EdicionDelSector.Font = new System.Drawing.Font("Segoe UI Semibold", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.grp_EdicionDelSector.Location = new System.Drawing.Point(27, 78);
            this.grp_EdicionDelSector.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.grp_EdicionDelSector.Name = "grp_EdicionDelSector";
            this.grp_EdicionDelSector.Padding = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.grp_EdicionDelSector.Size = new System.Drawing.Size(337, 137);
            this.grp_EdicionDelSector.TabIndex = 3;
            this.grp_EdicionDelSector.TabStop = false;
            this.grp_EdicionDelSector.Text = "Edición del Sector";
            // 
            // txt_Nombre
            // 
            this.txt_Nombre.Location = new System.Drawing.Point(135, 34);
            this.txt_Nombre.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.txt_Nombre.MaxLength = 255;
            this.txt_Nombre.Name = "txt_Nombre";
            this.txt_Nombre.Size = new System.Drawing.Size(193, 29);
            this.txt_Nombre.TabIndex = 5;
            this.txt_Nombre.TextChanged += new System.EventHandler(this.txt_Nombre_TextChanged);
            // 
            // txt_ID
            // 
            this.txt_ID.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.txt_ID.ForeColor = System.Drawing.SystemColors.InactiveCaption;
            this.txt_ID.Location = new System.Drawing.Point(513, 142);
            this.txt_ID.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.txt_ID.MaxLength = 255;
            this.txt_ID.Name = "txt_ID";
            this.txt_ID.ReadOnly = true;
            this.txt_ID.Size = new System.Drawing.Size(233, 22);
            this.txt_ID.TabIndex = 97;
            this.txt_ID.Visible = false;
            // 
            // lbl_ID
            // 
            this.lbl_ID.AutoSize = true;
            this.lbl_ID.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_ID.ForeColor = System.Drawing.SystemColors.AppWorkspace;
            this.lbl_ID.Location = new System.Drawing.Point(479, 145);
            this.lbl_ID.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.lbl_ID.Name = "lbl_ID";
            this.lbl_ID.Size = new System.Drawing.Size(31, 23);
            this.lbl_ID.TabIndex = 98;
            this.lbl_ID.Text = "ID:";
            this.lbl_ID.Visible = false;
            // 
            // lbl_EdicionDeSectores
            // 
            this.lbl_EdicionDeSectores.AutoSize = true;
            this.lbl_EdicionDeSectores.Font = new System.Drawing.Font("Segoe UI Semibold", 15.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_EdicionDeSectores.Location = new System.Drawing.Point(483, 101);
            this.lbl_EdicionDeSectores.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.lbl_EdicionDeSectores.Name = "lbl_EdicionDeSectores";
            this.lbl_EdicionDeSectores.Size = new System.Drawing.Size(254, 37);
            this.lbl_EdicionDeSectores.TabIndex = 99;
            this.lbl_EdicionDeSectores.Text = "Edición de Sectores";
            this.lbl_EdicionDeSectores.Visible = false;
            // 
            // grp_SectoresActuales
            // 
            this.grp_SectoresActuales.Controls.Add(this.dgv_Sectores);
            this.grp_SectoresActuales.Font = new System.Drawing.Font("Segoe UI Semibold", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.grp_SectoresActuales.Location = new System.Drawing.Point(388, 34);
            this.grp_SectoresActuales.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.grp_SectoresActuales.Name = "grp_SectoresActuales";
            this.grp_SectoresActuales.Padding = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.grp_SectoresActuales.Size = new System.Drawing.Size(168, 180);
            this.grp_SectoresActuales.TabIndex = 7;
            this.grp_SectoresActuales.TabStop = false;
            this.grp_SectoresActuales.Text = "Sectores actuales";
            // 
            // frm_EdicionDeSectores
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(581, 234);
            this.Controls.Add(this.txt_ID);
            this.Controls.Add(this.lbl_ID);
            this.Controls.Add(this.lbl_EdicionDeSectores);
            this.Controls.Add(this.lbl_SectoresAhoraGuardados);
            this.Controls.Add(this.grp_SectoresActuales);
            this.Controls.Add(this.cmb_Sector);
            this.Controls.Add(this.lbl_ElegirSectorAEditar);
            this.Controls.Add(this.grp_EdicionDelSector);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.Name = "frm_EdicionDeSectores";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Hilos Libertad · Edición de Sectores";
            this.Load += new System.EventHandler(this.Form2_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgv_Sectores)).EndInit();
            this.grp_EdicionDelSector.ResumeLayout(false);
            this.grp_EdicionDelSector.PerformLayout();
            this.grp_SectoresActuales.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView dgv_Sectores;
        private System.Windows.Forms.Label lbl_SectoresAhoraGuardados;
        private System.Windows.Forms.Button btn_GuardarCambios;
        private System.Windows.Forms.ComboBox cmb_Sector;
        private System.Windows.Forms.Label lbl_ElegirSectorAEditar;
        private System.Windows.Forms.Label lab_Nombre;
        private System.Windows.Forms.GroupBox grp_EdicionDelSector;
        private System.Windows.Forms.TextBox txt_Nombre;
        private System.Windows.Forms.TextBox txt_ID;
        private System.Windows.Forms.Label lbl_ID;
        private System.Windows.Forms.Label lbl_EdicionDeSectores;
        private System.Windows.Forms.GroupBox grp_SectoresActuales;
    }
}