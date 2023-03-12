<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowData.aspx.cs" Inherits="UserRegistrationApp.Forms.ShowData" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"/>
    <link href="../Content/bootstrap.cosmo.min.css" rel="stylesheet" />
    <link href="Content/StyleSheet.css" rel="stylesheet" />  

    <style>
        .btnAdd {
            color: White;
            background-color: #3366FF;
            font-weight: bold;
            border: aliceblue;
            width: 140px;
            height: 41px;
            float: right;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="mainContainer" class="container">  
            <div class="shadowBox">  
                <div class="page-container">  
                    <div class="container">  
                        <div class="jumbotron">  
                            <p class="text-danger" style="text-align: center;font-size: xxx-large;font-family: auto;">Registered Users List </p>  
                        </div>  
                        <asp:Button ID="Button1" runat="server" Text="User Register" OnClick="Button1_Click" BackColor="#3366FF" Font-Bold="True" ForeColor="White" cssClass="btnAdd"/>
                        <div class="row">  
                            <div class="col-lg-12 ">  
                                <div class="table-responsive">  
                                    <asp:GridView ID="GridView1" runat="server" Width="100%" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" EmptyDataText="There are no data records to display.">  
                                        <Columns>  
                                            <asp:BoundField DataField="FirstName" HeaderText="First Name" ReadOnly="True" SortExpression="FirstName" HeaderStyle-CssClass="visible-lg visible-md visible-sm" ItemStyle-CssClass="visible-lg visible-md visible-sm" />  
                                            <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" HeaderStyle-CssClass="visible-lg visible-md visible-sm" ItemStyle-CssClass="visible-lg visible-md visible-sm" />  
                                            <asp:BoundField DataField="Email" HeaderText="Email" ReadOnly="True" SortExpression="Email" ItemStyle-CssClass="visible-lg visible-md visible-sm" HeaderStyle-CssClass="visible-lg visible-md visible-sm" />  
                                            <asp:BoundField DataField="PhoneNumber" HeaderText="Phone Number" ReadOnly="True" SortExpression="PhoneNumber" HeaderStyle-CssClass="visible-lg visible-md visible-sm" ItemStyle-CssClass="visible-lg visible-md visible-sm" />  
                                            <asp:BoundField DataField="CreditCardNumber" ReadOnly="True" HeaderText="Credit Card Number" SortExpression="CreditCardNumber" ItemStyle-CssClass="visible-lg visible-md visible-sm" HeaderStyle-CssClass="visible-lg visible-md visible-sm" />  
                                            <asp:BoundField DataField="CCV" ReadOnly="True" HeaderText="CCV" SortExpression="CCV" ItemStyle-CssClass="visible-lg visible-md visible-sm" HeaderStyle-CssClass="visible-lg visible-md visible-sm" />  
                                            <asp:BoundField DataField="ExpireDate" ReadOnly="True" HeaderText="Expire Date" SortExpression="ExpireDate" HeaderStyle-CssClass="visible-lg visible-md visible-sm" ItemStyle-CssClass="visible-lg visible-md visible-sm" />  
                                        </Columns>  
                                    </asp:GridView>  
                                </div>  
                            </div>  
                        </div>  
                    </div>  
                </div>  
            </div>  
        </div>  
    </form>
</body>
</html>
