
namespace HilosLibertad
{
    partial class Form2
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form2));
            this.dgv_Sectores = new System.Windows.Forms.DataGridView();
            this.lbl_Sectores = new System.Windows.Forms.Label();
            this.btn_GuardarCambios = new System.Windows.Forms.Button();
            this.cmb_Sector = new System.Windows.Forms.ComboBox();
            this.lbl_Sector = new System.Windows.Forms.Label();
            this.lab_Nombre = new System.Windows.Forms.Label();
            this.grp_SeleccionarSector = new System.Windows.Forms.GroupBox();
            this.grp_EditarSector = new System.Windows.Forms.GroupBox();
            this.txt_Nombre = new System.Windows.Forms.TextBox();
            this.txt_ID = new System.Windows.Forms.TextBox();
            this.lbl_ID = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_Sectores)).BeginInit();
            this.grp_SeleccionarSector.SuspendLayout();
            this.grp_EditarSector.SuspendLayout();
            this.SuspendLayout();
            // 
            // dgv_Sectores
            // 
            this.dgv_Sectores.AllowUserToAddRows = false;
            this.dgv_Sectores.AllowUserToDeleteRows = false;
            this.dgv_Sectores.AllowUserToOrderColumns = true;
            this.dgv_Sectores.AllowUserToResizeColumns = false;
            this.dgv_Sectores.AllowUserToResizeRows = false;
            this.dgv_Sectores.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgv_Sectores.Location = new System.Drawing.Point(326, 59);
            this.dgv_Sectores.Name = "dgv_Sectores";
            this.dgv_Sectores.ReadOnly = true;
            this.dgv_Sectores.Size = new System.Drawing.Size(144, 195);
            this.dgv_Sectores.TabIndex = 0;
            // 
            // lbl_Sectores
            // 
            this.lbl_Sectores.AutoSize = true;
            this.lbl_Sectores.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_Sectores.Location = new System.Drawing.Point(323, 36);
            this.lbl_Sectores.Name = "lbl_Sectores";
            this.lbl_Sectores.Size = new System.Drawing.Size(65, 16);
            this.lbl_Sectores.TabIndex = 1;
            this.lbl_Sectores.Text = "Sectores:";
            // 
            // btn_GuardarCambios
            // 
            this.btn_GuardarCambios.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_GuardarCambios.Location = new System.Drawing.Point(120, 91);
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
            this.cmb_Sector.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmb_Sector.FormattingEnabled = true;
            this.cmb_Sector.Location = new System.Drawing.Point(79, 27);
            this.cmb_Sector.Name = "cmb_Sector";
            this.cmb_Sector.Size = new System.Drawing.Size(173, 24);
            this.cmb_Sector.TabIndex = 3;
            this.cmb_Sector.SelectedIndexChanged += new System.EventHandler(this.cmb_Sector_SelectedIndexChanged);
            // 
            // lbl_Sector
            // 
            this.lbl_Sector.AutoSize = true;
            this.lbl_Sector.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_Sector.Location = new System.Drawing.Point(27, 32);
            this.lbl_Sector.Name = "lbl_Sector";
            this.lbl_Sector.Size = new System.Drawing.Size(50, 16);
            this.lbl_Sector.TabIndex = 4;
            this.lbl_Sector.Text = "Sector:";
            // 
            // lab_Nombre
            // 
            this.lab_Nombre.AutoSize = true;
            this.lab_Nombre.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lab_Nombre.Location = new System.Drawing.Point(27, 61);
            this.lab_Nombre.Name = "lab_Nombre";
            this.lab_Nombre.Size = new System.Drawing.Size(60, 16);
            this.lab_Nombre.TabIndex = 5;
            this.lab_Nombre.Text = "Nombre:";
            // 
            // grp_SeleccionarSector
            // 
            this.grp_SeleccionarSector.Controls.Add(this.cmb_Sector);
            this.grp_SeleccionarSector.Controls.Add(this.lbl_Sector);
            this.grp_SeleccionarSector.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.grp_SeleccionarSector.Location = new System.Drawing.Point(27, 27);
            this.grp_SeleccionarSector.Name = "grp_SeleccionarSector";
            this.grp_SeleccionarSector.Size = new System.Drawing.Size(273, 67);
            this.grp_SeleccionarSector.TabIndex = 6;
            this.grp_SeleccionarSector.TabStop = false;
            this.grp_SeleccionarSector.Text = "Seleccionar Sector";
            // 
            // grp_EditarSector
            // 
            this.grp_EditarSector.Controls.Add(this.txt_ID);
            this.grp_EditarSector.Controls.Add(this.lbl_ID);
            this.grp_EditarSector.Controls.Add(this.txt_Nombre);
            this.grp_EditarSector.Controls.Add(this.lab_Nombre);
            this.grp_EditarSector.Controls.Add(this.btn_GuardarCambios);
            this.grp_EditarSector.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.grp_EditarSector.Location = new System.Drawing.Point(27, 112);
            this.grp_EditarSector.Name = "grp_EditarSector";
            this.grp_EditarSector.Size = new System.Drawing.Size(273, 142);
            this.grp_EditarSector.TabIndex = 7;
            this.grp_EditarSector.TabStop = false;
            this.grp_EditarSector.Text = "Editar Sector";
            // 
            // txt_Nombre
            // 
            this.txt_Nombre.Location = new System.Drawing.Point(89, 58);
            this.txt_Nombre.MaxLength = 255;
            this.txt_Nombre.Name = "txt_Nombre";
            this.txt_Nombre.Size = new System.Drawing.Size(163, 22);
            this.txt_Nombre.TabIndex = 6;
            // 
            // txt_ID
            // 
            this.txt_ID.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.txt_ID.ForeColor = System.Drawing.SystemColors.InactiveCaption;
            this.txt_ID.Location = new System.Drawing.Point(89, 27);
            this.txt_ID.MaxLength = 255;
            this.txt_ID.Name = "txt_ID";
            this.txt_ID.ReadOnly = true;
            this.txt_ID.Size = new System.Drawing.Size(163, 22);
            this.txt_ID.TabIndex = 8;
            // 
            // lbl_ID
            // 
            this.lbl_ID.AutoSize = true;
            this.lbl_ID.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_ID.ForeColor = System.Drawing.SystemColors.AppWorkspace;
            this.lbl_ID.Location = new System.Drawing.Point(63, 30);
            this.lbl_ID.Name = "lbl_ID";
            this.lbl_ID.Size = new System.Drawing.Size(24, 16);
            this.lbl_ID.TabIndex = 7;
            this.lbl_ID.Text = "ID:";
            // 
            // Form2
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(498, 280);
            this.Controls.Add(this.grp_EditarSector);
            this.Controls.Add(this.grp_SeleccionarSector);
            this.Controls.Add(this.lbl_Sectores);
            this.Controls.Add(this.dgv_Sectores);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "Form2";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Hilos Libertad · Edición de Sectores";
            this.Load += new System.EventHandler(this.Form2_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgv_Sectores)).EndInit();
            this.grp_SeleccionarSector.ResumeLayout(false);
            this.grp_SeleccionarSector.PerformLayout();
            this.grp_EditarSector.ResumeLayout(false);
            this.grp_EditarSector.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView dgv_Sectores;
        private System.Windows.Forms.Label lbl_Sectores;
        private System.Windows.Forms.Button btn_GuardarCambios;
        private System.Windows.Forms.ComboBox cmb_Sector;
        private System.Windows.Forms.Label lbl_Sector;
        private System.Windows.Forms.Label lab_Nombre;
        private System.Windows.Forms.GroupBox grp_SeleccionarSector;
        private System.Windows.Forms.GroupBox grp_EditarSector;
        private System.Windows.Forms.TextBox txt_Nombre;
        private System.Windows.Forms.TextBox txt_ID;
        private System.Windows.Forms.Label lbl_ID;
    }
}