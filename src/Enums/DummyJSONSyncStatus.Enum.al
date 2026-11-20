enum 50101 "Dummy JSON Sync Status"
{
    Extensible = false;

    value(0; Inserted)
    {
        Caption = 'Inserted';
    }
    value(1; Exists)
    {
        Caption = 'Already Exists';
    }
    value(2; ItemNumberConflict)
    {
        Caption = 'Item Number Conflict';
    }
}