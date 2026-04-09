report 50195 "DHLab Outstanding Purch Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = Excel;
    ExcelLayout = 'DailyOSPurchReport.xlsx';

    dataset
    {
        dataitem(PurchaseLine; "Purchase Line")
        {
            DataItemTableView = sorting("Document Type", "Document No.", "Line No.") where("Document Type" = const(Order), "Outstanding Quantity" = filter(<> 0));
            RequestFilterFields = Type, "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Document No.", "Order Date", "Buy-from Vendor No.";

            column(BuyFromVendorNo; "Buy-from Vendor No.")
            {
                IncludeCaption = true;
            }
            column(DocumentNo; "Document No.")
            {
                IncludeCaption = true;
            }
            column(OrderDate; "Order Date")
            {
            }
            column(OSDays; OSDays)
            {
            }
            column(LineNo; "No.")
            {
                IncludeCaption = true;
            }
            column(Description; Description)
            {
                IncludeCaption = true;
            }
            column(Type; Type)
            {
                IncludeCaption = true;
            }
            column(LocationCode; "Location Code")
            {
                IncludeCaption = true;
            }
            column(Quantity; Quantity)
            {
                IncludeCaption = true;
            }
            column(OutstandingQuantity; "Outstanding Quantity")
            {
                IncludeCaption = true;
            }
            column(UnitOfMeasureCode; "Unit of Measure Code")
            {
                IncludeCaption = true;
            }
            column(B2BSalesOrderNo; "B2B Sales Order No.")
            {
                IncludeCaption = true;
            }
            column(B2BSellToCustomerNo; B2BSellToCustomerNo)
            {
            }
            column(ExpectedReceiptDate; "Expected Receipt Date")
            {
                IncludeCaption = true;
            }
            column(LineAmount; "Line Amount")
            {
                IncludeCaption = true;
            }
            column(BuyFromVendorName; BuyFromVendorName)
            {
            }
            column(REGION; "Shortcut Dimension 1 Code")
            {
                IncludeCaption = true;
            }
            column(DEPT; "Shortcut Dimension 2 Code")
            {
                IncludeCaption = true;
            }

            trigger OnAfterGetRecord()
            var
                PurchaseHeader: Record "Purchase Header";
                SalesLine: Record "Sales Line";
            begin
                // Pull header fields not available on the line
                if PurchaseHeader.Get("Document Type", "Document No.") then begin
                    DocumentDate := PurchaseHeader."Document Date";
                    BuyFromVendorName := PurchaseHeader."Buy-from Vendor Name";
                end else begin
                    DocumentDate := 0D;
                    BuyFromVendorName := '';
                end;

                // Calculate days outstanding from Order Date to today
                if "Order Date" <> 0D then
                    OSDays := Today - "Order Date"
                else
                    OSDays := 0;

                // Look up Sell-to Customer No. from the related B2B Sales Order Line
                B2BSellToCustomerNo := '';
                if ("B2B Sales Order No." <> '') and ("B2B Sales Order Line No." <> 0) then
                    if SalesLine.Get(SalesLine."Document Type"::Order, "B2B Sales Order No.", "B2B Sales Order Line No.") then
                        B2BSellToCustomerNo := SalesLine."Sell-to Customer No.";
            end;
        }
    }

    var
        DocumentDate: Date;
        BuyFromVendorName: Text[100];
        B2BSellToCustomerNo: Code[20];
        OSDays: Integer;

    trigger OnPreReport()
    begin
    end;
}
