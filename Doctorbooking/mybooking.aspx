<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="mybooking.aspx.cs" Inherits="Doctorbooking.mybooking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="section-padding" id="booking">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-12 mx-auto">
                    <div class="booking-form">
                        <h2 class="text-center mb-lg-3 mb-2">My Bookings</h2>
                        <asp:Label ID="lblerror"  runat="server" Text="" ForeColor="Red"></asp:Label>
                        <div class="row">
                            <div class="col-12">
                                <asp:GridView ID="grddiags" runat="server"
                                    CssClass="table table-hover table-responsive" AutoGenerateColumns="False"
                                    DataSourceID="SqldsTest" AllowPaging="True" PageSize="2"  DataKeyNames="apid" OnSelectedIndexChanged="grddiags_SelectedIndexChanged" >
                                    <Columns>
                                        <asp:CommandField ShowSelectButton="True"  SelectText="Feedback"  />
                                        <asp:TemplateField HeaderText="Date" SortExpression="date">
                                            <ItemTemplate>
                                                <asp:Label ID="lbldate" runat="server" Text='<%# Eval("date","{0:dd-MM-yyyy}") %>' CssClass="form-control-sm"></asp:Label>
                                                <asp:HiddenField ID="HiddenID" runat="server" Value='<%# Bind("apid") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Booking Details" SortExpression="apid">
                                            <ItemTemplate>
                                                <asp:Label ID="lblbdate" runat="server" Text='<%# Eval("bookingdate","{0:dd-MM-yyyy}") %>' CssClass="form-control-sm"></asp:Label>
                                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("time") %>' CssClass="form-control-sm"></asp:Label>
                                           <%--     <asp:Label ID="lblstatus" runat="server" Text='<%# ((bool) Eval("Cancelled"))==true?"Cancelled":((bool) Eval("Consulted"))==true?"Visited":"Pending"%>'></asp:Label>--%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Doctor" SortExpression="docname">
                                            <ItemTemplate>
                                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("docname") %>'></asp:Label>
                                           <div>  <asp:TextBox ID="txtfeedback" ClientIDMode="Static" runat="server" Visible="false" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                                <asp:Button ID="btnfback" ClientIDMode="Static" runat="server" Text="Save" Visible="false" OnClick="btnfback_Click" />
                                           </div>
                                               </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ShowHeader="False">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete" Text="x" 
                                                Visible='<%# string.IsNullOrEmpty(Eval("Cancelled").ToString()+Eval("Consulted").ToString())  %>'
                                                    ForeColor="Red" OnClientClick="return confirm('Going to Cancel this Booking..Sure?')"></asp:LinkButton>
                                                <asp:Label ID="Label3" runat="server" Text="Cancelled" ForeColor="Red" Visible='<%# !string.IsNullOrEmpty(Eval("Cancelled").ToString()) %>'></asp:Label>
                                               <asp:Label ID="Label4" runat="server" Text="Visited" ForeColor="Green" Visible='<%# !string.IsNullOrEmpty(Eval("Consulted").ToString())  %>'></asp:Label>
                                               
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="SqldsTest" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                                    SelectCommand="SELECT appointment.apid, appointment.drloc, appointment.drcid, 
                                    appointment.patid, appointment.pname, appointment.time, appointment.bookingdate,
                                    appointment.ailments, appointment.Cancelled, appointment.Consulted, 
                                    appointment.Feepaid, appointment.Date, doctor.docname, doctor.mob, doctor.email,
                                    doctor.fee FROM appointment INNER JOIN doctor ON appointment.drcid = doctor.docId 
                                    WHERE (patid = @pid) ORDER BY appointment.apid DESC" 
                                    DeleteCommand="Update appointment set cancelled=true where apid=@apid">
                                    <DeleteParameters>
                                        <asp:ControlParameter ControlID="grddiags" Name="apid" PropertyName="SelectedValue" />
                                    </DeleteParameters>
                                    <SelectParameters>
                                        <asp:SessionParameter Name="pid" SessionField="id" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </section>
</asp:Content>
