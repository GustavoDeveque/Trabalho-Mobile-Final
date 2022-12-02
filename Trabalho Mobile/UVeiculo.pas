unit UVeiculo;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, IOUtils,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Objects, FMX.Ani, FMX.Controls.Presentation, FMX.Layouts,
  FMX.TabControl, FMX.MultiView, System.Actions, FMX.ActnList, FMX.ListBox,
  IdHashSHA;

type
  TFrmVeiculo = class(TForm)
    rect_toolbar: TRectangle;
    lbl_titulo: TLabel;
    img_busca: TImage;
    img_cancelar: TImage;
    rect_busca: TRectangle;
    img_cancel_busca: TImage;
    AnimationBusca: TFloatAnimation;
    RoundRect1: TRoundRect;
    edt_busca: TEdit;
    img_salvar: TImage;
    img_favorito: TImage;
    btnMenu: TSpeedButton;
    MultiView1: TMultiView;
    VertScrollBox1: TVertScrollBox;
    RectMeusDados: TRoundRect;
    Label1: TLabel;
    RectFavoritos: TRoundRect;
    Label2: TLabel;
    RoundProfissionais: TRoundRect;
    LabelProfissionais: TLabel;
    ActionList1: TActionList;
    ChangeTabAction1: TChangeTabAction;
    ChangeTabAction2: TChangeTabAction;
    ChangeTabAction3: TChangeTabAction;
    ChangeTabAction4: TChangeTabAction;
    ChangeTabAction5: TChangeTabAction;
    Layout1: TLayout;
    Placa: TLabel;
    edt_placa: TEdit;
    Descri��o: TLabel;
    edt_descricao: TEdit;
    Qtd_do_tanque: TLabel;
    edt_tanque: TEdit;
    RoundRect2: TRoundRect;
    Salvar: TLabel;
    Layout2: TLayout;
    LabelPular: TLabel;
    edt_tipocombustivel: TEdit;
    procedure LabelPularClick(Sender: TObject);
    procedure RoundRect2Click(Sender: TObject);
  private
    { Private declarations }

  public
    FValorTotal: double;
    { Public declarations }
  end;

var
  FrmVeiculo: TFrmVeiculo;

implementation

{$R *.fmx}

uses UDM, UInicial, UViagem;

{ TFrmLista }



procedure TFrmVeiculo.LabelPularClick(Sender: TObject);
begin
  FrmViagem.Show;
end;

procedure TFrmVeiculo.RoundRect2Click(Sender: TObject);
begin
  DM.FDQVeiculo.Edit;
  DM.FDQVeiculoplaca.AsString := edt_placa.Text;
  DM.FDQVeiculoqtdtanque.AsInteger := StrToInt(edt_tanque.text);
  DM.FDQVeiculodescricao.AsString := edt_descricao.Text;
  DM.FDQVeiculotipoCombustivel.AsString := edt_tipocombustivel.Text;
  DM.FDQVeiculo.Post;

  FrmViagem.Show;
end;

end.
