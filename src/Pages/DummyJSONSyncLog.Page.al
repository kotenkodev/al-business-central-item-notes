page 50104 "Dummy JSON Sync Log"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Dummy JSON Sync Log';
    SourceTable = "Dummy JSON Sync Log";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Entries)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Sync Time"; Rec."Sync Time")
                {
                    ApplicationArea = All;
                }
                field("Product ID"; Rec."Product ID")
                {
                    ApplicationArea = All;
                }
                field("Product Title"; Rec."Product Title")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Details; Rec.Details)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}