using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;     // Para poder usar el ConfigurationManager
using System.Data.SqlClient;    // Para tener disponible la clase conexión
using System.Data;              // 
/*using System.Data.SqlClient; // librería necesaria para usar SQL*/

namespace HilosLibertad
{
    public class Conexion
    {
        // Método que devuelve un objeto de conexión (de tipo SqlConnection)
        // Método que devuelve una conexión activa a la base de datos, la cual fue definida previamente en las propiedades del proyecto
        public SqlConnection LeerCadena() {

            // Se crea el objeto de tipo SqlConnection
            // Dentro del constructor se va a invocar a la variable "única" que guarda la cadena de conexión, creada previamente
            SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["unica"].ConnectionString);

            // Se agrega una validación:
            // Si el estado del objeto de conexión es abierto, se cierra.
            // Si es cerrado, se abre.
            if (cn.State == ConnectionState.Open) {
                cn.Close();
            }
            else {
                cn.Open();
            }
            


            // Se retorna el objeto de conexión (esté abierto o cerrado)
            return cn;
        }

        public void cerrarConexion(SqlConnection c)
        {
            c.Close();
        }

    }
    
    
    
    /*class conexionConBaseDeDatos
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

    }*/
}
