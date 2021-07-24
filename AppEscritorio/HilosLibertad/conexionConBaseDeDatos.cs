using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient; // librería necesaria para usar SQL

namespace HilosLibertad
{
    class conexionConBaseDeDatos
    {
        // PABLO-PC             nombre de usuario de la base de datos
        // pruebaDB             nombre de la base de datos
        string cadenaDeConexion = "Data Source = PABLO-PC; Initial Catalog = pruebaDB; Integrated Security = true";

        public SqlConnection conectarBD = new SqlConnection();

        public conexionConBaseDeDatos() {
            conectarBD.ConnectionString = cadenaDeConexion;
        }


        public void abrir() {
            try {
                conectarBD.Open();
                Console.WriteLine("Conexión abierta");
                }
            catch (Exception exc) {
                Console.WriteLine("Error al abrir la base de datos: " + exc.Message);
            }
        }

        public void cerrar() {
            conectarBD.Close();
        }

    }
}
