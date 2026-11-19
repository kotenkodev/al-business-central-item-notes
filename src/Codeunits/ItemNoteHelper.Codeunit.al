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
}