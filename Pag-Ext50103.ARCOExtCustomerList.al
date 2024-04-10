pageextension 50103 ARCOExtCustomerList extends "Customer List"
{
    layout
    {
        addbefore("Location Code")
        {
            field("Global Dimension 2 Code"; rec."Global Dimension 2 Code")
            {
                //Caption ='';
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}
