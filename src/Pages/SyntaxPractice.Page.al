page 50101 "Syntax Practice"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Syntax Practice';
    SourceTable = "Name/Value Buffer";
    SourceTableTemporary = true;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Exercises)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Exercise';
                }
                field(Value; Rec.Value)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(RunSelected)
            {
                ApplicationArea = All;
                Caption = 'Run Selected';
                Image = Start;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SyntaxPractice: Codeunit "Syntax Practice";
                begin
                    SyntaxPractice.RunExercise(Rec.Name);
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        SyntaxPractice: Codeunit "Syntax Practice";
    begin
        SyntaxPractice.GetExercises(Rec);
    end;
}