<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="patientdetail.aspx.cs" Inherits="Doctorbooking.patientdetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        $(document).ready(function () {
            $('#usertab').DataTable({
                responsive: true,
                autofill: false,
                "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]] //show entries per page
            });
         
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <section class="section-padding" id="patient">
     <div class="container">
<table class="table table-hover table-responsive" id ="usertab">
    <thead>
        <th>Name</th>
        <th>Gender</th>
        <th>Address</th>
        <th>Place</th>
    </thead>
        <tbody>
             <% foreach (Doctorbooking .patientreg p in db.patientregs)
                 {
                     %>
            <tr>
                <td><%=p.name%></td>
                <td>m</td>
                <td>xyz</td>
                <td>thr</td>
            </tr>
             <tr>
                <td>John</td>
                <td>m</td>
                <td>xyz</td>
                <td>thr</td>
            </tr>
           <%}%>
        </tbody>

</table>
         </div>
</section>
</asp:Content>
