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
        ProductList: Text;
        ProductLine: Text;
    begin
        Setup.GetSetup();

        if not Setup."Sync Enabled" then
            exit;

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
                ProductList += StrSubstNo(
                    '%1. %2 - already exists\',
                    ProductCount,
                    ProductTitle);
                continue;
            end;

            if ItemRec.Get(ItemNo) then begin
                ProductList += StrSubstNo(
                    '%1. %2 - item number already exists\',
                    ProductCount,
                    ProductTitle);
                continue;
            end;

            ItemRec.Init();
            ItemRec.Validate("No.", ItemNo);
            ItemRec.Validate(Description, ProductTitle);
            ItemRec."Dummy JSON Product ID" := ProductId;
            ItemRec."Dummy JSON Synced" := true;
            ItemRec.Insert(true);
            InsertedCount += 1;
            ProductList += StrSubstNo(
                '%1. %2 - inserted\',
                ProductCount,
                ProductTitle);
        end;

        Setup."Last Sync Time" := CurrentDateTime();
        Setup."Last Sync Count" := InsertedCount;
        Setup."Last Sync Status" := StrSubstNo(
            'Processed %1 products; inserted %2',
            ProductCount,
            InsertedCount);
        Setup.Modify(true);

        ProductLine := StrSubstNo(
            'Processed %1 products. Inserted %2 new items.\%3',
            ProductCount,
            InsertedCount,
            ProductList);
        Message(ProductLine);
    end;


    procedure LogProduct(
        ProductId: Integer;
        ProductTitle: Text[100];
        ItemNo: Code[20];
        SyncStatus: Enum "Dummy JSON Sync Status";
        Details: Text[250])
    var
        SyncLog: Record "Dummy JSON Sync Log";
    begin
        SyncLog.Init();
        SyncLog."Sync Time" := CurrentDateTime();
        SyncLog."Product ID" := ProductId;
        SyncLog."Product Title" := ProductTitle;
        SyncLog."Item No." := ItemNo;
        SyncLog.Status := SyncStatus;
        SyncLog.Details := Details;
        SyncLog.Insert(true);
    end;

}
