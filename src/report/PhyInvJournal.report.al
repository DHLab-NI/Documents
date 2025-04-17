// SGH 15/04/25 Copied from Lisclare Report
report 50190 "DHLab Phy Inv Journal"
{
    DefaultLayout = Word;
    UsageCategory = Tasks;
    Caption = 'Physical Inventory Journal';
    WordLayout = 'DHLab_Phy_Inv_Journal.docx';
    UseRequestPage = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(Journal; "Item Journal Line")
        {

            DataItemTableView = WHERE("Journal Template Name" = const('PHYSINV'));

            //Filters
            RequestFilterFields = "Journal Batch Name";

            column(Journal_Template_Name; Journal."Journal Template Name") { }
            column(Journal_Batch_Name; Journal."Journal Batch Name") { }
            column(Item_No; Journal."Item No.") { }
            column(Description; Journal.Description) { }
            column(Location_Code; Journal."Location Code") { }
            column(Qty_Calculated; Journal."Qty. (Calculated)") { }
            column(Unit_of_Measure_Code; Journal."Unit of Measure Code") { }
            column(ShelfNo; Shelf_No) { }
            column(VendorNo; Vendor_No) { }
            column(VendorItemNo; Vendor_Item_No) { }
            column(VendorName; Vendor_Name) { }
            column(ItemCategoryCode; Item_Category_Code) { }
            column(UOM; UOM) { }
            column(SKUShelf; SKU_Shelf) { }
            column(Report_Filters; Report_Filters) { }


            trigger OnAfterGetRecord()
            begin
                IF Item.GET(Journal."Item No.") then begin
                    Shelf_No := Item."Shelf No.";
                    Vendor_No := Item."Vendor No.";
                    Vendor_Item_No := Item."Vendor Item No.";
                    Item_Category_Code := Item."Item Category Code";
                    UOM := Item."Base Unit of Measure";
                    IF Vendor.GET(Item."Vendor No.") then begin
                        Vendor_Name := Vendor.Name
                    end;
                end else begin
                    Shelf_No := '';
                    Vendor_No := '';
                    Vendor_Item_No := '';
                    Vendor_Name := '';
                    Item_Category_Code := '';
                    UOM := '';
                end;

                IF SKU.GET(Journal."Location Code", Journal."Item No.", Journal."Variant Code") then begin
                    SKU_Shelf := SKU."Shelf No.";
                end else begin
                    SKU_Shelf := 'None';
                end
            end;

        }

    }

    requestpage
    {
        SaveValues = true;
    }

    trigger OnPostReport()
    begin

    end;

    trigger OnPreReport()
    begin
        Report_Filters := Journal.GetFilters;
    end;

    var
        Item: Record Item;
        SKU: Record "Stockkeeping Unit";
        Vendor: Record Vendor;
        Shelf_No: Text;
        Vendor_No: Text;
        Vendor_Item_No: Text;
        Vendor_Name: Text;
        Journal_Batch_Name: Text;
        Item_Category_Code: Text;
        SKU_Shelf: Text;
        Report_Filters: Text;
        UOM: Code[10];
}