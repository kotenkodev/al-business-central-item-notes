# Business Central and AL

## How to learn

- The idea of the whole learning process is running a live Business Central instance, using Claude as a guide in order to understand Business Central - what it is, how it works and why it works this way, exploring it by hand by yourself (Stage 1). Stage 2 is focused on the AL fundamentals.

- Do every action yourself in Business Central. Reading about it without doing it does not count.

- After each operation, open the entries it created and work out where they came from.

- Microsoft Learn documentation is there for anything that is still unclear.

## Environment

- A Business Central tenant is provided. You can also use your own on-premises Business Central locally.

- VS Code with the AL Language extension.

- Claude Code.

## Stage 1. Business Central

There is no code in this stage. The goal is to understand what happens in the system on every operation.

### 1.0. What BC is

- ERP: finance, purchasing, sales, inventory and manufacturing in one system

- Navigation: Role Center, lists, cards, documents, search

- Master data: Item, Customer, Vendor, Location

- Number Series, Dimensions, setup tables

- Versions and updates: two major releases a year, in April and October (for example, 29.0 is 2026 release wave 2), and a minor update in each of the other months (29.1, 29.2, ...). Microsoft updates online environments within a window the admin sets.

**Worth a quick look:** Service, Jobs, BC online vs on-premises

**Safe to skip:** Fixed Assets, Intercompany, multiple currencies

**Read:** [Get ready for doing business](https://learn.microsoft.com/en-us/dynamics365/business-central/ui-get-ready-business) · [General functionality across business areas](https://learn.microsoft.com/en-us/dynamics365/business-central/ui-across-business-areas) · [Number Series](https://learn.microsoft.com/en-us/dynamics365/business-central/ui-create-number-series) · [Dimensions](https://learn.microsoft.com/en-us/dynamics365/business-central/finance-dimensions) · [Deployment overview](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/deployment/deployment) · [Update cycles](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/administration/update-rollout-timeline)

### 1.1. Inventory

- Item Journal

- Item Ledger Entry: entry types, why entries are never changed

- Value Entry and how it links to ILE

- Purchase Order, Sales Order, Transfer Order, Return Orders

- Partial posting: Ship/Receive and Invoice separately

- Release vs Shipment

**Worth a quick look:** Drop Shipment, Item Charges

**Safe to skip:** Special Order

**Read:** [Count, adjust, and reclassify inventory](https://learn.microsoft.com/en-us/dynamics365/business-central/inventory-how-count-adjust-reclassify) · [Record purchases](https://learn.microsoft.com/en-us/dynamics365/business-central/purchasing-how-record-purchases) · [Sell products](https://learn.microsoft.com/en-us/dynamics365/business-central/sales-how-sell-products) · [Transfer between locations](https://learn.microsoft.com/en-us/dynamics365/business-central/inventory-how-transfer-between-locations) · [Status field on documents](https://learn.microsoft.com/en-us/dynamics365/business-central/ui-document-status) · [Drop shipment](https://learn.microsoft.com/en-us/dynamics365/business-central/sales-how-drop-shipment) · [Item charges](https://learn.microsoft.com/en-us/dynamics365/business-central/payables-how-assign-item-charges)

### 1.2. Corrections and returns

- Credit Memo, Return Order

- Undo Shipment, Undo Receipt

- Application: linking inbound to outbound entries, Remaining Quantity, Appl.-to Item Entry

**Worth a quick look:** Exact Cost Reversing

**Safe to skip:** manual reapplication

**Read:** [Sales returns](https://learn.microsoft.com/en-us/dynamics365/business-central/sales-how-process-sales-returns-orders) · [Correct or cancel a sales invoice](https://learn.microsoft.com/en-us/dynamics365/business-central/sales-how-correct-cancel-sales-invoice) · [Item application](https://learn.microsoft.com/en-us/dynamics365/business-central/design-details-item-application)

### 1.3. Costing and posting

- Costing Methods: FIFO, LIFO, Specific and Average and why it's needed

- Adjust Cost - Item Entries, Post Inventory Cost to G/L

- Posting Groups and Posting Setup

- Chart of Accounts, G/L Entry, how Value Entry links to G/L

**Safe to skip:** Standard Cost, revaluation, Inventory Periods

**Read:** [Inventory costing](https://learn.microsoft.com/en-us/dynamics365/business-central/design-details-inventory-costing) · [Costing methods](https://learn.microsoft.com/en-us/dynamics365/business-central/design-details-costing-methods) · [Cost adjustment](https://learn.microsoft.com/en-us/dynamics365/business-central/design-details-cost-adjustment) · [Inventory posting](https://learn.microsoft.com/en-us/dynamics365/business-central/design-details-inventory-posting) · [Posting groups](https://learn.microsoft.com/en-us/dynamics365/business-central/finance-posting-groups)

### 1.4. Locations and warehouse

- Location, Bin, Transfer, In-Transit

- Warehouse setup levels

- Warehouse Receipt, Shipment, Put-away, Pick

- Warehouse Entry and how it differs from ILE

- Warehouse Shipment and Posted Sales Shipment (they are different)

**Worth a quick look:** Directed Put-away and Pick, zones, bin classes and bin types

**Safe to skip:** Movement Worksheets

**Note:** It's important to understand here why you can't just post a Sales Order when warehouse documents are required.

**Read:** [Warehouse overview](https://learn.microsoft.com/en-us/dynamics365/business-central/design-details-warehouse-overview) · [Warehouse setup](https://learn.microsoft.com/en-us/dynamics365/business-central/design-details-warehouse-setup) · [Set up warehouse](https://learn.microsoft.com/en-us/dynamics365/business-central/warehouse-setup-warehouse) · [Create bins](https://learn.microsoft.com/en-us/dynamics365/business-central/warehouse-how-to-create-individual-bins) · [Receive items](https://learn.microsoft.com/en-us/dynamics365/business-central/warehouse-how-receive-items) · [Ship items](https://learn.microsoft.com/en-us/dynamics365/business-central/warehouse-how-ship-items) · [Warehouse entries](https://learn.microsoft.com/en-us/dynamics365/business-central/design-details-warehouse-entries)

### 1.5. Manufacturing

- Production BOM, Production Order and its statuses

- Consumption and Output

- Reversing consumption

**Worth a quick look:** Routing

**Safe to skip:** capacities, Planning/MRP, Assembly

**Note:** It's important to understand here what happens when you produce one item out of, say, three components.

**Read:** [Manufacturing](https://learn.microsoft.com/en-us/dynamics365/business-central/production-manage-manufacturing) · [Create production orders](https://learn.microsoft.com/en-us/dynamics365/business-central/production-how-to-create-production-orders) · [Post consumption](https://learn.microsoft.com/en-us/dynamics365/business-central/production-how-to-post-consumption) · [Post output](https://learn.microsoft.com/en-us/dynamics365/business-central/production-how-to-post-output-quantity)

### 1.6. Item Tracking

- Item Tracking Code, Lot No., Serial No.

- Reservation Entry: where the numbers live before posting

- Warehouse Tracking: lots in bins, Pick and Put-away

**Worth a quick look:** Expiration Dates

**Note:** It's important to understand here how a Pick differs for an item with and without Warehouse Tracking.

**Read:** [Set up item tracking](https://learn.microsoft.com/en-us/dynamics365/business-central/inventory-how-setup-item-tracking) · [Work with item tracking](https://learn.microsoft.com/en-us/dynamics365/business-central/inventory-how-work-item-tracking) · [Item tracking design](https://learn.microsoft.com/en-us/dynamics365/business-central/design-details-item-tracking)

### 1.7. Users and permissions

- Users and licenses are created in Microsoft 365, not in BC

- Users, Update users from Microsoft 365

- What a license limits

- Permission Sets

- Security Groups (formerly User Groups)

- Profile (Role) that changes the UI, not the permissions

**Worth a quick look:** license types, admin center, Entra ID

**Safe to skip:** Delegated Admin

**Read:** [Create users according to licenses](https://learn.microsoft.com/en-us/dynamics365/business-central/ui-how-users-permissions) · [Licensing](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/deployment/licensing) · [Permissions](https://learn.microsoft.com/en-us/dynamics365/business-central/ui-define-granular-permissions) · [Security groups](https://learn.microsoft.com/en-us/dynamics365/business-central/ui-security-groups) · [Users and roles](https://learn.microsoft.com/en-us/dynamics365/business-central/admin-users-profiles-roles) · [Manage access to environment](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/administration/tenant-admin-center-manage-access)

## Stage 2. AL fundamentals

### 2.0. Environment

- app.json, launch.json, publishing to Business Central, symbols

- Three versions in app.json:

  - platform: the minimum platform version, the System symbols (Microsoft\_System)

  - application: the minimum version of the System Application and Base Application (Microsoft\_Application)

  - runtime: the version of the AL language and its features, for example runtime 18.0 ships with BC 29.0

  - The extension installs only on an environment that meets all three

**Read:** [Get started with AL](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-get-started) · [Debugging](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-debugging) · [app.json settings](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-json-files) · [Runtime versions](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-choosing-runtime)

### 2.1. Objects

- Table, Page, Codeunit, Enum

- Table Extension, Page Extension

- Page Inspection

- Object IDs: 50000-99999 for your own extensions

**Read:** [Development overview](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-dev-overview) · [Tables](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-tables-overview) · [Pages](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-pages-overview) · [Codeunits](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-codeunit-object) · [Enums](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-extensible-enums) · [Table extensions](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-table-ext-object) · [Page extensions](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-page-ext-object) · [Page Inspection](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-inspecting-pages) · [Object ranges](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-object-ranges)

### 2.2. Data

- Record: SetRange, SetFilter, FindSet, Get, Insert, Modify

- FlowField, CalcFields

**Read:** [Record data type](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/methods-auto/record/record-data-type) · [FlowFields](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-flowfields)

### 2.3. Logic

- Triggers: OnInsert, OnValidate, OnAction

- Error, Confirm, Message

- Transactions: what is rolled back on an error

**Read:** [Programming in AL](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-programming-in-al) · [Triggers](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-triggers-overview) · [Error handling](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-al-error-handling)

### 2.4. Events

- Event Publisher and Subscriber

- Finding the right event in the Base App

- Your own Integration Events

**Read:** [Events in AL](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-events-in-al) · [Subscribing to events](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-subscribing-to-events)

### 2.5. Tests

- Test Codeunit, \[Test\]

- Library codeunits: Library - Sales, Library - Inventory, others

- asserterror, handler methods, TestPage

**Read:** [Testing the application](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-testing-application) · [Test codeunits and test methods](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-test-codeunits-and-test-methods) · [Handler methods](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-creating-handler-methods)

## Optional: AppSource

You can also take a look at the AppSource publication process.

- Know the difference: a per-tenant extension (PTE) goes to one customer (while developing you actually use a PTE extension); a Marketplace app goes to everyone and must pass Microsoft's technical and marketing validation.

- Process of registering an affix and an object ID range for your publisher, and use them on every object and field.

- Once published, your first version becomes the baseline: no schema-breaking changes, and objects are obsoleted before removal.

**Read:** [Add your app to Marketplace](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/administration/appsource) · [Technical validation checklist](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-checklist-submission) · [Prefix and suffix](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/compliance/apptest-prefix-suffix) · [AppSourceCop](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/analyzers/appsourcecop) · [Testing your extension](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/compliance/apptest-testingyourextension) · [Maintain Marketplace apps and PTEs](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/app-maintain) · [Hotfix a Marketplace app](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-hotfixing-appsource-app)
