unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button0: TButton;
    ButtonDel: TButton;
    ButtonMul: TButton;
    ButtonMinus: TButton;
    ButtonPlus: TButton;
    ButtonResult: TButton;
    ButtonNEZ: TButton;
    ButtonKvadrat: TButton;
    ButtonBack: TButton;
    ButtonCE: TButton;
    ButtonC: TButton;
    ButtonKoren: TButton;
    ButtonZap: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Edit1: TEdit;
    procedure ButtonBackClick(Sender: TObject);
    procedure ButtonCClick(Sender: TObject);
    procedure ButtonCEClick(Sender: TObject);
    procedure ButtonKorenClick(Sender: TObject);
    procedure ButtonKvadratClick(Sender: TObject);
    procedure ButtonNEZClick(Sender: TObject);
    procedure ButtonResultClick(Sender: TObject);
    procedure Vvodsknopochek(Sender: TObject);
    procedure Deistvie(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  second: real;
  first: Extended;
  res: double;
  znak: string;
implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.ButtonBackClick(Sender: TObject);
var edit: string;
begin
  edit:= Edit1.Text;
  if edit <> '' then
   Delete(edit, Length(edit), 1);
  Edit1.Text:= edit;
end;

procedure TForm1.ButtonCClick(Sender: TObject);
begin
  if Edit1.Text <> '' then
   begin
  Edit1.Clear;
  first:= 0;
  second:= 0;
  res:= 0;
   end
  else
  exit;
end;

procedure TForm1.ButtonCEClick(Sender: TObject);
begin
  Edit1.Clear;
end;

procedure TForm1.ButtonKorenClick(Sender: TObject);
begin
  if (Edit1.Text <> 'НЕЗЯ') and (Edit1.Text <> '') then
   begin
  first:= StrToFloat(Edit1.Text);
  first:= sqrt(first);
  Edit1.Text:= FloatToStr(first);
  first:= 0;

   end;
end;

procedure TForm1.ButtonKvadratClick(Sender: TObject);
var
  first: extended;
begin
  if (Edit1.Text <> 'НЕЗЯ') and (Edit1.Text <> '') then
   begin
  first:= StrToFloat(Edit1.Text);
  if first >= 0 then
  first:= Sqr(first)
  else
  exit;
  Edit1.Text:= FloatToStr(first);
  first:= 0;
   end;
end;

procedure TForm1.ButtonNEZClick(Sender: TObject);
begin
  if (Edit1.Text <> 'НЕЗЯ') and (Edit1.Text <> '') and (Edit1.Text <> '0') then
   begin
  first:= StrToFloat(Edit1.Text);
  first:= 1/(first);
  Edit1.Text:= FloatToStr(first);
  first:= 0;

   end;
end;

procedure TForm1.ButtonResultClick(Sender: TObject);
begin
  if (Edit1.Text <> 'НЕЗЯ') and (Edit1.Text <> '') then
  second := StrToFloat(Edit1.Text);

  Edit1.Clear;

  case znak of
    '+': res:= first + second;
    '-': res:= first - second;
    '*': res:= first * second;
    '/':
      if second <> 0 then
        res := first / second
      else
      begin
        Edit1.Text := 'НЕЗЯ';
        Exit;
      end;
  end;

  Edit1.Text := FloatToStr(res);
end;

procedure TForm1.Vvodsknopochek(Sender: TObject);
begin
  if (Edit1.Text = 'НЕЗЯ') then
  begin
   Edit1.Clear;
   Exit;
   end;
  if (Sender as TButton).Caption = '.' then
  begin
    if Pos('.', Edit1.Text) = 0 then
      Edit1.Text := Edit1.Text + '.'
  end
  else
    Edit1.Text := Edit1.Text + (Sender as TButton).Caption;
end;

procedure TForm1.Deistvie(Sender: TObject);
begin
  if (Edit1.Text <> 'НЕЗЯ') and (Edit1.Text <> '') then
  begin
  first:= StrToFloat(Edit1.Text);
  Edit1.Clear;
  znak:= (Sender as TButton).Caption;
  end
  else
  Edit1.Clear;
  Exit;
end;

end.

