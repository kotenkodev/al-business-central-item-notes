page 50102 "Submit Ticket"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            group(Ticket)
            {
                field(Subject; Subject)
                {
                    ApplicationArea = All;
                }
                field(Priority; Priority)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Submit)
            {
                ApplicationArea = All;
                Caption = 'Submit';

                trigger OnAction()
                begin
                    Message('Ticket submitted: %1', Subject);
                end;
            }
        }
    }

    var
        Subject: Text[100];
        Priority: Option Low,Medium,High;
        Description: Text;
}