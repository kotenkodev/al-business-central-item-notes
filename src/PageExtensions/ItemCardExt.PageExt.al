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
        }
    }
}