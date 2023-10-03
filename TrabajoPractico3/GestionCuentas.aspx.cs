using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection.Emit;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TrabajoPractico3
{
    public partial class GestionCuentas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                completarTablaCuentas();
            }
        }
        protected void completarTablaCuentas()
        {
            try
            {
                DataView dv = (DataView)SqlDataSourceCuentas.Select(DataSourceSelectArguments.Empty);

                if (dv != null && dv.Count > 0)
                {
                    
                    TableRow headerRow = new TableRow();

                    TableCell headerCell1 = new TableCell();
                    headerCell1.Text = "ID";
                    headerRow.Cells.Add(headerCell1);

                    TableCell headerCell2 = new TableCell();
                    headerCell2.Text = "Descripción";
                    headerRow.Cells.Add(headerCell2);

                    TableCuentas.Rows.Add(headerRow);

                    
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

                        TableCuentas.Rows.Add(tableRow);
                    }
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "AlertScript", $"alert('Error: {ex.Message}');", true);
            }
        }

        protected void ButtonCC_Click(object sender, EventArgs e)
        {
            int result = SqlDataSourceCuentas.Insert();
            if (result > 0)
            {
                LabelMensaje.Text = "Se ha agregado " + result.ToString() + " registro.";
                completarTablaCuentas();
               TextBoxDC.Text = string.Empty;
                
            }
            else
            {
                LabelMensaje.Text = "No se agregaron registros.";
            }
        }

        protected void DropDownListCuentas_SelectedIndexChanged(object sender, EventArgs e)
        {
            string descripcionCuenta = DropDownListCuentas.SelectedItem.ToString();
            TextBoxDC.Text = descripcionCuenta;
            completarTablaCuentas();
        }

        protected void ButtonEC_Click(object sender, EventArgs e)
        {
            int result = SqlDataSourceCuentas.Delete();
            if (result > 0)
            {
                LabelMensaje.Text = "Se ha eliminado " + result.ToString() + " registro.";
                completarTablaCuentas();
                TextBoxDC.Text = string.Empty;

            }
            else
            {
                LabelMensaje.Text = "No se eliminaron registros.";
            }
        }

        protected void ButtonMC_Click(object sender, EventArgs e)
        {
            int result = SqlDataSourceCuentas.Update();
            if (result > 0)
            {
                LabelMensaje.Text = "Se ha modificado " + result.ToString() + " registro.";
                completarTablaCuentas();
                TextBoxDC.Text = string.Empty;

            }
            else
            {
                LabelMensaje.Text = "No se modificaron registros.";
            }
        }
    }
}