<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Doctorbooking.login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="js/jquery.min.js"></script>
    <script>
        $(document).ready(function () {

            $('input:checkbox').on('click', function () {
                $('#chkpat').prop('checked', false);
                $('#chkdr,#chkadn').prop('checked', false);
                $(this).prop('checked', true);
            });

        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="section-padding" id="booking">
        <div class="container">
            <div class="row">

                <div class="col-lg-8 col-12 mx-auto">
                    <div class="booking-form">

                        <h2 class="text-center mb-lg-3 mb-2">Login to access Doctor-in</h2>
                        Iam
                        <asp:CheckBox ID="chkpat" runat="server" Text="Patient" ClientIDMode="Static" />
                        <asp:CheckBox ID="chkdr" runat="server" Text="Doctor" ClientIDMode="Static" />
                        <asp:CheckBox ID="chkadn" runat="server" Text="Admin" ClientIDMode="Static" />
                        <div class="row">

                            <div class="col-lg-6 col-12">
                                <%--<input type="email" name="email" id="email" pattern="[^ @]*@[^ @]*" class="form-control" placeholder="Email address" runat="server"  required>--%>
                                <asp:TextBox ID="txtusr" runat="server" class="form-control" placeholder="Email address"></asp:TextBox>
                            </div>

                            <div class="col-lg-6 col-12">
                                <%-- <input type="password" name="name" id="pwd" class="form-control" placeholder="password" runat="server" required>--%>
                                <asp:TextBox ID="txtpwd" runat="server" class="form-control" placeholder="password"></asp:TextBox>

                            </div>

                            <div class="col-12">
                                <label runat="server" class="form-control" rows="5" id="message" name="message" placeholder="Additional Message"></label>
                            </div>

                            <div class="col-12">
                                <label runat="server" id="lblmsg" name="lblmsg"></label>
                            </div>

                            <div class="col-lg-6 col-md-12 col-6 mx-auto">
                                <div>

                                    <%--<button   class="form-control" id="submit-button" text="login">login</button>--%>

                                    <asp:Button ID="loginButton" runat="server" class="form-control" Text="Login" OnClick="loginButton_Click" />

                                    New to Doctor-in?
                                </div>
                                <%-- <div>
                                            <asp:Button class="form-control btn-info "  ID="btnreg" runat="server" Text="Register" OnClick="btnreg_Click" Height="136px" />
                                        </div>--%>
                            </div>

                        </div>
                    </div>

                </div>
            </div>
        </div>
    </section>
</asp:Content>
