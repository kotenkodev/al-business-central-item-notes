page 50102 "Item Note API"
{
    PageType = API;
    Caption = 'Item Note API';
    APIPublisher = 'vadym';
    APIGroup = 'inventory';
    APIVersion = 'v1.0';
    EntityName = 'itemNote';
    EntitySetName = 'itemNotes';
    SourceTable = "Item Note";
    DelayedInsert = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(noteText; Rec."Note Text")
                {
                    Caption = 'Note Text';
                }
            }
        }
    }
}