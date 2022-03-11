<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="patprofile.aspx.cs" Inherits="Doctorbooking.patprofile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="section-padding" id="patient">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-4 col-6 mx-auto">

                    <asp:Button ID="Button1" runat="server" Text="View Booking" OnClick="Button1_Click" />
                </div>
            </div>
        </div>
    </section>
</asp:Content>
