codeunit 50102 "ARCO PurchaseQuoteFindEven"
{

    local procedure OnBeforeFindPurchLinePrice(var PurchaseLine: Record "Purchase Line"; var PurchaseHeader: Record "Purchase Header"; CalledByFieldNo: Integer; var IsHandled: Boolean);
    var
        purchaseprice: Record "Purchase Price";
    begin
        // PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type"::Quote);
        // PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        // if PurchaseLine.get(PurchaseLine."Line No.") then begin
        //     PurchaseLine."ARCO Price Starting date" := purchaseprice."Starting Date";
        // end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Price Calc. Mgt.", OnAfterFindPurchLinePrice, '', false, false)]
    local procedure OnAfterFindPurchLinePrice(var PurchaseLine: Record "Purchase Line"; var PurchaseHeader: Record "Purchase Header"; var PurchasePrice: Record "Purchase Price"; CalledByFieldNo: Integer; PriceInSKU: Boolean; FoundPurchPrice: Boolean);
    begin
        PurchaseLine."ARCO Price Starting date" := PurchasePrice."Starting Date";
    end;

}
