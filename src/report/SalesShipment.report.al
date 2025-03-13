// DH Lab Shipment/Delivery Note
// SGH 25/02/25
report 50180 "DHLab Shipment"
{
    //    UsageCategory = Administration;
    //    ApplicationArea = All;
    DefaultLayout = Word;
    WordLayout = '50180_DHLab Shipment.docx';

    dataset
    {
        dataitem(Header; "Sales Shipment Header")
        {
            // Specify sort order (not required for a single document report)
            DataItemTableView = Sorting("No.");
            // Include the "No." field on the filter tab of the request page.
            RequestFilterFields = "No.";

            column(No_Header; "No.")
            {
                IncludeCaption = true;

            }

            column(BillToCustomerNo_Header; "Bill-to Customer No.")
            {
                IncludeCaption = true;

            }

            column(BillToName_Header; "Bill-to Name")
            {
            }

            column(BillToName2_Header; "Bill-to Name 2")
            {
            }

            column(BillToAddress_Header; "Bill-to Address")
            {
            }

            column(BillToAddress2_Header; "Bill-to Address 2")
            {
            }

            column(BillToCity_Header; "Bill-to City")
            {
            }

            column(BillToContact_Header; "Bill-to Contact")
            {
            }

            column(ShipToName_Header; "Ship-to Name")
            {
            }

            column(ShipToName2_Header; "Ship-to Name 2")
            {
            }

            column(ShipToAddress_Header; "Ship-to Address")
            {
            }

            column(ShipToAddress2_Header; "Ship-to Address 2")
            {
            }

            column(ShipToCity_Header; "Ship-to City")
            {
            }

            column(ShipToContact_Header; "Ship-to Contact")
            {
            }

            column(PaymentTermsCode_Header; "Payment Terms Code")
            {
            }

            column(DueDate_Header; "Due Date")
            {
                IncludeCaption = true;

            }
            column(CurrencyCode_Header; "Currency Code")
            {
                IncludeCaption = true;

            }

            column(SalespersonCode_Header; "Salesperson Code")
            {
                IncludeCaption = true;

            }

            column(OrderNo_Header; "Order No.")
            {
                IncludeCaption = true;

            }

            column(BillToPostCode_Header; "Bill-to Post Code")
            {
            }

            column(BillToCounty_Header; "Bill-to County")
            {
            }

            column(BillToCountry_Header; "Bill-to Country/Region Code")
            {
            }

            column(ShipToPostCode_Header; "Ship-to Post Code")
            {
            }

            column(ShipToCounty_Header; "Ship-to County")
            {
            }

            column(ShipToCountry_Header; "Ship-to Country/Region Code")
            {
            }

            column(DocumentDate_Header; format("Document Date", 0, '<day,2>/<month,2>/<year4>'))
            {
            }

            column(ExternalDocumentNo_Header; "External Document No.")
            {
                IncludeCaption = true;

            }

            column(BillToAddressBlock_Header; BillToAddressBlock)
            {
            }

            column(ShipToAddressBlock_Header; ShipToAddressBlock)
            {
            }

            dataitem(Line; "Sales Shipment Line")
            {

                DataItemTableView = sorting("Line No.");
                // Set a filter on the child data item, **Line** to select only the records where the 
                // value of `Sales Header."No."` field and the `"Sales Line"."Document No."` field matches
                // and where "Document Type" are equal (optional, for illustration)
                DataItemLink = "Document No." = field("No.");

                column(No_Line; "No.")
                {
                    IncludeCaption = true;

                }

                column(Description_Line; "Description")
                {
                    IncludeCaption = true;

                }

                column(Description2_Line; "Description 2")
                {
                    IncludeCaption = true;

                }

                column(UnitOfMeasure_Line; "Unit of Measure")
                {
                    IncludeCaption = true;

                }

                column(Quantity_Line; "Quantity")
                {
                    IncludeCaption = true;

                }

                column(QtyOrdered_Line; QtyOrdered)
                {
                    //Caption = 'Ordered';
                    DecimalPlaces = 0 : 5;
                }

                column(QtyToFollow_Line; QtyToFollow)
                {
                    //Caption = 'To follow';
                    DecimalPlaces = 0 : 5;
                }

                column(SerialNos_Line; SerialNos)
                {
                }

                dataitem(Item; Item)
                {

                    DataItemLink = "No." = field("No.");

                    column(VendorItemNo_Item; "Vendor Item No.")
                    {
                        IncludeCaption = true;
                    }

                    column(UN_Number_Code; "UN Number Code")
                    {
                        IncludeCaption = true;
                    }

                    column(No2; "No. 2")
                    {
                        IncludeCaption = true;
                    }

                    column(ShelfNo; "Shelf No.")
                    {
                        IncludeCaption = true;
                    }



                    dataitem(UNNumber; UNNumber)
                    {
                        DataItemLink = Code = field("UN Number Code");
                        column(Class_Division; "Class/Division")
                        {
                            IncludeCaption = true;
                        }
                        column(Subsidiary_Risk; "Subsidiary Risk")
                        {
                            IncludeCaption = true;
                        }
                        column(Subsidiary_Risk_2; "Subsidiary Risk 2")
                        {
                            IncludeCaption = true;
                        }
                        column(UN_Packing_Group; "UN Packing Group")
                        {
                            IncludeCaption = true;
                        }
                        column(UNNumberPrint_Text; UNNumberPrintText)
                        {

                        }
                        // UN_Number dataitem trigger

                        trigger OnAfterGetRecord()
                        begin

                            if Item."UN Number Code" <> '' then begin
                                if UNSubsid1Txt <> '' then begin
                                    UNSubsid1Txt := ' (' + UNNumber."Subsidiary Risk";
                                    if UNNumber."Subsidiary Risk 2" <> '' then
                                        UNSubsid2Txt := ', ' + UNNumber."Subsidiary Risk 2" + ')' else
                                        UNSubsid2Txt := ')';
                                end else begin
                                    UNSubsid1Txt := '';
                                    UNSubsid2Txt := '';
                                end;
                                UNNumberPrintText := Item."UN Number Code" + ' ' + UNNumber."Class/Division" + UNSubsid1Txt + UNSubsid2Txt + ' ' + Format(UNNumber."UN Packing Group");
                            end else
                                UNNumberPrintText := '';
                        end;
                    }
                }

                // Sales Shipment Line dataitem Trigger
                trigger OnAfterGetRecord()
                begin

                    // Get order quantities from sales order
                    if SalesLine.Get(SalesLine."Document Type"::Order, "Order No.", "Order Line No.") then begin
                        QtyOrdered := SalesLine.Quantity;
                        QtyToFollow := SalesLine."Outstanding Quantity";
                    end else begin
                        QtyOrdered := Quantity;
                        QtyToFollow := 0;
                    end;

                    // Get serial numbers
                    //Initialise variables
                    CRLF[1] := 13;
                    CRLF[2] := 10;
                    NewLine := format(CRLF[1]) + format(CRLF[2]);
                    SerialNos := '';

                    ItemLedgerEntry.SetRange("Document No.", "Document No.");
                    ItemLedgerEntry.SetRange("Item No.", "No.");
                    If ItemLedgerEntry.FindSet() then begin
                        repeat
                            if ItemLedgerEntry."Serial No." <> '' then
                                if SerialNos <> '' then
                                    SerialNos += ', ' + ItemLedgerEntry."Serial No."
                                else
                                    SerialNos := NewLine + 'Serial No.s: ' + ItemLedgerEntry."Serial No.";
                        until ItemLedgerEntry.Next() = 0;
                    end;
                end;
            }

            dataitem(CompanyInfo; "Company Information")
            {

                column(Name_CompanyInfo; "Name")
                {
                    IncludeCaption = true;

                }

                column(Name2_CompanyInfo; "Name 2")
                {
                    IncludeCaption = true;

                }

                column(Address_CompanyInfo; "Address")
                {
                    IncludeCaption = true;

                }

                column(Address2_CompanyInfo; "Address 2")
                {
                    IncludeCaption = true;

                }

                column(City_CompanyInfo; "City")
                {
                    IncludeCaption = true;

                }

                column(PhoneNo_CompanyInfo; "Phone No.")
                {
                    IncludeCaption = true;

                }

                column(BankName_CompanyInfo; "Bank Name")
                {
                    IncludeCaption = true;

                }

                column(BankBranchNo_CompanyInfo; "Bank Branch No.")
                {
                    IncludeCaption = true;

                }

                column(BankAccountNo_CompanyInfo; "Bank Account No.")
                {
                    IncludeCaption = true;

                }

                column(VatRegistrationNo_CompanyInfo; "VAT Registration No.")
                {
                    IncludeCaption = true;

                }

                column(RegistrationNo_CompanyInfo; "Registration No.")
                {
                    IncludeCaption = true;

                }

                column(Picture_CompanyInfo; "Picture")
                {
                    IncludeCaption = true;

                }

                column(PostCode_CompanyInfo; "Post Code")
                {
                    IncludeCaption = true;

                }

                column(County_CompanyInfo; "County")
                {
                    IncludeCaption = true;

                }

                column(EMail_CompanyInfo; "E-Mail")
                {
                    IncludeCaption = true;

                }

                /*                column(HomePage_CompanyInfo; "Home Page")
                                {
                                    IncludeCaption = true;

                                } */
                column(Country_CompanyInfo; "Country/Region Code")
                {
                    IncludeCaption = true;

                }

                column(Iban_CompanyInfo; "IBAN")
                {
                    IncludeCaption = true;

                }

                column(SwiftCode_CompanyInfo; "SWIFT Code")
                {
                    IncludeCaption = true;

                }

                column(RegisteredName_CompanyInfo; "Registered Name")
                {
                    IncludeCaption = true;

                }


                column(RegisteredName2_CompanyInfo; "Registered Name 2")
                {
                    IncludeCaption = true;

                }

                column(RegisteredAddress_CompanyInfo; "Registered Address")
                {
                    IncludeCaption = true;

                }

                column(RegisteredAddress2_CompanyInfo; "Registered Address 2")
                {
                    IncludeCaption = true;

                }

                column(RegisteredCity_CompanyInfo; "Registered City")
                {
                    IncludeCaption = true;

                }

                column(RegisteredCounty_CompanyInfo; "Registered County")
                {
                    IncludeCaption = true;

                }

                column(RegisteredPostCode_CompanyInfo; "Registered Post Code")
                {
                    IncludeCaption = true;

                }
            }

            // Sales Shipment Header dataitem Trigger
            trigger OnAfterGetRecord()
            begin

                //Initialise variables
                CLEAR(BillToAddressBlock);
                CLEAR(ShipToAddressBlock);
                CRLF[1] := 13;
                CRLF[2] := 10;
                NewLine := format(CRLF[1]) + format(CRLF[2]);

                // Place addresses into arrays and remove blank lines
                FormatAddr.SalesShptBillTo(BillToAddress, ShipToAddress, Header);
                FormatAddr.SalesShptShipTo(ShipToAddress, Header);

                // Convert arrays to address blocks
                for i := 1 to 8 do begin
                    //Bill-to
                    if BillToAddress[i] <> '' then BillToAddressBlock += BillToAddress[i];
                    if BillToAddress[i + 1] <> '' then BillToAddressBlock += NewLine;
                    //Ship-to
                    if ShipToAddress[i] <> '' then ShipToAddressBlock += ShipToAddress[i];
                    if ShipToAddress[i + 1] <> '' then ShipToAddressBlock += NewLine;
                end;
            end;

        }
    }



    var
        BillToAddressBlock, ShipToAddressBlock : Text;
        BillToAddress, ShipToAddress : Array[9] of Text;
        FormatAddr: Codeunit "Format Address";
        i: Integer;
        CRLF: array[2] of Char;
        NewLine: Text;
        SerialNos: Text;
        QtyToFollow: Decimal;
        QtyOrdered: Decimal;
        ItemLedgerEntry: Record "Item Ledger Entry";
        SalesLine: Record "Sales Line";
        UNNumberPrintText: Text;
        UNSubsid1Txt: Text;
        UNSubsid2Txt: Text;
}