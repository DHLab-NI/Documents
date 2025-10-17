// DHLab Quotation
// SGH 26/02/2025
report 50185 "DHLab Quotation"
{
    //Make the report searchable from Tell me under the Administration category.
    //UsageCategory = Administration;
    //ApplicationArea = All;
    //Caption="DHLab Quotation";
    //
    DefaultLayout = Word;
    // Specify the name of the file that the report will use for the layout.
    WordLayout = '50104_DHLab_Quotation.docx';

    dataset
    {

        dataitem(Header; "Sales Header")
        {
            // Specify sort order (not required for a single document report)
            DataItemTableView = Sorting("No.");
            // Include the "No." field on the filter tab of the request page.
            RequestFilterFields = "No.";

            column(No_Header; "No.")
            {
                IncludeCaption = true;

            }

            column(VersionNo_Header; VersionNo)
            {
            }
            column(DocumentNoVersion_Header; DocumentNoVersion)
            {
            }
            column(BillToCustomerNo_Header; "Bill-to Customer No.")
            {
                IncludeCaption = true;
            }

            column(BillToName_Header; "Bill-to Name")
            {
            }

            column(BillToContact_Header; "Bill-to Contact")
            {
            }

            column(ShipToName_Header; "Ship-to Name")
            {
            }

            column(ShipToContact_Header; "Ship-to Contact")
            {
            }

            column(SellToName_Header; "Sell-to Customer Name")
            {
            }

            column(SellToContact_Header; "Sell-to Contact")
            {
            }

            column(PaymentTermsCode_Header; "Payment Terms Code")
            {
            }

            column(PromDelDate_Header; format("Promised Delivery Date", 0, '<day,2>/<month,2>/<year4>'))
            {
            }
            column(Currency_Header; Currency)
            {
                //Caption = 'Currency';
            }

            column(SalespersonCode_Header; "Salesperson Code")
            {
                IncludeCaption = true;

            }

            column(Amount_Header; "Amount")
            {
                IncludeCaption = true;

            }

            column(AmountIncludingVat_Header; "Amount Including VAT")
            {
                IncludeCaption = true;

            }

            column(OrderDate_Header; format("Order Date", 0, '<day,2>/<month,2>/<year4>'))
            {
            }

            column(Document_Date; format("Document Date", 0, '<day,2>/<month,2>/<year4>'))
            {
            }

            column(ValidToDate_Header; "Quote Valid Until Date")
            {
            }

            column(ExternalDocumentNo_Header; "External Document No.")
            {
                IncludeCaption = true;

            }

            //            column(TotalExclVAT_Header; TotalExclVAT)
            //            {
            //            }
            //
            column(TotalVAT_Header; TotalVAT)
            {
            }

            //            column(TotalInclVAT_Header; TotalInclVAT)
            //            {
            //            }
            //
            column(BillToAddressBlock_Header; BillToAddressBlock)
            {
            }

            column(ShipToAddressBlock_Header; ShipToAddressBlock)
            {
            }

            column(SellToAddressBlock_Header; SellToAddressBlock)
            {
            }

            dataitem(Line; "Sales Line")
            {

                DataItemTableView = sorting("Line No.");
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

                column(GrossUnitPrice_Line; "Unit Price")
                {
                    IncludeCaption = true;

                }

                column(UnitPrice_Line; NetUnitPrice)
                {
                    //Caption = 'Unit Price';

                }

                column(VatPC_Line; "VAT %")
                {
                    IncludeCaption = true;

                }

                column(LineDiscountPC_Line; "Line Discount %")
                {
                    IncludeCaption = true;

                }

                column(LineDiscountAmount_Line; "Line Discount Amount")
                {
                    IncludeCaption = true;

                }
                column(Amount_Line; "Amount")
                {
                    IncludeCaption = true;

                }

                column(AmountIncludingVat_Line; "Amount Including VAT")
                {
                    IncludeCaption = true;

                }

                column(LineAmount_Line; "Line Amount")
                {
                    IncludeCaption = true;

                }
                column(VATAmount_Line; LineVAT)
                {
                }

                //VENDOR ID INCLUSION - Reuben @14:55 07-04-21
                dataitem(Item; Item)
                {
                    DataItemLink = "No." = field("No.");
                    column(Vendor_Item_No_; "Vendor Item No.")
                    {
                        IncludeCaption = true;
                    }
                }

                // Sales Line dataitem Trigger
                trigger OnAfterGetRecord()
                begin

                    //Calculate Total Invoice VAT Amount
                    LineVAT := Line."Amount Including VAT" - Line."Line Amount";

                    //Calculate Net Unit Price
                    NetUnitPrice := 0;
                    if (Quantity > 0) or (Quantity < 0) then begin
                        NetUnitPrice := (Amount / Quantity);
                    end else begin
                        NetUnitPrice := 0;
                    end;

                end;

            }


            dataitem(PayTerms; "Payment Terms")
            {

                DataItemLink = "Code" = field("Payment Terms Code");

                column(Description_PayTerms; "Description")
                {
                    IncludeCaption = true;

                }

            }

            // Sales Header dataitem Trigger
            trigger OnAfterGetRecord()
            begin

                //Initialise variables
                CLEAR(BillToAddressBlock);
                CLEAR(ShipToAddressBlock);
                CLEAR(SellToAddressBlock);
                CRLF[1] := 13;
                CRLF[2] := 10;
                NewLine := format(CRLF[1]) + format(CRLF[2]);
                Currency := '';

                // Set currency (blank = GBP)

                If ("Currency Code" = '') then
                    Currency := 'GBP' else
                    Currency := "Currency Code";

                // Place addresses into arrays and remove blank lines
                FormatAddr.SalesHeaderBillTo(BillToAddress, Header);
                FormatAddr.SalesHeaderSellTo(SellToAddress, Header);
                FormatAddr.SalesHeaderShipTo(ShipToAddress, BillToAddress, Header);
                // Convert arrays to address blocks
                for i := 1 to 8 do begin
                    //Bill-to
                    if BillToAddress[i] <> '' then BillToAddressBlock += BillToAddress[i];
                    if BillToAddress[i + 1] <> '' then BillToAddressBlock += NewLine;

                    //Ship-to
                    if ShipToAddress[i] <> '' then ShipToAddressBlock += ShipToAddress[i];
                    if ShipToAddress[i + 1] <> '' then ShipToAddressBlock += NewLine;

                    //Sell-to
                    if SellToAddress[i] <> '' then SellToAddressBlock += SellToAddress[i];
                    if SellToAddress[i + 1] <> '' then SellToAddressBlock += NewLine;
                end;

                //Calculate Total Invoice VAT Amount
                TotalVAT := Header."Amount Including VAT" - Header.Amount;

                //Calculate version number
                CalcFields("No. of Archived Versions");
                VersionNo := "No. of Archived Versions" + 1;
                DocumentNoVersion := Format("No.") + '-' + Format(VersionNo);

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

            column(HomePage_CompanyInfo; "Home Page")
            {
                IncludeCaption = true;

            }
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

    }

    // Variables for totals calculation



    // These labels will be used later as captions in the report layout.  
    labels
    {
        SalesQuotation_Document_Caption = 'Sales Quotation';
    }

    var
        TotalVAT: Decimal;
        LineVAT: Decimal;
        NetUnitPrice: Decimal;
        BillToAddressBlock, ShipToAddressBlock, SellToAddressBlock : Text;
        BillToAddress, ShipToAddress, SellToAddress : Array[9] of Text;
        FormatAddr: Codeunit "Format Address";
        i: Integer;
        CRLF: array[2] of Char;
        NewLine: Text;
        Currency: text;
        VersionNo: Integer;
        DocumentNoVersion: Text;
}