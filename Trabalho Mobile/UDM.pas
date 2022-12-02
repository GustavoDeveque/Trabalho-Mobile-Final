unit UDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, IOUtils;

type
  TDM = class(TDataModule)
    FDConnection1: TFDConnection;
    FDQPessoa: TFDQuery;
    FDQPessoaid: TFDAutoIncField;
    FDQPessoanome: TStringField;
    FDQPessoacpf: TStringField;
    FDQPessoacelular: TStringField;
    FDQPessoacep: TStringField;
    FDQPessoaendereco: TStringField;
    FDQPessoacidade: TStringField;
    FDQPessoauf: TStringField;
    FDQPessoabairro: TStringField;
    FDQPessoaemail: TStringField;
    FDQPessoasenha: TStringField;
    FDQPessoaimg_usuario: TBlobField;
    FDQVeiculo: TFDQuery;
    FDQVeiculoid: TFDAutoIncField;
    FDQVeiculoplaca: TStringField;
    FDQVeiculoqtdtanque: TIntegerField;
    FDQVeiculodescricao: TStringField;
    FDQVeiculotipoCombustivel: TStringField;
    procedure FDConnection1AfterConnect(Sender: TObject);
    procedure FDConnection1BeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

procedure TDM.FDConnection1AfterConnect(Sender: TObject);
var
  strSQL: string;
begin
  strSQL := 'create table IF NOT EXISTS pessoa( 		' + //
            'id integer not null primary key autoincrement, ' + //
            'nome varchar(40),                              ' + //
            'cpf varchar(11),                               ' + //
            'celular varchar(13),                           ' + //
            'cep varchar(10),                               ' + //
            'endereco varchar(60),                          ' + //
            'cidade varchar(60),                            ' + //
            'uf char(2),                                    ' + //
            'bairro varchar(60),                            ' + //
            'email varchar(60),                             ' + //
            'senha varchar(40),                             ' + //
            'img_usuario blob) ';
  FDConnection1.ExecSQL(strSQL);

  strSQL := EmptyStr;
  strSQL := 'create table IF NOT EXISTS veiculo( ' + //
            'id integer not null primary key autoincrement, ' + //
            'placa char(7), '+ //
            'qtdtanque integer, '+//
            'descricao varchar(500), '+   //
            'tipoCombustivel varchar(50)';

    FDConnection1.ExecSQL(strSQL);

  FDQPessoa.Active := true;
  FDQVeiculo.Active := true;
  //FDQViagem.Active :=true;
end;

procedure TDM.FDConnection1BeforeConnect(Sender: TObject);
var
  strPath: string;
begin
{$IF DEFINED(iOS) or DEFINED(ANDROID)}
  strPath := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,
    'BD.db');
{$ENDIF}
{$IFDEF MSWINDOWS}
  strPath := System.IOUtils.TPath.Combine
    ('D:\Users\aluno\Downloads\Trabalho Mobile\BD',
    'BD.db');
{$ENDIF}
  FDConnection1.Params.Values['UseUnicode'] := 'False';
  FDConnection1.Params.Values['DATABASE'] := strPath;
end;

end.
