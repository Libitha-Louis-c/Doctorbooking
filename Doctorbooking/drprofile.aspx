<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="drprofile.aspx.cs" Inherits="Doctorbooking.drprofile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="js/jquery.min.js"></script>
      <script>
        function selectedVal(list) {
            var listLength = list.options.length;
            var k = '';
            for (var i = 0; i < listLength; i++) {
                if (list.options[i].selected)
                    k += list.options[i].text + ",";
            }
            $('#spec').val(k).change();
        }
        //Image Upload Preview  
        function ShowImagePreview(input) {  
            if (input.files && input.files[0]) {  
                var reader = new FileReader();  
                reader.onload = function (e) {  
                    $('#drimage').prop('src', e.target.result);  
                };  
                reader.readAsDataURL(input.files[0]);  
            }  
        }  
    </script>
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

                        <h2 class="text-center mb-lg-3 mb-2">Doctor's Profile</h2>
                        <asp:Label ID="lblerror" runat="server" Text="" ForeColor="Red"></asp:Label>
                        <div class="row">
                            <div class="col-lg-6 col-12">
                                <input type="text" runat="server" name="name" id="name" class="form-control" placeholder="Full name" required />
                         <asp:HiddenField ID="hidnid" runat="server" />
                                </div>

                            <div class="col-lg-6 col-12">
                                <input type="email" runat="server" name="email" id="email" pattern="[^ @]*@[^ @]*" class="form-control" placeholder="Email address" readonly />
                            </div>

                            <div class="col-lg-6 col-12">
                                <input type="tel" runat="server" name="phone" id="phone"  pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}" class="form-control" placeholder="Phone: 123-456-7890" />
                            </div>

                            <div class="col-lg-6 col-12">
                                <div class="input-group">
                                    <input type="text" runat="server" name="spec" id="spec" clientidmode="Static" readonly class="form-control" placeholder="Specialization" />
                                    <asp:ListBox ID="drpspec1" ClientIDMode="Static" class="form-control" runat="server"
                                        SelectionMode="Multiple" Style="display: none;" onclick="javascript:selectedVal(this);"></asp:ListBox>

                                    <div class="input-group-append">
                                        <button type="button" class="btn btn-outline-secondary form-control" onclick="$('#drpspec1,#spec').slideToggle();">...</button>
                                    </div>

                                </div>
                            </div>

                            <div class="col-12">
                                <input type="text" runat="server" name="hosp" id="hosp" class="form-control" placeholder="Hospital/Clinic/Location" />
                            </div>
                            <div class="col-lg-6 col-12">
                                <textarea class="form-control" runat="server" rows="3" id="address" name="address" placeholder="Address"></textarea>

                            </div>
                            <div class="col-lg-6 col-12">
                                <asp:Image ID="drimage" ClientIDMode="Static" runat="server" Height="81px"  Width="97px" />
                                <asp:FileUpload ID="FileUpload1" runat="server" onchange="ShowImagePreview(this)"/>
                               <%-- <asp:Button ID="Button1" runat="server" Text="upload image" />--%>
                            </div>

                            <div class="col-12">
                                <label runat="server" id="lblmsg" name="lblmsg"></label>
                            </div>

                            <div class="col-lg-3 col-md-4 col-6 mx-auto">
                                <asp:Button type="submit" runat="server" class="btn btn-success" ID="drRegButton" Text="Register" OnClick="drRegButton_Click" />
                            </div>
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </section>
</asp:Content>
