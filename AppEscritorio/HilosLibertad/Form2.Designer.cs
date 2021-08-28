
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
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle2 = new System.Windows.Forms.DataGridViewCellStyle();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frm_EdicionDeSectores));
            this.dgv_Sectores = new System.Windows.Forms.DataGridView();
            this.lbl_SectoresAhoraGuardados = new System.Windows.Forms.Label();
            this.btn_GuardarCambios = new System.Windows.Forms.Button();
            this.cmb_Sector = new System.Windows.Forms.ComboBox();
            this.lbl_ElegirSectorAEditar = new System.Windows.Forms.Label();
            this.lab_Nombre = new System.Windows.Forms.Label();
            this.grp_EdicionDelSector = new System.Windows.Forms.GroupBox();
            this.txt_ID = new System.Windows.Forms.TextBox();
            this.lbl_ID = new System.Windows.Forms.Label();
            this.txt_Nombre = new System.Windows.Forms.TextBox();
            this.lbl_EdicionDeSectores = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_Sectores)).BeginInit();
            this.grp_EdicionDelSector.SuspendLayout();
            this.SuspendLayout();
            // 
            // dgv_Sectores
            // 
            this.dgv_Sectores.AllowUserToAddRows = false;
            this.dgv_Sectores.AllowUserToDeleteRows = false;
            dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle1.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgv_Sectores.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
            this.dgv_Sectores.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgv_Sectores.Location = new System.Drawing.Point(215, 287);
            this.dgv_Sectores.Name = "dgv_Sectores";
            this.dgv_Sectores.ReadOnly = true;
            dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle2.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle2.Font = new System.Drawing.Font("Segoe UI Semibold", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle2.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle2.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle2.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgv_Sectores.RowHeadersDefaultCellStyle = dataGridViewCellStyle2;
            this.dgv_Sectores.RowHeadersVisible = false;
            this.dgv_Sectores.RowHeadersWidthSizeMode = System.Windows.Forms.DataGridViewRowHeadersWidthSizeMode.DisableResizing;
            this.dgv_Sectores.Size = new System.Drawing.Size(104, 91);
            this.dgv_Sectores.TabIndex = 0;
            // 
            // lbl_SectoresAhoraGuardados
            // 
            this.lbl_SectoresAhoraGuardados.AutoSize = true;
            this.lbl_SectoresAhoraGuardados.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_SectoresAhoraGuardados.Location = new System.Drawing.Point(42, 287);
            this.lbl_SectoresAhoraGuardados.Name = "lbl_SectoresAhoraGuardados";
            this.lbl_SectoresAhoraGuardados.Size = new System.Drawing.Size(167, 17);
            this.lbl_SectoresAhoraGuardados.TabIndex = 1;
            this.lbl_SectoresAhoraGuardados.Text = "Sectores ahora guardados:";
            // 
            // btn_GuardarCambios
            // 
            this.btn_GuardarCambios.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_GuardarCambios.Location = new System.Drawing.Point(124, 100);
            this.btn_GuardarCambios.Name = "btn_GuardarCambios";
            this.btn_GuardarCambios.Size = new System.Drawing.Size(133, 34);
            this.btn_GuardarCambios.TabIndex = 2;
            this.btn_GuardarCambios.Text = "Guardar cambios";
            this.btn_GuardarCambios.UseVisualStyleBackColor = true;
            this.btn_GuardarCambios.Click += new System.EventHandler(this.btn_MostrarSectores_Click);
            // 
            // cmb_Sector
            // 
            this.cmb_Sector.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmb_Sector.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmb_Sector.FormattingEnabled = true;
            this.cmb_Sector.Location = new System.Drawing.Point(181, 78);
            this.cmb_Sector.Name = "cmb_Sector";
            this.cmb_Sector.Size = new System.Drawing.Size(137, 25);
            this.cmb_Sector.TabIndex = 3;
            this.cmb_Sector.SelectedIndexChanged += new System.EventHandler(this.cmb_Sector_SelectedIndexChanged);
            // 
            // lbl_ElegirSectorAEditar
            // 
            this.lbl_ElegirSectorAEditar.AutoSize = true;
            this.lbl_ElegirSectorAEditar.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_ElegirSectorAEditar.Location = new System.Drawing.Point(42, 81);
            this.lbl_ElegirSectorAEditar.Name = "lbl_ElegirSectorAEditar";
            this.lbl_ElegirSectorAEditar.Size = new System.Drawing.Size(137, 17);
            this.lbl_ElegirSectorAEditar.TabIndex = 4;
            this.lbl_ElegirSectorAEditar.Text = "Elija el sector a editar:";
            // 
            // lab_Nombre
            // 
            this.lab_Nombre.AutoSize = true;
            this.lab_Nombre.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lab_Nombre.Location = new System.Drawing.Point(17, 66);
            this.lab_Nombre.Name = "lab_Nombre";
            this.lab_Nombre.Size = new System.Drawing.Size(60, 17);
            this.lab_Nombre.TabIndex = 5;
            this.lab_Nombre.Text = "Nombre:";
            // 
            // grp_EdicionDelSector
            // 
            this.grp_EdicionDelSector.Controls.Add(this.txt_ID);
            this.grp_EdicionDelSector.Controls.Add(this.lbl_ID);
            this.grp_EdicionDelSector.Controls.Add(this.txt_Nombre);
            this.grp_EdicionDelSector.Controls.Add(this.lab_Nombre);
            this.grp_EdicionDelSector.Controls.Add(this.btn_GuardarCambios);
            this.grp_EdicionDelSector.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.grp_EdicionDelSector.Location = new System.Drawing.Point(45, 119);
            this.grp_EdicionDelSector.Name = "grp_EdicionDelSector";
            this.grp_EdicionDelSector.Size = new System.Drawing.Size(273, 150);
            this.grp_EdicionDelSector.TabIndex = 7;
            this.grp_EdicionDelSector.TabStop = false;
            this.grp_EdicionDelSector.Text = "Edición del Sector";
            // 
            // txt_ID
            // 
            this.txt_ID.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.txt_ID.ForeColor = System.Drawing.SystemColors.InactiveCaption;
            this.txt_ID.Location = new System.Drawing.Point(79, 30);
            this.txt_ID.MaxLength = 255;
            this.txt_ID.Name = "txt_ID";
            this.txt_ID.ReadOnly = true;
            this.txt_ID.Size = new System.Drawing.Size(178, 25);
            this.txt_ID.TabIndex = 8;
            // 
            // lbl_ID
            // 
            this.lbl_ID.AutoSize = true;
            this.lbl_ID.Font = new System.Drawing.Font("Segoe UI", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_ID.ForeColor = System.Drawing.SystemColors.AppWorkspace;
            this.lbl_ID.Location = new System.Drawing.Point(53, 33);
            this.lbl_ID.Name = "lbl_ID";
            this.lbl_ID.Size = new System.Drawing.Size(23, 17);
            this.lbl_ID.TabIndex = 7;
            this.lbl_ID.Text = "ID:";
            // 
            // txt_Nombre
            // 
            this.txt_Nombre.Location = new System.Drawing.Point(79, 63);
            this.txt_Nombre.MaxLength = 255;
            this.txt_Nombre.Name = "txt_Nombre";
            this.txt_Nombre.Size = new System.Drawing.Size(178, 25);
            this.txt_Nombre.TabIndex = 6;
            // 
            // lbl_EdicionDeSectores
            // 
            this.lbl_EdicionDeSectores.AutoSize = true;
            this.lbl_EdicionDeSectores.Font = new System.Drawing.Font("Segoe UI Semibold", 15.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_EdicionDeSectores.Location = new System.Drawing.Point(42, 24);
            this.lbl_EdicionDeSectores.Name = "lbl_EdicionDeSectores";
            this.lbl_EdicionDeSectores.Size = new System.Drawing.Size(199, 30);
            this.lbl_EdicionDeSectores.TabIndex = 8;
            this.lbl_EdicionDeSectores.Text = "Edición de Sectores";
            // 
            // frm_EdicionDeSectores
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(364, 413);
            this.Controls.Add(this.cmb_Sector);
            this.Controls.Add(this.lbl_ElegirSectorAEditar);
            this.Controls.Add(this.lbl_EdicionDeSectores);
            this.Controls.Add(this.grp_EdicionDelSector);
            this.Controls.Add(this.lbl_SectoresAhoraGuardados);
            this.Controls.Add(this.dgv_Sectores);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "frm_EdicionDeSectores";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Hilos Libertad · Edición de Sectores";
            this.Load += new System.EventHandler(this.Form2_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgv_Sectores)).EndInit();
            this.grp_EdicionDelSector.ResumeLayout(false);
            this.grp_EdicionDelSector.PerformLayout();
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
    }
}