<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="patprofile.aspx.cs" Inherits="Doctorbooking.patprofile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="js/jquery.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="section-padding" id="booking">
        <div class="pwd" style="float: right">
            <a href="javascript:void(0);" id="cpwd" onclick="$('#pwddiv').slideToggle();">Change Password</a>
            <div id="pwddiv" style="display:none;">
                <div>
                    <asp:TextBox ID="opwd" placeholder="Current Password" runat="server" TextMode="Password" ValidationGroup="pwd"></asp:TextBox>
                </div>
                <div>
                    <asp:TextBox placeholder="New Password" ID="txtnew" runat="server" TextMode="Password" ValidationGroup="pwd"></asp:TextBox>
                </div>
                <div>
                   <asp:TextBox placeholder="Retype Password" ID="txtre" runat="server" TextMode="Password" ValidationGroup="pwd"></asp:TextBox>
                </div>
                <div>
                    <asp:Button ID="btnpwd" CssClass="btn btn-success" runat="server" Text="Change" OnClick="btnpwd_Click" CausesValidation="false" ValidationGroup="pwd" />
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row">

                <div class="col-lg-8 col-12 mx-auto">
                    <div class="booking-form">

                        <h2 class="text-center mb-lg-3 mb-2">Patient Profile</h2>
                        <asp:Label ID="lblerror" runat="server" Text="" ForeColor="Red"></asp:Label>
                        <div class="row">
                            <div class="col-lg-6 col-12">
                                <input type="text" runat="server" name="name" id="name" class="form-control" placeholder="Full name" required />
                                <asp:HiddenField ID="hidnid" runat="server" />
                            </div>

                            <div class="col-lg-6 col-12">
                                <input type="email" runat="server" name="email" id="email" title="email" pattern="[^ @]*@[^ @]*" class="form-control" placeholder="Email address" readonly />
                            </div>

                            <div class="col-lg-6 col-12">
                                <input type="tel" runat="server" name="phone" id="phone" title="phone" pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}" class="form-control" placeholder="Phone: 123-456-7890" />
                            </div>


                            <div class="col-12">
                                <%--         <input type="text" runat="server" name="gender" id="gender" class="form-control" placeholder="Gender" />--%>
                                <select id="gender" runat="server" class="form-select">
                                    <option>Female</option>
                                    <option>Male</option>
                                    <option>Trans</option>
                                </select>
                            </div>

                            <div class="col-12">
                                <textarea class="form-control" runat="server" rows="3" id="address" name="address" placeholder="Address"></textarea>

                            </div>
                            <div class="col-12">
                                <input type="text" runat="server" name="pincode" id="pincode" class="form-control" placeholder="pincode" maxlength="10" />
                            </div>

                            <div class="col-12">
                                <label runat="server" id="lblmsg" name="lblmsg" style="color: green;"></label>
                            </div>

                            <div class="col-lg-3 col-md-4 col-6 mx-auto">
                                <asp:Button type="submit" ID="PatientRegButton" runat="server" class="btn btn-success1" Text="Update Profile" OnClick="PatientRegButton_Click" />
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
