<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GestionRegistros.aspx.cs" Inherits="TrabajoPractico3.GestionRegistros" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gestion de Registros Contables</title>
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
            <h2 class="mb-4">Gestión de Registros Contables</h2>
            <div class="mb-3">
                <h5 class="mb-3">Selecciona Id de Registro Existente (para modificar)</h5>
                <asp:DropDownList ID="DropDownListRegistrosExistentes" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceRegistrosContables" DataTextField="id" DataValueField="id" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" CssClass="form-select"></asp:DropDownList>
            </div>
            <div class="mb-3">
                <h5 class="mb-3">Elige una cuenta para asignar el registro</h5>
                <asp:DropDownList ID="DropDownListCuentasExistentes" runat="server" DataSourceID="SqlDataSourceCuentasExistentes" DataTextField="descripcion" DataValueField="id" CssClass="form-select"></asp:DropDownList>
            </div>
            <div class="mb-3">
                <h5 class="mb-3">Ingrese Monto del Registro Contable</h5>
                <asp:TextBox ID="TextBoxMonto" runat="server" required placeholder="Ingrese Monto del Registro Contable" TextMode="Number" ToolTip="Ingrese monto" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="mb-3">
                <h5 class="mb-3">Seleccionar Deber/Haber</h5>
                <asp:DropDownList ID="DropDownListTipo" runat="server" CssClass="form-select">
                    <asp:ListItem Selected="True" Value="False">Debe</asp:ListItem>
                    <asp:ListItem Value="True">Haber</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="mb-3">
                <asp:Button ID="ButtonCR" runat="server" Text="Crear Registro" OnClick="ButtonCR_Click" CssClass="btn btn-primary" />
                <asp:Button ID="ButtonER" runat="server" Text="Eliminar Registro" OnClientClick="return confirm('¿Estás seguro de que quieres eliminar esta cuenta?');" OnClick="ButtonER_Click" CssClass="btn btn-danger" />
                <asp:Button ID="ButtonMR" runat="server" Text="Modificar Registro" OnClick="ButtonMR_Click" CssClass="btn btn-secondary" />
            </div>
            <asp:Label ID="LabelMensaje" runat="server" CssClass="alert alert-info mt-3"></asp:Label>
        </div>
        <asp:Table ID="TableRegistros" CssClass="table table-striped mt-4" runat="server">
        </asp:Table>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-vp1RIe3HovB2PPVp+EElSI5sqYY3RvlSSCKaef35OVR8oZ2Pq4CNk6cUfOgTbA" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <asp:SqlDataSource ID="SqlDataSourceCuentasExistentes" runat="server" ConnectionString="<%$ ConnectionStrings:conexion %>" SelectCommand="SELECT * FROM [Cuentas]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceRegistrosContables" runat="server" ConnectionString="<%$ ConnectionStrings:conexion %>" DeleteCommand="DELETE FROM [RegistrosContables] WHERE [id] = @id" InsertCommand="INSERT INTO [RegistrosContables] ([idCuenta], [monto], [tipo]) VALUES (@idCuenta, @monto, @tipo)" SelectCommand="SELECT * FROM [RegistrosContables]" UpdateCommand="UPDATE [RegistrosContables] SET [idCuenta] = @idCuenta, [monto] = @monto, [tipo] = @tipo WHERE [id] = @id">
            <DeleteParameters>
                <asp:ControlParameter ControlID="DropDownListRegistrosExistentes" Name="id" PropertyName="SelectedValue" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="DropDownListCuentasExistentes" Name="idCuenta" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="TextBoxMonto" Name="monto" PropertyName="Text" Type="Int32" />
                <asp:ControlParameter ControlID="DropDownListTipo" Name="tipo" PropertyName="SelectedValue" Type="Boolean" />
            </InsertParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="DropDownListCuentasExistentes" Name="idCuenta" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="TextBoxMonto" Name="monto" PropertyName="Text" Type="Int32" />
                <asp:ControlParameter ControlID="DropDownListTipo" Name="tipo" PropertyName="SelectedValue" Type="Boolean" />
                <asp:ControlParameter ControlID="DropDownListRegistrosExistentes" Name="id" PropertyName="SelectedValue" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceRegistrosContablesJoinDescripcion" runat="server" ConnectionString="<%$ ConnectionStrings:conexion %>" DeleteCommand="DELETE FROM [RegistrosContables] WHERE [id] = @id" InsertCommand="INSERT INTO [RegistrosContables] ([idCuenta], [monto], [tipo]) VALUES (@idCuenta, @monto, @tipo)" SelectCommand="SELECT RegistrosContables.id, RegistrosContables.idCuenta, RegistrosContables.monto, RegistrosContables.tipo, Cuentas.descripcion FROM RegistrosContables INNER JOIN Cuentas ON RegistrosContables.idCuenta = Cuentas.id" UpdateCommand="UPDATE [RegistrosContables] SET [idCuenta] = @idCuenta, [monto] = @monto, [tipo] = @tipo WHERE [id] = @id">
            <DeleteParameters>
                <asp:Parameter Name="id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="idCuenta" Type="Int32" />
                <asp:Parameter Name="monto" Type="Int32" />
                <asp:Parameter Name="tipo" Type="Boolean" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="idCuenta" Type="Int32" />
                <asp:Parameter Name="monto" Type="Int32" />
                <asp:Parameter Name="tipo" Type="Boolean" />
                <asp:Parameter Name="id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceMontoRegistroExistente" runat="server" ConnectionString="<%$ ConnectionStrings:conexion %>" DeleteCommand="DELETE FROM [RegistrosContables] WHERE [id] = @id" InsertCommand="INSERT INTO [RegistrosContables] ([idCuenta], [monto], [tipo]) VALUES (@idCuenta, @monto, @tipo)" SelectCommand="SELECT * FROM [RegistrosContables] WHERE ([id] = @id)" UpdateCommand="UPDATE [RegistrosContables] SET [idCuenta] = @idCuenta, [monto] = @monto, [tipo] = @tipo WHERE [id] = @id">
            <DeleteParameters>
                <asp:Parameter Name="id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="idCuenta" Type="Int32" />
                <asp:Parameter Name="monto" Type="Int32" />
                <asp:Parameter Name="tipo" Type="Boolean" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownListRegistrosExistentes" Name="id" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="idCuenta" Type="Int32" />
                <asp:Parameter Name="monto" Type="Int32" />
                <asp:Parameter Name="tipo" Type="Boolean" />
                <asp:Parameter Name="id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </form>
        </body>
</html>
