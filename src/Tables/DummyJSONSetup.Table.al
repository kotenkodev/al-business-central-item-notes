table 50101 "Dummy JSON Setup"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Sync Enabled"; Boolean)
        {
            Caption = 'Sync Enabled';
        }
        field(3; "Last Sync Time"; DateTime)
        {
            Caption = 'Last Sync Time';
            Editable = false;
        }
        field(4; "Last Sync Status"; Text[250])
        {
            Caption = 'Last Sync Status';
            Editable = false;
        }
        field(5; "Last Sync Count"; Integer)
        {
            Caption = 'Last Sync Count';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    procedure GetSetup()
    begin
        if not Get('') then begin
            Init();
            "Primary Key" := '';
            Insert(true);
        end;
    end;
}
