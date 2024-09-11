unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Grids, StdCtrls, Types;

type
  TLaptop = record
    Proizvoditel: string[50];
    Model: string[50];
    ComponentsMemo: string[200];
    Diagonal: string[20];
    Chastota: string[20];
    Price: Double;
  end;

type

  { TForm1 }

  TForm1 = class(TForm)
    AddButton: TButton;
    Clear: TButton;
    chastota: TEdit;
    EditButton: TButton;
    DeleteButton: TButton;
    proizvoditel: TEdit;
    model: TEdit;
    diagonal: TEdit;
    price: TEdit;
    ProizvoditelLB: TLabel;
    ModelLB: TLabel;
    ComponentsLB: TLabel;
    DiagonalLB: TLabel;
    PriceLB: TLabel;
    ChastotaLB: TLabel;
    ComponentsMemo: TMemo;
    StringGrid1: TStringGrid;
    procedure ClearClick(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure AddButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure EditLaptop(Index: Integer);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer; const Value: string);
  private
    Laptops: array of TLaptop;
    procedure LoadLaptops;
    procedure SaveLaptops;
    procedure UpdateGrid;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Caption := 'Ноутбуки';
  StringGrid1.ColCount := 7;
  StringGrid1.FixedCols := 0;
  StringGrid1.FixedRows := 1;
  StringGrid1.Cells[0, 0] := '№';
  StringGrid1.Cells[1, 0] := 'Производитель';
  StringGrid1.Cells[2, 0] := 'Модель';
  StringGrid1.Cells[3, 0] := 'Комплектующие';
  StringGrid1.Cells[4, 0] := 'Диагональ';
  StringGrid1.Cells[5, 0] := 'Частота';
  StringGrid1.Cells[6, 0] := 'Цена';
  StringGrid1.ColWidths[0] := 50;
  StringGrid1.ColWidths[1] := 100;
  StringGrid1.ColWidths[2] := 140;
  StringGrid1.ColWidths[3] := 180;
  StringGrid1.ColWidths[4] := 70;
  StringGrid1.ColWidths[5] := 70;
  StringGrid1.ColWidths[6] := 110;
  StringGrid1.DefaultRowHeight := 20;
  LoadLaptops;
  UpdateGrid;
  ComponentsMemo.clear;
  proizvoditel.Clear;
  model.Clear;
  chastota.Clear;
  diagonal.Clear;
  price.Clear;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin

  SaveLaptops;
end;

procedure TForm1.AddButtonClick(Sender: TObject);
var
  NewIndex: Integer;
begin
  Form1.Caption := 'Ноутбуки';
  NewIndex := Length(Laptops);
  SetLength(Laptops, NewIndex + 1);
  Laptops[NewIndex].Proizvoditel := proizvoditel.Text;
  Laptops[NewIndex].Model := model.Text;
  Laptops[NewIndex].Components := ComponentsMemo.Text;
  Laptops[NewIndex].Diagonal := diagonal.Text;
  Laptops[NewIndex].Chastota := chastota.Text;
  Laptops[NewIndex].Price := StrToFloatDef(price.Text, 0.0);
  UpdateGrid;
  StringGrid1.Row := NewIndex + 1;
  StringGrid1.Col := 1;
  StringGrid1.SetFocus;
  SaveLaptops;
end;

procedure TForm1.StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer; const Value: string);
var
  LaptopIndex: Integer;
begin
  if (ARow > 0) and (ACol > 0) then
  begin
    Form1.Caption := 'Ноутбуки';
    LaptopIndex := ARow - 1;
    if LaptopIndex < Length(Laptops) then
    begin
      case ACol of
        1: Laptops[LaptopIndex].Proizvoditel := Value;
        2: Laptops[LaptopIndex].Model := Value;
        3: Laptops[LaptopIndex].Components := Value;
        4: Laptops[LaptopIndex].Diagonal := Value;
        5: Laptops[LaptopIndex].Chastota := Value;
        6: Laptops[LaptopIndex].Price := StrToFloatDef(Value, 0.0);
      end;
      UpdateGrid;
      SaveLaptops;
    end;
  end;
end;

procedure TForm1.UpdateGrid;
var
  I: Integer;
begin
  Form1.Caption := 'Ноутбуки';
  StringGrid1.RowCount := Length(Laptops) + 1;
  for I := 0 to High(Laptops) do
  begin
    StringGrid1.Cells[0, I + 1] := IntToStr(I + 1);
    StringGrid1.Cells[1, I + 1] := Laptops[I].Proizvoditel;
    StringGrid1.Cells[2, I + 1] := Laptops[I].Model;
    StringGrid1.Cells[3, I + 1] := Laptops[I].Components;
    StringGrid1.Cells[4, I + 1] := Laptops[I].Diagonal + '"';
    StringGrid1.Cells[5, I + 1] := Laptops[I].Chastota + 'Hz';
    StringGrid1.Cells[6, I + 1] := FloatToStr(Laptops[I].Price) + ' ₽';
    StringGrid1.RowHeights[I + 1] := 65;
  end;
end;

procedure TForm1.LoadLaptops;
var

  f: file of TLaptop;
  Laptop: TLaptop;
begin
  Form1.Caption := 'Ноутбуки';
  SetLength(Laptops, 0);
  if FileExists('laptops.dat') then
  begin
    AssignFile(f, 'laptops.dat');
    try
      Reset(f);
      while not Eof(f) do
      begin
        Read(f, Laptop);
        SetLength(Laptops, Length(Laptops) + 1);
        Laptops[High(Laptops)] := Laptop;
      end;
    except
      on E: Exception do
        ShowMessage('Ошибка при загрузке данных: ' + E.Message);
    end;
    CloseFile(f);
  end;
end;

procedure TForm1.SaveLaptops;
var
  f: file of TLaptop;
  I: Integer;
begin
  Form1.Caption := 'Ноутбуки';
  AssignFile(f, 'laptops.dat');
  try
    Rewrite(f);
    for I := 0 to High(Laptops) do
    begin
      Write(f, Laptops[I]);
    end;
  except
    on E: Exception do
      ShowMessage('Ошибка при сохранении данных: ' + E.Message);
  end;
  CloseFile(f);
end;

procedure TForm1.DeleteButtonClick(Sender: TObject);
var
  SelectedRow: Integer;
begin
  Form1.Caption := 'Ноутбуки';
  SelectedRow := StringGrid1.Row - 1;
  if (SelectedRow >= 0) and (SelectedRow < Length(Laptops)) then
  begin
    if SelectedRow < Length(Laptops) - 1 then
      System.Move(Laptops[SelectedRow + 1], Laptops[SelectedRow], (Length(Laptops) - SelectedRow - 1) * SizeOf(TLaptop));
    SetLength(Laptops, Length(Laptops) - 1);
    UpdateGrid;
    SaveLaptops;
  end;
end;
procedure TForm1.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var

  Grid: TStringGrid;
  Text2: string;
  Flags: TTextStyle;
  Lines: TStringList;
  I: Integer;
  LineRect: TRect;
begin
  Form1.Caption := 'Ноутбуки';
  Grid := Sender as TStringGrid;
  if (ACol > 0) and (ARow > 0) then
  begin
    Text := Grid.Cells[ACol, ARow];
    // Отключаем выделение ячейки при отрисовке
    if gdSelected in State then
      Grid.Canvas.Brush.Color := clNone;
    // Устанавливаем флаги для переноса текста
    Flags.Alignment := taLeftJustify; // Выравнивание текста по левому краю
    Flags.Layout := tlTop; // Выравнивание текста по верхнему краю
    Flags.Wordbreak := True; // Разрешение переноса слов

    // Если столбец является столбцом с многострочным текстом (Memo),
    // то мы должны вручную разбить текст на строки и отрисовать каждую строку
    if ACol = 3 then // Предполагаем, что столбец с многострочным текстом - это 4-й (индекс 3)
    begin
      Lines := TStringList.Create;
      try
        Lines.Text := Text; // Разбиваем текст на строки
        LineRect := Rect; // Используем исходный прямоугольник для отрисовки каждой строки
        for I := 0 to Lines.Count - 1 do
        begin
          // Отрисовываем каждую строку текста
          Grid.Canvas.TextRect(LineRect, LineRect.Left + 2, LineRect.Top + 2, Lines[I], Flags);
          // Смещаем прямоугольник для следующей строки вниз
          Inc(LineRect.Top, Grid.Canvas.TextHeight('Wg')); // Примерное вычисление высоты строки
        end;
      finally
        Lines.Free;
      end;
    end
    else
    begin
      // Отрисовываем текст с переносом строк в обычных ячейках
      Grid.Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, Text, Flags);
    end;
  end;
end;

procedure TForm1.ClearClick(Sender: TObject);
begin
  Form1.Caption := 'Ноутбуки';
  ComponentsMemo.Clear;
  proizvoditel.Clear;
  model.Clear;
  chastota.Clear;
  diagonal.Clear;
  price.Clear;
end;

procedure TForm1.EditButtonClick(Sender: TObject);
var
  SelectedRow: Integer;
begin
  Form1.Caption := 'Ноутбуки';
  SelectedRow := StringGrid1.Row - 1;
  if (SelectedRow >= 0) and (SelectedRow < Length(Laptops)) then
  begin
    EditLaptop(SelectedRow); // Вызываем процедуру редактирования записи
  end;
end;

procedure TForm1.EditLaptop(Index: Integer);
begin
  Form1.Caption := 'Ноутбуки';
  // Заполняем поля формы данными выбранной записи
  proizvoditel.Text := Laptops[Index].Proizvoditel;
  model.Text := Laptops[Index].Model;
  ComponentsMemo.Text := Laptops[Index].Components;
  diagonal.Text := Laptops[Index].Diagonal;
  chastota.Text := Laptops[Index].Chastota;
  price.Text := FloatToStr(Laptops[Index].Price);
  // Сохраняем текущий индекс выбранной записи для дальнейшей обработки
  StringGrid1.Tag := Index;
end;
end.
