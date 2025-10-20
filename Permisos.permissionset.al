namespace Permisos;

permissionset 50100 Permisos
{
    Assignable = true;
    Caption = 'Permissions', MaxLength = 30;
    Permissions = codeunit "Order Creation WebService" = X;
}