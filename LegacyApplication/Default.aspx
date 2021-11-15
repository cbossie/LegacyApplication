<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="LegacyApplication._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        On this page we will deal with some session data.
    </h2>

    <div class="row">
        <div class="col-md-10">
            <p>
                The server you are on is <strong><%= Environment.MachineName %></strong>.
            </p>
            <p>
                The Session State mode we are using is <strong><asp:Label onload="lblSessionState_Load" runat="server" id="lblSessionState"></asp:Label></strong>.
            </p>
            <p>
                The Session ID you are using is <strong><asp:Label runat="server" ID="lblId" OnLoad="lblId_Load"></asp:Label>.</strong>
            </p>
            <p>
                <asp:Label runat="server" id="lblSessionValue" OnPreRender="lblSessionValue_PreRender"  ></asp:Label>
            </p>

        </div>
    </div>
    <hr />
    <div class="form-group">
        <label for="txtSessionItem">Enter a value for the session</label>
        <asp:TextBox
            runat="server"
            CssClass="form-control"
            ID="txtSessionItem"
            ClientIDMode="Static"
            >

        </asp:TextBox>
    </div>
    <asp:Button runat="server" ID="btnSave" CssClass="btn btn-primary" Text="Save to Session" OnClick="btnSave_Click" />

    <div class="row col-md-12">

        <asp:Panel runat="server" CssClass="alert alert-alert-success"
            id="pnlAlert">
            Saved value to session!
        </asp:Panel>
    </div>

</asp:Content>
