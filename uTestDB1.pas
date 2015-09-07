unit uTestDB1;

interface

uses
  Classes,
  TestFramework;

type
  TTestDB1 = class(TTestCase)
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestDB1_1;
    procedure TestDB1_2;
  end;

implementation

uses
  SysUtils,
  uTestedDBClass;

{ TTestDB1 }

procedure TTestDB1.SetUp;
begin
  inherited;
  TDBConnection.Connect;
end;

procedure TTestDB1.TearDown;
begin
  TDBConnection.Disconnect;
  inherited;
end;

procedure TTestDB1.TestDB1_1;
begin
  CheckTrue(TDBConnection.Connected, 'Not connected to DB!');
  CheckTrue(True);
end;

procedure TTestDB1.TestDB1_2;
begin
  CheckTrue(TDBConnection.Connected, 'Not connected to DB!');
  CheckTrue(True);
end;

initialization
  RegisterTest(TTestDB1.Suite);
end.