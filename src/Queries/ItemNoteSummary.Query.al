query 50100 "Item Note Summary"
{
    QueryType = API;
    APIPublisher = 'vadym';
    APIGroup = 'inventory';
    APIVersion = 'v1.0';
    EntityName = 'itemNoteSummary';
    EntitySetName = 'itemNoteSummaries';

    elements
    {
        dataitem(Item; Item)
        {
            column(ItemNo; "No.")
            {
            }
            column(ItemDescription; Description)
            {
            }
            dataitem(ItemNote; "Item Note")
            {
                DataItemLink = "Item No." = Item."No.";

                column(EntryNo; "Entry No.")
                {
                }
                column(NoteText; "Note Text")
                {
                }
                column(Priority; Priority)
                {
                }
            }
        }
    }
}
