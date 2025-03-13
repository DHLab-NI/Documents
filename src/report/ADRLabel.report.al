// DH Lab ADR Label
// SGH 12/03/25
report 50188 "DHLab ADR Label"
{
    //    UsageCategory = Administration;
    //    ApplicationArea = All;
    DefaultLayout = Word;
    WordLayout = '50188_DHLab_ADR_Label.docx';

    dataset
    {
        dataitem("Sales Shipment Line"; "Sales Shipment Line")
        {
            // Specify sort order (not required for a single document report)
            DataItemTableView = Sorting("Document No.", "Line No.");
            // Include the "No." field on the filter tab of the request page.
            RequestFilterFields = "No.";

            column(No; "No.")
            {
                IncludeCaption = true;
            }

            column(Document_No; "Document No.")
            {
                IncludeCaption = true;
            }

            column(Description; Description)
            {
                IncludeCaption = true;

            }

            column(Description_2; "Description 2")
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

            // Posted Sales Shipment Line
            trigger OnAfterGetRecord()
            begin

            end;

        }
    }

    // These labels will be used later as captions in the report layout.  
    labels
    {
        ADR_Label_Caption = 'DH Lab Shipping Label';
    }

    var
        UNNumberPrintText: Text;
        UNSubsid1Txt: Text;
        UNSubsid2Txt: Text;
}