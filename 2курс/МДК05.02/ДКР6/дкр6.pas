program Кольцевойдвусвязныйсписок;

const
  MAX_SIZE = 10;

type
  Node = record
    data: integer;
    next, prev: integer;
  end;

var
  list: array [1..MAX_SIZE] of Node;
  head, tail, free: integer;

procedure InitializeList();
var
  i: integer;
begin

  for i := 1 to MAX_SIZE do
  begin
    list[i].next := i + 1;
    list[i].prev := i - 1;
  end;
  list[MAX_SIZE].next := 1; 
  list[1].prev := MAX_SIZE;
  head := 0; 
  free := 1; 
end;

function CreateNode(value: integer): integer;//добавить элемент в список
var
  newNode: integer;
begin
  if free = 0 then 
  begin
    writeln('Не хватает памяти');
    Halt;
  end;
  newNode := free; 
  free := list[free].next; 
  list[newNode].data := value; 
  CreateNode := newNode; 
end;

procedure InsertFront(value: integer); 
var
  newNode: integer;
begin
  newNode := CreateNode(value); 
  if head = 0 then 
  begin
    head := newNode;
    tail := newNode;
  end
  else
  begin
    list[newNode].next := head; 
    list[head].prev := newNode; 
    head := newNode; 
  end;
end;

procedure DisplayList(); //показать список
var
  currentNode: integer;
begin
  if head = 0 then 
  begin
    writeln('Список пуст');
    Exit;
  end;
  currentNode := head;
  repeat
    if (list[currentNode].data <> 0) then 
      writeln('Data: ', list[currentNode].data);
    currentNode := list[currentNode].next;
  until currentNode = head; 
end;

procedure Menu(); //case menu
var
  choice, value: integer;
begin
  repeat
    writeln('1. Вставить элемент в начало списка');
    writeln('2. Вывести список');
    writeln('3. Выйти из программы');
    writeln('Выберите действие: ');
    readln(choice);
    case choice of
      1: begin
           writeln('Введите значение для нового элемента: ');
           readln(value);
           InsertFront(value);
         end;
      2: begin
           writeln('Список:');
           DisplayList();
         end;
      3: writeln('Выход из программы');
    else
      writeln('Неверный ввод. Пожалуйста, выберите существующий пункт меню.');
    end;
  until choice = 3;
end;

begin
  InitializeList();
  Menu();
end.
