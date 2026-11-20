pageextension 50100 "Item Card Ext" extends "Item Card"
{
    layout
    {
        addlast(Item)
        {
            field("Item Priority"; Rec."Item Priority")
            {
                ApplicationArea = All;
            }
            field("Internal Note"; Rec."Internal Note")
            {
                ApplicationArea = All;
            }
            field("Note Count"; Rec."Note Count")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action(ShowSummary)
            {
                Caption = 'Show Item Summary';
                ApplicationArea = All;
                Image = Info;

                trigger OnAction()
                var
                    Helper: Codeunit "Item Note Helper";
                begin
                    Helper.ShowItemSummary(Rec);
                end;
            }
            action(AddNote)
            {
                Caption = 'Add Note';
                ApplicationArea = All;
                Image = NewDocument;

                trigger OnAction()
                var
                    Helper: Codeunit "Item Note Helper";
                begin
                    Helper.AddNoteFromItem(Rec);
                    CurrPage.Update(false);
                end;
            }
            action(BumpNotes)
            {
                Caption = 'Set All Notes High';
                ApplicationArea = All;
                Image = Approve;

                trigger OnAction()
                var
                    Helper: Codeunit "Item Note Helper";
                begin
                    Helper.BumpAllNotesToHigh(Rec."No.");
                end;
            }
            action(TestRollback)
            {
                Caption = 'Test Rollback';
                ApplicationArea = All;
                Image = ErrorLog;

                trigger OnAction()
                var
                    Helper: Codeunit "Item Note Helper";
                begin
                    Helper.TestRollback(Rec);
                end;
            }
            action(ItemNoteSummary)
            {
                Caption = 'Item Note Summary';
                ApplicationArea = All;
                Image = Report;
                ToolTip = 'Run the Item Note Summary report.';

                trigger OnAction()
                begin
                    Report.Run(50100);
                end;
            }
        }
    }
}