pageextension 50181 "PostedSalesShipmtHdrPrintExt" extends "Posted Sales Shipment"
{
    actions
    {
        addlast(processing)
        {
            action("Print Address Label")
            {
                Caption = 'Print Address Label';
                Image = Print; // Optional: You can choose a relevant icon
                ApplicationArea = All;

                trigger OnAction()
                var
                    SalesShipmentHeader: Record "Sales Shipment Header";
                begin
                    Rec.TestField("No."); // Ensure there's a valid document number

                    // Fetch the current line
                    SalesShipmentHeader.Get(Rec."No.");

                    // Run the report with the selected record
                    Report.Run(50188, true, false, SalesShipmentHeader);
                end;
            }
        }
    }
}
