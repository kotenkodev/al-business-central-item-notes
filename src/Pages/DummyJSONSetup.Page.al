page 50103 "Dummy JSON Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Dummy JSON Setup';
    SourceTable = "Dummy JSON Setup";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(Sync)
            {
                Caption = 'Dummy JSON Sync';

                field("Sync Enabled"; Rec."Sync Enabled")
                {
                    ApplicationArea = All;
                }
                field("Last Sync Time"; Rec."Last Sync Time")
                {
                    ApplicationArea = All;
                }
                field("Last Sync Count"; Rec."Last Sync Count")
                {
                    ApplicationArea = All;
                }
                field("Last Sync Status"; Rec."Last Sync Status")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ViewSyncLog)
            {
                ApplicationArea = All;
                Caption = 'View Sync Log';
                Image = Log;

                trigger OnAction()
                var
                    SyncLog: Record "Dummy JSON Sync Log";
                begin
                    Page.Run(Page::"Dummy JSON Sync Log", SyncLog);
                end;
            }
            action(SyncNow)
            {
                ApplicationArea = All;
                Caption = 'Sync Products Now';
                Image = Refresh;

                trigger OnAction()
                var
                    Sync: Codeunit "Dummy JSON Product Sync";
                begin
                    Sync.Run();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.GetSetup();
    end;
}
