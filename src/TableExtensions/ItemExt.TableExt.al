tableextension 50100 "Item Ext" extends Item
{
    fields
    {
        field(50100; "Item Priority"; Enum "Item Priority")
        {
            Caption = 'Priority';
            DataClassification = CustomerContent;
        }
        field(50101; "Internal Note"; Text[100])
        {
            Caption = 'Internal Note';
            DataClassification = CustomerContent;
        }
    }
}