page 50101 ItemLineCheckErrorList
{
    ApplicationArea = All;
    Caption = 'ItemLineCheckErrorList';
    PageType = List;
    SourceTable = ItemLineCheckError;
    SourceTableView = sorting("Line No.", "No.") order(descending);
    UsageCategory = Lists;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Line No."; rec."Line No.")
                {

                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Parent Iten No."; rec."Parent Iten No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field(Level; rec.Level)
                {
                    ToolTip = 'Specifies the value of the Level.';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the value of the Unit Price field.';
                }
                field("Check Item"; rec."Check Item")
                {
                    ToolTip = 'Specifies the value of the Check Item field.';
                    Editable = false;
                }
            }
        }
    }

    // var
    //     "Check Item": Boolean;

}
