unit UInicial;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, Data.DB, System.permissions,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Edit, FMX.TabControl, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Layouts, System.Actions, FMX.ActnList, FMX.StdActns,
  FMX.MediaLibrary.Actions, IdHashSHA, FMX.DialogService;

type
  TFrmInicial = class(TForm)
    ActionList1: TActionList;
    TabAction1: TChangeTabAction;
    TabAction2: TChangeTabAction;
    TabAction3: TChangeTabAction;
    TabAction4: TChangeTabAction;
    TabAction5: TChangeTabAction;
    ActionPhotoLibrary: TTakePhotoFromLibraryAction;
    StyleBook1: TStyleBook;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    LayoutCorpo: TLayout;
    TabItem4: TTabItem;
    LayoutCadProfissional: TLayout;
    layout_cad_senha: TLayout;
    Layout4: TLayout;
    Edt_senha: TEdit;
    Line7: TLine;
    Label7: TLabel;
    Layout5: TLayout;
    img_exibir: TImage;
    img_esconder: TImage;
    Layout6: TLayout;
    Edt_email: TEdit;
    Line8: TLine;
    Label8: TLabel;
    RectaCadastroSenha: TRectangle;
    Label16: TLabel;
    LabeltelaSenha: TLabel;
    CircleFotoCadastro: TCircle;
    img_add: TImage;
    TabItem5: TTabItem;
    LayoutLogin: TLayout;
    Layout1: TLayout;
    LayoutSenha: TLayout;
    edt_senhalogin: TEdit;
    Line1: TLine;
    Label9: TLabel;
    Layout3: TLayout;
    Image_exibir: TImage;
    LayoutEmail: TLayout;
    edt_login: TEdit;
    Line2: TLine;
    Label10: TLabel;
    RectEntrar: TRectangle;
    Label11: TLabel;
    LayoutImg: TLayout;
    CircleFoto: TCircle;
    Label12: TLabel;
    Label13: TLabel;
    Image3: TImage;
    Image1: TImage;
    Image4: TImage;
    layout_rodape: TLayout;
    LabelPular: TLabel;
    Image2: TImage;
    Image_esconder: TImage;
    procedure LabelPularClick(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure RectaCadastroSenhaClick(Sender: TObject);
    procedure img_esconderClick(Sender: TObject);
    procedure img_exibirClick(Sender: TObject);
    procedure img_addClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RectEntrarClick(Sender: TObject);
    procedure Image_esconderClick(Sender: TObject);
    procedure Image_exibirClick(Sender: TObject);
  private
    { Private declarations }
{$IFDEF ANDROID}
    PermissaoCamera, PermissaoReadStorage, PermissaoWriteStorage: string;
    procedure LibraryPermissionRequestResult(Sender: TObject;
      const APermissions: TArray<string>;
      const AGrantResults: TArray<TPermissionStatus>);
    procedure DisplayMessageLibrary(Sender: TObject;
      const APermissions: TArray<string>; const APostProc: TProc);
{$ENDIF}
  public
    { Public declarations }
    StreamImg: TStream;
  end;

var
  FrmInicial: TFrmInicial;

implementation

{$R *.fmx}

uses UDM

{$IFDEF ANDROID}
    , Androidapi.Helpers, Androidapi.JNI.JavaTypes, Androidapi.JNI.Os
{$ENDIF}
    , ULista;
{$IFDEF ANDROID}

procedure TFrmInicial.LibraryPermissionRequestResult(Sender: TObject;
  const APermissions: TArray<string>;
  const AGrantResults: TArray<TPermissionStatus>);
begin
  // 2 Permissoes: READ_EXTERNAL_STORAGE e WRITE_EXTERNAL_STORAGE
  if (Length(AGrantResults) = 2) and
    (AGrantResults[0] = TPermissionStatus.Granted) and
    (AGrantResults[1] = TPermissionStatus.Granted) then
    ActionPhotoLibrary.Execute
  else
    TDialogService.ShowMessage('Você não tem permissão para acessar as fotos');
end;

procedure TFrmInicial.DisplayMessageLibrary(Sender: TObject;
  const APermissions: TArray<string>; const APostProc: TProc);
begin
  TDialogService.ShowMessage
    ('O app precisa acessar as fotos do seu dispositivo',
    procedure(const AResult: TModalResult)
    begin
      APostProc;
    end);
end;
{$ENDIF}

function SHA1FromString(const AString: string): string;
var
  SHA1: TIdHashSHA1;
begin
  SHA1 := TIdHashSHA1.Create;
  try
    Result := SHA1.HashStringAsHex(AString);
  finally
    SHA1.Free;
  end;
end;

procedure TFrmInicial.FormCreate(Sender: TObject);
begin
  TabAction1.Execute;
end;

procedure TFrmInicial.Image2Click(Sender: TObject);
begin
  case TabControl1.TabIndex of
    0:
      TabAction2.Execute;
    1:
      TabAction3.Execute;
    2:
      TabAction4.Execute;
    3:
      TabAction5.Execute;
  end;
end;

procedure TFrmInicial.Image_esconderClick(Sender: TObject);
begin
  Image_esconder.Visible := false;
  Image_exibir.Visible := True;
  edt_senhalogin.Password := false;
end;

procedure TFrmInicial.Image_exibirClick(Sender: TObject);
begin
  Image_esconder.Visible := True;
  Image_exibir.Visible := false;
  edt_senhalogin.Password := True;
end;

procedure TFrmInicial.img_addClick(Sender: TObject);
begin
{$IFDEF ANDROID}
  PermissionsService.RequestPermissions([PermissaoReadStorage,
    PermissaoWriteStorage], LibraryPermissionRequestResult,
    DisplayMessageLibrary);
{$ENDIF}
{$IFDEF IOS}
  ActionPhotoLibrary.Execute;
{$ENDIF}
end;

procedure TFrmInicial.img_esconderClick(Sender: TObject);
begin
  img_esconder.Visible := false;
  img_exibir.Visible := True;
  Edt_senha.Password := false;
end;

procedure TFrmInicial.img_exibirClick(Sender: TObject);
begin
  img_esconder.Visible := True;
  img_exibir.Visible := false;
  Edt_senha.Password := True;
end;

procedure TFrmInicial.LabelPularClick(Sender: TObject);
begin
  TabAction4.Execute;
end;

procedure TFrmInicial.RectaCadastroSenhaClick(Sender: TObject);
var
  senha: string;
begin
  senha := SHA1FromString(Edt_senha.Text);

  DM.FDQPessoa.Close;
  DM.FDQPessoa.Open();
  if (Edt_email.Text = EmptyStr) or (Edt_senha.Text = EmptyStr) then
    Abort;

  DM.FDQPessoa.Close;
  DM.FDQPessoa.Open();
  if (Edt_email.Text = EmptyStr) or (Edt_senha.Text = EmptyStr) then
    Abort;

  DM.FDQPessoa.Append;
  DM.FDQPessoaemail.AsString := Edt_email.Text;
  DM.FDQPessoasenha.AsString := senha;
  StreamImg := TMemoryStream.Create;
  CircleFotoCadastro.Fill.Bitmap.Bitmap.SaveToStream(StreamImg);
  CircleFoto.Fill.Bitmap.Bitmap.SaveToStream(StreamImg);
  DM.FDQPessoaimg_usuario.LoadFromStream(StreamImg);

  DM.FDQPessoa.Post;
  DM.FDConnection1.CommitRetaining;

  TabAction5.Execute;

end;

procedure TFrmInicial.RectEntrarClick(Sender: TObject);
var
  senha: string;
begin
  senha := SHA1FromString(edt_senhalogin.Text);
  DM.FDQPessoa.Close;
  DM.FDQPessoa.ParamByName('pnome').AsString := edt_login.Text;
  DM.FDQPessoa.Open();

  if not(DM.FDQPessoa.IsEmpty) and (DM.FDQPessoasenha.AsString = senha) then
  begin
    if not Assigned(FrmLista) then
      Application.CreateForm(TFrmLista, FrmLista);
    FrmLista.Show;
  end
  else
  begin
    ShowMessage('Login ou senha não confere');
  end;
end;

end.
