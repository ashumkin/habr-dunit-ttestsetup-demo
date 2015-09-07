unit uTestDB1;

interface

uses
  Classes,
  TestFramework, TestExtensions;

type
  TTestDBSetup = class(TTestSetup)
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    // this method is not executed (for TTestSetup)
    procedure TestDBSetupTest;
  end;

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
  CheckTrue(TDBConnection.Connected, 'Not connected to DB!');
end;

procedure TTestDB1.TearDown;
begin
  inherited;
end;

procedure TTestDB1.TestDB1_1;
begin
  CheckTrue(True);
end;

procedure TTestDB1.TestDB1_2;
begin
  CheckTrue(True);
end;

{ TTestDBSetup }

procedure TTestDBSetup.TestDBSetupTest;
begin
  CheckTrue(True);
end;

procedure TTestDBSetup.SetUp;
begin
  inherited;
  TDBConnection.Connect;
end;

procedure TTestDBSetup.TearDown;
begin
  TDBConnection.Disconnect;
  inherited;
end;

initialization
  RegisterTest(TTestDBSetup.Create(TTestDB1.Suite));
end.