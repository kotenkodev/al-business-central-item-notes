table 50100 "Item Note"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item."No.";
        }
        field(3; "Note Text"; Text[100])
        {
            Caption = 'Note Text';
        }
        field(4; Priority; Enum "Item Priority")
        {
            Caption = 'Priority';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}