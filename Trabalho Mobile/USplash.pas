unit USplash;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts, REST.Types,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, System.JSON;

type
  TFrmSplash = class(TForm)
    Image1: TImage;
    Image2: TImage;
    RoundRectComecar: TRoundRect;
    ClickAqui: TLabel;
    LayoutFundo: TLayout;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    LayoutUpdate: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    lbl_titulo: TLabel;
    lbl_texto1: TLabel;
    lbl_texto2: TLabel;
    rect_botao: TRectangle;
    Label4: TLabel;
    img_seta: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RoundRectComecarClick(Sender: TObject);
    procedure rect_botaoClick(Sender: TObject);
  private
    { Private declarations }
    versaoapp, versaoserver:string;
    procedure OnFinishUpdate(Sender: TObject);
  public
    { Public declarations }
  end;

var
  FrmSplash: TFrmSplash;

implementation

{$R *.fmx}

uses UInicial, UOpenURL;


procedure TFrmSplash.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  FrmSplash := nil;
end;

procedure TFrmSplash.FormCreate(Sender: TObject);
begin
  //Image1.Align := TAlignLayout.Center;
  versaoapp:='1.0';
  versaoserver:='0.0';
end;

procedure TFrmSplash.FormShow(Sender: TObject);
 var
    t: TThread;
begin
  t := TThread.CreateAnonymousThread(
  procedure
  var
    JsonObj: TJSONObject;
    begin
    sleep(2000);
    try
      RESTRequest1.Execute;
    except
      on ex: Exception do
      begin
        raise Exception.Create('Erro ao acessar do servidor' + ex.Message);
        exit
      end;
    end;
    try
      JsonObj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes
      (RESTRequest1.Response.JSONValue.ToString), 0) as TJSONObject;

      versaoserver :=TJSONObject(JsonObj).GetValue('versao').Value;
    finally
      JsonObj.disposeof;
    end;
  end);
  t.OnTerminate := OnFinishUpdate;
  t.Start;
end;


procedure TFrmSplash.rect_botaoClick(Sender: TObject);
var
  url: string;
begin
{$IFDEF ANDROID}
  url := 'https://drive.google.com/drive/folders/1l2ES5RcQLlYhjBSHwgSXrQbKBV_s33e0';
{$ELSE}
  url := 'https://drive.google.com/drive/folders/1l2ES5RcQLlYhjBSHwgSXrQbKBV_s33e0';
{$ENDIF}
  OpenURL(url, False);
  Application.Terminate;
end;

procedure TFrmSplash.OnFinishUpdate(Sender: TObject);
begin
  if Assigned(TThread(Sender).FatalException) then
  begin
    showmessage(Exception(TThread(Sender).FatalException).Message);
    exit;
  end;

  if versaoapp < versaoserver then
  begin
    LayoutFundo.Visible := False;
    LayoutUpdate.Visible := true;
    img_seta.Position.Y := 0;
    img_seta.Opacity := 0.5;
    lbl_titulo.Opacity := 0;
    lbl_texto1.Opacity := 0;
    lbl_texto2.Opacity := 0;
    rect_botao.Opacity := 0;

    LayoutUpdate.BringToFront;
    LayoutUpdate.AnimateFloat('Margins.Top', 0, 0.8, TAnimationType.inOut,
      TInterpolationType.Circular);

    img_seta.AnimateFloatDelay('Position.Y', 50, 0.5, 1, TAnimationType.Out,
      TInterpolationType.Back);
    img_seta.AnimateFloatDelay('Opecity', 1, 0.4, 0.9);

    lbl_titulo.AnimateFloatDelay('Opecity', 1, 0.7, 1.3);
    lbl_texto1.AnimateFloatDelay('Opecity', 1, 0.7, 1.6);
    rect_botao.AnimateFloatDelay('Opecity', 1, 0.7, 1.9);
  end;
end;

procedure TFrmSplash.RoundRectComecarClick(Sender: TObject);
begin
  if not Assigned(FrmInicial) then
    Application.CreateForm(TFrmInicial, FrmInicial);

  FrmInicial.Show;

end;

end.
