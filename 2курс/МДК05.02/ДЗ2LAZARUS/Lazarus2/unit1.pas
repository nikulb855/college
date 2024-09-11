unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Math, Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit5: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var a,b,x,e:integer;
  f:real;
begin
  a:=StrToInt(Edit1.text);
  b:=StrToInt(Edit2.text);
  x:=Strtoint(Edit3.text);
  f:= sqr(a)*x+exp(-x)*cos(b*x)/b*x-exp(-x)*sin(b*x)+1;
  edit5.text:=floattostr(f);
end;

end.

