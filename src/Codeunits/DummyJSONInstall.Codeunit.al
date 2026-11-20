codeunit 50104 "Dummy JSON Install"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        Setup: Record "Dummy JSON Setup";
    begin
        if not Setup.Get('') then begin
            Setup.Init();
            Setup."Primary Key" := '';
            Setup."Sync Enabled" := true;
            Setup."Last Sync Status" := 'Waiting for first synchronization';
            Setup.Insert(true);
        end;

        // TODO: Create a one-time Job Queue entry for the sync codeunit.
    end;
}
