unit uTestedDBClass;

interface

uses
  Classes;

type
  TDBConnection = class
  protected
    class var FConnected: Boolean;
  public
    class procedure Connect;
    class function Connected: Boolean;
    class procedure Disconnect;
  end;

implementation

uses
  SysUtils;

{ TDBConnection }

class procedure TDBConnection.Connect;
begin
  // invert FConnected to catch disbalance of Connect/Disconnect calls
  FConnected := not FConnected;
end;

class function TDBConnection.Connected: Boolean;
begin
  Result := FConnected;
end;

class procedure TDBConnection.Disconnect;
begin
  // invert FConnected to catch disbalance of Connect/Disconnect calls
  FConnected := not FConnected;
end;

initialization
  // init FConnected with False
  TDBConnection.FConnected := False;
end.
