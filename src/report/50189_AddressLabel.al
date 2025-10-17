// DH Lab Address Label
// SGH 25/02/25
report 50189 "DHLab Address Label"
{
    UsageCategory = Documents;
    ApplicationArea = All;
    DefaultLayout = Word;
    WordLayout = '50189_DHLab_Address_Label.docx';

    dataset
    {
        dataitem(Header; "Sales Shipment Header")
        {
            // Specify sort order (not required for a single document report)
            DataItemTableView = Sorting("No.");
            // Include the "No." field on the filter tab of the request page.
            RequestFilterFields = "No.";

            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(SystemId); // Sorting by SystemId is required

                column(DocumentNo_Header; Header."No.")
                {
                    IncludeCaption = true;

                }
                column(OrderNo_Header; Header."Order No.")
                {
                    IncludeCaption = true;

                }
                column(ShipToName_Header; Header."Ship-to Name")
                {
                }

                column(ShipToName2_Header; Header."Ship-to Name 2")
                {
                }

                column(ShipToAddress_Header; Header."Ship-to Address")
                {
                }

                column(ShipToAddress2_Header; Header."Ship-to Address 2")
                {
                }

                column(ShipToCity_Header; Header."Ship-to City")
                {
                }

                column(ShipToContact_Header; Header."Ship-to Contact")
                {
                }

                column(ShipToPostCode_Header; Header."Ship-to Post Code")
                {
                }

                column(ShipToCounty_Header; Header."Ship-to County")
                {
                }

                column(ShipToCountry_Header; Header."Ship-to Country/Region Code")
                {
                }

                column(DocumentDate_Header; format(Header."Document Date", 0, '<day,2>/<month,2>/<year4>'))
                {
                }

                column(ExternalDocumentNo_Header; Header."External Document No.")
                {
                    IncludeCaption = true;

                }

                column(ShipToAddressBlock_Header; ShipToAddressBlock)
                {
                }

                column(CopyNumber; CopyLoop.Number) { }  // Page X
                column(TotalCopies; MaxCopies) { }  // Page Y



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


                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, MaxCopies); // Dynamically create multiple copies
                end;

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
    }


    requestpage
    {
        layout
        {
            area(content)
            {
                field(NumberOfCopies; NumberOfCopies)
                {
                    ApplicationArea = All;
                    Caption = 'Number of Copies';
                    MinValue = 1;
                    MaxValue = 100;
                }
            }
        }
    }


    labels
    {
        ADR_Label_Caption = 'DH Lab Address Label';
    }


    trigger OnPreReport()
    begin
        MaxCopies := NumberOfCopies; // Assign user input to a local variable before processing
    end;

    var
        BillToAddressBlock, ShipToAddressBlock : Text;
        BillToAddress, ShipToAddress : Array[9] of Text;
        FormatAddr: Codeunit "Format Address";
        i: Integer;
        CRLF: array[2] of Char;
        NewLine: Text;
        NumberOfCopies: Integer;
        MaxCopies: Integer;
}