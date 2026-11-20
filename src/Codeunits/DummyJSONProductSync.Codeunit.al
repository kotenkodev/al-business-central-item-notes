codeunit 50105 "Dummy JSON Product Sync"
{
    trigger OnRun()
    begin
        SyncProducts();
    end;

    procedure SyncProducts()
    var
        Setup: Record "Dummy JSON Setup";
        Client: HttpClient;
        Response: HttpResponseMessage;
        ResponseText: Text;
        RootObject: JsonObject;
        ProductsToken: JsonToken;
        ProductsArray: JsonArray;
        ProductToken: JsonToken;
        ProductObject: JsonObject;
        IdToken: JsonToken;
        TitleToken: JsonToken;
        ItemRec: Record Item;
        ProductCount: Integer;
        InsertedCount: Integer;
        ProductId: Integer;
        ProductTitle: Text[100];
        ItemNo: Code[20];
        RunId: Guid;
    begin
        Setup.GetSetup();

        if not Setup."Sync Enabled" then
            exit;

        RunId := CreateGuid();

        if not Client.Get(
            'https://dummyjson.com/products?limit=100',
            Response)
        then
            Error('Could not connect to DummyJSON.');


        if not Response.IsSuccessStatusCode() then
            Error(
                'DummyJSON returned HTTP %1.',
                Response.HttpStatusCode());

        Response.Content().ReadAs(ResponseText);

        if not RootObject.ReadFrom(ResponseText) then
            Error('DummyJSON returned invalid JSON.');

        if not RootObject.Get('products', ProductsToken) then
            Error('DummyJSON JSON does not contain a products array.');

        if not ProductsToken.IsArray() then
            Error('The DummyJSON products property is not an array.');

        ProductsArray := ProductsToken.AsArray();
        InsertedCount := ProcessProducts(ProductsArray, RunId);
        ProductCount := ProductsArray.Count();

        Setup."Last Sync Time" := CurrentDateTime();
        Setup."Last Sync Count" := InsertedCount;
        Setup."Last Sync Status" := StrSubstNo(
            'Processed %1 products; inserted %2',
            ProductCount,
            InsertedCount);
        Setup.Modify(true);

        Message(
            'Processed %1 products. Inserted %2 new items. Open Dummy JSON Sync Log for details.',
            ProductCount,
            InsertedCount);
    end;

    procedure ProcessProducts(ProductsArray: JsonArray; RunId: Guid): Integer
    var
        ProductToken: JsonToken;
        ProductObject: JsonObject;
        IdToken: JsonToken;
        TitleToken: JsonToken;
        ItemRec: Record Item;
        ProductCount: Integer;
        InsertedCount: Integer;
        ProductId: Integer;
        ProductTitle: Text[100];
        ItemNo: Code[20];
    begin
        foreach ProductToken in ProductsArray do begin
            ProductObject := ProductToken.AsObject();
            if not ProductObject.Get('id', IdToken) then
                Error('A DummyJSON product does not contain an id.');
            if not ProductObject.Get('title', TitleToken) then
                Error('A DummyJSON product does not contain a title.');

            ProductCount += 1;
            ProductId := IdToken.AsValue().AsInteger();
            ProductTitle := CopyStr(
                TitleToken.AsValue().AsText(),
                1,
                MaxStrLen(ProductTitle));
            ItemNo := CopyStr(
                StrSubstNo('DJ-%1', ProductId),
                1,
                MaxStrLen(ItemNo));

            ItemRec.SetRange("Dummy JSON Product ID", ProductId);
            if not ItemRec.IsEmpty() then begin
                LogProduct(
                    RunId,
                    ProductId,
                    ProductTitle,
                    ItemNo,
                    Enum::"Dummy JSON Sync Status"::Exists,
                    'An Item with this Dummy JSON Product ID already exists.');
                continue;
            end;

            if ItemRec.Get(ItemNo) then begin
                LogProduct(
                    RunId,
                    ProductId,
                    ProductTitle,
                    ItemNo,
                    Enum::"Dummy JSON Sync Status"::ItemNumberConflict,
                    'The generated Item No. is already used by another Item.');
                continue;
            end;

            if not TryValidateProduct(ProductTitle) then begin
                LogProduct(
                    RunId,
                    ProductId,
                    ProductTitle,
                    ItemNo,
                    Enum::"Dummy JSON Sync Status"::Failed,
                    CopyStr(GetLastErrorText(), 1, 250));
                continue;
            end;

            InsertProduct(ItemRec, ItemNo, ProductTitle, ProductId);
            InsertedCount += 1;
            LogProduct(
                RunId,
                ProductId,
                ProductTitle,
                ItemNo,
                Enum::"Dummy JSON Sync Status"::Inserted,
                'Item created successfully.');
        end;

        exit(InsertedCount);
    end;

    [TryFunction]
    local procedure TryValidateProduct(ProductTitle: Text[100])
    begin
        if ProductTitle = '' then
            Error('Product title cannot be empty.');
    end;

    local procedure InsertProduct(
        var ItemRec: Record Item;
        ItemNo: Code[20];
        ProductTitle: Text[100];
        ProductId: Integer)
    begin
        ItemRec.Reset();
        ItemRec.Init();
        ItemRec.Validate("No.", ItemNo);
        ItemRec.Validate(Description, ProductTitle);
        ItemRec."Dummy JSON Product ID" := ProductId;
        ItemRec."Dummy JSON Synced" := true;
        ItemRec.Insert(true);
    end;


    procedure LogProduct(
        RunId: Guid;
        ProductId: Integer;
        ProductTitle: Text[100];
        ItemNo: Code[20];
        SyncStatus: Enum "Dummy JSON Sync Status";
        Details: Text[250])
    var
        SyncLog: Record "Dummy JSON Sync Log";
    begin
        SyncLog.Init();
        SyncLog."Run ID" := RunId;
        SyncLog."Sync Time" := CurrentDateTime();
        SyncLog."Product ID" := ProductId;
        SyncLog."Product Title" := ProductTitle;
        SyncLog."Item No." := ItemNo;
        SyncLog.Status := SyncStatus;
        SyncLog.Details := Details;
        SyncLog.Insert(true);
    end;

}
