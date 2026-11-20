report 50100 "Item Note Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/ItemNoteSummary.rdlc';

    dataset
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
                DataItemLink = "Item No." = field("No.");

                column(EntryNo; "Entry No.")
                {
                }
                column(NoteText; "Note Text")
                {
                }
                column(Priority; Priority)
                {
                }

                trigger OnPreDataItem()
                begin
                    if PriorityFilter <> '' then
                        SetFilter(Priority, PriorityFilter);
                end;
            }

            trigger OnPreDataItem()
            begin
                if ItemNoFilter <> '' then
                    SetRange("No.", ItemNoFilter);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Filters)
                {
                    field(ItemNoFilterField; ItemNoFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Item No.';
                        ToolTip = 'Optionally filter by a single item number.';
                    }
                    field(PriorityFilterField; PriorityFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Priority';
                        ToolTip = 'Optionally filter with Low, Medium, High, or an AL filter expression.';
                    }
                }
            }
        }
    }

    var
        ItemNoFilter: Code[20];
        PriorityFilter: Text[20];
}
