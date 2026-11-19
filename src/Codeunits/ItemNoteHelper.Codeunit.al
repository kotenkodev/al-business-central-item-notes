codeunit 50100 "Item Note Helper"
{
    procedure ShowItemSummary(ItemRec: Record Item)
    begin
        Message(
            'Item: %1\Priority: %2\Note: %3',
            ItemRec."No.",
            ItemRec."Item Priority",
            ItemRec."Internal Note"
        );
    end;

    procedure AddNoteFromItem(ItemRec: Record Item)
    var
        ItemNote: Record "Item Note";
    begin
        ItemNote.Init();
        ItemNote."Entry No." := 0;
        ItemNote.Validate("Item No.", ItemRec."No.");
        ItemNote.Validate("Note Text", ItemRec."Internal Note");
        ItemNote.Priority := ItemRec."Item Priority";
        ItemNote.Insert(true);
    end;

    procedure BumpAllNotesToHigh(ItemNo: Code[20])
    var
        ItemRec: Record Item;
        ItemNote: Record "Item Note";
        UpdatedCount: Integer;
    begin
        ItemNote.SetRange("Item No.", ItemNo);
        if ItemNote.FindSet() then
            repeat
                ItemNote.Priority := Enum::"Item Priority"::High;
                ItemNote.Modify(true);
                UpdatedCount += 1;
            until ItemNote.Next() = 0;

        if ItemRec.Get(ItemNo) then begin
            ItemRec.CalcFields("Note Count");
            Message('Updated: %1\Total notes (FlowField): %2', UpdatedCount, ItemRec."Note Count");
        end;
    end;

    procedure TestRollback(ItemRec: Record Item)
    begin
        if not Confirm('Insert a note for %1 and then trigger an Error?', false, ItemRec."No.") then
            exit;

        AddNoteFromItem(ItemRec);
        Error('Simulated error after Insert. Transaction rolled back.');
    end;
}