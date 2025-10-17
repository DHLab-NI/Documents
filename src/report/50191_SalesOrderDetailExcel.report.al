report 50191 "DHLab Sales Order Detail Excel"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = Excel;
    //    ExcelLayoutMultipleDataSheets = true;
    ExcelLayout = 'SalesOrderDetailExcel.xlsx';

    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const(Order));
            RequestFilterFields = "No.", "Order Date", Status, "Salesperson Code", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code";

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
            column(SellToCustomerNo; "Sell-to Customer No.")
            {
                IncludeCaption = true;
            }
            column(SellToCustomerName; "Sell-to Customer Name")
            {
                IncludeCaption = true;
            }
            column(SalespersonCode; "Salesperson Code")
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
            column(ExternalDocumentNo; "External Document No.")
            {
                IncludeCaption = true;
            }

            dataitem(SalesLine; "Sales Line")
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
                column(UnitPrice; "Unit Price")
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
                column(REGION; "Shortcut Dimension 1 Code")
                {
                    IncludeCaption = true;
                }
                column(DEPT; "Shortcut Dimension 2 Code")
                {
                    IncludeCaption = true;
                }
            }
            trigger OnAfterGetRecord()
            var
                Customer: Record Customer;
            begin
                if (not IncludeBlocked) and Customer.Get("Sell-to Customer No.") then
                    if Customer.Blocked <> Customer.Blocked::" " then
                        CurrReport.Skip();
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
                        Caption = 'Include Blocked Customers';
                    }
                }
            }
        }
    }

    var
        IncludeBlocked: Boolean;
}


