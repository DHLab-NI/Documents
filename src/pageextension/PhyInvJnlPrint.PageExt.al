// SGH Copied from Lisclare 15/04/25

pageextension 50182 extPhyInvJnlPrint extends "Phys. Inventory Journal"
{
    layout
    {
    }
    actions
    {

        addafter(CalculateInventory)
        {
            action("Print Count Sheets")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print C&ount Sheets';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category5;
                ToolTip = 'Print the DH Lab stock counting sheets';
                trigger OnAction();
                var
                    //    rep: Report "DHLab Phy Inv Journal";
                    PhysInvJnlLine: Record "Item Journal Line";
                begin
                    PhysInvJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                    PhysInvJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    //    rep.Run;
                    Report.RunModal(50190, true, true, PhysInvJnlLine);
                end;
            }
        }
    }
}