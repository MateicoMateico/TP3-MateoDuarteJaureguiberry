using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TrabajoPractico3
{
    public partial class GestionRegistros : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                completarTablaRegistros();
            }
        }

        protected void completarTablaRegistros()
        {
            try
            {
                DataView dv = (DataView)SqlDataSourceRegistrosContablesJoinDescripcion.Select(DataSourceSelectArguments.Empty);

                if (dv != null && dv.Count > 0)
                {
                    TableRow headerRow = new TableRow();

                    TableCell headerCell1 = new TableCell();
                    headerCell1.Text = "ID";
                    headerRow.Cells.Add(headerCell1);

                    TableCell headerCell2 = new TableCell();
                    headerCell2.Text = "Cuenta";
                    headerRow.Cells.Add(headerCell2);

                    TableCell headerCell3 = new TableCell();
                    headerCell3.Text = "Monto";
                    headerRow.Cells.Add(headerCell3);

                    TableCell headerCell4 = new TableCell();
                    headerCell4.Text = "Tipo";
                    headerRow.Cells.Add(headerCell4);

                    TableRegistros.Rows.Add(headerRow);

                    foreach (DataRowView rowView in dv)
                    {
                        DataRow row = rowView.Row;
                        TableRow tableRow = new TableRow();

                        TableCell cell1 = new TableCell();
                        cell1.Text = row["id"].ToString();
                        tableRow.Cells.Add(cell1);

                        TableCell cell2 = new TableCell();
                        cell2.Text = row["descripcion"].ToString(); 
                        tableRow.Cells.Add(cell2);

                        TableCell cell3 = new TableCell();
                        cell3.Text = row["monto"].ToString();
                        tableRow.Cells.Add(cell3);

                        TableCell cell4 = new TableCell();
                        bool tipo = Convert.ToBoolean(row["tipo"]);
                        cell4.Text = tipo ? "Haber" : "Debe";
                        tableRow.Cells.Add(cell4);

                        TableRegistros.Rows.Add(tableRow);
                    }
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "AlertScript", $"alert('Error: {ex.Message}');", true);
            }

        }

        protected void ButtonCR_Click(object sender, EventArgs e)
        {
            int result = SqlDataSourceRegistrosContables.Insert();
            if (result > 0)
            {
                LabelMensaje.Text = "Se ha agregado " + result.ToString() + " registro.";
                completarTablaRegistros();
                TextBoxMonto.Text = string.Empty;

            }
            else
            {
                LabelMensaje.Text = "No se agregaron registros.";
            }
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataView dv = (DataView)SqlDataSourceMontoRegistroExistente.Select(DataSourceSelectArguments.Empty);
            if (dv != null && dv.Count > 0) {
                DataRowView row = dv[0];
                TextBoxMonto.Text = row["monto"].ToString();
                DropDownListCuentasExistentes.SelectedValue = row["idCuenta"].ToString();
                DropDownListTipo.SelectedValue = row["tipo"].ToString();
            }
            completarTablaRegistros();
        }

        protected void ButtonMR_Click(object sender, EventArgs e)
        {
            int result = SqlDataSourceRegistrosContables.Update();
            if (result > 0)
            {
                LabelMensaje.Text = "Se ha modificado " + result.ToString() + " registro.";
                completarTablaRegistros();
                TextBoxMonto.Text = string.Empty;

            }
            else
            {
                LabelMensaje.Text = "No se modificaron registros.";
            }
        }

        protected void ButtonER_Click(object sender, EventArgs e)
        {
            int result = SqlDataSourceRegistrosContables.Delete();
            if (result > 0)
            {
                LabelMensaje.Text = "Se ha eliminado " + result.ToString() + " registro.";
                completarTablaRegistros();
                TextBoxMonto.Text = string.Empty;

            }
            else
            {
                LabelMensaje.Text = "No se eliminaron registros.";
            }
        }
    }
}