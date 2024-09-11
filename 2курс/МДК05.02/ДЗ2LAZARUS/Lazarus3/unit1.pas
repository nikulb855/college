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
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
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
var R, n:integer;
  a,b,diagonal,ploshad:real;
begin
  R:= strtoint(edit1.text);
  n:= strtoint(edit2.text);
  a:= sqrt((R*R)/(1+n*n));
  b:=n*a;
  diagonal:=sqrt(a*a+b*b);
  ploshad:= a*b;
  edit3.text:=floattostr(diagonal);
  edit4.text:=floattostr(ploshad);
end;

end.

