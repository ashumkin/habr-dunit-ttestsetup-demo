unit uTestDB1;

interface

uses
  Classes,
  TestFramework, TestExtensions;

type
  TTestDBSetup = class(TTestSetup, ITestSuite)
  protected
    function CountTestsInterfaces: Integer;
    function CountEnabledTestInterfaces: Integer;
  public
    procedure SetUp; override;
    procedure TearDown; override;

    function CountTestCases: Integer; override;
    function CountEnabledTestCases: Integer; override;

    function GetName: string; override;
    procedure RunTest(ATestResult: TTestResult); override;
    procedure AddTest(test: ITest);
    procedure AddSuite(suite : ITestSuite);
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

  TTestDB2 = class(TTestCase)
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestDB2_1;
    procedure TestDB2_2;
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

procedure TTestDBSetup.AddSuite(suite: ITestSuite);
begin
  AddTest(suite);
end;

procedure TTestDBSetup.AddTest(test: ITest);
begin
  Assert(Assigned(test));

  FTests.Add(test);
end;

function TTestDBSetup.CountEnabledTestCases: Integer;
begin
  Result := inherited CountEnabledTestCases;
  if Enabled then
    Inc(Result, CountEnabledTestInterfaces);
end;

function TTestDBSetup.CountEnabledTestInterfaces: Integer;
var
  i: Integer;
begin
  Result := 0;
  // skip FIRST test case (it is FTest)
  for i := 1 to FTests.Count - 1 do
    if (FTests[i] as ITest).Enabled then
      Inc(Result, (FTests[i] as ITest).CountEnabledTestCases);
end;

function TTestDBSetup.CountTestCases: Integer;
begin
  Result := inherited CountTestCases;
  if Enabled then
    Inc(Result, CountTestsInterfaces);
end;

function TTestDBSetup.CountTestsInterfaces: Integer;
var
  i: Integer;
begin
  Result := 0;
  // skip FIRST test case (it is FTest)
  for i := 1 to FTests.Count - 1 do
    Inc(Result, (FTests[i] as ITest).CountTestCases);
end;

function TTestDBSetup.GetName: string;
begin
  Result := FTestName;
end;

procedure TTestDBSetup.RunTest(ATestResult: TTestResult);
var
  i: Integer;
begin
  inherited;
  // skip FIRST test case (it is FTest)
  for i := 1 to FTests.Count - 1 do
    (FTests[i] as ITest).RunWithFixture(ATestResult);
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

{ TTestDB2 }

procedure TTestDB2.SetUp;
begin
  inherited;
  CheckTrue(TDBConnection.Connected, 'Not connected to DB!');
end;

procedure TTestDB2.TearDown;
begin
  inherited;

end;

procedure TTestDB2.TestDB2_1;
begin
  CheckTrue(True);
end;

procedure TTestDB2.TestDB2_2;
begin
  CheckTrue(True);
end;

function DBSuite: ITestSuite;
begin
  Result := TTestSuite.Create('DB tests');
  Result.AddTest(TTestDB1.Suite);
  Result.AddTest(TTestDB2.Suite);
end;

initialization
  RegisterTest(TTestDBSetup.Create(DBSuite, 'DB'));
end.
