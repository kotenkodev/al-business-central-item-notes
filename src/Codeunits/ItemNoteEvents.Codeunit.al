codeunit 50101 "Item Note Events"
{
    [EventSubscriber(ObjectType::Table, Database::Item, OnAfterValidateEvent, 'Description', false, false)]
    local procedure OnAfterValidateItemDescription(var Rec: Record Item; var xRec: Record Item; CurrFieldNo: Integer)
    var
        ItemNote: Record "Item Note";
    begin
        if Rec.Description = xRec.Description then
            exit;

        ItemNote.Init();
        ItemNote."Entry No." := 0;
        ItemNote."Item No." := Rec."No.";
        ItemNote."Note Text" := CopyStr('Description changed to: ' + Rec.Description, 1, MaxStrLen(ItemNote."Note Text"));
        ItemNote.Priority := Enum::"Item Priority"::Low;
        ItemNote.Insert(false);

        OnAfterAutoNoteCreated(Rec."No.", ItemNote."Note Text");
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterAutoNoteCreated(ItemNo: Code[20]; NoteText: Text[100])
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Note Events", OnAfterAutoNoteCreated, '', false, false)]
    local procedure HandleAutoNoteCreated(ItemNo: Code[20]; NoteText: Text[100])
    begin
        Message('Event fired! Auto-note created for %1: %2', ItemNo, NoteText);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnAfterReleaseSalesDoc, '', false, false)]
    local procedure OnAfterReleaseSalesDocSubscriber(var SalesHeader: Record "Sales Header")
    var
        CustomerName: Text[100];
    begin
        CustomerName := SalesHeader."Sell-to Customer Name";
        if GuiAllowed() then
            Message('Sales Order %1 released for %2', SalesHeader."No.", CustomerName);
    end;

}