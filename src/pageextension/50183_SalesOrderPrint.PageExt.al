pageextension 50183 SalesOrderPrintExt extends "Sales Order"
{
    layout
    {

    }

    actions
    {


        addafter("Pick Instruction")
        {
            action("DHLab_Pick_List")
            {
                Caption = 'DHLab Pick List';
                Image = Print;
                ApplicationArea = All;
                //Promoted = true;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin
                    // Run the pick list report for the current Sales Order
                    SalesHeader := Rec;
                    CurrPage.SetSelectionFilter(SalesHeader);
                    Report.Run(50194, true, false, SalesHeader);
                end;
            }
        }

        addlast("Category_Category11")
        {
            actionref("DHLab_Pick_List_Promoted"; "DHLab_Pick_List")
            {

            }
        }

    }

    var


    trigger OnAfterGetRecord()
    var
    begin

    end;
}
