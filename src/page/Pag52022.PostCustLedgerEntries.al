page 52022 "Post Cust. Ledger Entries"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Customer Ledger Entries';
    DataCaptionFields = "Customer No.";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Cust. Ledger Entry Historico";

    layout
    {
        area(content)
        {
            repeater(Entries)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Posting Date';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Document Type';
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Document No.';
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Bill No."; Rec."Bill No.")
                {
                    ToolTip = 'Bill No.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Situation"; Rec."Document Situation")
                {
                    ToolTip = 'Document Situation';
                    ApplicationArea = All;
                }
                field("Document Status"; Rec."Document Status")
                {
                    ToolTip = 'Document Status';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Customer No.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Global Dimension 1 Code';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Global Dimension 2 Code';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ToolTip = 'IC Partner Code';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ToolTip = 'Salesperson Code';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Currency Code';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Original Amount"; Rec."Original Amount")
                {
                    ToolTip = 'Original Amount';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Original Amt. (LCY)"; Rec."Original Amt. (LCY)")
                {
                    ToolTip = 'Original Amt. (LCY)';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Amount';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ToolTip = 'Amount (LCY)';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ToolTip = 'Remaining Amount';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Remaining Amt. (LCY)"; Rec."Remaining Amt. (LCY)")
                {
                    ToolTip = 'Remaining Amt. (LCY)';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ToolTip = 'Bal. Account Type';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ToolTip = 'Bal. Account No.';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Due Date';
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ToolTip = 'Pmt. Discount Date';
                    ApplicationArea = All;
                }
                field("Pmt. Disc. Tolerance Date"; Rec."Pmt. Disc. Tolerance Date")
                {
                    ToolTip = 'Pmt. Disc. Tolerance Date';
                    ApplicationArea = All;
                }
                field("Original Pmt. Disc. Possible"; Rec."Original Pmt. Disc. Possible")
                {
                    ToolTip = 'Original Pmt. Disc. Possible';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Remaining Pmt. Disc. Possible"; Rec."Remaining Pmt. Disc. Possible")
                {
                    ToolTip = 'Remaining Pmt. Disc. Possible';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Max. Payment Tolerance"; Rec."Max. Payment Tolerance")
                {
                    ToolTip = 'Max. Payment Tolerance';
                    ApplicationArea = All;
                }
                field("Pmt. Disc. Given (LCY)"; Rec."Pmt. Disc. Given (LCY)")
                {
                    ToolTip = 'Pmt. Disc. Given (LCY)';
                    ApplicationArea = All;
                }
                field(Open; Rec.Open)
                {
                    ToolTip = 'Open';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("On Hold"; Rec."On Hold")
                {
                    ToolTip = 'On Hold';
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'User ID';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ToolTip = 'Source Code';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ToolTip = 'Reason Code';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(Reversed; Rec.Reversed)
                {
                    ToolTip = 'Reversed';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Reversed by Entry No."; Rec."Reversed by Entry No.")
                {
                    ToolTip = 'Reversed by Entry No.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Reversed Entry No."; Rec."Reversed Entry No.")
                {
                    ToolTip = 'Reversed Entry No.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Entry No.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Direct Debit Mandate ID"; Rec."Direct Debit Mandate ID")
                {
                    ToolTip = 'Direct Debit Mandate ID';
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            part(CustomerLedgerEntries;9106)
            {
                ApplicationArea = All;
                SubPageLink = "Entry No."=FIELD("Entry No.");
                Visible = true;
            }
            part(IncomingDocAttachFactBox;193)
            {
                ApplicationArea = All;
                ShowFilter = false;
            }
            systempart(Links; Links)
            {
                ApplicationArea = All;
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("Ent&ry")
            {
                Caption = 'Entry';
                Image = Entry;
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'Functions';
                Image = "Action";

                group(IncomingDocument)
                {
                    Caption = 'Incoming Document';
                    Image = Documents;

                    action(IncomingDocCard)
                    {
                        ToolTip = 'View Incoming Document';
                        ApplicationArea = All;
                        Caption = 'View Incoming Document';
                        Enabled = HasIncomingDocument;
                        Image = ViewOrder;

                        //The property 'ToolTip' cannot be empty.
                        //ToolTip = '';
                        trigger OnAction()
                        var
                            IncomingDocument: Record 130;
                        begin
                            IncomingDocument.ShowCard(Rec."Document No.", Rec."Posting Date");
                        end;
                    }
                    action(SelectIncomingDoc)
                    {
                        ToolTip = 'Select Incoming Document';
                        ApplicationArea = All;
                        AccessByPermission = TableData "Incoming Document"=R;
                        Caption = 'Select Incoming Document';
                        Enabled = NOT HasIncomingDocument;
                        Image = SelectLineToApply;

                        //The property 'ToolTip' cannot be empty.
                        //ToolTip = '';
                        trigger OnAction()
                        var
                            IncomingDocument: Record "Incoming Document";
                        begin
                            IncomingDocument.SelectIncomingDocumentForPostedDocument(Rec."Document No.", Rec."Posting Date", Rec.RecordId);
                        end;
                    }
                    action(IncomingDocAttachFile)
                    {
                        ToolTip = 'Create Incoming Document from File';
                        ApplicationArea = All;
                        Caption = 'Create Incoming Document from File';
                        Ellipsis = true;
                        Enabled = NOT HasIncomingDocument;
                        Image = Attach;

                        //The property 'ToolTip' cannot be empty.
                        //ToolTip = '';
                        trigger OnAction()
                        var
                            IncomingDocumentAttachment: Record 133;
                        begin
                            IncomingDocumentAttachment.NewAttachmentFromPostedDocument(Rec."Document No.", Rec."Posting Date");
                        end;
                    }
                }
            }
            action("&Navigate")
            {
                ToolTip = 'Navigate';
                ApplicationArea = All;
                Caption = 'Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                Scope = Repeater;

                trigger OnAction()
                begin
                    Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
                    Navigate.Run();
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    var
        IncomingDocument: Record 130;
    begin
        HasIncomingDocument:=IncomingDocument.PostedDocExists(Rec."Document No.", Rec."Posting Date");
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;
    trigger OnAfterGetRecord()
    begin
    //StyleTxt := SetStyle;
    end;
    trigger OnModifyRecord(): Boolean begin
        CODEUNIT.RUN(CODEUNIT::"Cust. Entry-Edit", Rec);
        EXIT(FALSE);
    end;
    var Navigate: Page 344;
    StyleTxt: Text;
    HasIncomingDocument: Boolean;
}
