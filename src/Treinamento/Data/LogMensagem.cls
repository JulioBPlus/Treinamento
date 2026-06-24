Class Treinamento.Data.LogMensagem Extends (%Persistent, %XML.Adaptor)
{
property Metodo As %String;
property Classe As %String;
property Inicio As %String;
property Fim As %String;
property Status As %Boolean;
property StatusProcesso As %String;
property ListLog As list Of Treinamento.VO.LogMensagem;

ClassMethod CriarEntrada(pMetodo As %String, pClasse As %String) As Treinamento.Data.LogMensagem
{
    set tsc = $$$OK
    try{
        set classe                 = ..%ClassName()
        set name                   =   $ZNAME
        #Dim exception             As %Exception.General = ""
        #Dim statuCode             As %Status            = $SYSTEM.Status.OK()
        #Dim logMensagem           As LogMensagem        = ..%New() 

        set entry.Metodo              = pMetodo
        set entry.Classe              = pClasse
        set entry.Inicio              = $ZTIMESTAMP($HOROLOG,4)
        set entry.Status              = entry.%Save()
    }
    catch (exception){
        set tsc = exception.AsStatus()
        set errorMensagem = $SYSTEM.Status.GetErrorText(tsc)
        Throw exception
    }
    return entry
}
Storage Default
{
<Data name="LogMensagemDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Metodo</Value>
</Value>
<Value name="3">
<Value>Classe</Value>
</Value>
<Value name="4">
<Value>Inicio</Value>
</Value>
<Value name="5">
<Value>Fim</Value>
</Value>
<Value name="6">
<Value>Status</Value>
</Value>
<Value name="7">
<Value>StatusProcesso</Value>
</Value>
<Value name="8">
<Value>ListLog</Value>
</Value>
</Data>
<DataLocation>^Treinamento.Data.LogMensagemD</DataLocation>
<DefaultData>LogMensagemDefaultData</DefaultData>
<IdLocation>^Treinamento.Data.LogMensagemD</IdLocation>
<IndexLocation>^Treinamento.Data.LogMensagemI</IndexLocation>
<StreamLocation>^Treinamento.Data.LogMensagemS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}