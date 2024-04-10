pageextension 50108 "ARCO Ext. Item List_copy_test" extends "Item List"
{
    PromotedActionCategories = 'New,Process,Report,Item,History,Prices & Discounts,Request Approval,Periodic Activities,Inventory,Attributes,ARCO';

    actions
    {
        addlast("ARCO Action")
        {
            action("ARCO Calc. Item Sales Level Price_CheckLine")
            {
                // ApplicationArea = All;
                // Caption = 'Caption', comment = 'NLB="YourLanguageCaption"';
                // Promoted = true;
                // PromotedCategory = Process;
                // PromotedIsBig = true;
                // Image = Image;

                // trigger OnAction()
                // begin

                // end;

                ApplicationArea = All;
                Caption = 'Calc. Item Sales Price_CheckLine';
                Image = Calculate;
                // Promoted = true;
                // PromotedCategory = Category11;
                // PromotedIsBig = true;

                trigger OnAction();
                var
                    lRec_Item: Record Item;
                    lRpt_CalcItemSalesPrice: Report "ARCo Calc. Item Sales Price_";
                begin
                    lRec_Item.RESET;
                    lRec_Item.SETRANGE("No.", Rec."No.");
                    //20210627 Modify by Renee ------------------- <<
                    //Report.RUN(50005, TRUE, TRUE, lRec_Item);
                    CLEAR(lRpt_CalcItemSalesPrice);
                    lRpt_CalcItemSalesPrice.SetAdjustDate(Today);
                    lRpt_CalcItemSalesPrice.SetTableView(lRec_Item);
                    lRpt_CalcItemSalesPrice.RUN;
                    //20210627 Modify by Renee ------------------- >>
                end;
            }

            action("ArcoCalc.Item Level Prcie_checkAllLine")
            {
                ApplicationArea = all;
                Caption = 'ArcoCalc.Item Level Prcie_CheckAllLine';
                Image = Price;
                RunObject = page ItemLineCheckErrorList;
                RunPageLink = "No." = field("No.");
            }

            // action("ArcoCalc.Item Level Prcie_UpdateLine")
            // {
            //     ApplicationArea = all;
            //     Caption = 'ArcoCalc.Item Level Prcie_UpdateLine';
            //     Image = Price;
            //     RunObject = page ItemLineCheckErrorList_update;
            //     RunPageLink = "No." = field("No.");
            // }
        }

    }
}
