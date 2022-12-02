unit UViagem;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.Edit, FMX.ListBox, FMX.Controls.Presentation, FMX.Layouts,
  REST.Types, Data.Bind.Components, Data.Bind.ObjectScope, REST.Client,System.JSON,
  FMX.Maps, System.Sensors.Components, System.Sensors, System.Permissions;

type
  TFrmViagem = class(TForm)
    Layout1: TLayout;
    Viagem: TLabel;
    Rectangle1: TRectangle;
    Veiculo: TLabel;
    ComboBox1: TComboBox;
    Origem: TLabel;
    edt_origem: TEdit;
    Destino: TLabel;
    edt_destino: TEdit;
    RoundRect1: TRoundRect;
    Calcular_Viagem: TLabel;
    Layout3: TLayout;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    lbl_distancia: TLabel;
    lbl_tempo: TLabel;
    MapView1: TMapView;
    Switch1: TSwitch;
    LocationSensor1: TLocationSensor;
    procedure RoundRect1Click(Sender: TObject);
    procedure Switch1Click(Sender: TObject);
    procedure LocationSensor1LocationChanged(Sender: TObject; const OldLocation,
      NewLocation: TLocationCoord2D);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmViagem: TFrmViagem;

implementation

uses UDM

{$IFDEF ANDROID}
    , Androidapi.Helpers, Androidapi.JNI.JavaTypes, Androidapi.JNI.Os
{$ENDIF}
    ;
{$R *.fmx}

procedure TFrmViagem.FormCreate(Sender: TObject);
begin
     MapView1.MapType := TMapType.Normal;
end;

procedure TFrmViagem.LocationSensor1LocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);
var
  MyMarker: TMapMarkerDescriptor;
  posicao: TMapCoordinate;
begin
  MapView1.Location := TMapCoordinate.Create(NewLocation.Latitude,
    NewLocation.Longitude);
  posicao.Latitude := NewLocation.Latitude;
  posicao.Longitude := NewLocation.Longitude;
  MyMarker := TMapMarkerDescriptor.Create(posicao, 'Estou aqui!');
  MyMarker.Draggable :=true;
  MyMarker.Visible := true;
  MyMarker.Snippet := 'EU';
  MapView1.AddMarker(MyMarker);
  //Label4.Text := NewLocation.Latitude.ToString().Replace(',', '.');
  //Label5.Text := NewLocation.Longitude.ToString().Replace(',', '.');
end;

procedure TFrmViagem.RoundRect1Click(Sender: TObject);
var
  retorno: TJSONObject;
  prows: TJSONPair;
  arrayr: TJSONArray;
  orows: TJSONObject;
  arraye: TJSONArray;
  oelementos: TJSONObject;
  oduracao, odistancia: TJSONObject;

  distancia_str, duracao_str: string;
  distancia_int, duracao_int: integer;
begin
  RESTRequest1.Resource := 'json?origins={origem}&destinations={destino}&mode=driving&language=pt-BR&key=AIzaSyCF3asSuxAcmXmQckP_M8ERqvlT9zzXGqY';
  RESTRequest1.Params.AddUrlSegment('origem', edt_origem.Text);
  RESTRequest1.Params.AddUrlSegment('destino', edt_destino.Text);
  RESTRequest1.Execute;

  retorno := RESTRequest1.Response.JSONValue as TJSONObject;

  if retorno.GetValue('status').Value <> 'OK' then
  begin
    ShowMessage('Ocorreu um erro ao calcular a viagem.');
    exit;
  end;

  prows := retorno.Get('rows');
  arrayr := prows.JsonValue as TJSONArray;
  orows := arrayr.Items[0] as TJSONObject;
  arraye := orows.GetValue('elements') as TJSONArray;
  oelementos := arraye.Items[0] as TJSONObject;

  odistancia := oelementos.GetValue('distance') as TJSONObject;
  oduracao := oelementos.GetValue('duration') as TJSONObject;

  distancia_str := odistancia.GetValue('text').Value;
  distancia_int := odistancia.GetValue('value').Value.ToInteger;

  duracao_str := oduracao.GetValue('text').Value;
  duracao_int := oduracao.GetValue('value').Value.ToInteger;

  lbl_distancia.Text := 'Dist�ncia: ' + distancia_str;
  lbl_tempo.Text := 'Dura��o: ' + duracao_str;
end;

procedure TFrmViagem.Switch1Click(Sender: TObject);
{$IFDEF ANDROID}
var
  APermissaoGPS: string;
{$ENDIF}
begin
{$IFDEF ANDROID}
  APermissaoGPS := JStringToString
    (TJManifest_permission.JavaClass.ACCESS_FINE_LOCATION);

  PermissionsService.RequestPermissions([APermissaoGPS],
    procedure(const APermissions: TArray<string>;
      const AGrantResults: TArray<TPermissionStatus>)
    begin
      if (Length(AGrantResults) = 1)and
      (AGrantResults[0] = TPermissionStatus.Granted) then
      LocationSensor1.Active := True
      else
      LocationSensor1.Active := False
      end);
{$ENDIF}
end;

end.
