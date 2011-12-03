program Project1;

{%File 'ModelSupport\Unit1\Unit1.txvpck'}
{%File 'ModelSupport\IEHTTP3\IEHTTP3.txvpck'}
{%File 'ModelSupport\iiehttp3_funcs\iiehttp3_funcs.txvpck'}
{%File 'ModelSupport\iehttp4_thread\iehttp4_thread.txvpck'}
{%File 'ModelSupport\default.txvpck'}

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  iehttp4_thread in 'D:\Program\Borland\Delphi2005\source\nerladdat\iehttp4_thread.pas',
  iiehttp3_funcs in 'D:\Program\Borland\Delphi2005\source\nerladdat\iiehttp3_funcs.pas',
  IEHTTP3 in 'D:\Program\Borland\Delphi2005\source\nerladdat\IEHTTP3.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

