unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    CalculateB: TButton;
    Length1: TEdit;
    Materials: TComboBox;
    Width1: TEdit;
    Height1: TEdit;
    MaterialLB: TLabel;
    CalculateLB: TLabel;
    LengthLB: TLabel;
    WidthLB: TLabel;
    HeigthLB: TLabel;
    Result: TLabel;
    procedure CalculateBClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  MaterialDensity: array[0..9] of Double = (7850, 2700, 11340, 8920, 8000, 10500, 19300, 22500, 1000, 11300); // Плотности материалов (кг/м³)
  MaterialNames: array[0..9] of string = ('Сталь', 'Алюминий', 'Золото', 'Медь', 'Стекло', 'Платина', 'Серебро', 'Кирпич', 'Дерево', 'Свинец');

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to 9 do
    Materials.Items.Add(MaterialNames[i]);
end;


procedure TForm1.CalculateBClick(Sender: TObject);
var
  LengthInput, WidthInput, HeightInput, Volume, Mass: Double;
begin
  LengthInput := StrToFloat(Length1.Text);
  WidthInput := StrToFloat(Width1.Text);
  HeightInput := StrToFloat(Height1.Text);
  Volume := LengthInput * WidthInput * HeightInput;
  Mass := Volume * MaterialDensity[Materials.ItemIndex];
  Result.Caption := 'Масса бруска: ' + FloatToStr(Mass) + ' кг';
end;

end.

