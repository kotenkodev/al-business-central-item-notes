table 50102 "Dummy JSON Sync Log"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Sync Time"; DateTime)
        {
            Caption = 'Sync Time';
        }
        field(3; "Product ID"; Integer)
        {
            Caption = 'Product ID';
        }
        field(4; "Product Title"; Text[100])
        {
            Caption = 'Product Title';
        }
        field(5; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(6; Status; Enum "Dummy JSON Sync Status")
        {
            Caption = 'Status';
        }
        field(7; Details; Text[250])
        {
            Caption = 'Details';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Product; "Product ID", "Sync Time")
        {
        }
    }
}