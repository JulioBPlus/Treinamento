Class Treinamento.Data.Curso Extends (%Persistent, %XML.Adaptor)
{

Property Nome As %String(MAXLEN = 50);
Property Preco As %Numeric(MAXVAL = 999999.99, MINVAL = 0.00);
Property Duracao As %DateTime;

}