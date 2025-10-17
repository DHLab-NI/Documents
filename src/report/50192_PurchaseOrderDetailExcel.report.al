report 50192 "DHLab PO Detail Excel"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = Excel;
    ExcelLayout = 'PurchaseOrderDetailExcel.xlsx';

    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const(Order));
            RequestFilterFields = "No.", "Order Date", Status, "Purchaser Code", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code";

            column(OrderNo; "No.")
            {
                IncludeCaption = true;
            }
            column(OrderDate; "Order Date")
            {
                IncludeCaption = true;
            }
            column(Status; Status)
            {
                IncludeCaption = true;
            }
            column(BuyFromVendorNo; "Buy-from Vendor No.")
            {
                IncludeCaption = true;
            }
            column(BuyFromVendorName; "Buy-from Vendor Name")
            {
                IncludeCaption = true;
            }
            column(PurchaserCode; "Purchaser Code")
            {
                IncludeCaption = true;
            }
            column(CurrencyCode; "Currency Code")
            {
                IncludeCaption = true;
            }
            column(DocumentDate; "Document Date")
            {
                IncludeCaption = true;
            }
            column(YourReference; "Your Reference")
            {
                IncludeCaption = true;
            }
            column(ExpectedReceiptDate; "Expected Receipt Date")
            {
                IncludeCaption = true;
            }
            column(PaymentTermsCode; "Payment Terms Code")
            {
                IncludeCaption = true;
            }
            column(ShipmentMethodCode; "Shipment Method Code")
            {
                IncludeCaption = true;
            }

            dataitem(PurchaseLine; "Purchase Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.");

                column(LineNo; "Line No.")
                {
                    IncludeCaption = true;
                }
                column(Type; Type)
                {
                    IncludeCaption = true;
                }
                column(ItemNo; "No.")
                {
                    IncludeCaption = true;
                }
                column(VendorItemNo; "Vendor Item No.")
                {
                    IncludeCaption = true;
                }
                column(Description; Description)
                {
                    IncludeCaption = true;
                }
                column(Description2; "Description 2")
                {
                    IncludeCaption = true;
                }
                column(Quantity; Quantity)
                {
                    IncludeCaption = true;
                }
                column(UnitOfMeasure; "Unit of Measure")
                {
                    IncludeCaption = true;
                }
                column(UnitOfMeasureCode; "Unit of Measure Code")
                {
                    IncludeCaption = true;
                }
                column(UnitCost; "Unit Cost")
                {
                    IncludeCaption = true;
                }
                column(LineDiscountPercent; "Line Discount %")
                {
                    IncludeCaption = true;
                }
                column(LineDiscountAmount; "Line Discount Amount")
                {
                    IncludeCaption = true;
                }
                column(LineAmount; "Line Amount")
                {
                    IncludeCaption = true;
                }
                column(Amount; Amount)
                {
                    IncludeCaption = true;
                }
                column(AmountIncludingVAT; "Amount Including VAT")
                {
                    IncludeCaption = true;
                }
                column(VATPercent; "VAT %")
                {
                    IncludeCaption = true;
                }
                column(LocationCode; "Location Code")
                {
                    IncludeCaption = true;
                }
                column(B2B_SONo; "B2B Sales Order No.")
                {
                    IncludeCaption = true;
                }
                column(B2B_SOLineNo; "B2B Sales Order Line No.")
                {
                    IncludeCaption = true;
                }
                column(SellToCustomerNo; SellToCustomerNo)
                {
                }
                column(REGION; SalesRegion)
                {
                }
                column(DEPT; SalesDept)
                {
                }
            }
            trigger OnAfterGetRecord()
            var
                Vendor: Record Vendor;
                SalesLine: Record "Sales Line";
            begin
                if (not IncludeBlocked) and Vendor.Get("Buy-from Vendor No.") then
                    if Vendor.Blocked <> Vendor.Blocked::" " then
                        CurrReport.Skip();

                // Look up Sell-to Customer No. and dimensions from related Sales Order Line
                SellToCustomerNo := '';
                SalesRegion := '';
                SalesDept := '';
                if (PurchaseLine."B2B Sales Order No." <> '') and (PurchaseLine."B2B Sales Order Line No." <> 0) then begin
                    if SalesLine.Get(SalesLine."Document Type"::Order, PurchaseLine."B2B Sales Order No.", PurchaseLine."B2B Sales Order Line No.") then begin
                        SellToCustomerNo := SalesLine."Sell-to Customer No.";
                        SalesRegion := SalesLine."Shortcut Dimension 1 Code";
                        SalesDept := SalesLine."Shortcut Dimension 2 Code";
                    end;
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    field(IncludeBlocked; IncludeBlocked)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Blocked Vendors';
                    }
                }
            }
        }
    }

    var
        IncludeBlocked: Boolean;
        SellToCustomerNo: Code[20];
        SalesRegion: Code[20];
        SalesDept: Code[20];
}
