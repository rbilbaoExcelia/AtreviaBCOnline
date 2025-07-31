page 52023 "Post Vendor Ledger Entries"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Post Vendor Ledger Entries';
    DataCaptionFields = "Vendor No.";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Vend. Ledger Entry Historico";

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
                field("Autodocument No."; Rec."Autodocument No.")
                {
                    ToolTip = 'Autodocument No.';
                    ApplicationArea = All;
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
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'External Document No.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ToolTip = 'Vendor No.';
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
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ToolTip = 'Purchaser Code';
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
                field("Pmt. Disc. Rcd.(LCY)"; Rec."Pmt. Disc. Rcd.(LCY)")
                {
                    ToolTip = 'Pmt. Disc. Rcd.(LCY)';
                    ApplicationArea = All;
                }
                field("Max. Payment Tolerance"; Rec."Max. Payment Tolerance")
                {
                    ToolTip = 'Max. Payment Tolerance';
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
            }
        }
        area(factboxes)
        {
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
                Caption = 'Ent&ry';
                Image = Entry;

                action("Applied E&ntries")
                {
                    Caption = 'Applied E&ntries';
                    ToolTip = 'Applied E&ntries';
                    ApplicationArea = All;
                    Image = Approve;
                    RunObject = Page 62;
                    RunPageOnRec = true;
                    Scope = Repeater;
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData 348=R;
                    Caption = 'Dimensions';
                    ToolTip = 'Dimensions';
                    ApplicationArea = All;
                    Image = Dimensions;
                    Scope = Repeater;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions();
                    end;
                }
                action("Detailed &Ledger Entries")
                {
                    Caption = 'Detailed &Ledger Entries';
                    ToolTip = 'Detailed &Ledger Entries';
                    ApplicationArea = All;
                    Image = View;
                    RunObject = Page 574;
                    RunPageLink = "Vendor Ledger Entry No."=FIELD("Entry No."), "Vendor No."=FIELD("Vendor No.");
                    RunPageView = SORTING("Vendor Ledger Entry No.", "Posting Date");
                    Scope = Repeater;
                    ShortCutKey = 'Ctrl+F7';
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

                group(IncomingDocument)
                {
                    Caption = 'Incoming Document';
                    Image = Documents;

                    action(IncomingDocAttachFile)
                    {
                        Caption = 'Create Incoming Document from File';
                        ToolTip = 'IncomingDocAttachFile';
                        ApplicationArea = All;
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
                Caption = '&Navigate';
                ToolTip = '&Navigate';
                ApplicationArea = All;
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
            action("Show Posted Document")
            {
                Caption = 'Show Posted Document';
                ToolTip = 'Show Posted Document';
                ApplicationArea = All;
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Return';

                trigger OnAction()
                begin
                    Rec.ShowDoc();
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
        StyleTxt:=Rec.SetStyle();
    end;
    trigger OnModifyRecord(): Boolean begin
        CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit", Rec);
        EXIT(FALSE);
    end;
    var Navigate: Page 344;
    StyleTxt: Text;
    HasIncomingDocument: Boolean;
}
