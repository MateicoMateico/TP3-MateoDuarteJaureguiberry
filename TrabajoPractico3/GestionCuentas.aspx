<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GestionCuentas.aspx.cs" Inherits="TrabajoPractico3.GestionCuentas" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gestión de Cuentas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
</head>
<body class="bg-light">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container">
    <a class="navbar-brand" href="#">Trabajo Practico Numero 3 - Mateo Duarte Jaureguiberry</a>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ml-auto">
        <li class="nav-item">
          <a class="nav-link" href="GestionCuentas.aspx">Gestión de Cuentas</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="GestionRegistros.aspx">Gestión de Registros Contables</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

    <form id="form1" runat="server" class="container py-5">
        <div class="card p-4 shadow bg-white">
            <h2 class="mb-4">Gestión de Cuentas</h2>
            <div class="mb-3">
                <h5 class="mb-3">Selecciona Cuenta Existente (para modificar)</h5>
                <asp:DropDownList ID="DropDownListCuentas" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceCuentas" DataTextField="descripcion" DataValueField="id" OnSelectedIndexChanged="DropDownListCuentas_SelectedIndexChanged" CssClass="form-select">
                </asp:DropDownList>
            </div>
            <div class="mb-3">
                <h5 class="mb-3">Agrega una Descripción/Nombre para la cuenta</h5>
                <asp:TextBox ID="TextBoxDC" placeholder="Descripción Cuenta" runat="server" ToolTip="Crear Cuenta" required onkeyup="filtrarTabla(this.value)" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="d-flex">
                <asp:Button ID="ButtonCC" runat="server" Text="Crear Cuenta" OnClick="ButtonCC_Click" CssClass="btn btn-primary me-2" />
                <asp:Button ID="ButtonEC" runat="server" OnClick="ButtonEC_Click" OnClientClick="return confirm('¿Estás seguro de que quieres eliminar esta cuenta?');" Text="Eliminar Cuenta" CssClass="btn btn-danger me-2" />
                <asp:Button ID="ButtonMC" runat="server" OnClick="ButtonMC_Click" Text="Modificar Cuenta" CssClass="btn btn-secondary" />
            </div>
            <asp:Label ID="LabelMensaje" runat="server" CssClass="alert alert-info mt-3"></asp:Label>
        </div>
        <asp:Table ID="TableCuentas" CssClass="table table-striped mt-4" runat="server">
        </asp:Table>
        <asp:SqlDataSource ID="SqlDataSourceCuentas" runat="server" ConnectionString="<%$ ConnectionStrings:conexion %>" DeleteCommand="DELETE FROM [Cuentas] WHERE [id] = @id" InsertCommand="INSERT INTO [Cuentas] ([descripcion]) VALUES (@descripcion)" SelectCommand="SELECT * FROM [Cuentas]" UpdateCommand="UPDATE [Cuentas] SET [descripcion] = @descripcion WHERE [id] = @id">
            <DeleteParameters>
                <asp:ControlParameter ControlID="DropDownListCuentas" Name="id" PropertyName="SelectedValue" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="TextBoxDC" Name="descripcion" PropertyName="Text" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="TextBoxDC" Name="descripcion" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="DropDownListCuentas" Name="id" PropertyName="SelectedValue" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-vp1RIe3HovB2PPVp+EElSI5sqYY3RvlSSCKaef35OVR8oZ2Pq4CNk6cUfOgTbA" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        function filtrarTabla(filtro) {
            filtro = filtro.toLowerCase();
            let tabla = document.getElementById('TableCuentas');
            let filas = tabla.getElementsByTagName('tr');
            for (var i = 1; i < filas.length; i++) {
                var fila = filas[i];
                var celdas = fila.getElementsByTagName('td');
                var mostrarFila = false;
                for (var j = 0; j < celdas.length; j++) {
                    var celda = celdas[j];
                    if (celda) {
                        var contenido = celda.textContent || celda.innerText;
                        if (contenido.toLowerCase().indexOf(filtro) > -1) {
                            mostrarFila = true;
                            break;
                        }
                    }
                }
                fila.style.display = mostrarFila ? '' : 'none';
            }
        }
    </script>
</body>
</html>
