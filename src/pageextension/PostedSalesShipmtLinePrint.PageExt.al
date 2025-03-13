pageextension 50180 "PostedSalesShipmtLinePrintExt" extends "Posted Sales Shpt. Subform"
{
    actions
    {
        addlast(processing)
        {
            action("Print ADR Label")
            {
                Caption = 'Print ADR Label';
                Image = Print; // Optional: You can choose a relevant icon
                ApplicationArea = All;

                trigger OnAction()
                var
                    SalesShipmentLine: Record "Sales Shipment Line";
                begin
                    Rec.TestField("Document No."); // Ensure there's a valid document number
                    Rec.TestField("Line No."); // Ensure there's a valid line number

                    // Fetch the current line
                    SalesShipmentLine.Get(Rec."Document No.", Rec."Line No.");

                    // Run the report with the selected record
                    Report.Run(50188, true, false, SalesShipmentLine);
                end;
            }
        }
    }
}
