codeunit 50103 "Syntax Practice"
{
    procedure GetExercises(var Buffer: Record "Name/Value Buffer" temporary)
    begin
        AddExercise(Buffer, 1, 'TestSlaHours', 'Case statement with Enum');
        AddExercise(Buffer, 2, 'TestSyntax', 'If/else and GetShippingFee');
        AddExercise(Buffer, 3, 'TestCurrencyRate', ' Dictionary of currency rates');
    end;

    procedure RunExercise(ExerciseName: Text)
    begin
        case ExerciseName of
            'TestSlaHours':
                Message('Run SLA exercise here');
            'TestSyntax':
                GetShippingFee(45, false);
            'TestCurrencyRate':
                GetCurrencyRate('EUR');
            else
                Error('Unknown exercise: %1', ExerciseName);
        end;
    end;

    local procedure AddExercise(var Buffer: Record "Name/Value Buffer" temporary; Id: Integer; Name: Text[250]; Desc: Text[250])
    begin
        Buffer.Init();
        Buffer.ID := Id;
        Buffer.Name := Name;
        Buffer.Value := Desc;
        Buffer.Insert();
    end;

    procedure GetShippingFee(OrderTotal: Decimal; IsVIP: Boolean): Decimal
    var
        ShippingFee: Decimal;
    begin
        if IsVIP or (OrderTotal >= 100) then
            ShippingFee := 0
        else
            if OrderTotal >= 50 then
                ShippingFee := 5
            else
                ShippingFee := 10;
        Message('Shipping fee calculated: %1', ShippingFee);
    end;

    procedure GetCurrencyRate(CurrencyCode: Code[10]): Decimal
    var
        Dictionary: Dictionary of [Code[10], Decimal];
    begin
        Dictionary.Add('USD', 1);
        Dictionary.Add('EUR', 0.92);
        Dictionary.Add('UAH', 41.5);

        if Dictionary.ContainsKey(CurrencyCode) then
            Message('Currency rate: %1', Dictionary.Get(CurrencyCode))
        else
            Message('Unknown currency code: %1', 0);

    end;


}