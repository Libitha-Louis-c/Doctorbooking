﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Doctorbooking
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class bookingdbEntities1 : DbContext
    {
        public bookingdbEntities1()
            : base("name=bookingdbEntities1")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<appointment> appointments { get; set; }
        public virtual DbSet<payment> payments { get; set; }
        public virtual DbSet<spectab> spectabs { get; set; }
        public virtual DbSet<usertab> usertabs { get; set; }
        public virtual DbSet<doctor> doctors { get; set; }
        public virtual DbSet<test> tests { get; set; }
        public virtual DbSet<drspecialisation> drspecialisations { get; set; }
        public virtual DbSet<patientreg> patientregs { get; set; }
    }
}