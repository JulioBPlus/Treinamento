Class Treinamento.Data.Turma Extends (%Persistent, %XML.Adaptor)
{

Property Instrutor As Treinamento.Data.Instrutor [ SqlColumnNumber = 2 ];
 
Property DataInicio As %Date [ SqlColumnNumber = 3 ];
 
Property Status As %String [ SqlColumnNumber = 4 ];
 
Property Alunos As list Of Treinamento.Data.Aluno [ SqlColumnNumber = 5 ];
 
Property Curso As Treinamento.Data.Curso [ SqlColumnNumber = 6 ];

/// Description
ClassMethod ImprimeTurma(curso As %String) As %Status
{
    Set status = $$$OK
    Try {
        set sql = "SELECT * FROM Treinamento.Data.Turma WHERE -> Nome = '"_curso_"'"
        set resultSet = ##class(%ResultSet).%New(sql)

        set status = resultSet.Prepare(sql)
        if $SYSTEM.Status.IsError(status) return status

        set status = resultSet.Execute()
        if $SYSTEM.Status.IsError(status) return status

        if resultSet.%Next() {
            set idTurma = resultSet.Get("ID")
            set turma = ##class(Treinamento.Data.Turma).%OpenId(idTurma)
        }
        For i=1:1:turma.Alunos.Count() {
            set aluno = turma.Alunos.GetAt(i)
            Write "Nome: "_aluno.Nome_" - Matricula: "_aluno.Matricula_" - Idade: "_aluno.Idade, !
        }
    }
    Catch (exception) {
        set status = exception.AsStatus()
        Throw exception
    }
    return
}

Method VerificaStatus(curso As %String) As %String
{
    Set status = $$$OK
    Set statusTurma = ""
    Set sql = "SELECT * FROM Treinamento.Data.Turma WHERE Curso->Nome = '"_curso_"'"
    Set resultSet = ##class(%ResultSet).%New(sql)
    Set status = resultSet.Prepare(sql)
    Set status = resultSet.Execute()

    While resultSet.%Next()
    {
        Set statusTurma = resultSet.Get("Status")
        Set idTurma = resultSet.Get("ID")
        Set turma = ##class(Treinamento.Data.Turma).%OpenId(idTurma)
        Set statusTurma = turma.Status
    }

    return statusTurma
}



Storage Default
{
<Data name="TurmaDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Instrutor</Value>
</Value>
<Value name="3">
<Value>DataInicio</Value>
</Value>
<Value name="4">
<Value>Status</Value>
</Value>
<Value name="5">
<Value>Alunos</Value>
</Value>
<Value name="6">
<Value>Curso</Value>
</Value>
</Data>
<DataLocation>^Treinamento.Data.TurmaD</DataLocation>
<DefaultData>TurmaDefaultData</DefaultData>
<IdLocation>^Treinamento.Data.TurmaD</IdLocation>
<IndexLocation>^Treinamento.Data.TurmaI</IndexLocation>
<StreamLocation>^Treinamento.Data.TurmaS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}


