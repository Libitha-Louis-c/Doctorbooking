<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="drreg.aspx.cs" Inherits="Doctorbooking.drreg" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script>
        function selectedVal(list) {
            //var s = $('#spec').val();
            //var sel1 = list.options[list.selectedIndex].text;
           // var ary = s.split(',');
            var listLength = list.options.length;
            var k = '';
            for (var i = 0; i < listLength; i++) {
                if (list.options[i].selected)
                    //document.getElementById("list2").add(new Option(list.options[i].value));
                    // k += list.options[i].value;
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
        <div class="container">
            <div class="row">

                <div class="col-lg-8 col-12 mx-auto">
                    <div class="booking-form">

                        <h2 class="text-center mb-lg-3 mb-2">Doctor Registration</h2>

                        <div class="row">
                            <div class="col-lg-6 col-12">
                                <input type="text" runat="server" name="name" id="name" class="form-control" placeholder="Full name" required />
                            </div>

                            <div class="col-lg-6 col-12">
                                <input type="email" runat="server" name="email" id="email" pattern="[^ @]*@[^ @]*" class="form-control" placeholder="Email address" required />
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
