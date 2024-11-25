codeunit 50791 "50791_ActValoresFecha.CodeUnit"
{
    TableNo = "Purchase Line";

    trigger OnRun()
    var
        PurchaseLines: Record "Purchase Line";
        Web: Record PQNCaracteristicasWeb;
    begin
        PurchaseLines.SetFilter("Quantity Received", '< ' + Format(PurchaseLines."Quantity (Base)"));
        PurchaseLines.SetFilter(Type, Format(PurchaseLines.Type::Item));
        PurchaseLines.setFilter("Document Type", Format(PurchaseLines."Document Type"::Order));

        if (PurchaseLines.FindSet()) then begin
            repeat begin
                if PurchaseLines.ProposedDeliveryDate < System.Today + 2 then begin
                    if Web.get(PurchaseLines."No.") then begin
                        PurchaseLines.ProposedDeliveryDate := System.today + Web.EstimacionDiasEntrega;
                        PurchaseLines.Modify();
                    end;
                end;
            end until PurchaseLines.Next() = 0;
        end;
    end;


}