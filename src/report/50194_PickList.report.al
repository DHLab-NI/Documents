// DH Lab Sales Order Pick List
// Created to generate pick lists per Sales Order
// SGH 02/02/2026
report 50194 "DHLab Pick List"
{
    //UsageCategory = Administration;
    //ApplicationArea = All;
    DefaultLayout = Word;
    WordLayout = '50194_DHLab_Pick_List.docx';

    dataset
    {
        dataitem(Header; "Sales Header")
        {
            DataItemTableView = Sorting("No.");
            RequestFilterFields = "No.";

            column(TodayDate_Header; format(TodayDate, 0, '<day,2>/<month,2>/<year4>'))
            {
                //IncludeCaption = true;
            }

            column(No_Header; "No.")
            {
                IncludeCaption = true;
            }

            column(OrderDate_Header; format("Order Date", 0, '<day,2>/<month,2>/<year4>'))
            {
                //IncludeCaption = true;
            }

            column(CustomerNo_Header; "Sell-to Customer No.")
            {
                IncludeCaption = true;
            }

            column(CustomerName_Header; "Sell-to Customer Name")
            {
                IncludeCaption = true;
            }

            dataitem(Line; "Sales Line")
            {
                DataItemTableView = sorting("Line No.") where("Type" = const(Item));
                DataItemLink = "Document No." = field("No.");

                column(ItemNo_Line; "No.")
                {
                    IncludeCaption = true;
                }

                column(Description_Line; "Description")
                {
                    IncludeCaption = true;
                }

                column(LocationCode_Line; "Location Code")
                {
                    IncludeCaption = true;
                }

                column(ShipmentDate_Line; format("Shipment Date", 0, '<day,2>/<month,2>/<year4>'))
                {
                    //IncludeCaption = true;
                }

                column(Quantity_Line; "Quantity")
                {
                    IncludeCaption = true;
                }

                column(UnitOfMeasure_Line; "Unit of Measure")
                {
                    IncludeCaption = true;
                }

                column(Outstanding_Qty_Line; "Outstanding Quantity")
                {
                    IncludeCaption = true;
                }

                dataitem(Item; Item)
                {
                    DataItemLink = "No." = field("No.");

                    column(ShelfNo_Item; "Shelf No.")
                    {
                        IncludeCaption = true;
                    }
                }

            }

            // Header - populate some variables on each header record
            trigger OnAfterGetRecord()
            begin
                // nothing required per header record; CompanyName is set by CompanyInfo dataitem
            end;
        }
    }

    var
        TodayDate: Date;

    trigger OnPreReport()
    begin
        // Today's date
        TodayDate := WorkDate();
    end;

}
