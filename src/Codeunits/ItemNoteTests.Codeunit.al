codeunit 50102 "Item Note Tests"
{
    Subtype = Test;

    [Test]
    procedure TestAddNoteIncreasesCount()
    var
        ItemRec: Record Item;
        Helper: Codeunit "Item Note Helper";
        CountBefore: Integer;
        CountAfter: Integer;
    begin
        ItemRec.Get('1002');
        ItemRec.CalcFields("Note Count");
        CountBefore := ItemRec."Note Count";

        ItemRec."Internal Note" := 'Automated test note';
        Helper.AddNoteFromItem(ItemRec);

        ItemRec.CalcFields("Note Count");
        CountAfter := ItemRec."Note Count";

        if CountAfter <> CountBefore + 1 then
            Error('Expected Note Count %1, got %2.', CountBefore + 1, CountAfter);
    end;

    [Test]
    procedure TestEmptyNoteThrowsError()
    var
        ItemRec: Record Item;
        Helper: Codeunit "Item Note Helper";
    begin
        ItemRec.Get('1002');
        ItemRec."Internal Note" := '';

        asserterror Helper.AddNoteFromItem(ItemRec);

        if StrPos(GetLastErrorText(), 'Note Text cannot be empty.') = 0 then
            Error('Unexpected error text: %1', GetLastErrorText());
    end;

    [Test]
    [HandlerFunctions('AutoNoteMessageHandler')]
    procedure TestDescriptionChangeFiresMessage()
    var
        ItemRec: Record Item;
    begin
        ItemRec.Get('1002');
        ItemRec.Validate(Description, 'Test Auto Note Msg');
    end;

    [Test]
    procedure TestItemCardAddNoteAction()
    var
        ItemCard: TestPage "Item Card";
        CountBefore: Integer;
        CountAfter: Integer;
    begin
        ItemCard.OpenEdit();
        ItemCard.GoToKey('1002');

        CountBefore := ItemCard."Note Count".AsInteger();

        ItemCard."Internal Note".SetValue('Note from TestPage');
        ItemCard.AddNote.Invoke();

        CountAfter := ItemCard."Note Count".AsInteger();
        ItemCard.Close();

        if CountAfter <> CountBefore + 1 then
            Error('Expected Note Count %1, got %2.', CountBefore + 1, CountAfter);
    end;

  [Test]
    [HandlerFunctions('IgnoreMessageHandler')]
    procedure TestAddNoteWithLibraryItem()
    var
        ItemRec: Record Item;
        Helper: Codeunit "Item Note Helper";
        LibraryInventory: Codeunit "Library - Inventory";
        Assert: Codeunit "Library Assert";
    begin
        LibraryInventory.CreateItem(ItemRec); // +1 авто-заметка из события Description
        ItemRec."Internal Note" := 'Note for generated item';
        ItemRec.Modify();

        Helper.AddNoteFromItem(ItemRec); // +1 наша заметка

        ItemRec.CalcFields("Note Count");
        Assert.AreEqual(2, ItemRec."Note Count", 'Note Count should be 2 (1 auto-note + 1 manual note).');
    end;

    [Test]
    [HandlerFunctions('IgnoreMessageHandler')]
    procedure TestDummyJSONFirstSyncInsertsProducts()
    var
        Products: JsonArray;
        Sync: Codeunit "Dummy JSON Product Sync";
        ItemRec: Record Item;
        InsertedCount: Integer;
    begin
        Products := CreateDummyProducts(910001, 'Training product one');
        InsertedCount := Sync.ProcessProducts(Products, CreateGuid());

        ItemRec.SetRange("Dummy JSON Product ID", 910001);
        if InsertedCount <> 1 then
            Error('Expected one inserted product, got %1.', InsertedCount);
        if ItemRec.Count() <> 1 then
            Error('Expected one Item for Dummy JSON product 910001.');
    end;

    [Test]
    [HandlerFunctions('IgnoreMessageHandler')]
    procedure TestDummyJSONSecondSyncInsertsZeroProducts()
    var
        Products: JsonArray;
        Sync: Codeunit "Dummy JSON Product Sync";
        InsertedCount: Integer;
    begin
        Products := CreateDummyProducts(910002, 'Training product two');
        Sync.ProcessProducts(Products, CreateGuid());
        InsertedCount := Sync.ProcessProducts(Products, CreateGuid());

        if InsertedCount <> 0 then
            Error('Expected zero inserted products on the second sync, got %1.', InsertedCount);
    end;

    [Test]
    [HandlerFunctions('IgnoreMessageHandler')]
    procedure TestDummyJSONExistingProductIsLogged()
    var
        Products: JsonArray;
        Sync: Codeunit "Dummy JSON Product Sync";
        SyncLog: Record "Dummy JSON Sync Log";
        RunId: Guid;
    begin
        Products := CreateDummyProducts(910003, 'Training product three');
        Sync.ProcessProducts(Products, CreateGuid());
        RunId := CreateGuid();
        Sync.ProcessProducts(Products, RunId);

        SyncLog.SetRange("Run ID", RunId);
        SyncLog.SetRange(Status, Enum::"Dummy JSON Sync Status"::Exists);
        if SyncLog.Count() <> 1 then
            Error('Expected one Already Exists log entry.');
    end;

    [Test]
    procedure TestDummyJSONFailedProductIsLogged()
    var
        Products: JsonArray;
        Sync: Codeunit "Dummy JSON Product Sync";
        SyncLog: Record "Dummy JSON Sync Log";
        RunId: Guid;
    begin
        Products := CreateDummyProducts(910004, '');
        RunId := CreateGuid();
        Sync.ProcessProducts(Products, RunId);

        SyncLog.SetRange("Run ID", RunId);
        SyncLog.SetRange(Status, Enum::"Dummy JSON Sync Status"::Failed);
        if SyncLog.Count() <> 1 then
            Error('Expected one Failed log entry.');
    end;

    local procedure CreateDummyProducts(ProductId: Integer; ProductTitle: Text): JsonArray
    var
        Products: JsonArray;
        Product: JsonObject;
    begin
        Product.Add('id', ProductId);
        Product.Add('title', ProductTitle);
        Products.Add(Product);
        exit(Products);
    end;

    [MessageHandler]
    procedure IgnoreMessageHandler(Message: Text[1024])
    begin
    end;

    [MessageHandler]
    procedure AutoNoteMessageHandler(Message: Text[1024])
    begin
        if StrPos(Message, 'Event fired! Auto-note created for 1002') = 0 then
            Error('Unexpected message: %1', Message);
    end;
}