<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="asp.netcrud.Contact" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link rel="stylesheet" type="text/css" href="style.css" />

</head>
<body style="height: 347px">
    <form id="form1" runat="server">
        <div class="containerMain">

            <div class="box">
                <asp:Panel ID="Panel2" runat="server" CssClass="auto-style1" Height="533px">

                    <div>
                        <asp:HiddenField ID="hfContactID" runat="server" />
                        <table>
                            <tr>
                                <td>
                                    <asp:Label ID="Label1" runat="server" Text="Name"></asp:Label>
                                </td>
                                <td colspan="2">
                                    <asp:TextBox ID="txtname" runat="server" Width="175px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label2" runat="server" Text="Surname"></asp:Label>
                                </td>
                                <td colspan="2">
                                    <asp:TextBox ID="txtsurname" runat="server" Width="175px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label3" runat="server" Text="Address"></asp:Label>
                                </td>
                                <td colspan="2">
                                    <asp:TextBox ID="txtaddress" runat="server" TextMode="MultiLine"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Button ID="btnsave" runat="server" Text="Save" OnClick="btnsave_Click" />
                                    <asp:Button ID="btndelete" runat="server" Text="Delete" OnClick="btndelete_Click1" />
                                    <asp:Button ID="btnclear" runat="server" Text="Clear" OnClick="btnclear_Click" />
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Label ID="lblSuccessMessage" runat="server" Text="" ForeColor="lightgreen"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Label ID="lblErrorMessage" runat="server" Text="" ForeColor="Red"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td colspan="3">
                                    <asp:GridView ID="gvContact" runat="server" AutoGenerateColumns="False" Width="430px" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" GridLines="Horizontal">
                                        <Columns>
                                            <asp:BoundField DataField="Name" HeaderText="Name" />
                                            <asp:BoundField DataField="Surname" HeaderText="Surname" />
                                            <asp:BoundField DataField="Address" HeaderText="Address" />
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkView" runat="server" CommandArgument='<%# Eval("ContactID") %>' OnClick="lnView_OnClick">View</asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <FooterStyle BackColor="White" ForeColor="#333333" />
                                        <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                                        <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
                                        <RowStyle BackColor="White" ForeColor="#333333" />
                                        <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                                        <SortedAscendingCellStyle BackColor="#F7F7F7" />
                                        <SortedAscendingHeaderStyle BackColor="#487575" />
                                        <SortedDescendingCellStyle BackColor="#E5E5E5" />
                                        <SortedDescendingHeaderStyle BackColor="#275353" />
                                    </asp:GridView>
                                </td>
                            </tr>


                        </table>
                    </div>

                    <asp:Panel ID="Panel1" runat="server" Height="95px" Width="446px">
                        <asp:DropDownList runat="server" ID="dropdownNames" DataTextField="name" DataValueField="ContactID" OnSelectedIndexChanged="dropdownNames_SelectedIndexChanged" AutoPostBack="True" />
                        <br />
                        <asp:Label ID="lblSelectedName0" runat="server" Text="Selected Value Here"></asp:Label><br />
                        <asp:Label ID="lblSelectedName1" runat="server" Text="Selected Index Here"></asp:Label><br />
                        <asp:Label ID="lblSelectedName2" runat="server" Text="Selected Item Here"></asp:Label><br />
                    </asp:Panel>
                </asp:Panel>
            </div>


            <%--Bellow box is webcam related--%>

            <div class="box">
                <asp:Panel ID="Panel3" runat="server" CssClass="auto-style1" Height="533px">
                    <div class="webCamContainer">
                        <div class="w3-row">
                            <div class="w3-col-m8">
                                <div id="mywebcam"></div>
                                <p>
                                    <button onclick="captureImage()" class="w3-button w3-blue">Capture Image</button>
                                </p>
                            </div>
                            <div class="w3-col-m4">
                                <div id="results">Your captured image here</div>
                            </div>
                        </div>
                    </div>

                    <script src="webcam.min.js"></script>
                    <script src="webcam.js"></script>
                    <script>
                        Webcam.set({
                            width: 300,
                            height: 200,
                            image_format: 'jpeg',
                            jpeg_quality: 90
                        })
                        Webcam.attach('mywebcam')

                        function captureImage() {
                            Webcam.snap(function (data_uri) {
                                document.getElementById('results').innerHTML = "<h2>Here is your image:</h2><image width='300' height='200' src='" + data_uri + "'>";

                            })
                        }

                    </script>
                </asp:Panel>
            </div>
        </div>
    </form>
</body>
</html>
