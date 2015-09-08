unit uTestDB3;

interface

uses
  Classes,
  TestFramework;

type
  TTestDB3 = class(TTestCase)
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestDB3_1;
    procedure TestDB3_2;
  end;

implementation

uses
  SysUtils,
  uTestedDBClass;

{ TTestDB3 }

procedure TTestDB3.SetUp;
begin
  inherited;
  CheckTrue(TDBConnection.Connected, 'Not connected to DB!');
end;

procedure TTestDB3.TearDown;
begin
  inherited;

end;

procedure TTestDB3.TestDB3_1;
begin
  CheckTrue(True);
end;

procedure TTestDB3.TestDB3_2;
begin
  CheckTrue(True);
end;

initialization
  RegisterTest('DB', TTestDB3.Suite);
end.