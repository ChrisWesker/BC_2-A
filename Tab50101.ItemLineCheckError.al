table 50101 ItemLineCheckError
{
    Caption = 'ItemLineCheckError';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(3; "Parent Iten No."; code[20])
        {
            Caption = 'Parent Iten No';
        }

        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
        }
        field(6; "Level"; Code[1])
        {
            Caption = 'Level';
            Width = 2;
        }
        field(7; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
        }
        field(8; "Check Item"; Boolean)

        {
            Caption = 'Check Item';
        }
    }

    keys
    {
        key(PK; /*"Date",*/ "Line No.", "No.", Level, "Currency Code")
        {
            Clustered = true;
        }
    }
}
