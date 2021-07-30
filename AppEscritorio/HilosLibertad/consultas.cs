using System;
using System.Collections.Generic;
using System.Data;              // Necesario para el DataTable
using System.Data.SqlClient;    // Necesario para el SqlDataAdapter
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HilosLibertad
{
    public class Consultas
    {
        // Creamos el objeto de la clase Conexion y la instanciamos
        Conexion cn = new Conexion();

        // 
        public DataTable mostrarCantidadDeHorasPorMaquina() {
            string consulta = "SELECT * FROM HILOSLIBERTAD.sectores";
            SqlDataAdapter da = new SqlDataAdapter(consulta, cn.LeerCadena());

            // Lo que sigue es solamente para procedimientos almacenados
            // da.SelectCommand.CommandType = CommandType.StoredProcedure;

            DataTable dt = new DataTable();
            da.Fill(dt);

            return (dt);
        }
    }
}
