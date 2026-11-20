codeunit 50105 "Dummy JSON Product Sync"
{
    trigger OnRun()
    begin
        SyncProducts();
    end;

    procedure SyncProducts()
    var
        Setup: Record "Dummy JSON Setup";
    begin
        Setup.GetSetup();

        if not Setup."Sync Enabled" then
            exit;

        // TODO: Call https://dummyjson.com/products?limit=100.
        // TODO: Read the JSON array named "products".
        // TODO: For each product, find its "Dummy JSON Product ID".
        // TODO: Insert missing Items; do not overwrite existing items.
        // TODO: Update Last Sync Time, Last Sync Count, and Last Sync Status.
        Error('Dummy JSON Product Sync is ready to implement.');
    end;
}
