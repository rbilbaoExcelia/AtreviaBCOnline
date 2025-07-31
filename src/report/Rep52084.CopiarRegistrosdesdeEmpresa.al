report 52084 "Copiar Registros desde Empresa"
{
    Caption = 'Copiar Registros desde Empresa';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Permissions = tabledata "Job"=rimd,
        tabledata "Job Task"=rimd,
        tabledata "Job Ledger Entry"=rimd,
        tabledata "Job Planning Line"=rimd,
        tabledata "Job Posting Group"=rimd,
        tabledata "Job Register"=rimd,
        tabledata "Jobs Setup"=rimd,
        tabledata "Customer"=rimd,
        tabledata "Customer Posting Group"=rimd,
        tabledata "Bank Account Posting Group"=rimd,
        tabledata "Vendor"=rimd,
        tabledata "Vendor Posting Group"=rimd,
        tabledata "G/L Account"=rimd,
        tabledata "Dimension Value"=rimd,
        tabledata "Currency Exchange Rate"=rimd,
        tabledata "Vendor Bank Account"=rimd,
        tabledata "Customer Bank Account"=rimd,
        tabledata "Default Dimension"=rimd,
        tabledata "Sales Invoice Header"=rimd,
        tabledata "Sales Cr.Memo Header"=rimd;

    dataset
    {
        dataitem("Job"; "Job")
        {
            trigger OnPreDataItem()
            begin
                if not "GBoolJob" then CurrReport.Break();
                ChangeCompany(FromCompany);
            end;
            trigger OnAfterGetRecord()
            begin
                CurentRecord+=1;
                ProgressWindow.Update(1, CurentRecord);
                Clear(RecJob);
                if RecJob.Get(Job."No.")then begin
                    RecJob.TransferFields(Job, false); //EX-RBF 220223
                    RecJob.Modify(false);
                end
                else
                begin
                    RecJob.Copy(Job);
                    RecJob.Insert(false);
                end;
            end;
        }
        dataitem("Job Task"; "Job Task")
        {
            trigger OnPreDataItem()
            begin
                if not "GBoolJob Task" then CurrReport.Break();
                ChangeCompany(FromCompany);
            end;
            trigger OnAfterGetRecord()
            begin
                CurentRecord+=1;
                ProgressWindow.Update(1, CurentRecord);
                Clear("RecJob Task");
                if "RecJob Task".Get("Job Task"."Job No.", "Job Task"."Job Task No.")then begin
                    "RecJob Task".TransferFields("Job Task", false); //EX-RBF 220223
                    "RecJob Task".Modify(false);
                end
                else
                begin
                    "RecJob Task".Copy("Job Task");
                    "RecJob Task".Insert(false);
                end;
            end;
        }
        dataitem("Job Ledger Entry"; "Job Ledger Entry")
        {
            trigger OnPreDataItem()
            begin
                if not "GBoolJob Ledger Entry" then CurrReport.Break();
                ChangeCompany(FromCompany);
            end;
            trigger OnAfterGetRecord()
            begin
                CurentRecord+=1;
                ProgressWindow.Update(1, CurentRecord);
                Clear("RecJob Ledger Entry");
                if "RecJob Ledger Entry".Get("Job Ledger Entry"."Entry No.")then begin
                    "RecJob Ledger Entry".TransferFields("Job Ledger Entry", false); //EX-RBF 220223
                    "RecJob Ledger Entry".Modify(false);
                end
                else
                begin
                    "RecJob Ledger Entry".Copy("Job Ledger Entry");
                    "RecJob Ledger Entry".Insert(false);
                end;
            end;
        }
        dataitem("Job Planning Line"; "Job Planning Line")
        {
            trigger OnPreDataItem()
            begin
                if not "GBoolJob Planning Line" then CurrReport.Break();
                ChangeCompany(FromCompany);
            end;
            trigger OnAfterGetRecord()
            begin
                CurentRecord+=1;
                ProgressWindow.Update(1, CurentRecord);
                Clear("RecJob Planning Line");
                if "RecJob Planning Line".Get("Job Planning Line"."Job No.", "Job Planning Line"."Job Task No.", "Job Planning Line"."Line No.")then begin
                    "RecJob Planning Line".TransferFields("Job Planning Line", false); //EX-RBF 220223
                    "RecJob Planning Line".Modify(false);
                end
                else
                begin
                    "RecJob Planning Line".Copy("Job Planning Line");
                    "RecJob Planning Line".Insert(false);
                end;
            end;
        }
        dataitem("Job Posting Group"; "Job Posting Group")
        {
            trigger OnPreDataItem()
            begin
                if not "GBoolJob Posting Group" then CurrReport.Break();
                ChangeCompany(FromCompany);
            end;
            trigger OnAfterGetRecord()
            begin
                CurentRecord+=1;
                ProgressWindow.Update(1, CurentRecord);
                Clear("RecJob Posting Group");
                if "RecJob Posting Group".Get("Job Posting Group"."Code")then begin
                    "RecJob Posting Group".TransferFields("Job Posting Group", false); //EX-RBF 220223
                    "RecJob Posting Group".Modify(false);
                end
                else
                begin
                    "RecJob Posting Group".Copy("Job Posting Group");
                    "RecJob Posting Group".Insert(false);
                end;
            end;
        }
        dataitem("Job Register"; "Job Register")
        {
            trigger OnPreDataItem()
            begin
                if not "GBoolJob Register" then CurrReport.Break();
                ChangeCompany(FromCompany);
            end;
            trigger OnAfterGetRecord()
            begin
                CurentRecord+=1;
                ProgressWindow.Update(1, CurentRecord);
                Clear("RecJob Register");
                if "RecJob Register".Get("Job Register"."No.")then begin
                    "RecJob Register".TransferFields("Job Register", false); //EX-RBF 220223
                    "RecJob Register".Modify(false);
                end
                else
                begin
                    "RecJob Register".Copy("Job Register");
                    "RecJob Register".Insert(false);
                end;
            end;
        }
        dataitem("Jobs Setup"; "Jobs Setup")
        {
            trigger OnPreDataItem()
            begin
                if not "GBoolJobs Setup" then CurrReport.Break();
                ChangeCompany(FromCompany);
            end;
            trigger OnAfterGetRecord()
            begin
                // ProgressWindow.Close();
                // ProgressWindow.Update(1, CurentRecord);
                Clear("RecJobs Setup");
                if "RecJobs Setup".Get("Jobs Setup"."Primary Key")then begin
                    // "RecJobs Setup".TransferFields("Jobs Setup");
                    // "RecJobs Setup"."Primary Key" := "Jobs Setup"."Primary Key";
                    "RecJobs Setup"."Job Nos.":="Jobs Setup"."Job Nos.";
                    "RecJobs Setup"."Apply Usage Link by Default":="Jobs Setup"."Apply Usage Link by Default";
                    "RecJobs Setup"."Default WIP Method":="Jobs Setup"."Default WIP Method";
                    "RecJobs Setup"."Default Job Posting Group":="Jobs Setup"."Default Job Posting Group";
                    "RecJobs Setup"."Default WIP Posting Method":="Jobs Setup"."Default WIP Posting Method";
                    "RecJobs Setup"."Allow Sched/Contract Lines Def":="Jobs Setup"."Allow Sched/Contract Lines Def";
                    "RecJobs Setup"."Document No. Is Job No.":="Jobs Setup"."Document No. Is Job No.";
                    "RecJobs Setup"."Logo Position on Documents":="Jobs Setup"."Logo Position on Documents";
                    "RecJobs Setup"."Job WIP Nos.":="Jobs Setup"."Job WIP Nos.";
                    "RecJobs Setup"."Automatic Update Job Item Cost":="Jobs Setup"."Automatic Update Job Item Cost";
                    "RecJobs Setup"."Price List Nos.":="Jobs Setup"."Price List Nos.";
                    "RecJobs Setup"."Default Sales Price List Code":="Jobs Setup"."Default Sales Price List Code";
                    "RecJobs Setup"."Default Purch Price List Code":="Jobs Setup"."Default Purch Price List Code";
                    "RecJobs Setup"."Expenses Series No. AT":="Jobs Setup"."Expenses Series No. AT";
                    "RecJobs Setup"."Expenses Source Code AT":="Jobs Setup"."Expenses Source Code AT";
                    "RecJobs Setup"."Increase by Expenses AT":="Jobs Setup"."Increase by Expenses AT";
                    "RecJobs Setup"."SQL User AT":="Jobs Setup"."SQL User AT";
                    "RecJobs Setup"."SQL Password AT":="Jobs Setup"."SQL Password AT";
                    "RecJobs Setup"."SQL IP AT":="Jobs Setup"."SQL IP AT";
                    "RecJobs Setup"."SQL Database AT":="Jobs Setup"."SQL Database AT";
                    "RecJobs Setup"."Gen. Prod. Posting Group AT":="Jobs Setup"."Gen. Prod. Posting Group AT";
                    "RecJobs Setup"."Job Posting Group AT":="Jobs Setup"."Job Posting Group AT";
                    "RecJobs Setup"."Unit of Measure AT":="Jobs Setup"."Unit of Measure AT";
                    "RecJobs Setup"."Word Path AT":="Jobs Setup"."Word Path AT";
                    "RecJobs Setup"."CPI % AT":="Jobs Setup"."CPI % AT";
                    "RecJobs Setup"."CPI Text AT":="Jobs Setup"."CPI Text AT";
                    "RecJobs Setup"."Sector Text 1 AT":="Jobs Setup"."Sector Text 1 AT";
                    "RecJobs Setup"."Sector Text 2 AT":="Jobs Setup"."Sector Text 2 AT";
                    "RecJobs Setup"."Sector Text 3 AT":="Jobs Setup"."Sector Text 3 AT";
                    "RecJobs Setup"."G/L Accounts Rep. Filter AT":="Jobs Setup"."G/L Accounts Rep. Filter AT";
                    "RecJobs Setup"."G/L Acct. Dept. Rep. Filter AT":="Jobs Setup"."G/L Acct. Dept. Rep. Filter AT";
                    "RecJobs Setup"."Generic Task Identation AT":="Jobs Setup"."Generic Task Identation AT";
                    "RecJobs Setup"."Customer Billing Acct. No. AT":="Jobs Setup"."Customer Billing Acct. No. AT";
                    "RecJobs Setup"."Accounts Services AT":="Jobs Setup"."Accounts Services AT";
                    "RecJobs Setup"."Management Accounts AT":="Jobs Setup"."Management Accounts AT";
                    "RecJobs Setup"."Refillable Accounts AT":="Jobs Setup"."Refillable Accounts AT";
                    if "RecJobs Setup".Modify(false)then CurentRecord+=1;
                end
                else
                begin
                    "RecJobs Setup".Copy("Jobs Setup");
                    if "RecJobs Setup".Insert(false)then CurentRecord+=1;
                end;
                ProgressWindow.Update(1, CurentRecord);
            end;
        }
        dataitem("Customer"; "Customer")
        {
            trigger OnPreDataItem()
            begin
                if not "GBoolCustomer" then CurrReport.Break();
                ChangeCompany(FromCompany);
            end;
            trigger OnAfterGetRecord()
            begin
                CurentRecord+=1;
                ProgressWindow.Update(1, CurentRecord);
                Clear("RecCustomer");
                if "RecCustomer".Get("Customer"."No.")then begin
                    "RecCustomer".TransferFields("Customer", false); //EX-RBF 220223
                    "RecCustomer".Modify(false);
                end
                else
                begin
                    "RecCustomer".Copy("Customer");
                    "RecCustomer".Insert(false);
                end;
            end;
        }
        dataitem("Customer Posting Group"; "Customer Posting Group")
        {
            trigger OnPreDataItem()
            begin
                if not "GBoolCustomer Posting Group" then CurrReport.Break();
                ChangeCompany(FromCompany);
            end;
            trigger OnAfterGetRecord()
            begin
                CurentRecord+=1;
                ProgressWindow.Update(1, CurentRecord);
                Clear("RecCustomer Posting Group");
                if "RecCustomer Posting Group".Get("Customer Posting Group"."Code")then begin
                    "RecCustomer Posting Group".TransferFields("Customer Posting Group", false); //EX-RBF 220223
                    "RecCustomer Posting Group".Modify(false);
                end
                else
                begin
                    "RecCustomer Posting Group".Copy("Customer Posting Group");
                    "RecCustomer Posting Group".Insert(false);
                end;
            end;
        }
        dataitem("Bank Account Posting Group"; "Bank Account Posting Group")
        {
            trigger OnPreDataItem()
            begin
                if not "GBoolBank Account Posting Group" then CurrReport.Break();
                ChangeCompany(FromCompany);
            end;
            trigger OnAfterGetRecord()
            begin
                CurentRecord+=1;
                ProgressWindow.Update(1, CurentRecord);
                Clear("RecBank Account Posting Group");
                if "RecBank Account Posting Group".Get("Bank Account Posting Group"."Code")then begin
                    "RecBank Account Posting Group".TransferFields("Bank Account Posting Group", false); //EX-RBF 220223
                    "RecBank Account Posting Group".Modify(false);
                end
                else
                begin
                    "RecBank Account Posting Group".Copy("Bank Account Posting Group");
                    "RecBank Account Posting Group".Insert(false);
                end;
            end;
        }
        dataitem("Vendor"; "Vendor")
        {
            trigger OnPreDataItem()
            begin
                if not "GBoolVendor" then CurrReport.Break();
                ChangeCompany(FromCompany);
            end;
            trigger OnAfterGetRecord()
            begin
                CurentRecord+=1;
                ProgressWindow.Update(1, CurentRecord);
                Clear("RecVendor");
                if "RecVendor".Get("Vendor"."No.")then begin
                    "RecVendor".TransferFields("Vendor", false); //EX-RBF 220223
                    "RecVendor".Modify(false);
                end
                else
                begin
                    "RecVendor".Copy("Vendor");
                    "RecVendor".Insert(false);
                end;
            end;
        }
        dataitem("Vendor Posting Group"; "Vendor Posting Group")
        {
            trigger OnPreDataItem()
            begin
                if not "GBoolVendor Posting Group" then CurrReport.Break();
                ChangeCompany(FromCompany);
            end;
            trigger OnAfterGetRecord()
            begin
                CurentRecord+=1;
                ProgressWindow.Update(1, CurentRecord);
                Clear("RecVendor Posting Group");
                if "RecVendor Posting Group".Get("Vendor Posting Group"."Code")then begin
                    "RecVendor Posting Group".TransferFields("Vendor Posting Group", false); //EX-RBF 220223
                    "RecVendor Posting Group".Modify(false);
                end
                else
                begin
                    "RecVendor Posting Group".Copy("Vendor Posting Group");
                    "RecVendor Posting Group".Insert(false);
                end;
            end;
        }
        //TODO > Omitir GLAccount de compartición de datos > Activar Plan de Cuentas     
        dataitem("G/L Account"; "G/L Account")
        {
            trigger OnPreDataItem()
            begin
                if not "GBoolG/L Account" then CurrReport.Break();
                ChangeCompany(FromCompany);
            end;
            trigger OnAfterGetRecord()
            begin
                CurentRecord+=1;
                ProgressWindow.Update(1, CurentRecord);
                Clear("RecG/L Account");
                if "RecG/L Account".Get("G/L Account"."No.")then begin
                    "RecG/L Account".TransferFields("G/L Account", false); //EX-RBF 220223
                    "RecG/L Account".Modify(false);
                end
                else
                begin
                    "RecG/L Account".Copy("G/L Account");
                    "RecG/L Account".Insert(false);
                end;
            end;
        }
        dataitem("Dimension Value"; "Dimension Value")
        {
            trigger OnPreDataItem()
            begin
                if not "GBoolDimension Value" then CurrReport.Break();
                ChangeCompany(FromCompany);
            end;
            trigger OnAfterGetRecord()
            var
                LRecDimension: Record Dimension;
                LRecDimensionFromCompany: Record Dimension;
            begin
                CurentRecord+=1;
                ProgressWindow.Update(1, CurentRecord);
                if not LRecDimension.Get("Dimension Value"."Dimension Code")then begin
                    Clear(LRecDimensionFromCompany);
                    LRecDimensionFromCompany.ChangeCompany(FromCompany);
                    if LRecDimensionFromCompany.Get("Dimension Value"."Dimension Code")then begin
                        LRecDimension.Copy(LRecDimensionFromCompany);
                        LRecDimension.Insert(false);
                    end;
                end;
                Clear("RecDimension Value");
                if "RecDimension Value".Get("Dimension Value"."Dimension Code", "Dimension Value"."Code")then begin
                    // "RecDimension Value".TransferFields("Dimension Value");
                    "RecDimension Value"."Name":="Dimension Value"."Name";
                    "RecDimension Value"."Dimension Value Type":="Dimension Value"."Dimension Value Type";
                    "RecDimension Value"."Totaling":="Dimension Value"."Totaling";
                    "RecDimension Value"."Blocked":="Dimension Value"."Blocked";
                    "RecDimension Value"."Consolidation Code":="Dimension Value"."Consolidation Code";
                    "RecDimension Value"."Indentation":="Dimension Value"."Indentation";
                    "RecDimension Value"."Global Dimension No.":="Dimension Value"."Global Dimension No.";
                    "RecDimension Value"."Map-to IC Dimension Code":="Dimension Value"."Map-to IC Dimension Code";
                    "RecDimension Value"."Map-to IC Dimension Value Code":="Dimension Value"."Map-to IC Dimension Value Code";
                    // "RecDimension Value"."Dimension Value ID" := "Dimension Value"."Dimension Value ID";
                    // "RecDimension Value"."Id" := "Dimension Value"."Id";
                    "RecDimension Value"."Last Modified Date Time":="Dimension Value"."Last Modified Date Time";
                    "RecDimension Value"."Dimension Id":="Dimension Value"."Dimension Id";
                    "RecDimension Value"."SQL Synchronized":="Dimension Value"."SQL Synchronized";
                    "RecDimension Value"."Show Office":="Dimension Value"."Show Office";
                    "RecDimension Value"."No. of Ranking Entries":="Dimension Value"."No. of Ranking Entries";
                    "RecDimension Value"."Excel Column":="Dimension Value"."Excel Column";
                    "RecDimension Value"."Dim Estructura":="Dimension Value"."Dim Estructura";
                    "RecDimension Value"."Split Dimension":="Dimension Value"."Split Dimension";
                    "RecDimension Value"."Alias":="Dimension Value"."Alias";
                    "RecDimension Value".Modify(false);
                end
                else
                begin
                    "RecDimension Value".Copy("Dimension Value");
                    "RecDimension Value".Insert(false);
                end;
            end;
        }
        dataitem("Currency Exchange Rate"; "Currency Exchange Rate")
        {
            trigger OnPreDataItem()
            begin
                if not "GBoolCurrency Exchange Rate" then CurrReport.Break();
                ChangeCompany(FromCompany);
            end;
            trigger OnAfterGetRecord()
            begin
                CurentRecord+=1;
                ProgressWindow.Update(1, CurentRecord);
                Clear("RecCurrency Exchange Rate");
                if "RecCurrency Exchange Rate".Get("Currency Exchange Rate"."Currency Code", "Currency Exchange Rate"."Starting Date")then begin
                    "RecCurrency Exchange Rate".TransferFields("Currency Exchange Rate", false); //EX-RBF 220223
                    "RecCurrency Exchange Rate".Modify(false);
                end
                else
                begin
                    "RecCurrency Exchange Rate".Copy("Currency Exchange Rate");
                    "RecCurrency Exchange Rate".Insert(false);
                end;
            end;
        }
        dataitem("Vendor Bank Account"; "Vendor Bank Account")
        {
            trigger OnPreDataItem()
            begin
                if not "GBoolVendor Bank Account" then CurrReport.Break();
                ChangeCompany(FromCompany);
            end;
            trigger OnAfterGetRecord()
            begin
                CurentRecord+=1;
                ProgressWindow.Update(1, CurentRecord);
                Clear("RecVendor Bank Account");
                if "RecVendor Bank Account".Get("Vendor Bank Account"."Vendor No.", "Vendor Bank Account"."Code")then begin
                    "RecVendor Bank Account".TransferFields("Vendor Bank Account", false); //EX-RBF 220223
                    "RecVendor Bank Account".Modify(false);
                end
                else
                begin
                    "RecVendor Bank Account".Copy("Vendor Bank Account");
                    "RecVendor Bank Account".Insert(false);
                end;
            end;
        }
        dataitem("Customer Bank Account"; "Customer Bank Account")
        {
            trigger OnPreDataItem()
            begin
                if not "GBoolCustomer Bank Account" then CurrReport.Break();
                ChangeCompany(FromCompany);
            end;
            trigger OnAfterGetRecord()
            begin
                CurentRecord+=1;
                ProgressWindow.Update(1, CurentRecord);
                Clear("RecCustomer Bank Account");
                if "RecCustomer Bank Account".Get("Customer Bank Account"."Customer No.", "Customer Bank Account"."Code")then begin
                    "RecCustomer Bank Account".TransferFields("Customer Bank Account", false); //EX-RBF 220223
                    "RecCustomer Bank Account".Modify(false);
                end
                else
                begin
                    "RecCustomer Bank Account".Copy("Customer Bank Account");
                    "RecCustomer Bank Account".Insert(false);
                end;
            end;
        }
        dataitem("Default Dimension"; "Default Dimension")
        {
            trigger OnPreDataItem()
            begin
                if not "GBoolDefault Dimension" then CurrReport.Break();
                ChangeCompany(FromCompany);
            end;
            trigger OnAfterGetRecord()
            begin
                CurentRecord+=1;
                ProgressWindow.Update(1, CurentRecord);
                Clear("RecDefault Dimension");
                if "RecDefault Dimension".Get("Default Dimension"."Table ID", "Default Dimension"."No.", "Default Dimension"."Dimension Code")then begin
                    "RecDefault Dimension".TransferFields("Default Dimension", false); //EX-RBF 220223
                    "RecDefault Dimension".Modify(false);
                end
                else
                begin
                    "RecDefault Dimension".Copy("Default Dimension");
                    "RecDefault Dimension".Insert(false);
                end;
            end;
        }
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            trigger OnPreDataItem()
            begin
                if not "GBoolSales Invoice Header" then CurrReport.Break();
                ChangeCompany(FromCompany);
            end;
            trigger OnAfterGetRecord()
            begin
                CurentRecord+=1;
                ProgressWindow.Update(1, CurentRecord);
                Clear("RecSales Invoice Header");
                if "RecSales Invoice Header".Get("Sales Invoice Header"."No.")then begin
                    "RecSales Invoice Header".TransferFields("Sales Invoice Header", false); //EX-RBF 220223
                    "RecSales Invoice Header".Modify(false);
                end
                else
                begin
                    "RecSales Invoice Header".Copy("Sales Invoice Header");
                    "RecSales Invoice Header".Insert(false);
                end;
            end;
        }
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            trigger OnPreDataItem()
            begin
                if not "GBoolSales Cr.Memo Header" then CurrReport.Break();
                ChangeCompany(FromCompany);
            end;
            trigger OnAfterGetRecord()
            begin
                CurentRecord+=1;
                ProgressWindow.Update(1, CurentRecord);
                Clear("RecSales Cr.Memo Header");
                if "RecSales Cr.Memo Header".Get("Sales Cr.Memo Header"."No.")then begin
                    "RecSales Cr.Memo Header".TransferFields("Sales Cr.Memo Header", false); //EX-RBF 220223
                    "RecSales Cr.Memo Header".Modify(false);
                end
                else
                begin
                    "RecSales Cr.Memo Header".Copy("Sales Cr.Memo Header");
                    "RecSales Cr.Memo Header".Insert(false);
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(FromCompany; FromCompany)
                    {
                        ApplicationArea = All;
                        Caption = 'Empresa Origen';
                        TableRelation = Company;
                    }
                    group("Ejecutar Tablas")
                    {
                        field("GBoolJob"; "GBoolJob")
                        {
                            ApplicationArea = All;
                            Caption = 'Job';
                        }
                        field("GBoolJob Task"; "GBoolJob Task")
                        {
                            ApplicationArea = All;
                            Caption = 'Job Task';
                        }
                        field("GBoolJob Ledger Entry"; "GBoolJob Ledger Entry")
                        {
                            ApplicationArea = All;
                            Caption = 'Job Ledger Entry';
                        }
                        field("GBoolJob Planning Line"; "GBoolJob Planning Line")
                        {
                            ApplicationArea = All;
                            Caption = 'Job Planning Line';
                        }
                        field("GBoolJob Posting Group"; "GBoolJob Posting Group")
                        {
                            ApplicationArea = All;
                            Caption = 'Job Posting Group';
                        }
                        field("GBoolJob Register"; "GBoolJob Register")
                        {
                            ApplicationArea = All;
                            Caption = 'Job Register';
                        }
                        field("GBoolJobs Setup"; "GBoolJobs Setup")
                        {
                            ApplicationArea = All;
                            Caption = 'Jobs Setup';
                        }
                        field("GBoolCustomer"; "GBoolCustomer")
                        {
                            ApplicationArea = All;
                            Caption = 'Customer';
                        }
                        field("GBoolCustomer Posting Group"; "GBoolCustomer Posting Group")
                        {
                            ApplicationArea = All;
                            Caption = 'Customer Posting Group';
                        }
                        field("GBoolBank Account Posting Group"; "GBoolBank Account Posting Group")
                        {
                            ApplicationArea = All;
                            Caption = 'Bank Account Posting Group';
                        }
                        field("GBoolVendor"; "GBoolVendor")
                        {
                            ApplicationArea = All;
                            Caption = 'Vendor';
                        }
                        field("GBoolVendor Posting Group"; "GBoolVendor Posting Group")
                        {
                            ApplicationArea = All;
                            Caption = 'Vendor Posting Group';
                        }
                        //TODO > Omitir GLAccount de compartición de datos > Activar Plan de Cuentas                    
                        field("GBoolG/L Account"; "GBoolG/L Account")
                        {
                            ApplicationArea = All;
                            Caption = 'G/L Account';
                        }
                        field("GBoolDimension Value"; "GBoolDimension Value")
                        {
                            ApplicationArea = All;
                            Caption = 'Dimension Value';
                        }
                        field("GBoolCurrency Exchange Rate"; "GBoolCurrency Exchange Rate")
                        {
                            ApplicationArea = All;
                            Caption = 'Currency Exchange Rate';
                        }
                        field("GBoolVendor Bank Account"; "GBoolVendor Bank Account")
                        {
                            ApplicationArea = All;
                            Caption = 'Vendor Bank Account';
                        }
                        field("GBoolCustomer Bank Account"; "GBoolCustomer Bank Account")
                        {
                            ApplicationArea = All;
                            Caption = 'Customer Bank Account';
                        }
                        field("GBoolDefault Dimension"; "GBoolDefault Dimension")
                        {
                            ApplicationArea = All;
                            Caption = 'Default Dimension';
                        }
                    // field("GBoolSales Invoice Header"; "GBoolSales Invoice Header")
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Sales Invoice Header';
                    // }
                    // field("GBoolSales Cr.Memo Header"; "GBoolSales Cr.Memo Header")
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Sales Cr.Memo Header';
                    // }
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        if(FromCompany = '') or (FromCompany = CompanyName)then Error(TxtErrorSelectCompany);
        ProgressWindow.OPEN('Procesando Registro #1#######');
    end;
    trigger OnPostReport()
    begin
        ProgressWindow.CLOSE;
    end;
    var TxtErrorSelectCompany: Label 'Debe seleccionar una compañía distinta a la Actual.';
    FromCompany: Text[30];
    "RecJob": Record "Job";
    "RecJob Task": Record "Job Task";
    "RecJob Ledger Entry": Record "Job Ledger Entry";
    "RecJob Planning Line": Record "Job Planning Line";
    "RecJob Posting Group": Record "Job Posting Group";
    "RecJob Register": Record "Job Register";
    "RecJobs Setup": Record "Jobs Setup";
    "RecCustomer": Record "Customer";
    "RecCustomer Posting Group": Record "Customer Posting Group";
    "RecBank Account Posting Group": Record "Bank Account Posting Group";
    "RecVendor": Record "Vendor";
    "RecVendor Posting Group": Record "Vendor Posting Group";
    "RecG/L Account": Record "G/L Account";
    "RecDimension Value": Record "Dimension Value";
    "RecCurrency Exchange Rate": Record "Currency Exchange Rate";
    "RecVendor Bank Account": Record "Vendor Bank Account";
    "RecCustomer Bank Account": Record "Customer Bank Account";
    "RecDefault Dimension": Record "Default Dimension";
    "RecSales Invoice Header": Record "Sales Invoice Header";
    "RecSales Cr.Memo Header": Record "Sales Cr.Memo Header";
    ProgressWindow: Dialog;
    CurentRecord: Integer;
    "GBoolJob": Boolean;
    "GBoolJob Task": Boolean;
    "GBoolJob Ledger Entry": Boolean;
    "GBoolJob Planning Line": Boolean;
    "GBoolJob Posting Group": Boolean;
    "GBoolJob Register": Boolean;
    "GBoolJobs Setup": Boolean;
    "GBoolCustomer": Boolean;
    "GBoolCustomer Posting Group": Boolean;
    "GBoolBank Account Posting Group": Boolean;
    "GBoolVendor": Boolean;
    "GBoolVendor Posting Group": Boolean;
    "GBoolG/L Account": Boolean;
    "GBoolDimension Value": Boolean;
    "GBoolCurrency Exchange Rate": Boolean;
    "GBoolVendor Bank Account": Boolean;
    "GBoolCustomer Bank Account": Boolean;
    "GBoolDefault Dimension": Boolean;
    "GBoolSales Invoice Header": Boolean;
    "GBoolSales Cr.Memo Header": Boolean;
}
