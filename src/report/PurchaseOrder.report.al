// DHLab Purchase Order (based on Lisclare PO)
// SGH 26/02/2025
report 50181 "DHLab Purchase Order"
{
    //Make the report searchable from Tell me under the Administration category.
    //UsageCategory = Administration;
    //ApplicationArea = All;
    //Caption="DH Lab Purchase Order";
    //
    DefaultLayout = Word;
    // Specify the name of the file that the report will use for the layout.
    WordLayout = '50181_DHLab_Purchase_Order.docx';

    dataset
    {

        dataitem(Header; "Purchase Header")
        {
            // Specify sort order (not required for a single document report)
            DataItemTableView = Sorting("No.");
            // Include the "No." field on the filter tab of the request page.
            RequestFilterFields = "No.";

            column(No_Header; "No.")
            {
                IncludeCaption = true;

            }

            column(BuyFromVendorNo_Header; "Buy-from Vendor No.")
            {
                IncludeCaption = true;
            }

            column(BuyFromVendorName_Header; "Buy-from Vendor Name")
            {
                IncludeCaption = true;
            }

            column(BuyFromContact_Header; "Buy-from Contact")
            {
                IncludeCaption = true;
            }

            column(PayToVendorNo_Header; "Pay-to Vendor No.")
            {
                IncludeCaption = true;
            }

            column(PayToName_Header; "Pay-to Name")
            {
                IncludeCaption = true;
            }

            column(PaytoContact_Header; "Pay-to Contact")
            {
                IncludeCaption = true;
            }

            column(ShipToCode_Header; "Ship-to Code")
            {
                IncludeCaption = true;
            }

            column(ShipToName_Header; "Ship-to Name")
            {
                IncludeCaption = true;
            }

            column(ShipToContact_Header; "Ship-to Contact")
            {
                IncludeCaption = true;
            }

            column(PaymentTermsCode_Header; "Payment Terms Code")
            {
                IncludeCaption = true;
            }

            column(ShipmentMethodCode_Header; "Shipment Method Code")
            {
                IncludeCaption = true;
            }

            column(ExpRcptDate_Header; format("Expected Receipt Date", 0, '<day,2>/<month,2>/<year4>'))
            {
            }
            column(Currency_Header; Currency)
            {
                //Caption = 'Currency';
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

            column(YourRef_Header; "Your Reference")
            {
                IncludeCaption = true;

            }

            column(TotalVAT_Header; TotalVAT)
            {
            }

            column(PayToAddressBlock_Header; PayToAddressBlock)
            {
            }

            column(BuyFromAddressBlock_Header; BuyFromAddressBlock)
            {
            }

            column(ShipToAddressBlock_Header; ShipToAddressBlock)
            {
            }

            dataitem(Line; "Purchase Line")
            {

                DataItemTableView = sorting("Line No.");
                DataItemLink = "Document No." = field("No.");

                column(No_Line; "No.")
                {
                    IncludeCaption = true;

                }

                column(VendorItemNo; "Vendor Item No.")
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

                column(UnitOfMeasureCode_Line; "Unit of Measure Code")
                {
                    IncludeCaption = true;

                }

                column(Quantity_Line; "Quantity")
                {
                    IncludeCaption = true;

                }

                column(GrossUnitPrice_Line; "Unit Cost")
                {
                    IncludeCaption = true;

                }

                column(NetUnitCost_Line; NetUnitCost)
                {
                    //Caption = 'Unit Cost';

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

                // Purchase Line dataitem Trigger
                trigger OnAfterGetRecord()
                begin

                    //Calculate Total Invoice VAT Amount
                    LineVAT := Line."Amount Including VAT" - Line."Line Amount";

                    //Calculate Net Unit Price
                    NetUnitCost := 0;
                    if (Quantity > 0) or (Quantity < 0) then begin
                        NetUnitCost := (Amount / Quantity);
                    end else begin
                        NetUnitCost := 0;
                    end;

                end;

            }

            dataitem(Vendor; Vendor)
            {

                DataItemLink = "No." = field("Buy-from Vendor No.");

                column(OurAccountNo; "Our Account No.")
                {
                    IncludeCaption = True;
                }
            }

            dataitem(SalesPurchaser; "Salesperson/Purchaser")
            {

                DataItemLink = "Code" = field("Purchaser Code");

                column(Purchaser; Name)
                {
                    IncludeCaption = True;
                }
            }

            dataitem(PayTerms; "Payment Terms")
            {

                DataItemLink = "Code" = field("Payment Terms Code");

                column(Description_PayTerms; "Description")
                {
                    IncludeCaption = true;

                }

            }

            //Added for Jonny- Reuben 28/09/2022

            dataitem(SKU; "Stockkeeping Unit")
            {
                // Link Item No. and location to SKU record
                DataItemLink = "Item No." = field("No."), "Location Code" = field("Location Code");
                column(SKU_Shelf_No; "Shelf No.")
                {
                    IncludeCaption = true;
                }
            }

            // Purchase Header dataitem Trigger
            trigger OnAfterGetRecord()
            begin

                //Initialise variables
                CLEAR(BuyFromAddressBlock);
                CLEAR(ShipToAddressBlock);
                CLEAR(PayToAddressBlock);
                CRLF[1] := 13;
                CRLF[2] := 10;
                NewLine := format(CRLF[1]) + format(CRLF[2]);
                Currency := '';

                // Set currency (blank = GBP)

                If ("Currency Code" = '') then
                    Currency := 'GBP' else
                    Currency := "Currency Code";

                // Place addresses into arrays and remove blank lines
                FormatAddr.PurchHeaderBuyFrom(BuyFromAddress, Header);
                FormatAddr.PurchHeaderShipTo(ShipToAddress, Header);
                FormatAddr.PurchHeaderPayTo(PayToAddress, Header);
                // Convert arrays to address blocks
                for i := 1 to 8 do begin
                    //Buy-From
                    if BuyFromAddress[i] <> '' then BuyFromAddressBlock += BuyFromAddress[i];
                    if BuyFromAddress[i + 1] <> '' then BuyFromAddressBlock += NewLine;

                    //Ship-to
                    if ShipToAddress[i] <> '' then ShipToAddressBlock += ShipToAddress[i];
                    if ShipToAddress[i + 1] <> '' then ShipToAddressBlock += NewLine;

                    //Pay-to
                    if PayToAddress[i] <> '' then PayToAddressBlock += PayToAddress[i];
                    if PayToAddress[i + 1] <> '' then PayToAddressBlock += NewLine;
                end;

                //Calculate Total Invoice VAT Amount
                TotalVAT := Header."Amount Including VAT" - Header.Amount;

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

            column(CompanyAddressBlock_CompanyInfo; CompanyAddressBlock)
            {
            }

            // Company Info dataitem Trigger
            trigger OnAfterGetRecord()
            begin

                //Initialise variables
                CLEAR(CompanyAddressBlock);
                CRLF[1] := 13;
                CRLF[2] := 10;
                NewLine := format(CRLF[1]) + format(CRLF[2]);

                // Place addresses into arrays and remove blank lines
                FormatAddr.Company(CompanyAddress, CompanyInfo);
                // Convert arrays to address blocks
                for i := 1 to 8 do begin
                    //Bill-to
                    if CompanyAddress[i] <> '' then CompanyAddressBlock += CompanyAddress[i];
                    if CompanyAddress[i + 1] <> '' then CompanyAddressBlock += NewLine;
                end;
            end;

        }

    }

    // Variables for totals calculation



    // These labels will be used later as captions in the report layout.  
    labels
    {
        Purchase_Document_Caption = 'Purchase Order';
    }

    var
        TotalVAT: Decimal;
        LineVAT: Decimal;
        NetUnitCost: Decimal;
        PayToAddressBlock, BuyFromAddressBlock, ShipToAddressBlock, CompanyAddressBlock : Text;
        PayToAddress, BuyFromAddress, ShipToAddress, CompanyAddress : Array[9] of Text;
        FormatAddr: Codeunit "Format Address";
        i: Integer;
        CRLF: array[2] of Char;
        NewLine: Text;
        Currency: text;
}