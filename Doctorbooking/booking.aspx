<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="booking.aspx.cs" Inherits="Doctorbooking.booking" EnableEventValidation="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .drimg{
            height:216px;
            width:216px;
        }
    </style>
     <script>
        function selectdr(id, name) {
            $('#lbldr').text(name+' '+$('#spln'+id.toString()).html()).change();
            $('#hidndr').val(id).change();
            $('#lbldr').focus(true);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- ======= Doctors Section ======= -->
    <section id="doctors" class="doctors section-bg">
      <div class="container" data-aos="fade-up">

        <div class="section-title">
          <h2>Doctors</h2>
          <p>Magnam dolores commodi suscipit. Necessitatibus eius consequatur ex aliquid fuga eum quidem. Sit sint consectetur velit. Quisquam quos quisquam cupiditate. Et nemo qui impedit suscipit alias ea. Quia fugiat sit in iste officiis commodi quidem hic quas.</p>
        </div>

        <div class="row">
            <%foreach (Doctorbooking.doctor d in db.doctors)
                {
                    %>

          <div class="col-lg-3 col-md-6 d-flex align-items-stretch">
            <div class="member" data-aos="fade-up" data-aos-delay="100" style="cursor:help;" onclick="selectdr('<%=d.docId%>','<%=d.docname %>')">
              <div class="member-img">
                <img src="images/drimage/<%=d.docId%>.png" class="img-fluid drimg" alt="" />
                <%--<div class="social">
                  <a href=""><i class="bi bi-twitter"></i></a>
                  <a href=""><i class="bi bi-facebook"></i></a>
                  <a href=""><i class="bi bi-instagram"></i></a>
                  <a href=""><i class="bi bi-linkedin"></i></a>
                </div>--%>
              </div>
              <div class="member-info">
                <h4><%=d.docname %></h4>
                <span id="spln<%=d.docId.ToString() %>"><%if (d.drspecialisations != null)
                          { %><% =string.Join(",", d.drspecialisations.Select(s => s.spectab.specname)) %><%} %></span>
              </div>
            </div>
          </div>
<%} %>
         
        </div>

      </div>
    </section><!-- End Doctors Section -->
    <section class="section-padding" id="booking">
                <div class="container">
                    <div class="row">
                    
                        <div class="col-lg-8 col-12 mx-auto">
                            <div class="booking-form">
                                
                                <h2 class="text-center mb-lg-3 mb-2">Book an appointment</h2>
                                <asp:Label ID="lblerror" ClientIDMode="Static" runat="server" ForeColor="Red"></asp:Label>
                                <form role="form" action="#booking" method="post">
                                    <div class="row">
                                         <div class="col-12">
                                    Selected Doctor:<label id="lbldr" style="font-weight:bold;"></label>
                                    <asp:HiddenField ID="hidndr" ClientIDMode="Static" runat="server" />
                                    
                                </div>
                                       <div class="col-lg-6 col-12">
                                    <asp:TextBox runat="server" ClientIDMode="Static" type="text" name="name" id="txtname" class="form-control" placeholder="Full name" required/>
                                </div>

                                <div class="col-lg-6 col-12">
                                     <asp:TextBox runat="server" ClientIDMode="Static" type="email" name="email" id="txtemail" pattern="[^ @]*@[^ @]*" class="form-control" placeholder="Email address" required/>
                                </div>

                                <div class="col-lg-6 col-12">
                                    <asp:TextBox runat="server" ClientIDMode="Static" type="telephone" name="phone" id="phone" pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}" class="form-control" placeholder="Phone: 123-456-7890"/>
                                </div>

                                <div class="col-lg-3 col-12">
                                     <asp:TextBox runat="server" ClientIDMode="Static" type="date" name="date" id="txtdate" value="" class="form-control"/>
                                </div>
                                 <div class="col-lg-3 col-12">
                                     <asp:TextBox runat="server" ClientIDMode="Static" type="text" name="time" id="txttime" value="" class="form-control"/>
                                </div>
                                <div class="col-12">
                                     <asp:TextBox runat="server" ClientIDMode="Static" class="form-control" rows="5" id="txtmessage" name="message" placeholder="Ailments,Symptoms any" />
                                </div>

                                <div class="col-lg-3 col-md-4 col-6 mx-auto">
                                    <asp:Button runat="server" type="submit" class="form-control" id="btnbook" Text="Book Now" OnClick="btnbook_Click" />
                                </div>
                                    </div>
                                </form>

                            </div>
                        </div>

                    </div>
                </div>
            </section>
</asp:Content>
