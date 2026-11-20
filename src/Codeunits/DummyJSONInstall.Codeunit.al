codeunit 50104 "Dummy JSON Install"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        Setup: Record "Dummy JSON Setup";
        JobQueueEntry: Record "Job Queue Entry";
    begin
        if not Setup.Get('') then begin
            Setup.Init();
            Setup."Primary Key" := '';
            Setup."Sync Enabled" := true;
            Setup."Last Sync Status" := 'Waiting for first synchronization';
            Setup.Insert(true);
        end;

        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        JobQueueEntry.SetRange("Object ID to Run", Codeunit::"Dummy JSON Product Sync");
        if JobQueueEntry.FindFirst() then
            exit;

        JobQueueEntry.Init();
        JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
        JobQueueEntry."Object ID to Run" := Codeunit::"Dummy JSON Product Sync";
        JobQueueEntry.Description := 'Synchronize DummyJSON products';
        JobQueueEntry."Earliest Start Date/Time" := CurrentDateTime();
        JobQueueEntry."Recurring Job" := true;
        JobQueueEntry."No. of Minutes between Runs" := 1440;
        JobQueueEntry.Insert(true);
        JobQueueEntry.SetStatus(JobQueueEntry.Status::Ready);
    end;
}
