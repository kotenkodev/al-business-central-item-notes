codeunit 50103 "Syntax Practice"
{
    procedure GetExercises(var Buffer: Record "Name/Value Buffer" temporary)
    begin
        AddExercise(Buffer, 1, 'TestSlaHours', 'Case statement with Enum');
        AddExercise(Buffer, 2, 'TestSyntax', 'If/else and GetShippingFee');
        AddExercise(Buffer, 3, 'TestCurrencyRate', ' Dictionary of currency rates');
        AddExercise(Buffer, 4, 'TestGetPaymentDueDate', 'Calculate payment due date based on invoice date and net days');
        AddExercise(Buffer, 5, 'TestTempSorting', 'Insert rows into a temporary table and sort them');
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
            'TestGetPaymentDueDate':
                GetPaymentDueDate(WorkDate, 30);
            'TestTempSorting':
                TestTempSorting();
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
        Rates: Dictionary of [Code[10], Decimal];
    begin
        Rates.Add('USD', 1);
        Rates.Add('EUR', 0.92);
        Rates.Add('UAH', 41.5);

        if Rates.ContainsKey(CurrencyCode) then
            Message('Currency rate: %1', Rates.Get(CurrencyCode))
        else
            Message('Unknown currency code: %1', 0);
    end;

    procedure GetPaymentDueDate(InvoiceDate: Date; NetDays: Integer): Date
    var
        Formula: Text;
        ResultDate: Date;
    begin
        if InvoiceDate = 0D then
            Message('Invoice date is not set. %1 ', 0)
        else begin

            Formula := StrSubstNo('<+%1D>', NetDays);
            ResultDate := CalcDate(Formula, InvoiceDate);
            Message('Payment due date calculated: %1', ResultDate);
        end;
    end;

    local procedure InsertRow(var TempBuffer: Record "Name/Value Buffer" temporary; NewID: Integer; NewName: Text[250])
    begin
        TempBuffer.Init();
        TempBuffer.ID := NewID;
        TempBuffer.Name := NewName;
        TempBuffer.Insert();
    end;

    procedure TestTempSorting()
    var
        TempBuffer: Record "Name/Value Buffer" temporary;
        Result: Text;
    begin
        InsertRow(TempBuffer, 1, 'Zebra');
        InsertRow(TempBuffer, 2, 'Alpha');
        InsertRow(TempBuffer, 3, 'Beta');

        TempBuffer.SetCurrentKey(Name);
        if TempBuffer.FindSet() then
            repeat
                if Result <> '' then
                    Result += ', ';
                Result += TempBuffer.Name;
            until TempBuffer.Next() = 0;

        Message('Sorted result: %1', Result);
    end;

}