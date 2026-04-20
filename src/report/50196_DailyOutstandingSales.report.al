report 50196 "DHLab Outstanding Sales Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = Excel;
    ExcelLayout = 'OutstandingSalesReport.xlsx';

    dataset
    {
        dataitem(SalesLine; "Sales Line")
        {
            DataItemTableView = sorting("Document Type", "Document No.", "Line No.") where("Document Type" = const(Order), "Outstanding Quantity" = filter(<> 0));
            RequestFilterFields = Type, "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Document No.", "Promised Delivery Date", "Sell-to Customer No.";

            column(SellToCustomerNo; "Sell-to Customer No.")
            {
                IncludeCaption = true;
            }
            column(DocumentNo; "Document No.")
            {
                IncludeCaption = true;
            }
            column(OrderDate; OrderDate)
            {
            }
            column(Promised_Delivery_Date; "Promised Delivery Date")
            {
            }
            column(OSDays; OSDays)
            {
            }
            column(LineNo; "Line No.")
            {
                IncludeCaption = true;
            }
            column(ItemNo; "No.")
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
            column(RequestedDeliveryDate; "Requested Delivery Date")
            {
                IncludeCaption = true;
            }
            column(LineAmount; "Line Amount")
            {
                IncludeCaption = true;
            }
            column(SellToCustomerName; SellToCustomerName)
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
            column(OSLineAmount; OSLineAmount)
            {
            }

            trigger OnAfterGetRecord()
            var
                SalesHeader: Record "Sales Header";
            begin
                // Pull header fields not available on the line
                if SalesHeader.Get("Document Type", "Document No.") then begin
                    OrderDate := SalesHeader."Document Date";
                    SellToCustomerName := SalesHeader."Sell-to Customer Name";
                end else begin
                    OrderDate := 0D;
                    SellToCustomerName := '';
                end;

                // Calculate days outstanding from Order Date to today
                if OrderDate <> 0D then
                    OSDays := Today - OrderDate
                else
                    OSDays := 0;

                // Calculate outstanding line amount (unit price × outstanding qty)
                if Quantity <> 0 then
                    OSLineAmount := Round(("Line Amount" / Quantity) * "Outstanding Quantity", 0.01)
                else
                    OSLineAmount := 0;
            end;
        }
    }

    var
        OrderDate: Date;
        SellToCustomerName: Text[100];
        OSDays: Integer;
        OSLineAmount: Decimal;

    trigger OnPreReport()
    begin
    end;
}
