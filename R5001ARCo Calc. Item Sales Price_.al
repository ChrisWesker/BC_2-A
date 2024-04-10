report 50101 "ARCo Calc. Item Sales Price_"
{
    Caption = 'Calc. Item Sales Level Price_CheckLine';
    //ProcessingOnly = true;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report Layout\ARCO Calc Item Sales Level1.rdl';

    dataset
    {
        dataitem(Item; Item)
        {
            // 2021.06.28 Modify by Frank
            // RequestFilterFields = "No.", "Item Category Code";
            // 2023.03.23 Add new filters - Steven

            RequestFilterFields = "No.", "Item Category Code", "Vendor No.", "ARCO Created Date", "ARCO Last Date Adjusted";
            DataItemTableView = where("ARCO Do Not Adjust Sales Price" = CONST(false));

            trigger OnAfterGetRecord()
            var
                IsHandled: Boolean;
                lRec_BOMComp: Record "BOM Component";
                lRec_BOMComp2: Record "BOM Component";
                lRec_BOMComp3: Record "BOM Component";
                Itemlinecheck: Record ItemLineCheckError;
                Item_SalesPrice: Record "ARCO Item Sales Level Price";
                Item_Currency: Record Currency;
                Rec_PurchPrice: Record "Purchase Price";
                ArcoSalesLevelPriceSetip: Record "ARCO Sales Level Price Setup";
                ii: Integer;
                lASCII: Char;
            begin
                // << chris add for check update in item sales price

                lRec_BOMComp.SetRange(Type, lRec_BOMComp.Type::Item);
                lRec_BOMComp.SetRange("No.", Item."No.");
                Item_currency.SetRange("ARCO Sales Level Price Calc.", true);
                Item.CalcFields("Assembly BOM");
                IF CurrencyFilter <> '' then
                    Item_currency.SetFilter(Code, CurrencyFilter);

                if Item.Get("No.") then begin
                    if (Item."Assembly BOM" = false) and (item."Vendor No." <> '') then begin  // 抓料號，有指定供應商，無Bom(料號是子件及對應其他母件)
                        if Item_currency.FindSet() then   // 篩出 料號自己及幣別
                            repeat

                                for ii := 1 to 35 do begin   // 迴圈排序level
                                    IF ii <= 9 then
                                        itemlinecheck.Level := Format(ii)
                                    else begin
                                        lASCII := ii + 55;
                                        itemlinecheck.Level := lASCII;
                                    end;

                                    if (ArcoSalesLevelPriceSetip.Get(Itemlinecheck.Level) and (ArcoSalesLevelPriceSetip."Level 1" > 0)) then begin
                                        Itemlinecheck."No." := Item."No.";

                                        itemlinecheck."Parent Iten No." := lRec_BOMComp."Parent Item No.";
                                        //itemlinecheck.Date := lRec_BOMComp."ARCO Modified Date";
                                        itemlinecheck."Currency Code" := Item_currency.Code;
                                        itemlinecheck."Line No." := itemlinecheck."Line No." + 1;
                                        itemlinecheck.Insert();
                                    end;
                                end;
                            until Item_currency.Next() = 0;

                        if lRec_BOMComp.Findset() then     // 篩出 料號對應的母件及幣別
                            repeat
                                if Item_currency.FindSet() then
                                    repeat

                                        for ii := 1 to 35 do begin   // 迴圈排序level
                                            IF ii <= 9 then
                                                itemlinecheck.Level := Format(ii)
                                            else begin
                                                lASCII := ii + 55;
                                                itemlinecheck.Level := lASCII;
                                            end;

                                            if (ArcoSalesLevelPriceSetip.Get(Itemlinecheck.Level) and (ArcoSalesLevelPriceSetip."Level 1" > 0)) then begin
                                                Itemlinecheck."No." := Item."No.";


                                                itemlinecheck."Parent Iten No." := lRec_BOMComp."Parent Item No.";
                                                //itemlinecheck.Date := lRec_BOMComp."ARCO Modified Date";
                                                itemlinecheck."Currency Code" := Item_currency.Code;
                                                itemlinecheck."Line No." := itemlinecheck."Line No." + 1;
                                                itemlinecheck.Insert();
                                            end;
                                        end;
                                    until Item_currency.Next() = 0
                                until lRec_BOMComp.Next() = 0;
                    end;

                end;
                if Item.Get("No.") then begin
                    if (Item."Assembly BOM" = false) and (item."Vendor No." = '') then begin  // 抓料號，無指定供應商，無Bom
                        if Item_currency.FindSet() then   // 篩出 料號自己及幣別
                            repeat

                                for ii := 1 to 35 do begin   // 迴圈排序level
                                    IF ii <= 9 then
                                        itemlinecheck.Level := Format(ii)
                                    else begin
                                        lASCII := ii + 55;
                                        itemlinecheck.Level := lASCII;
                                    end;

                                    if (ArcoSalesLevelPriceSetip.Get(Itemlinecheck.Level) and (ArcoSalesLevelPriceSetip."Level 1" > 0)) then begin
                                        Itemlinecheck."No." := Item."No.";

                                        itemlinecheck."Parent Iten No." := lRec_BOMComp."Parent Item No.";
                                        //itemlinecheck.Date := lRec_BOMComp."ARCO Modified Date";
                                        itemlinecheck."Currency Code" := Item_currency.Code;
                                        itemlinecheck."Line No." := itemlinecheck."Line No." + 1;
                                        itemlinecheck.Insert();
                                    end;
                                end;
                            until Item_currency.Next() = 0;

                        if lRec_BOMComp.Findset() then     // 篩出 料號對應的母件及幣別
                            repeat
                                if Item_currency.FindSet() then
                                    repeat

                                        for ii := 1 to 35 do begin   // 迴圈排序level
                                            IF ii <= 9 then
                                                itemlinecheck.Level := Format(ii)
                                            else begin
                                                lASCII := ii + 55;
                                                itemlinecheck.Level := lASCII;
                                            end;

                                            if (ArcoSalesLevelPriceSetip.Get(Itemlinecheck.Level) and (ArcoSalesLevelPriceSetip."Level 1" > 0)) then begin
                                                Itemlinecheck."No." := Item."No.";


                                                itemlinecheck."Parent Iten No." := lRec_BOMComp."Parent Item No.";
                                                //itemlinecheck.Date := lRec_BOMComp."ARCO Modified Date";
                                                itemlinecheck."Currency Code" := Item_currency.Code;
                                                itemlinecheck."Line No." := itemlinecheck."Line No." + 1;
                                                itemlinecheck.Insert();
                                            end;
                                        end;
                                    until Item_currency.Next() = 0
                                until lRec_BOMComp.Next() = 0;
                    end;

                end;

                if Item.Get("No.") then begin  // 抓料號，沒有指定供應商，有Bom(料號是母件，對應多個子件?)
                    if (Item."Assembly BOM") and (Item."Vendor No." = '') then begin
                        if Item_currency.FindSet() then   // 篩出 料號自己及幣別
                            repeat

                                for ii := 1 to 35 do begin   // 迴圈排序level
                                    IF ii <= 9 then
                                        itemlinecheck.Level := Format(ii)
                                    else begin
                                        lASCII := ii + 55;
                                        itemlinecheck.Level := lASCII;
                                    end;

                                    if (ArcoSalesLevelPriceSetip.Get(Itemlinecheck.Level) and (ArcoSalesLevelPriceSetip."Level 1" > 0)) then begin
                                        Itemlinecheck."No." := Item."No.";

                                        itemlinecheck."Parent Iten No." := item."No.";
                                        //itemlinecheck.Date := lRec_BOMComp."ARCO Modified Date";
                                        itemlinecheck."Currency Code" := Item_currency.Code;
                                        itemlinecheck."Line No." := itemlinecheck."Line No." + 1;
                                        itemlinecheck.Insert();
                                    end;
                                end;
                            until Item_currency.Next() = 0;
                    end;
                end;

                if Item.Get("No.") then begin  // 抓料號，有指定供應商，有Bom(料號是母件，對應多個子件?)
                    if (Item."Assembly BOM") and (Item."Vendor No." <> '') then begin
                        if Item_currency.FindSet() then   // 篩出 料號自己及幣別
                            repeat

                                for ii := 1 to 35 do begin   // 迴圈排序level
                                    IF ii <= 9 then
                                        itemlinecheck.Level := Format(ii)
                                    else begin
                                        lASCII := ii + 55;
                                        itemlinecheck.Level := lASCII;
                                    end;

                                    if (ArcoSalesLevelPriceSetip.Get(Itemlinecheck.Level) and (ArcoSalesLevelPriceSetip."Level 1" > 0)) then begin
                                        Itemlinecheck."No." := Item."No.";

                                        itemlinecheck."Parent Iten No." := item."No.";
                                        //itemlinecheck.Date := lRec_BOMComp."ARCO Modified Date";
                                        itemlinecheck."Currency Code" := Item_currency.Code;
                                        itemlinecheck."Line No." := itemlinecheck."Line No." + 1;
                                        itemlinecheck.Insert();
                                    end;
                                end;
                            until Item_currency.Next() = 0;
                    end;
                end;

                //   chris add for check update in item sales price >>

                if not HideValidationDialog then
                    Window.Update(1, "No.");

                if CheckItem("No.") then begin
                    //20210804 Modify by Renee -------------------------- <<
                    //無論是子件或是母件，只要有指定主要供應商，則視為採購件的計算方式(A)
                    //IF (GetPurch_RefPrice("No.", "Vendor No.", true) > 0) THEN begin
                    IF ("Vendor No." <> '') then begin
                        //20210804 Modify by Renee -------------------------- >>
                        CalcItemSalesPrice_withoutBOM("No.");
                    end else begin
                        lRec_BOMComp3.RESET;
                        lRec_BOMComp3.SETRANGE(Type, lRec_BOMComp3.Type::Item);
                        lRec_BOMComp3.SETRANGE("Parent Item No.", "No.");
                        IF lRec_BOMComp3.COUNT = 1 then
                            CalcItemSalesPrice_BOM_C("No.", '0')
                        else
                            CalcItemSalesPrice_withoutBOM("No.");
                    end;
                    //commit;
                    //20210627 Modify by Renee ---------------------- <<
                    //end;
                end else begin
                    //20210804 Modify by Renee -------------------------- <<
                    //無論是子件或是母件，只要有指定主要供應商，則視為採購件的計算方式(A)
                    //IF (GetPurch_RefPrice("No.", "Vendor No.", true) > 0) THEN begin
                    IF ("Vendor No." <> '') then begin
                        //20210804 Modify by Renee -------------------------- >>
                        SetItemSalesPriceToZero_withoutBOM("No.");
                    end else begin
                        lRec_BOMComp3.RESET;
                        lRec_BOMComp3.SETRANGE(Type, lRec_BOMComp3.Type::Item);
                        lRec_BOMComp3.SETRANGE("Parent Item No.", "No.");
                        IF lRec_BOMComp3.COUNT = 1 then
                            CalcItemSalesPrice_BOM_C("No.", '0')
                        else
                            SetItemSalesPriceToZero_withoutBOM("No.");
                    end;
                end;
                //20210627 Modify by Renee ---------------------- >>

            end;




            trigger OnPostDataItem()
            var
            begin
                if not HideValidationDialog then begin
                    Window.Close;
                    if ItemsBlocked then
                        Message(BlockedItemMsg);
                    Message(
                      StrSubstNo(LinesCreatedMsg, LineCreatedCount, LineUpdatedCount));
                end;

            end;

            trigger OnPreDataItem()

            var
                itemlinecheck: Record ItemLineCheckError;
            begin
                if not HideValidationDialog then
                    Window.Open(CalculatingLinesMsg + ItemNoMsg + ParentItemNoMsg);

                LineCreatedCount := 0;
                LineUpdatedCount := 0;
                ItemsBlocked := false;
                //AdjustDate := Today;  //2021.05.16 Mark by Renee for Issue Log Part2 客製第 16 項
                gTxt_Filters := Item.GetFilters;

                IF AdjustDate = 0D then AdjustDate := Today;
                message(format(AdjustDate));


                itemlinecheck.Reset();
                itemlinecheck.DeleteAll();
                rec_itemlinecheck_updateline.Reset();
                rec_itemlinecheck_updateline.DeleteAll();

            end;
        }
        dataitem(Integer; Integer)   //2021.05.16 Mark by Renee for Issue Log Part2 客製第 16 項

        {
            column(SalesLineBuffer_Doc; SalesLineBuffer."Document No.")
            {

            }
            column(SalesLineBuffer_ItemNo; SalesLineBuffer."No.")
            {

            }
            column(SalesLineBuffer_ItemCategory; SalesLineBuffer."Cross-Reference No.")
            {

            }
            column(SalesLineBuffer_Error; SalesLineBuffer."Error Message")
            {

            }
            column(gTxt_Filters; gTxt_Filters)
            {

            }

            trigger OnPreDataItem()
            var
                l_Count: Integer;
            begin
                SalesLineBuffer.reset;
                l_Count := 0;
                l_Count := SalesLineBuffer.COUNT;
                IF l_Count > 0 THEN BEGIN
                    SETRANGE(Number, 1, l_Count);
                END ELSE
                    //CurrReport.BREAK;
                    SETRANGE(Number, 1, 1);

            end;

            trigger OnAfterGetRecord()
            var
            begin
                IF Number = 1 THEN BEGIN
                    IF SalesLineBuffer.FINDFIRST THEN;
                END ELSE BEGIN
                    IF SalesLineBuffer.NEXT <> 0 THEN;
                END;
            end;

        }

    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    //2021.05.16 add by Renee for Issue Log Part 2 客製第 16 項 <<
                    Caption = 'Options';
                    field(AdjustDate; AdjustDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Adjust Date';
                    }
                    field(CurrencyCode; CurrencyFilter)
                    {
                        TableRelation = Currency where("ARCO Sales Level Price Calc." = const(true));
                        ApplicationArea = All;
                        Caption = 'Currency Filter';
                    }
                    field(SetToZero; SetToZero)
                    {
                        ApplicationArea = All;
                        Caption = 'Set To Zero';
                    }
                    //2021.05.16 add by Renee for Issue Log Part 2 客製第 16 項 >>
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            //AdjustDate := Today;  //2021.05.16 Mark by Renee for Issue Log Part2 客製第 16 項
        end;
    }

    labels
    {
        ReportTitle = 'Erorr List for Calculating Item Sales Price';
        FilterCaption = 'Filter:';
        ItemCategoryCaption = 'Item Category Code';
        ItemNoCaption = 'Item No.';
        ErrorMsgCaption = 'Error Message';
    }

    var
        CalculatingLinesMsg: Label 'Calculating the Item ...\\';
        ItemNoMsg: Label 'Item No.  #1##################', Comment = '%1 = Item No.';
        ParentItemNoMsg: Label 'Parent No.  #2##################';
        LinesCreatedMsg: Label '%1 new lines have been created.\%2 lines have been updated.', Comment = '%1 = counter';
        BlockedItemMsg: Label 'There is at least one blocked item that was skipped.';
        Window: Dialog;
        QtyExp: Decimal;
        LastItemLedgEntryNo: Integer;
        NextLineNo: Integer;
        LineCreatedCount: Integer;
        LineUpdatedCount: Integer;
        ItemsBlocked: Boolean;
        AdjustDate: Date;
        CurrencyFilter: Code[10];
        SetToZero: Boolean;
        SalesLineBuffer: Record "ARCO Sales Line Buffer" temporary;
        ErrorLineNo: Integer;
        gTxt_Filters: Text[250];
        // << chris test
        rec_itemlinecheck: Record ItemLineCheckError;
        rec_itemlinecheck_updateline: Record ItemLineCheckError_updateline;
    //     chris test >>
    protected var
        HideValidationDialog: Boolean;


    procedure SetHideValidationDialog(NewHideValidationDialog: Boolean)
    begin
        HideValidationDialog := NewHideValidationDialog;
    end;

    //20210627 add by Renee <<
    procedure SetAdjustDate(pAdjustDate: Date)
    begin
        AdjustDate := pAdjustDate;
    end;
    //20210627 add by Renee >>

    //2021.05.16 add by Renee for Issue Log Part2 客製第 16 項
    procedure CheckItem(p_ItemNo: Code[20]) result: Boolean
    var
        lRec_Item: Record Item;
        lRec_BOMComp: Record "BOM Component";
        lRec_Item2: Record Item;
        lRec_PurchPrice: Record "Purchase Price";
        lBaseQty: Integer;
        lCode_BaseQty: Code[1];
        lRec_ARCOSalesPriceSetup: Record "ARCO Sales Level Price Setup";
        lRec_Vendor: Record Vendor;
        lRec_ItemCategory: Record "Item Category";    //20210804 add by Renee
        lMsg_BlockedItem: Label 'The Item has been blocked.';
        lMsg_ItemVendor: Label 'The Vendor No. is empty in the Item Card.';
        lMsg_ItemCate: Label 'The Item Category Code is empty in the Item Card.';
        lMsg_PurchPrice: Label 'The Purchase Price can not be found.';
        lMsg_PurchPrice_Ref: Label 'The Purchase Reference Price is 0.';
        lMsg_BaseQty: Label 'The Base Qty must be equal to number 1 to 9, please confirm the position (%1) of the Item No.';
        lMsg_BaseQty0: Label 'The Base Qty must be greater than 0';
        lMsg_ParentBOM: Label 'The Assembly Policy must be "Assemble-to-Order".';
        lMsg_ParetBOMnoBOM: Label 'The Assembly BOM can not be found.';
        lMsg_BOMLineType: Label 'The Type (%1) of the BOM Line must be "Item".';
        lMsg_BOMLineItem: Label 'The Item (%1) of the BOM Line does not exist in the Item Card.';
        lMsg_BOMLineVendor: Label 'The Vendor No. is empty in the Item Card of the BOM Component (%1).';
        //lMsg_BOMLinePurchPrice: Label 'The Purchase Price can not be found of the BOM Component (%1).';
        lMsg_BOMLinePurchPrice: Label 'The Purchase Price can not be found of the BOM Component (%1) or more than one.';  //上線後需求變更 4-1 20211012 Modify by Renee
        lMsg_BOMLineBlockedItem: Label 'The Item has been blocked of the BOM Component (%1).';
        lMsg_BOMLineItemCate: Label 'The Item Category Code is empty in the Item Card of the BOM Component (%1).';
    begin
        CLEAR(lRec_ItemCategory);  //20210804 add by Renee

        lRec_Item.GET(p_ItemNo);

        IF lRec_Item.Blocked then begin
            InsertErrorList(p_ItemNo, lRec_Item."Item Category Code", lMsg_BlockedItem);
            exit(false);
        end;
        //料品分類代碼必須要有值
        IF lRec_Item."Item Category Code" = '' THEN begin
            InsertErrorList(p_ItemNo, lRec_Item."Item Category Code", lMsg_ItemCate);
            exit(false);
            //20210804 Modify by Renee ---------------------------------------- <<
            //end;
        end else begin
            IF lRec_ItemCategory.GET(lRec_Item."Item Category Code") then;
        end;
        //20210804 Modify by Renee ---------------------------------------- >>

        //20210804 add by Renee --------------------------------- <<
        //當料品分類代碼設定為不做單位轉換時，則第一次計算也不除以缸數(所以將 缸數設定為 1)
        IF NOT lRec_ItemCategory."ARCO Unit Transform" THEN
            lBaseQty := 1
        ELSE BEGIN
            //20210804 add by Renee --------------------------------- >>
            //lBaseQty 缸數
            lRec_ARCOSalesPriceSetup.GET(' ');

            IF lRec_Item."ARCO Unit Qty. Of Packing" <> 0 then
                lBaseQty := lRec_Item."ARCO Unit Qty. Of Packing"
            ELSE begin
                lCode_BaseQty := CopyStr(lRec_Item."No.", lRec_ARCOSalesPriceSetup."The Position of Item No.", 1);
                CASE lCode_BaseQty OF
                    '1', '2', '3', '4', '5', '6', '7', '8', '9':
                        BEGIN
                            EVALUATE(lBaseQty, CopyStr(lRec_Item."No.", lRec_ARCOSalesPriceSetup."The Position of Item No.", 1));
                        END;
                    ELSE BEGIN
                        InsertErrorList(p_ItemNo, lRec_Item."Item Category Code", STRSUBSTNO(lMsg_BaseQty, lRec_ARCOSalesPriceSetup."The Position of Item No."));
                        exit(false);
                    END;
                END;
            END;
        END;   //20210804 add by Renee

        IF lBaseQty = 0 then begin
            InsertErrorList(p_ItemNo, lRec_Item."Item Category Code", lMsg_BaseQty0);
            exit(false);
        end;

        //20210804 Modify by Renee ---------------------------------- <<
        //母件有指定主要供應商時，則無需判斷子件的資訊
        //IF lRec_Item."Replenishment System" = lRec_Item."Replenishment System"::Assembly THEN begin
        IF (lRec_Item."Replenishment System" = lRec_Item."Replenishment System"::Assembly) and
           (lRec_Item."Vendor No." = '') THEN begin
            //20210804 Modify by Renee ---------------------------------- >>      
            //母件設定不正確
            IF lRec_Item."Assembly Policy" <> lRec_Item."Assembly Policy"::"Assemble-to-Order" then begin
                InsertErrorList(p_ItemNo, lRec_Item."Item Category Code", lMsg_ParentBOM);
                exit(false);
            end;

            lRec_BOMComp.RESET;
            lRec_BOMComp.SETRANGE(Type, lRec_BOMComp.Type::Item);
            lRec_BOMComp.SETRANGE("Parent Item No.", p_ItemNo);
            IF lRec_BOMComp.FindSet() then begin
                repeat
                    IF (lRec_BOMComp.Type <> lRec_BOMComp.Type::Item) then begin
                        InsertErrorList(p_ItemNo, lRec_Item."Item Category Code", STRSUBSTNO(lMsg_BOMLineType, lRec_BOMComp."No."));
                        exit(false);
                    end;

                    IF NOT lRec_Item2.GET(lRec_BOMComp."No.") THEN begin
                        InsertErrorList(p_ItemNo, lRec_Item."Item Category Code", STRSUBSTNO(lMsg_BOMLineType, lRec_BOMComp."No."));
                        exit(false);
                    end else begin
                        IF lRec_Item2.Blocked then begin
                            InsertErrorList(p_ItemNo, lRec_Item."Item Category Code", STRSUBSTNO(lMsg_BOMLineBlockedItem, lRec_Item2."No."));
                            exit(false);
                        end;
                        //料品分類代碼必須要有值
                        IF lRec_Item2."Item Category Code" = '' THEN begin
                            InsertErrorList(p_ItemNo, lRec_Item."Item Category Code", STRSUBSTNO(lMsg_BOMLineItemCate, lRec_Item2."No."));
                            exit(false);
                        end;

                        //子件沒有指定主要供應商
                        IF lRec_Item2."Vendor No." = '' then begin
                            InsertErrorList(p_ItemNo, lRec_Item."Item Category Code", STRSUBSTNO(lMsg_BOMLineVendor, lRec_Item2."No."));
                            exit(false);
                        end else begin
                            lRec_Vendor.GET(lRec_Item2."Vendor No.");    //20210616 add by Renee

                            lRec_PurchPrice.RESET;
                            lRec_PurchPrice.SETRANGE("Item No.", lRec_Item2."No.");
                            lRec_PurchPrice.SETRANGE("Vendor No.", lRec_Item2."Vendor No.");
                            lRec_PurchPrice.SETRANGE("Currency Code", lRec_Vendor."Currency Code");   //20210804 add by Renee
                            lRec_PurchPrice.SETFILTER("Ending Date", '%1|>=%2', 0D, AdjustDate);
                            lRec_PurchPrice.SETRANGE("Starting Date", 0D, AdjustDate);
                            //上線後需求變更 4-1 20211012 Modify by Renee -------------------------- <<
                            //lRec_PurchPrice.SETRANGE("Minimum Quantity", 1);    //20210804 add by Renee
                            //IF lRec_PurchPrice.COUNT = 0 THEN begin
                            lRec_PurchPrice.SETFILTER("Minimum Quantity", '>=%1', 1);
                            lRec_PurchPrice.SETFILTER("ARCO Ref. Price", '>%1', 0);
                            IF lRec_PurchPrice.COUNT <> 1 THEN begin
                                //上線後需求變更 4-1 20211012 Modify by Renee -------------------------- >>
                                InsertErrorList(p_ItemNo, lRec_Item."Item Category Code", STRSUBSTNO(lMsg_BOMLinePurchPrice, lRec_Item2."No."));
                                exit(false);
                            end;
                        end;
                    end;
                until lRec_BOMComp.Next = 0;
            end else begin
                //母件沒有子件
                InsertErrorList(p_ItemNo, lRec_Item."Item Category Code", lMsg_ParetBOMnoBOM);
                exit(false);
            end;
        end else begin

            //20210804 Modify by Renee ---------------------------------- << 
            //採購件沒有指定主要供應商
            //IF lRec_Item."Vendor No." = '' then begin
            IF (lRec_Item."Replenishment System" = lRec_Item."Replenishment System"::Purchase) AND
               (lRec_Item."Vendor No." = '') then begin
                //20210804 Modify by Renee ---------------------------------- >>  
                InsertErrorList(p_ItemNo, lRec_Item."Item Category Code", lMsg_ItemVendor);
                exit(false);

            end else begin
                lRec_Vendor.GET(lRec_Item."Vendor No.");  //20210616 add by Renee

                lRec_PurchPrice.RESET;
                lRec_PurchPrice.SETRANGE("Item No.", p_ItemNo);
                lRec_PurchPrice.SETRANGE("Vendor No.", lRec_Item."Vendor No.");
                lRec_PurchPrice.SETRANGE("Currency Code", lRec_Vendor."Currency Code");   //20210804 add by Renee
                lRec_PurchPrice.SETFILTER("Ending Date", '%1|>=%2', 0D, AdjustDate);
                lRec_PurchPrice.SETRANGE("Starting Date", 0D, AdjustDate);
                //上線後需求變更 4-1 20211012 Modify by Renee -------------------------- <<
                // lRec_PurchPrice.SETRANGE("Minimum Quantity", 1);    //20210804 add by Renee
                // IF lRec_PurchPrice.COUNT = 0 THEN begin
                lRec_PurchPrice.SETFILTER("Minimum Quantity", '>=%1', 1);
                lRec_PurchPrice.SETFILTER("ARCO Ref. Price", '>%1', 0);
                IF lRec_PurchPrice.COUNT <> 1 THEN begin
                    //上線後需求變更 4-1 20211012 Modify by Renee -------------------------- >>
                    InsertErrorList(p_ItemNo, lRec_Item."Item Category Code", lMsg_PurchPrice);
                    exit(false);
                end;
            end;
        end;

        exit(true);
    end;

    //2021.05.16 Mark by Renee for Issue Log Part2 客製第 16 項
    procedure InsertErrorList(p_ItemNo: Code[20]; p_ItemCategory: Code[20]; p_ErrorMsg: Text[250])
    var
    begin
        ErrorLineNo := ErrorLineNo + 1;

        SalesLineBuffer."No." := p_ItemNo;
        SalesLineBuffer."Cross-Reference No." := p_ItemCategory;
        SalesLineBuffer."Line No." := ErrorLineNo;
        SalesLineBuffer."Error Message" := p_ErrorMsg;
        SalesLineBuffer.Insert;
    end;

    //取得供應商參考價格
    procedure GetPurch_RefPrice(p_ItemNo: Code[20]; p_VendorNo: Code[20]; p_BOM: Boolean) r_RefPrice: Decimal;
    var
        lRec_PurchPrice: Record "Purchase Price";
        lRec_Vendor: Record Vendor;
    begin
        IF p_VendorNo = '' THEN exit(0);

        lRec_Vendor.GET(p_VendorNo);    //20210616 add by Renee

        lRec_PurchPrice.RESET;
        lRec_PurchPrice.SETRANGE("Item No.", p_ItemNo);
        lRec_PurchPrice.SETRANGE("Vendor No.", p_VendorNo);
        lRec_PurchPrice.SETRANGE("Currency Code", lRec_Vendor."Currency Code");   //20210616 add by Renee
        lRec_PurchPrice.SETFILTER("Ending Date", '%1|>=%2', 0D, AdjustDate);
        lRec_PurchPrice.SETRANGE("Starting Date", 0D, AdjustDate);
        //上線後需求變更 4-1 20211012 Modify by Renee -------------------------- <<
        //lRec_PurchPrice.SETRANGE("Minimum Quantity", 1);    //20210627 add by Renee
        lRec_PurchPrice.SETFILTER("Minimum Quantity", '>=%1', 1);
        lRec_PurchPrice.SETFILTER("ARCO Ref. Price", '>%1', 0);
        //上線後需求變更 4-1 20211012 Modify by Renee -------------------------- >>        
        IF lRec_PurchPrice.FindLast() THEN begin
            //IF not p_BOM then
            //    lRec_PurchPrice.Testfield("ARCO Ref. Price");  //2021.05.16 mark by Renee

            exit(lRec_PurchPrice."ARCO Ref. Price");
        end;
    end;

    //適用
    //C-有BOM, 且母件只對應一個子件
    procedure CalcItemSalesPrice_BOM_C(p_ParentItemNo: Code[20]; p_Call: Code[1])
    var
        lRec_BOMComp: Record "BOM Component";
        lRec_ItemSalesPrice: Record "ARCO Item Sales Level Price";
        lRec_ItemSalesPrice_ParentItem: Record "ARCO Item Sales Level Price";
        lRec_Item: Record Item;

        lRec_Currency: Record Currency;
    begin
        lRec_BOMComp.RESET;
        lRec_BOMComp.SETRANGE("Parent Item No.", p_ParentItemNo);
        lRec_BOMComp.SETRANGE(Type, lRec_BOMComp.Type::Item);
        IF lRec_BOMComp.FindFirst THEN begin
            if not HideValidationDialog then
                Window.Update(2, p_ParentItemNo);
            //message('Call %1', p_Call);

            //20210627 Modify by Renee ------------------------------------- <<  
            // IF p_Call = '0' then
            //    CalcItemSalesPrice_withoutBOM(lRec_BOMComp."No.");            
            IF p_Call = '0' then begin
                IF CheckItem(lRec_BOMComp."No.") then
                    CalcItemSalesPrice_withoutBOM(lRec_BOMComp."No.")
                else begin
                    SetItemSalesPriceToZero_withoutBOM(lRec_BOMComp."No.");
                end;
            end;
            //20210627 Modify by Renee ------------------------------------- >>

            lRec_ItemSalesPrice.RESET;
            lRec_ItemSalesPrice.SETRANGE("Adjust Date", AdjustDate);
            lRec_ItemSalesPrice.SETRANGE("Item No.", lRec_BOMComp."No.");
            IF lRec_ItemSalesPrice.FindSet() THEN begin
                repeat
                    Clear(lRec_ItemSalesPrice_ParentItem);
                    lRec_ItemSalesPrice_ParentItem.Init();
                    lRec_ItemSalesPrice_ParentItem.TransferFields(lRec_ItemSalesPrice);
                    lRec_ItemSalesPrice_ParentItem."Item No." := p_ParentItemNo;
                    lRec_ItemSalesPrice_ParentItem."Unit Price" := lRec_ItemSalesPrice."Unit Price" * lRec_BOMComp."Quantity per";
                    lRec_ItemSalesPrice_ParentItem."Unit Price(First Calc.)" := lRec_ItemSalesPrice."Unit Price(First Calc.)" * lRec_BOMComp."Quantity per";
                    IF lRec_ItemSalesPrice_ParentItem.Insert() then begin
                        LineCreatedCount += 1;
                        lRec_Item.Get(p_ParentItemNo);
                        lRec_Item."ARCO Last Date Adjusted" := AdjustDate;
                        lRec_Item.Modify();
                    end else begin
                        Clear(lRec_ItemSalesPrice_ParentItem);
                        lRec_ItemSalesPrice_ParentItem.Get(lRec_ItemSalesPrice."Item No.", lRec_ItemSalesPrice."Adjust Date"
                        , lRec_ItemSalesPrice."Currency Code", lRec_ItemSalesPrice."Level Code");
                        lRec_ItemSalesPrice_ParentItem."Item No." := p_ParentItemNo;
                        lRec_ItemSalesPrice_ParentItem."Unit Price" := lRec_ItemSalesPrice."Unit Price" * lRec_BOMComp."Quantity per";
                        lRec_ItemSalesPrice_ParentItem."Unit Price(First Calc.)" := lRec_ItemSalesPrice."Unit Price(First Calc.)" * lRec_BOMComp."Quantity per";
                        IF lRec_ItemSalesPrice_ParentItem.Modify() then begin
                            LineUpdatedCount += 1;
                            lRec_Item.Get(p_ParentItemNo);
                            lRec_Item."ARCO Last Date Adjusted" := AdjustDate;
                            lRec_Item.Modify();
                        end;
                    end;
                    // // <<  chris update lien no. test
                    rec_itemlinecheck_updateline.Date := AdjustDate;
                    rec_itemlinecheck_updateline."Line No." := rec_itemlinecheck_updateline."Line No." + 1;
                    rec_itemlinecheck_updateline."No." := Item."No.";
                    rec_itemlinecheck_updateline."Parent Iten No." := lRec_BOMComp."Parent Item No.";
                    rec_itemlinecheck_updateline."Currency Code" := lRec_Currency.Code;
                    rec_itemlinecheck_updateline.Level := lRec_ItemSalesPrice."Level Code";
                    rec_itemlinecheck_updateline."Unit Price" := lRec_ItemSalesPrice."Unit Price";
                    rec_itemlinecheck_updateline.Insert();
                    // // update的筆數 >>

                    // << 2024.01.29 chris add for checking Update LineNo.
                    if rec_itemlinecheck.FindSet() then
                        repeat
                            if rec_itemlinecheck."Parent Iten No." = lRec_BOMComp."Parent Item No." then
                                if rec_itemlinecheck."Currency Code" = lRec_ItemSalesPrice."Currency Code" then begin
                                    if rec_itemlinecheck.Level = lRec_ItemSalesPrice."Level Code" then begin
                                        rec_itemlinecheck.Date := AdjustDate;
                                        rec_itemlinecheck."Unit Price" := lRec_ItemSalesPrice."Unit Price";
                                        rec_itemlinecheck."Check Item" := true;
                                        rec_itemlinecheck.Modify();
                                    end
                                end;
                        until rec_itemlinecheck.Next() = 0;

                    // 2024.01.29 chris add for checking Update LineNo. >>

                    Commit(); // 2022.04.27 performance
                until lRec_ItemSalesPrice.Next = 0;
            end;

        end;
    end;

    // local procedure FixEdModifyUpdateError(var ModifyRec: Record "ARCO Item Sales Level Price"; ParentNo:Code[20]; UPrice: Decimal; UPrice2: Decimal; TheAdjDate: Date)
    // begin

    // end;

    //適用 
    //A-無 BOM
    //B-有 BOM, 且母件有 供應廠商＋參考價格, 則以Ａ方式計算。
    //D-有 BOM, 且母件是對應多個子件 
    procedure CalcItemSalesPrice_withoutBOM(p_ItemNo: Code[20])
    var
        lRec_Item: Record Item;
        lRec_ItemCategory: Record "Item Category";
        lRec_PurchPrice: Record "Purchase Price";
        lRec_ARCOSalesPriceSetup: Record "ARCO Sales Level Price Setup";
        lRec_ARCOPriceLevelSetup: Record "ARCO Sales Level Price Setup";
        lRec_Currency: Record Currency;
        lRec_BOMComp: Record "BOM Component";
        lRec_BOMComp2: Record "BOM Component";
        lRec_BOMComp3: Record "BOM Component";
        lRec_Item2: Record Item;


        lRec_ItemSalesPrice: Record "ARCO Item Sales Level Price";

        lRefPrice: Decimal;  //參考價格
        lRefPrice2: Decimal;  //參考價格
        lBoxCost: Decimal;   //盒子成本
        lExchRate: Decimal;  //匯率
        lBaseQty: Integer;   //缸數
        lRounding34: Decimal;  //三捨四入
        ii: Integer;
        lASCII: Char;
        islRefPrice2Zeor: Boolean;
    begin
        lRec_Item.Get(p_ItemNo);
        IF lRec_Item."ARCO Do Not Adjust Sales Price" THEN
            exit;

        //lRec_Item.Testfield("Vendor No.");
        //lRec_Item.Testfield("Item Category Code");  //2021.05.16 mark by Renee for Issue Log Part2 客製第 16 項

        lRec_ItemCategory.GET(lRec_Item."Item Category Code");
        //lRec_ItemCategory.Testfield("ARCO Box Cost");
        IF lRec_ItemCategory."ARCO Rounding Precision" = 0 then
            lRec_ItemCategory."ARCO Rounding Precision" := 1;

        //lRefPrice 參考價格
        lRec_Item.CalcFields("Assembly BOM");

        //20210804 Modify by Renee ------------------------------------------- <<
        //IF (lRec_Item."Assembly BOM") AND (GetPurch_RefPrice(lRec_Item."No.", lRec_Item."Vendor No.", true) = 0) THEN begin
        //母件若有指定主要供應商，則直接視為子件排價計算，無法判斷是否有採購參考價格
        IF (lRec_Item."Assembly BOM") AND (lRec_Item."Vendor No." = '') THEN begin
            //20210804 Modify by Renee ------------------------------------------- >>    
            islRefPrice2Zeor := false;

            //有 BOM, 且母件是對應多個子件
            lRec_BOMComp.RESET;
            lRec_BOMComp.SETRANGE("Parent Item No.", p_ItemNo);
            lRec_BOMComp.SETRANGE(Type, lRec_BOMComp.Type::Item);
            IF lRec_BOMComp.FindSet() THEN begin
                repeat
                    lRec_Item2.Get(lRec_BOMComp."No.");
                    //lRec_Item2.Testfield("Vendor No.");   //2021.05.16 Mark by Renee for Issue Log Part2 客製第 16 項
                    //lRec_Item2.Testfield("Item Category Code");  //2021.05.16 Mark by Renee for Issue Log Part2 客製第 16 項            

                    //總參考價格＝子件的需求數量＊子件的參考價格 
                    lRefPrice2 := GetPurch_RefPrice(lRec_Item2."No.", lRec_Item2."Vendor No.", false);
                    lRefPrice += (lRefPrice2 * lRec_BOMComp."Quantity per");

                    //2021.05.16 add by Renee for Issue Log Part2 客製第 16 項 ----------- <<
                    //母件中有任一子件的參考價為 0，則母件的排價就為 0 (避免母件排價被低估) 
                    IF lRefPrice2 = 0 then islRefPrice2Zeor := true;
                    IF islRefPrice2Zeor then lRefPrice := 0;
                //2021.05.16 Mark by Renee for Issue Log Part2 客製第 16 項 ---------- >>             

                until lRec_BOMComp.Next = 0;
            end;
        END ELSE begin
            //A-無 BOM
            lRefPrice := GetPurch_RefPrice(lRec_Item."No.", lRec_Item."Vendor No.", false);
            IF lRefPrice = 0 THEN islRefPrice2Zeor := true;    //20210804 add by Renee
        end;

        lRec_ARCOSalesPriceSetup.Get(' ');

        //lBoxCost 盒子成本
        IF lRec_Item."ARCO Box Cost" <> 0 then
            lBoxCost := lRec_Item."ARCO Box Cost"
        ELSE
            lBoxCost := lRec_ItemCategory."ARCO Box Cost";

        //20210804 add by Renee --------------------------- <<
        //當料品分類代碼設定為不做單位轉換時，則第一次計算也不除以缸數(所以將 缸數設定為 1)
        IF NOT lRec_ItemCategory."ARCO Unit Transform" then begin
            lBaseQty := 1;
        end else begin
            //20210804 add by Renee --------------------------- >>
            //lBaseQty 缸數
            IF lRec_Item."ARCO Unit Qty. Of Packing" <> 0 then
                lBaseQty := lRec_Item."ARCO Unit Qty. Of Packing"
            ELSE
                EVALUATE(lBaseQty, CopyStr(lRec_Item."No.", lRec_ARCOSalesPriceSetup."The Position of Item No.", 1));
        end;   //20210804 add by Renee        

        lRec_Currency.RESET;
        lRec_Currency.SETRANGE("ARCO Sales Level Price Calc.", TRUE);
        IF CurrencyFilter <> '' then  //2021.05.16 add by Renee for Issue Log Part2 客製第 16 項
            lRec_Currency.SetFilter(Code, CurrencyFilter);

        IF lRec_Currency.FindSet() then begin
            repeat
                lRec_Currency.Testfield("ARCO Exch. Rate-Level Price");
                lExchRate := lRec_Currency."ARCO Exch. Rate-Level Price";

                For ii := 1 to 35 do begin
                    lRec_ItemSalesPrice.init;
                    lRec_ItemSalesPrice."Item No." := lRec_Item."No.";
                    lRec_ItemSalesPrice."Adjust Date" := AdjustDate;
                    lRec_ItemSalesPrice."Currency Code" := lRec_Currency.Code;
                    IF ii <= 9 THEN
                        lRec_ItemSalesprice."Level Code" := FORMAT(ii)
                    ELSE begin
                        lASCII := ii + 55;
                        lRec_ItemSalesPrice."Level Code" := lASCII;
                    end;

                    IF (lRec_ARCOPriceLevelSetup.Get(lRec_ItemSalesPrice."Level Code")) and
                       (lRec_ARCOPriceLevelSetup."Level 1" > 0) THEN BEGIN

                        lRec_ItemSalesPrice."Profit %" := (1 - lRec_ARCOPriceLevelSetup."Level 1") * 100;

                        lRec_ItemSalesPrice."Box Cost" := lBoxCost;
                        lRec_ItemSalesPrice."Unit Transform" := lRec_ItemCategory."ARCO Unit Transform";
                        lRec_ItemSalesPrice."Rounding Precision" := lRec_ItemCategory."ARCO Rounding Precision";
                        lRec_ItemSalesPrice."Exch. Rate" := lExchRate;
                        lRec_ItemSalesPrice."Unit Qty Of Packing" := lBaseQty;

                        //第一次計算：（參考價格+盒子成本）/匯率/利潤1/缸數=售價1
                        //IF SetToZero then   //2021.05.16 add by Renee for Issue Log Part2 客製第 16 項
                        IF SetToZero OR islRefPrice2Zeor then   //20210616 Modify by Renee
                            lRec_ItemSalesPrice."Unit Price" := 0
                        else
                            lRec_ItemSalesPrice."Unit Price" := (lRefPrice + lBoxCost) / lExchRate / lRec_ARCOPriceLevelSetup."Level 1" / lBaseQty;

                        //三捨四入
                        lRounding34 := lRec_ItemCategory."ARCO Rounding Precision" / 10;
                        lRec_ItemSalesPrice."Unit Price" := ROUND((lRec_ItemSalesPrice."Unit Price" + lRounding34), lRec_ItemSalesPrice."Rounding Precision");
                        lRec_ItemSalesPrice."Unit Price(First Calc.)" := lRec_ItemSalesPrice."Unit Price";

                        //第二次計算：售價１ｘ缸數＝售價１
                        IF lRec_ItemSalesPrice."Unit Transform" THEN begin
                            lRec_ItemSalesPrice."Unit Price" := lRec_ItemSalesPrice."Unit Price" * lBaseQty;
                        end;

                        IF lRec_ItemSalesPrice.Insert() then begin
                            LineCreatedCount += 1;
                            lRec_Item."ARCO Last Date Adjusted" := AdjustDate;
                            lRec_Item.Modify();

                        end else begin
                            IF lRec_ItemSalesPrice.Modify() then begin
                                LineUpdatedCount += 1;
                                lRec_Item."ARCO Last Date Adjusted" := AdjustDate;
                            end;
                            lRec_Item.Modify();
                        end;
                        // // <<  chris update lien no. test
                        rec_itemlinecheck_updateline.Date := AdjustDate;
                        rec_itemlinecheck_updateline."Line No." := rec_itemlinecheck_updateline."Line No." + 1;
                        rec_itemlinecheck_updateline."No." := Item."No.";
                        rec_itemlinecheck_updateline."Parent Iten No." := lRec_BOMComp."Parent Item No.";
                        rec_itemlinecheck_updateline."Currency Code" := lRec_Currency.Code;
                        rec_itemlinecheck_updateline.Level := lRec_ItemSalesPrice."Level Code";
                        rec_itemlinecheck_updateline."Unit Price" := lRec_ItemSalesPrice."Unit Price";
                        rec_itemlinecheck_updateline.Insert();
                        // << 2024.01.29 chris add for checking Update LineNo.
                        if rec_itemlinecheck.FindSet() then
                            repeat
                                if rec_itemlinecheck."Parent Iten No." = lRec_BOMComp."Parent Item No." then  // << chris add 抓到料號沒有bom
                                    if rec_itemlinecheck."Currency Code" = lRec_Currency.Code then
                                        if rec_itemlinecheck.Level = lRec_ItemSalesPrice."Level Code" then begin
                                            rec_itemlinecheck.Date := AdjustDate;
                                            rec_itemlinecheck."Unit Price" := lRec_ItemSalesPrice."Unit Price";
                                            rec_itemlinecheck."Check Item" := true;
                                            rec_itemlinecheck.Modify();
                                        end;

                                if rec_itemlinecheck."no." = lRec_BOMComp."Parent Item No." then   // << chris add 抓到料號有bom
                                    if rec_itemlinecheck."Currency Code" = lRec_Currency.Code then
                                        if rec_itemlinecheck.Level = lRec_ItemSalesPrice."Level Code" then begin
                                            rec_itemlinecheck.Date := AdjustDate;
                                            rec_itemlinecheck."Unit Price" := lRec_ItemSalesPrice."Unit Price";
                                            rec_itemlinecheck."Check Item" := true;
                                            rec_itemlinecheck.Modify();
                                        end;
                            until rec_itemlinecheck.Next() = 0;

                        // < --------------------------------Frank test
                        // rec_itemlinecheck.Reset();
                        // if not lRec_Item."Assembly BOM" then
                        //     rec_itemlinecheck.SetRange("Parent Iten No.", lRec_BOMComp."Parent Item No.")
                        // else
                        //     rec_itemlinecheck.SetRange("No.", lRec_BOMComp."Parent Item No.");
                        // rec_itemlinecheck.SetRange("Currency Code", lRec_Currency.Code);
                        // rec_itemlinecheck.SetRange(Level, lRec_ItemSalesPrice."Level Code");
                        // if rec_itemlinecheck.FindFirst() then begin
                        //     rec_itemlinecheck.Date := AdjustDate;
                        //     rec_itemlinecheck."Unit Price" := lRec_ItemSalesPrice."Unit Price";
                        //     rec_itemlinecheck."Check Item" := true;
                        //     rec_itemlinecheck.Modify();
                        // end;
                        // ----------------------------------Frank >>

                        // << 2024.01.29 chris add for checking Update LineNo.

                        Commit(); // 2022.04.27 performance
                    END;
                end;
            until lRec_Currency.Next = 0;
        end;

        lRec_BOMComp2.RESET;
        lRec_BOMComp2.SETRANGE(Type, lRec_BOMComp2.Type::Item);
        lRec_BOMComp2.SETRANGE("No.", p_ItemNo);
        IF lRec_BOMComp2.FindSet() THEN begin
            repeat
                lRec_Item2.GET(lRec_BOMComp2."Parent Item No.");
                IF lRec_Item2."Vendor No." = '' THEN BEGIN  //20210804 add by Renee
                                                            //母件沒有指定供應商時，才需因子件重新排價而重新計算
                    IF CheckItem(lRec_Item2."No.") THEN begin   //2021.05.16 add by Renee for Issue Log Part2 客製第 16 項

                        lRec_BOMComp3.RESET;
                        lRec_BOMComp3.SETRANGE(Type, lRec_BOMComp3.Type::Item);
                        lRec_BOMComp3.SETRANGE("Parent Item No.", lRec_BOMComp2."Parent Item No.");
                        IF (lRec_BOMComp3.COUNT = 1) then begin
                            //20210804 Modify by Renee --------------------------------------------- <<
                            // IF (GetPurch_RefPrice(lRec_BOMComp2."Parent Item No.", lRec_Item2."Vendor No.", true) > 0) then
                            //     CalcItemSalesPrice_withoutBOM(lRec_BOMComp2."Parent Item No.")
                            // else
                            //     CalcItemSalesPrice_BOM_C(lRec_BOMComp2."Parent Item No.", '1')
                            CalcItemSalesPrice_BOM_C(lRec_BOMComp2."Parent Item No.", '1');
                            //20210804 Modify by Renee ---------------------------------------------- >>
                        end else
                            CalcItemSalesPrice_withoutBOM(lRec_BOMComp2."Parent Item No.");
                        //20210627 Modify by Renee ------------------------------------------------------- <<
                        //end;
                    end else begin
                        lRec_BOMComp3.RESET;
                        lRec_BOMComp3.SETRANGE(Type, lRec_BOMComp3.Type::Item);
                        lRec_BOMComp3.SETRANGE("Parent Item No.", lRec_BOMComp2."Parent Item No.");
                        IF (lRec_BOMComp3.COUNT = 1) then begin
                            //20210804 Modify by Renee ----------------------------------- <<
                            // IF (GetPurch_RefPrice(lRec_BOMComp2."Parent Item No.", lRec_Item2."Vendor No.", true) > 0) then
                            //     SetItemSalesPriceToZero_withoutBOM(lRec_BOMComp2."Parent Item No.")
                            // else
                            //     CalcItemSalesPrice_BOM_C(lRec_BOMComp2."Parent Item No.", '1')
                            CalcItemSalesPrice_BOM_C(lRec_BOMComp2."Parent Item No.", '1');
                            //20210804 Modify by Renee ------------------------------------ >>
                        end else
                            SetItemSalesPriceToZero_withoutBOM(lRec_BOMComp2."Parent Item No.");
                    end;
                    //20210627 Modify by Renee ------------------------------------------------------- >>
                END;    //20210804 add by Renee
            until lRec_BOMComp2.NEXT = 0;
        end;
    end;

    procedure SetItemSalesPriceToZero_withoutBOM(p_ItemNo: Code[20])
    var
        lRec_Item: Record Item;
        lRec_ItemCategory: Record "Item Category";
        lRec_PurchPrice: Record "Purchase Price";
        lRec_ARCOSalesPriceSetup: Record "ARCO Sales Level Price Setup";
        lRec_ARCOPriceLevelSetup: Record "ARCO Sales Level Price Setup";
        lRec_Currency: Record Currency;
        lRec_BOMComp: Record "BOM Component";
        lRec_BOMComp2: Record "BOM Component";
        lRec_BOMComp3: Record "BOM Component";
        lRec_Item2: Record Item;
        lRec_ItemSalesPrice: Record "ARCO Item Sales Level Price";
        lRefPrice: Decimal;  //參考價格
        lRefPrice2: Decimal;  //參考價格
        lBoxCost: Decimal;   //盒子成本
        lExchRate: Decimal;  //匯率
        lBaseQty: Integer;   //缸數
        lRounding34: Decimal;  //三捨四入
        ii: Integer;
        lASCII: Char;
        islRefPrice2Zeor: Boolean;
    begin
        lRec_Item.Get(p_ItemNo);
        IF lRec_Item."ARCO Do Not Adjust Sales Price" THEN
            exit;

        islRefPrice2Zeor := true;

        IF lRec_ItemCategory.GET(lRec_Item."Item Category Code") THEN BEGIN
            IF lRec_ItemCategory."ARCO Rounding Precision" = 0 then
                lRec_ItemCategory."ARCO Rounding Precision" := 1;
        END;

        //lRefPrice 參考價格
        lRec_Item.CalcFields("Assembly BOM");
        IF (lRec_Item."Assembly BOM") AND (GetPurch_RefPrice(lRec_Item."No.", lRec_Item."Vendor No.", true) = 0) THEN begin
            islRefPrice2Zeor := true;
            lRefPrice := 0;
        END ELSE begin
            //A-無 BOM
            lRefPrice := 0;
        end;

        lRec_ARCOSalesPriceSetup.Get(' ');

        //lBoxCost 盒子成本
        IF lRec_Item."ARCO Box Cost" <> 0 then
            lBoxCost := lRec_Item."ARCO Box Cost"
        ELSE
            lBoxCost := lRec_ItemCategory."ARCO Box Cost";

        //lBaseQty 缸數
        //IF lRec_Item."ARCO Unit Qty. Of Packing" <> 0 then
        //    lBaseQty := lRec_Item."ARCO Unit Qty. Of Packing"
        //ELSE
        //    EVALUATE(lBaseQty, CopyStr(lRec_Item."No.", lRec_ARCOSalesPriceSetup."The Position of Item No.", 1));
        lBaseQty := lRec_Item."ARCO Unit Qty. Of Packing";

        lRec_Currency.RESET;
        lRec_Currency.SETRANGE("ARCO Sales Level Price Calc.", TRUE);
        IF CurrencyFilter <> '' then  //2021.05.16 add by Renee for Issue Log Part2 客製第 16 項
            lRec_Currency.SetFilter(Code, CurrencyFilter);

        IF lRec_Currency.FindSet() then begin
            repeat
                // lRec_Currency.Testfield("ARCO Exch. Rate-Level Price");
                lExchRate := lRec_Currency."ARCO Exch. Rate-Level Price";

                For ii := 1 to 35 do begin
                    lRec_ItemSalesPrice.init;
                    lRec_ItemSalesPrice."Item No." := lRec_Item."No.";
                    lRec_ItemSalesPrice."Adjust Date" := AdjustDate;
                    lRec_ItemSalesPrice."Currency Code" := lRec_Currency.Code;
                    IF ii <= 9 THEN
                        lRec_ItemSalesprice."Level Code" := FORMAT(ii)
                    ELSE begin
                        lASCII := ii + 55;
                        lRec_ItemSalesPrice."Level Code" := lASCII;
                    end;

                    IF (lRec_ARCOPriceLevelSetup.Get(lRec_ItemSalesPrice."Level Code")) and
                       (lRec_ARCOPriceLevelSetup."Level 1" > 0) THEN BEGIN

                        lRec_ItemSalesPrice."Profit %" := (1 - lRec_ARCOPriceLevelSetup."Level 1") * 100;

                        lRec_ItemSalesPrice."Box Cost" := lBoxCost;
                        lRec_ItemSalesPrice."Unit Transform" := lRec_ItemCategory."ARCO Unit Transform";
                        lRec_ItemSalesPrice."Rounding Precision" := lRec_ItemCategory."ARCO Rounding Precision";
                        lRec_ItemSalesPrice."Exch. Rate" := lExchRate;
                        lRec_ItemSalesPrice."Unit Qty Of Packing" := lBaseQty;

                        //第一次計算：（參考價格+盒子成本）/匯率/利潤1/缸數=售價1
                        //IF SetToZero then   //2021.05.16 add by Renee for Issue Log Part2 客製第 16 項
                        // IF SetToZero OR islRefPrice2Zeor then   //20210616 Modify by Renee
                        //     lRec_ItemSalesPrice."Unit Price" := 0
                        // else
                        //     lRec_ItemSalesPrice."Unit Price" := (lRefPrice + lBoxCost) / lExchRate / lRec_ARCOPriceLevelSetup."Level 1" / lBaseQty;
                        lRec_ItemSalesPrice."Unit Price" := 0;

                        //三捨四入
                        // lRounding34 := lRec_ItemCategory."ARCO Rounding Precision" / 10;
                        // lRec_ItemSalesPrice."Unit Price" := ROUND((lRec_ItemSalesPrice."Unit Price" + lRounding34), lRec_ItemSalesPrice."Rounding Precision");
                        lRec_ItemSalesPrice."Unit Price(First Calc.)" := lRec_ItemSalesPrice."Unit Price";

                        //第二次計算：售價１ｘ缸數＝售價１
                        // IF lRec_ItemSalesPrice."Unit Transform" THEN begin
                        //     lRec_ItemSalesPrice."Unit Price" := lRec_ItemSalesPrice."Unit Price" * lBaseQty;
                        // end;

                        IF lRec_ItemSalesPrice.Insert() then begin
                            LineCreatedCount += 1;
                            lRec_Item."ARCO Last Date Adjusted" := AdjustDate;
                            lRec_Item.Modify();
                        end else begin
                            IF lRec_ItemSalesPrice.Modify() then begin
                                LineUpdatedCount += 1;
                                lRec_Item."ARCO Last Date Adjusted" := AdjustDate;
                                lRec_Item.Modify();
                            end;
                        end;
                        // << 2024.01.29 chris add for checking Update LineNo.
                        // if rec_itemlinecheck.FindSet() then
                        //     repeat
                        //         if rec_itemlinecheck."Parent Iten No." = lRec_BOMComp."Parent Item No." then  // << chris add 抓到料號沒有bom
                        //             if rec_itemlinecheck."Currency Code" = lRec_Currency.Code then
                        //                 if rec_itemlinecheck.Level = lRec_ItemSalesPrice."Level Code" then begin
                        //                     rec_itemlinecheck.Date := AdjustDate;
                        //                     rec_itemlinecheck."Unit Price" := lRec_ItemSalesPrice."Unit Price";
                        //                     rec_itemlinecheck."Check Item" := true;
                        //                     rec_itemlinecheck.Modify();
                        //                 end;

                        //         if rec_itemlinecheck."no." = lRec_BOMComp."Parent Item No." then   // << chris add 抓到料號有bom
                        //             if rec_itemlinecheck."Currency Code" = lRec_Currency.Code then
                        //                 if rec_itemlinecheck.Level = lRec_ItemSalesPrice."Level Code" then begin
                        //                     rec_itemlinecheck.Date := AdjustDate;
                        //                     rec_itemlinecheck."Unit Price" := lRec_ItemSalesPrice."Unit Price";
                        //                     rec_itemlinecheck."Check Item" := true;
                        //                     rec_itemlinecheck.Modify();
                        //                 end;
                        //     until rec_itemlinecheck.Next() = 0;

                        // << 2024.01.29 chris add for checking Update LineNo.
                        Commit(); // 2022.04.27 performance
                    END;
                end;
            until lRec_Currency.Next = 0;
        end;

        lRec_BOMComp2.RESET;
        lRec_BOMComp2.SETRANGE(Type, lRec_BOMComp2.Type::Item);
        lRec_BOMComp2.SETRANGE("No.", p_ItemNo);
        IF lRec_BOMComp2.FindSet() THEN begin
            repeat
                lRec_Item2.GET(lRec_BOMComp2."Parent Item No.");
                IF CheckItem(lRec_Item2."No.") THEN begin   //2021.05.16 add by Renee for Issue Log Part2 客製第 16 項

                    lRec_BOMComp3.RESET;
                    lRec_BOMComp3.SETRANGE(Type, lRec_BOMComp3.Type::Item);
                    lRec_BOMComp3.SETRANGE("Parent Item No.", lRec_BOMComp2."Parent Item No.");
                    IF (lRec_BOMComp3.COUNT = 1) then begin
                        IF (GetPurch_RefPrice(lRec_BOMComp2."Parent Item No.", lRec_Item2."Vendor No.", true) > 0) then
                            CalcItemSalesPrice_withoutBOM(lRec_BOMComp2."Parent Item No.")
                        else
                            CalcItemSalesPrice_BOM_C(lRec_BOMComp2."Parent Item No.", '1')
                    end else
                        CalcItemSalesPrice_withoutBOM(lRec_BOMComp2."Parent Item No.");
                end else begin
                    lRec_BOMComp3.RESET;
                    lRec_BOMComp3.SETRANGE(Type, lRec_BOMComp3.Type::Item);
                    lRec_BOMComp3.SETRANGE("Parent Item No.", lRec_BOMComp2."Parent Item No.");
                    IF (lRec_BOMComp3.COUNT = 1) then begin
                        IF (GetPurch_RefPrice(lRec_BOMComp2."Parent Item No.", lRec_Item2."Vendor No.", true) > 0) then
                            SetItemSalesPriceToZero_withoutBOM(lRec_BOMComp2."Parent Item No.")
                        else
                            CalcItemSalesPrice_BOM_C(lRec_BOMComp2."Parent Item No.", '1')
                    end else
                        SetItemSalesPriceToZero_withoutBOM(lRec_BOMComp2."Parent Item No.");
                end;
            until lRec_BOMComp2.NEXT = 0;
        end;
    end;

    // << 2024.01.17 chris add >>
    procedure checkItemLineError() result: Boolean
    var
        IsHandled: Boolean;
        lRec_BOMComp: Record "BOM Component";
        lRec_BOMComp2: Record "BOM Component";
        lRec_BOMComp3: Record "BOM Component";
    begin
        if not HideValidationDialog then
            Window.Update(1, item."No."); //"No."

        if CheckItem(item."No.") then begin  //"No."
            //20210804 Modify by Renee -------------------------- <<
            //無論是子件或是母件，只要有指定主要供應商，則視為採購件的計算方式(A)
            //IF (GetPurch_RefPrice("No.", "Vendor No.", true) > 0) THEN begin
            IF (item."Vendor No." <> '') then begin  //"Vendor No."
                //20210804 Modify by Renee -------------------------- >>
                CalcItemSalesPrice_withoutBOM(item."No.");  //"No."
                exit(true)  // chris test
            end else begin
                lRec_BOMComp3.RESET;
                lRec_BOMComp3.SETRANGE(Type, lRec_BOMComp3.Type::Item);
                lRec_BOMComp3.SETRANGE("Parent Item No.", item."No."); //"No."
                IF lRec_BOMComp3.COUNT = 1 then
                    CalcItemSalesPrice_BOM_C(item."No.", '0')  //"No."
                else
                    CalcItemSalesPrice_withoutBOM(item."No.");  //"No."
                exit(true)  // chris test
            end;
            //commit;
            //20210627 Modify by Renee ---------------------- <<
            //end;
        end else begin
            //20210804 Modify by Renee -------------------------- <<
            //無論是子件或是母件，只要有指定主要供應商，則視為採購件的計算方式(A)
            //IF (GetPurch_RefPrice("No.", "Vendor No.", true) > 0) THEN begin
            IF (item."Vendor No." <> '') then begin   //"Vendor No."
                //20210804 Modify by Renee -------------------------- >>
                SetItemSalesPriceToZero_withoutBOM(item."No."); //"No."
                exit(true)  // chris test
            end else begin
                lRec_BOMComp3.RESET;
                lRec_BOMComp3.SETRANGE(Type, lRec_BOMComp3.Type::Item);
                lRec_BOMComp3.SETRANGE("Parent Item No.", item."No."); //"No."
                IF lRec_BOMComp3.COUNT = 1 then
                    CalcItemSalesPrice_BOM_C(item."No.", '0') //"No."
                else
                    SetItemSalesPriceToZero_withoutBOM(item."No."); //"No."
                exit(true)  // chris test
            end;
        end;

        //20210627 Modify by Renee ---------------------- >>

    end;
}
