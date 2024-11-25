pageextension 50791 "50791PurchaseOrder.PageExt" extends "Purchase Order"
{

    trigger OnOpenPage()
    var
        LineasCompra: Record "Purchase Line";
        Web: Record PQNCaracteristicasWeb;
    begin
        LineasCompra.setFilter("Document No.", Rec."No.");
        LineasCompra.setFilter(Type, Format(LineasCompra.Type::Item));
        LineasCompra.setFilter("Document Type", Format(LineasCompra."Document Type"::Order));
        if (LineasCompra.FindSet()) then begin
            repeat begin
                if LineasCompra.ProposedDeliveryDate < System.Today then begin
                    if Web.get(LineasCompra."No.") then begin
                        LineasCompra.ProposedDeliveryDate := System.today + Web.EstimacionDiasEntrega;
                        LineasCompra.Modify();
                    end;
                end;
            end until LineasCompra.Next() = 0;
        end;

    end;

}
