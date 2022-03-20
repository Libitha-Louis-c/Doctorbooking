<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="drdiagno.aspx.cs" Inherits="Doctorbooking.drdiagno" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .list {
            color: #555;
            font-size: 22px;
            padding: 0 !important;
            width: 100%;
            font-family: courier, monospace;
            border: 1px solid #dedede;
        }

            .list li {
                list-style: none;
                border-bottom: 1px dotted #03a9f4;
                text-indent: 25px;
                height: auto;
                padding: 10px;
                text-transform: capitalize;
            }

                .list li:hover {
                    background-color: #f0f0f0;
                    -webkit-transition: all 0.2s;
                    -moz-transition: all 0.2s;
                    -ms-transition: all 0.2s;
                    -o-transition: all 0.2s;
                }

        .lines {
            border-left: 1px solid #e3240c;
            border-right: 1px solid #e3240c;
            width: 2px;
            float: left;
            height: 97%;
            margin-left: 80px;
        }

        .inputbox {
            color: black;
            border: none;
            font-size: 22px;
            font-family: courier, monospace;
        }
    </style>
    <script lang="javascript" type="text/javascript">
        function CallPrint(strid) {
            var prtContent = document.getElementById(strid);
            document.write(prtContent.innerHTML);
            window.print();
           // window.history.go(-1);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- ======= Doctors Section ======= -->
    <section id="doctors" class="doctors section-bg">
        <div class="container" data-aos="fade-up">

            <div class="section-title">
                <h2>Consultaion</h2>
                <p>Details of disgnaosis , prescriptions and tests.</p>
            </div>

            <div class="row">
                <div class="col-lg-8 col-12 mx-auto">
                    <div class="booking-form">
                        <h2 class="text-center mb-lg-3 mb-2">Case Sheet</h2>
                        <a href="drdiagno.aspx?bk=all" class="btn btn-dark" id="btnall"
                            title="Only today's booking are shown by default. Click this to get all days">show all &#8635</a>
                        Bookings:<asp:DropDownList ID="drpbooking" runat="server" AppendDataBoundItems="true"
                            OnSelectedIndexChanged="drpbooking_SelectedIndexChanged" AutoPostBack="true">
                        </asp:DropDownList>
                        <a href="drdiagno.aspx" class="btn btn-light" id="btntoday"
                            title=" Click here to get today's booking">Today's Bookings &#8635</a>
                        <asp:Label ID="lblerror" ClientIDMode="Static" runat="server" ForeColor="Red"></asp:Label>
                        <%--  <form role="form" action="#booking" method="post">--%>
                        <div class="row">
                            <div class="col-12">
                                <asp:HiddenField ID="hidnbid" ClientIDMode="Static" runat="server" />
                                <asp:HiddenField ID="hidnpid" ClientIDMode="Static" runat="server" />
                            </div>
                        </div>
                        <div class="row" id="prx"  style="min-width: 720px;">
                            <div class="col-12">
                                <div class="lines"></div>
                                <ul class="list">
                                    <li><b>Rx</b> 
                                        <asp:Label ID="lblPresTitle" ClientIDMode="Static" runat="server" Text=""></asp:Label>
                                        <label>Diagnosis / tests/ prescriptions  for Patient:</label>
                        <asp:Label ID="lblpat" CssClass="form-control" ClientIDMode="Static" runat="server" Text=""></asp:Label>
                                    </li>
                                    <li>
                                        <asp:TextBox runat="server" ClientIDMode="Static" type="text" name="name" ID="txtdetails" TextMode="MultiLine" Rows="12" Style="width: 80%; background-color: transparent;" class="inputbox" placeholder="Details" required />
                                        <asp:HiddenField ID="hidntid" Value="" ClientIDMode="Static" runat="server" />
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-8 col-12" style="text-align: right; vertical-align: middle">
                                Test Fee ₹.
                            </div>
                            <div class="col-lg-4 col-12">
                                <asp:TextBox runat="server" TextMode="Number" ClientIDMode="Static" ID="txttestamt" class="form-control" placeholder="Fee ₹. " />
                            </div>
                            <div class="col-lg-8 col-12" style="text-align: right;">
                                Consultation Fee ₹.
                            </div>
                            <div class="col-lg-4 col-12">
                                <asp:TextBox runat="server" TextMode="Number" ClientIDMode="Static" ID="txtamt" class="form-control" placeholder="Fee ₹. " />
                            </div>
                        </div>
                    <div class="row">
                        <div class="col-lg-6 col-12">
                            <asp:Button ID="btnsave" CssClass="btn btn-success" runat="server" Text="Save New" OnClick="btnsave_Click" />
                            <asp:Button ID="btnupdate" CssClass="btn btn-success" runat="server" Text="Update" Visible="false" OnClick="btnsave_Click" />
                            <button onclick="CallPrint('prx')">print</button>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <asp:GridView ID="grddiags" runat="server"
                                CssClass="table table-hover table-responsive" AutoGenerateColumns="False"
                                DataSourceID="SqldsTest" AllowPaging="True" PageSize="2" OnRowDeleting="grddiags_RowDeleting" DataKeyNames="tid" OnSelectedIndexChanged="grddiags_SelectedIndexChanged">
                                <Columns>

                                    <asp:CommandField ShowSelectButton="True" />
                                    <asp:TemplateField HeaderText="Date" SortExpression="date">
                                        <ItemTemplate>
                                            <asp:Label ID="lbldate" runat="server" Text='<%# Eval("date","{0:dd-MM-yyyy}") %>' CssClass="form-control-sm"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Consultation Details" SortExpression="test_details">
                                        <ItemTemplate>
                                            <asp:Label ID="lbldetails" runat="server" Text='<%# Bind("test_details") %>'></asp:Label>
                                            <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("tid") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Fee" SortExpression="test_details">
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("testamt") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete" Text="x"
                                                ForeColor="Red" OnClientClick="return confirm('Going to remove this diagnosis details..Sure?')"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>

                            <asp:LinqDataSource ID="LinqDsDiags" runat="server"
                                ContextTypeName="Doctorbooking.bookingdbEntities1" EntityTypeName=""
                                OrderBy="tid desc" Select="new (tid, test_details, testamt)"
                                TableName="tests" Where="docid == @docid &amp;&amp; pid=@pid">
                                <WhereParameters>
                                    <asp:SessionParameter Name="docid" SessionField="id" Type="Int32" />
                                    <asp:ControlParameter ControlID="hidnpid" Name="pid" PropertyName="Value" />
                                </WhereParameters>

                            </asp:LinqDataSource>
                            <asp:SqlDataSource ID="SqldsTest" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                                SelectCommand="SELECT * FROM [test] WHERE (([docid] = @docid) AND ([pid] = @pid)) ORDER BY [tid] DESC" DeleteCommand="delete from test where tid=@tid">
                                <DeleteParameters>
                                    <asp:ControlParameter ControlID="grddiags" Name="tid" PropertyName="SelectedValue" />
                                </DeleteParameters>
                                <SelectParameters>
                                    <asp:SessionParameter Name="docid" SessionField="id" Type="Int32" />
                                    <asp:ControlParameter ControlID="hidnpid" Name="pid" PropertyName="Value" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>

                        </div>
                    </div>
                    <%-- </form>--%>
                    </div>

                </div>
            </div>
        </div>
    </section>
</asp:Content>
