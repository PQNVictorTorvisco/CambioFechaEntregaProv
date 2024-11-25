tableextension 50791 "50791_PQNPurchaseline.TableExt" extends "Purchase Line"
{
    fields
    {

    }

    trigger OnAfterInsert()
    var
        Producto: Record Item;
        Web: Record PQNCaracteristicasWeb;
    begin
        if (Producto.get(Rec."No.")) then begin
            if (Web.get(Rec."No.")) then begin
                Rec.ProposedDeliveryDate := System.Today + Web.EstimacionDiasEntrega;
                Rec.Modify;
            end;

        end;
    end;
}
