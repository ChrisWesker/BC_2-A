pageextension 50107 "ARCOExt PostSalesCreditMemos" extends "Posted Sales Credit Memos"
{

    layout
    {
        addafter("Currency Code")
        {
            field("External Document No."; rec."External Document No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }
}
