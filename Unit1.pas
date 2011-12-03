unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IEHTTP3, StdCtrls, ComCtrls, Menus,strutils;

type
  TForm1 = class(TForm)
    IEHTTP1: TIEHTTP;
    MainMenu1: TMainMenu;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Button1: TButton;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    GroupBox2: TGroupBox;
    DateTimePicker1: TDateTimePicker;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    ComboBox6: TComboBox;
    ComboBox7: TComboBox;
    ComboBox8: TComboBox;
    Label7: TLabel;
    Memo1: TMemo;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    TabSheet3: TTabSheet;
    ProgressBar1: TProgressBar;
    Label6: TLabel;
    Label8: TLabel;
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


 type
   TResa = class(TObject)
   Private
          Tidavgang : String;
          Tidankomst : String;
          Tidresa : String;
          Tagnr   : integer;
          Tillganglighet : String;
          Giltig  : Boolean;
          Pris  : string;

          Antalenkresor:  byte;
          Separatresa  :array of String;

          TagModoNr  :array of String;

          Info : array of String;

          htmdata:  Ansistring;
          tempbool: Boolean;
          Constructor create;
          Destructor destruct;
          procedure fyllupdata(Resan:TResa;htmdata:ansistring) ;
          procedure kontrolleraifallgiltig(Resan  :Tresa);
          procedure rengorseperatresa (Resan:TResa);
   end;
  type
   TSokning = class(TObject)
   private
     ResaOchDatum  :string;
     Biljettyp : string ;
     SvarfronServer:  Ansistring;

     Constructor create;
     Destructor destruct;
     procedure matainPoststrtillIE;
     procedure visaallt (Resor: array of TResa;Antalresor:byte ) ;
   end;

    Procedure SokOvisaresultat;
    Procedure Jamforresor(Resan: Tresa);
    Procedure Jamformed(Resan: Tresa;FranSTHLM :boolean;STHLMomrade:boolean; FranPlats:string;postdata:ansistring;Kallelsenamn:string );
    Function  TaredapoantalResor(Letai:string):integer;
var
  Form1: TForm1;
  Resor :  array of TResa ;
  Sokning : TSokning;
  Memos : array of TMemo;
  Vilkenresa :Tcombobox ;
  billigasthittils  : Integer;
  billigasteresa  : string;
  Topplats  : integer;


implementation






{$R *.dfm}

Function  TaredapoantalResor(Letai:string):integer;
var Integ:integer;
    Antalresor:byte;
begin
//Ta reda på antal resor som finns:
Integ:=0;
Antalresor:=0;
Repeat
Integ:=Posex('<td width="19" class="time',Letai,integ+1 );
AntalResor:=AntalResor+1;
Until Integ=0;
AntalResor:=AntalResor-1;
Result:=antalresor;
end;


Procedure Tsokning.matainPoststrtillIE;
Var
fron: string[5];
till: string[5];
Streng: string; //Jag vill resa efter = departAtTheEarliest  Jag vill vara framme senast = arriveAtTheLatest
Tid:  string;
heldatum:string;  //bara för behandling
dag:  string[2];
ar: string[4];
monad:  string[2];
Vuxna:  string[1];
Ungdomar: string[1];
Studenter: string[1];
Pensionerer:  string[1];
Barn: string[1];
Klass:string[2];


Begin

  if form1.RadioButton1.Checked=true then
    begin
    fron:='00001';
    till:='00002';
    end
  else
    begin
    fron:='00002';
    till:='00001';
    end;

  if form1.ComboBox1.ItemIndex=0 then
  Streng:='departAtTheEarliest'
  else
  Streng:='arriveAtTheLatest';

  if form1.ComboBox2.ItemIndex=-1 then
  halt
  else
  tid:= inttostr(form1.ComboBox2.ItemIndex);

  heldatum:=datetostr(form1.DateTimePicker1.Date);
  dag:=heldatum[9]+heldatum[10];
  ar:=heldatum[1]+heldatum[2]+heldatum[3]+heldatum[4];
  monad:=heldatum[6]+heldatum[7];

  Vuxna:=inttostr(form1.ComboBox3.ItemIndex);
  Ungdomar:=inttostr(form1.ComboBox4.ItemIndex);
  Studenter:=inttostr(form1.ComboBox5.ItemIndex);
  Pensionerer:=inttostr(form1.ComboBox6.ItemIndex);
  Barn:=inttostr(form1.ComboBox7.ItemIndex);

  Case form1.ComboBox8.ItemIndex of
  0:Klass:='AM';
  1:Klass:='AL';
  2:Klass:='F1';
  3:Klass:='NO';
  4:Klass:='OB';
  5:Klass:='FO';
  6:Klass:='SM';
  end;

Form1.IEHTTP1.poststr:='method=submitSearchInfo&d=108&a=1844&l=sv&viewNighttrain=false&viewVia=false&viewTimeBetweenTrains=false&viewAdvancedOptions=false&departureLocation='+fron+'%3A074&arrivalLocation='+till+'%3A074&searchDepartureLocation=&searchArrivalLocation=&departureChoice=sales.searchTravel.'+Streng+'.topOption.label&time='+tid+'&day='+dag+'&month='+ar+monad+'&returnDepartureChoice=&adults='+vuxna+'&youth='+ungdomar+'&students='+studenter+'&retired='+pensionerer+'&children='+barn+'&priceGroup='+klass+'&campaignCode=&priceGroup=NO&nightTrainsPriceGroup=&campaignCode=&viaLocation=&searchViaLocation=&timeBetweenTrains=0';

end;

Procedure Sokovisaresultat;
var AntalResor  : byte;
    aktivResa : byte;
    Integ  :  integer;
    posi  : integer;
    tmpstr  :ansistring;
begin

sokning:=Tsokning.create ;
sokning.matainPoststrtillIE;
form1.IEHTTP1.Execute;
sokning.matainPoststrtillIE;
sokning.SvarfronServer:=form1.IEHTTP1.result_sl.Text;
Antalresor:=TaredapoantalResor(sokning.SvarfronServer);
Setlength(Resor,antalresor);

// Låta samtliga Resor fylla sig med data
Integ:=0;
Integ:=Posex('<td width="19" class="time',sokning.SvarfronServer,integ+1 );
posi:=integ;
form1.Memo1.Lines.Add(sokning.SvarfronServer);
For aktivresa := 0 to (antalresor-1) do begin
If aktivresa=(antalresor-1) then   Integ:=Posex('<!-- end /sales/viewTravelsTravelTile.jsp -->',sokning.SvarfronServer,integ+1 )
else
Integ:=Posex('<td width="19" class="time',sokning.SvarfronServer,integ+1 );
tmpstr:= copy(sokning.SvarfronServer,posi,integ-posi);
posi:=integ+1;
Resor[aktivresa]:=TResa.create;
Resor[aktivresa].fyllupdata(Resor[aktivresa],tmpstr);
Resor[aktivresa].kontrolleraifallgiltig(Resor[aktivresa]  );
end;
Sokning.visaallt(Resor,antalresor );

end;

constructor TSokning.Create;
begin
end;

Destructor TSokning.destruct;
begin
end;

procedure Tresa.fyllupdata(Resan:TResa;htmdata:ansistring);
var
Integ : Integer;
Tempint:  Integer;
posi : Integer;
Forer:  byte;
bool  : Boolean;
tmpchar:string;
begin
Resan.htmdata:=htmdata;
//Söker och fyller up datan...
Resan.tempbool:=false;
Integ:=1;
Integ:=posex('align="right">',Resan.htmdata,Integ);
Integ:=Integ+14;
posi:=integ;
tmpchar:=Copy(resan.htmdata,posi,1);
if not((tmpchar='1') or (tmpchar='2') or (tmpchar='3') or (tmpchar='4') or (tmpchar='5') or (tmpchar='6') or (tmpchar='7') or (tmpchar='8') or (tmpchar='9'))
then begin
Resan.Pris:='';
Integ:=0;
Integ:=posex('<td width="13" class="time2">&nbsp;</td>',Resan.htmdata,Integ);end
else
resan.Pris:=Copy(resan.htmdata,posi,posex(' <',Resan.htmdata,posi)-posi-1);
Integ:=posex('<td width="49" class="time',Resan.htmdata,Integ);
Integ:=Integ+3;
Integ:=posex(Chr(9)+'<p>',Resan.htmdata,Integ);
Integ:=integ+4;
posi:=Integ;
Resan.Tillganglighet:=Copy(resan.htmdata,posi,posex('<',Resan.htmdata,posi)-posi);
Integ:=posex('<td width="35">&nbsp;</td>',Resan.htmdata,Integ);
Integ:=posex('<p>',Resan.htmdata,Integ);
Integ:=Integ+3;
Posi:=integ;
Resan.Tidavgang:=Copy(resan.htmdata,posi,5);


  TempInt:=0;
  Resan.Antalenkresor:=0 ;
  Repeat
  TempInt:=Posex('<td height="18">&',Resan.htmdata,Tempint+1 );
  Resan.Antalenkresor:=Resan.Antalenkresor+1;
  Until Tempint=0;
  Resan.Antalenkresor:=Resan.Antalenkresor-1;

Setlength(Resan.Separatresa,Resan.Antalenkresor);
Setlength(Resan.TagModoNr,Resan.Antalenkresor);
Setlength(Resan.Info,Resan.Antalenkresor);

For  forer:= 0 to (Resan.Antalenkresor-1) do begin
Resan.Separatresa[forer]:=Copy(resan.htmdata,posi,posex('</p>',Resan.htmdata,posi)-posi);
Integ:=posex('<p>',Resan.htmdata,Integ);
  Integ:=Integ+3;
  Posi:=Integ;
Resan.TagModoNr[forer]:=Copy(resan.htmdata,posi,posex('</p>',Resan.htmdata,posi)-posi);
Resan.Info[forer]:='';
bool:=false;

//Fylla in Info's såsom Rullstolsgrej o sånt
If  not(posex('<td height="18">&',Resan.htmdata,Integ)=0)  then  begin

  Repeat
  If   posex('src=''../sales/images/',Resan.htmdata,Integ)=0 then bool:=true else begin
  If  (posex('src=''../sales/images/',Resan.htmdata,Integ)<posex('<td height="18">&',Resan.htmdata,Integ+1)) then   begin
  Integ:=posex('src=''../sales/images/',Resan.htmdata,Integ);
  Integ:=Integ+21;
Integ:=posex('alt=''',Resan.htmdata,Integ);
  Integ:=Integ+5;
  Posi:=Integ;
Resan.Info[forer]:=Resan.Info[forer]+','+Copy(resan.htmdata,posi,posex('''',Resan.htmdata,posi)-posi)
end
else bool:=true; end;
until bool=true;
end
else   begin
   Repeat
   If  not (0=posex('src=''../sales/images/',Resan.htmdata,Integ)) then begin
     Integ:=posex('src=''../sales/images/',Resan.htmdata,Integ);
  Integ:=Integ+21;
Integ:=posex('alt=''',Resan.htmdata,Integ);
  Integ:=Integ+5;
  Posi:=Integ;
Resan.Info[forer]:=Resan.Info[forer]+','+Copy(resan.htmdata,posi,posex('''',Resan.htmdata,posi)-posi)
  end
  else bool:=true;

  until bool=true;
end;

Integ:=posex('<td height="18">&',Resan.htmdata,Integ);
Integ:=posex('<p>',Resan.htmdata,Integ);
Integ:=Integ+3;
Posi:=integ;



end;
Resan.rengorseperatresa(Resan);



end;

Destructor TResa.destruct;
begin
end;

procedure TSokning.visaallt(Resor:array of Tresa;Antalresor:  byte);
var
FranOtill :TLabel;
Forer1 :  byte;
Forer2 :  byte;

begin
Form1.PageControl1.SelectNextPage(true,true);
FranOtill:=Tlabel.Create(form1.TabSheet2) ;
Franotill.Parent:=Form1.TabSheet2;
If  form1.RadioButton1.Checked then
Franotill.Caption:='Stockholm till Göteborg '+datetostr(form1.DateTimePicker1.Date)
else
Franotill.Caption:='Göteborg till Stockholm '+datetostr(form1.DateTimePicker1.Date);
Franotill.Left:=24;
Franotill.Top:=24;
Setlength(Memos,Antalresor-1);
For Forer1:=0 to (Antalresor-1) do begin
Memos[forer1]:=Tmemo.Create(form1.TabSheet2);
With memos[forer1] do begin
Parent:=Form1.TabSheet2;
Left:=48;
Top:= 80+80*forer1;
height:=80;
width:=400;

end;
With memos[forer1] do begin
lines.Add('Pris: '+Resor[forer1].Pris);
lines.Add('Tillgänglighet: '+Resor[forer1].Tillganglighet);  end;
If Resor[forer1].Giltig then
memos[Forer1].Lines.Add('Valbar')
else
memos[forer1].Lines.Add('OValbar');
for Forer2:=0 to (Resor[forer1].Antalenkresor-1) do begin

With memos[forer1] do begin

lines.Add('Delresa '+inttostr(forer2+1))  ;
lines.Add(Resor[forer1].Separatresa[forer2]);
lines.Add(Resor[forer1].Tagmodonr[forer2])  ;
lines.Add('Infos: '+Resor[forer1].Info[forer2]);
end;
 end;
  end;

Form1.Button3.Visible:=true;
Form1.Edit1.Visible:=true;


end;

Procedure Jamforresor(Resan:Tresa);
var
PrisLabel : TLabel;
Postdatan : ansistring;
bool      : Boolean;
begin
Topplats:=96;
Form1.ProgressBar1.Position:=0;
bool:= Form1.RadioButton1.Checked;
postdatan:=Form1.IEHTTP1.postStr;
Billigasthittils:=strtoint(Resan.Pris);
Billigasteresa:=Resan.Separatresa[0];

Form1.PageControl1.SelectNextPage(True);

//  å-ä-ö = %C3%A5-%C3%A4-%C3%B6

Jamformed(Resan,bool,true,'Enk%C3%B6ping',Postdatan,'Enköping');
sleep(100);
Form1.ProgressBar1.Position:=Form1.ProgressBar1.Position+1;
Form1.Update;
Jamformed(Resan,bool,true,'Uppsala',Postdatan,'Uppsala');
sleep(100);
Form1.ProgressBar1.Position:=Form1.ProgressBar1.Position+1;
Form1.Update;
Jamformed(Resan,bool,true,'Sundbyberg',Postdatan,'Sundbyberg');
sleep(100);
Form1.ProgressBar1.Position:=Form1.ProgressBar1.Position+1;
Form1.Update;
Jamformed(Resan,bool,true,'B%C3%A5lsta',Postdatan,'Bålsta');
sleep(100);
Form1.ProgressBar1.Position:=Form1.ProgressBar1.Position+1;
Form1.Update;
Jamformed(Resan,bool,true,'V%C3%A4ster%C3%A5s',Postdatan,'Västerås');
sleep(100);
Form1.ProgressBar1.Position:=Form1.ProgressBar1.Position+1;
Form1.Update;
Jamformed(Resan,bool,true,'Flemmingsberg',Postdatan,'Flemmingsberg');
sleep(100);
Form1.ProgressBar1.Position:=Form1.ProgressBar1.Position+1;
Form1.Update;
Jamformed(Resan,bool,true,'S%C3%B6dert%C3%A4lje',Postdatan,'Södertälje');
sleep(100);
Form1.ProgressBar1.Position:=Form1.ProgressBar1.Position+1;
Form1.Update;
Jamformed(Resan,bool,false,'Lerum',Postdatan,'Lerum');
sleep(100);
Form1.ProgressBar1.Position:=Form1.ProgressBar1.Position+1;
Form1.Update;
Jamformed(Resan,bool,false,'M%C3%B6lnlycke',Postdatan,'Mölnlycke');
sleep(100);
Form1.ProgressBar1.Position:=Form1.ProgressBar1.Position+1;
Form1.Update;
Jamformed(Resan,bool,false,'Kungsbacka',Postdatan,'Kungsbacka');
sleep(100);
Form1.ProgressBar1.Position:=Form1.ProgressBar1.Position+1;
Form1.Update;
Jamformed(Resan,bool,false,'Kunga%C3%A4lv',Postdatan,'Kungaälv');
sleep(100);
Form1.ProgressBar1.Position:=Form1.ProgressBar1.Position+1;
Form1.Update;
Jamformed(Resan,bool,false,'Hisingen',Postdatan,'Hisingen');
sleep(100);
Form1.ProgressBar1.Position:=Form1.ProgressBar1.Position+1;
Form1.Update;
Jamformed(Resan,bool,false,'Tuve',Postdatan,'Tuve');
sleep(100);
Form1.ProgressBar1.Position:=Form1.ProgressBar1.Position+1;
Form1.Update;


end;

Procedure Jamformed(Resan: Tresa;FranSTHLM :boolean;STHLMomrade:boolean; Franplats:string;postdata:ansistring;Kallelsenamn:string);
var
Resa1 : array of TResa  ;
Resa2 : array of TResa  ;  // söker 2 Timmar innan
Resa3 : array of TResa  ;  // söker 4 Timmar innan
Resa4 : array of TResa  ;  // söker 2 Timmar efter
Resa5 : array of TResa  ;  // söker 4 Timmar efter

integ :integer;
posi  :integer;
antalresor: integer;
Aktivresa:  integer ;
tmpstr  :ansistring;
svarfronserver  : ansistring;
Forer1  :integer;
Forer2  :integer;
tmpchar :string;
hittaden:boolean;
Dennaresapris:  string;
PrisLabel : TLabel;

begin
Dennaresapris:='0';
hittaden:=false;
//Sätta till rätt destination och viaplats
If FranSTHLM and STHLMomrade then begin

Insert('00001%3A074',Postdata,500);
Insert(Franplats,Postdata,214);
delete(Postdata,150,11);
end;
If FranSTHLM and not(STHLMomrade) then begin

Insert('00002%3A074',Postdata,500);
Insert(Franplats,Postdata,243);
delete(Postdata,177,11);
end;
If not(franSTHLM) and STHLMomrade  then begin

Insert('00001%3A074',Postdata,500);
Insert(Franplats,Postdata,220);
delete(Postdata,177,11);
end;
If not(franSTHLM) and not(STHLMomrade)  then begin

Insert('00002%3A074',Postdata,500);
Insert(Franplats,Postdata,243);
delete(Postdata,150,11);
end;
delete(Postdata,72,5);
Insert('true',Postdata,72);
form1.IEHTTP1.postStr:=postdata;
// Headern är klar...
form1.IEHTTP1.ExecuteURL('http://www.sj.se/sales/searchTravel.do');
Svarfronserver:=form1.IEHTTP1.result_sl.GetText;

Antalresor:=TaredapoantalResor(Svarfronserver);
Setlength(Resa1,antalresor);

// Låta samtliga Resor fylla sig med data
Integ:=0;
Integ:=Posex('<td width="19" class="time',SvarfronServer,integ+1 );
posi:=integ;
form1.Memo1.Lines.Clear;
form1.Memo1.Lines.Add(SvarfronServer);
For aktivresa := 0 to (antalresor-1) do begin
If aktivresa=(antalresor-1) then   Integ:=Posex('<!-- end /sales/viewTravelsTravelTile.jsp -->',SvarfronServer,integ+1)
else
Integ:=Posex('<td width="19" class="time',SvarfronServer,integ+1 );
tmpstr:= copy(SvarfronServer,posi,integ-posi);
posi:=integ+1;
Resa1[aktivresa]:=TResa.create;
Resa1[aktivresa].fyllupdata(Resa1[aktivresa],tmpstr);
end;


For Forer1:= 0 to Antalresor-1 do
// Ifall det finns biljetter kvar...
IF not((Resa1[Forer1].Tillganglighet='Finns ej')or(Resa1[Forer1].Tillganglighet='Slut/Finns ej')) then
For Forer2:= 0 to Resa1[Forer1].Antalenkresor-1 do begin
If (Resan.Separatresa[0]=Resa1[Forer1].separatresa[Forer2]) and (Resan.TagModoNr[0]=Resa1[Forer1].Tagmodonr[Forer2]) then
begin
hittaden:=true;
Dennaresapris:=Resa1[Forer1].Pris;
If billigasthittils>strtoint(Resa1[Forer1].Pris) then begin
billigasthittils:=strtoint(Resa1[Forer1].Pris);
billigasteresa:=Franplats;
end;
end;  end;
//      KLAR!!! RESA1
//      KLAR!!! RESA1
//      KLAR!!! RESA1
//      KLAR!!! RESA1
//      KLAR!!! RESA1
//      KLAR!!! RESA1
//      KLAR!!! RESA1
//      KLAR!!! RESA1
//      KLAR!!! RESA1

if not(hittaden) then begin

IF Form1.ComboBox2.ItemIndex>=2 then begin  //ifall den kan söka tidigare
posi:=pos('&time=',postdata);
tmpchar:=copy(postdata,posi+7,1);
if not((tmpchar='0') or(tmpchar='1') or (tmpchar='2') or (tmpchar='3') or (tmpchar='4') or (tmpchar='5') or (tmpchar='6') or (tmpchar='7') or (tmpchar='8') or (tmpchar='9'))
then begin
delete(postdata,posi+6,1);
insert(inttostr(form1.ComboBox2.ItemIndex-2),postdata,posi+6);;
end
else begin
delete(postdata,posi+6,2);
insert(inttostr(form1.ComboBox2.ItemIndex-2),postdata,posi+6);
end;

// Headern är klar...
form1.IEHTTP1.postStr:=postdata;
form1.IEHTTP1.ExecuteURL('http://www.sj.se/sales/searchTravel.do');
Svarfronserver:=form1.IEHTTP1.result_sl.GetText;

Antalresor:=TaredapoantalResor(Svarfronserver);
Setlength(Resa2,antalresor);

// Låta samtliga Resor fylla sig med data
Integ:=0;
Integ:=Posex('<td width="19" class="time',SvarfronServer,integ+1 );
posi:=integ;
form1.Memo1.Lines.Clear;
form1.Memo1.Lines.Add(SvarfronServer);
For aktivresa := 0 to (antalresor-1) do begin
If aktivresa=(antalresor-1) then   Integ:=Posex('<!-- end /sales/viewTravelsTravelTile.jsp -->',SvarfronServer,integ+1)
else
Integ:=Posex('<td width="19" class="time',SvarfronServer,integ+1 );
tmpstr:= copy(SvarfronServer,posi,integ-posi);
posi:=integ+1;
Resa2[aktivresa]:=TResa.create;
Resa2[aktivresa].fyllupdata(Resa2[aktivresa],tmpstr);
end;


For Forer1:= 0 to Antalresor-1 do
// Ifall det finns biljetter kvar...
IF not((Resa2[Forer1].Tillganglighet='Finns ej')or(Resa2[Forer1].Tillganglighet='Slut/Finns ej')) then
For Forer2:= 0 to Resa2[Forer1].Antalenkresor-1 do begin
If (Resan.Separatresa[0]=Resa2[Forer1].separatresa[Forer2]) and (Resan.TagModoNr[0]=Resa2[Forer1].Tagmodonr[Forer2]) then
begin
hittaden:=true;
Dennaresapris:=Resa2[Forer1].Pris;
If billigasthittils>strtoint(Resa2[Forer1].Pris) then begin

billigasthittils:=strtoint(Resa2[Forer1].Pris);
billigasteresa:=Franplats;
end;
end;
end;    end; end;


//      KLAR!!! RESA2
//      KLAR!!! RESA2
//      KLAR!!! RESA2
//      KLAR!!! RESA2
//      KLAR!!! RESA2
//      KLAR!!! RESA2
//      KLAR!!! RESA2
//      KLAR!!! RESA2
//      KLAR!!! RESA2
if not(hittaden) then begin

IF Form1.ComboBox2.ItemIndex>=4 then begin  //ifall den kan söka tidigare
posi:=pos('&time=',postdata);
tmpchar:=copy(postdata,posi+7,1);
if not((tmpchar='0') or(tmpchar='1') or (tmpchar='2') or (tmpchar='3') or (tmpchar='4') or (tmpchar='5') or (tmpchar='6') or (tmpchar='7') or (tmpchar='8') or (tmpchar='9'))
then begin
delete(postdata,posi+6,1);
insert(inttostr(form1.ComboBox2.ItemIndex-4),postdata,posi+6);
end
else begin
delete(postdata,posi+6,2);
insert(inttostr(form1.ComboBox2.ItemIndex-4),postdata,posi+6);
end;

// Headern är klar...
form1.IEHTTP1.postStr:=postdata;
form1.IEHTTP1.ExecuteURL('http://www.sj.se/sales/searchTravel.do');
Svarfronserver:=form1.IEHTTP1.result_sl.GetText;

Antalresor:=TaredapoantalResor(Svarfronserver);
Setlength(Resa3,antalresor);

// Låta samtliga Resor fylla sig med data
Integ:=0;
Integ:=Posex('<td width="19" class="time',SvarfronServer,integ+1 );
posi:=integ;
form1.Memo1.Lines.Clear;
form1.Memo1.Lines.Add(SvarfronServer);
For aktivresa := 0 to (antalresor-1) do begin
If aktivresa=(antalresor-1) then   Integ:=Posex('<!-- end /sales/viewTravelsTravelTile.jsp -->',SvarfronServer,integ+1)
else
Integ:=Posex('<td width="19" class="time',SvarfronServer,integ+1 );
tmpstr:= copy(SvarfronServer,posi,integ-posi);
posi:=integ+1;
Resa3[aktivresa]:=TResa.create;
Resa3[aktivresa].fyllupdata(Resa3[aktivresa],tmpstr);
end;


For Forer1:= 0 to Antalresor-1 do
// Ifall det finns biljetter kvar...
IF not((Resa3[Forer1].Tillganglighet='Finns ej')or(Resa3[Forer1].Tillganglighet='Slut/Finns ej')) then
For Forer2:= 0 to Resa3[Forer1].Antalenkresor-1 do begin
If (Resan.Separatresa[0]=Resa3[Forer1].separatresa[Forer2]) and (Resan.TagModoNr[0]=Resa3[Forer1].Tagmodonr[Forer2]) then
begin
hittaden:=true;
Dennaresapris:=Resa3[Forer1].Pris ;
If billigasthittils>strtoint(Resa3[Forer1].Pris) then begin
billigasthittils:=strtoint(Resa3[Forer1].Pris);
billigasteresa:=Franplats;
end;
end; end; end;  end;

//      KLAR!!! RESA3
//      KLAR!!! RESA3
//      KLAR!!! RESA3
//      KLAR!!! RESA3
//      KLAR!!! RESA3
//      KLAR!!! RESA3
//      KLAR!!! RESA3
//      KLAR!!! RESA3
//      KLAR!!! RESA3


if not(hittaden) then begin

IF Form1.ComboBox2.ItemIndex>=21 then begin  //ifall den kan söka tidigare
posi:=pos('&time=',postdata);
tmpchar:=copy(postdata,posi+7,1);
if not((tmpchar='0') or(tmpchar='1') or (tmpchar='2') or (tmpchar='3') or (tmpchar='4') or (tmpchar='5') or (tmpchar='6') or (tmpchar='7') or (tmpchar='8') or (tmpchar='9'))
then begin
delete(postdata,posi+6,1);
insert(inttostr(form1.ComboBox2.ItemIndex+2),postdata,posi+6);
end
else begin
delete(postdata,posi+6,2);
insert(inttostr(form1.ComboBox2.ItemIndex+2),postdata,posi+6);
end;

// Headern är klar...
form1.IEHTTP1.postStr:=postdata;
form1.IEHTTP1.ExecuteURL('http://www.sj.se/sales/searchTravel.do');
Svarfronserver:=form1.IEHTTP1.result_sl.GetText;

Antalresor:=TaredapoantalResor(Svarfronserver);
Setlength(Resa4,antalresor);

// Låta samtliga Resor fylla sig med data
Integ:=0;
Integ:=Posex('<td width="19" class="time',SvarfronServer,integ+1 );
posi:=integ;
form1.Memo1.Lines.Clear;
form1.Memo1.Lines.Add(SvarfronServer);
For aktivresa := 0 to (antalresor-1) do begin
If aktivresa=(antalresor-1) then   Integ:=Posex('<!-- end /sales/viewTravelsTravelTile.jsp -->',SvarfronServer,integ+1)
else
Integ:=Posex('<td width="19" class="time',SvarfronServer,integ+1 );
tmpstr:= copy(SvarfronServer,posi,integ-posi);
posi:=integ+1;
Resa4[aktivresa]:=TResa.create;
Resa4[aktivresa].fyllupdata(Resa4[aktivresa],tmpstr);
end;


For Forer1:= 0 to Antalresor-1 do
// Ifall det finns biljetter kvar...
IF not((Resa4[Forer1].Tillganglighet='Finns ej')or(Resa4[Forer1].Tillganglighet='Slut/Finns ej')) then
For Forer2:= 0 to Resa4[Forer1].Antalenkresor-1 do begin
If (Resan.Separatresa[0]=Resa4[Forer1].separatresa[Forer2]) and (Resan.TagModoNr[0]=Resa4[Forer1].Tagmodonr[Forer2]) then
begin
hittaden:=true;
Dennaresapris:=Resa4[Forer1].Pris;
If billigasthittils>strtoint(Resa4[Forer1].Pris) then begin
billigasthittils:=strtoint(Resa4[Forer1].Pris);
billigasteresa:=Franplats;
end;
end; end; end; end;

//      KLAR!!! RESA4
//      KLAR!!! RESA4
//      KLAR!!! RESA4
//      KLAR!!! RESA4
//      KLAR!!! RESA4
//      KLAR!!! RESA4
//      KLAR!!! RESA4
//      KLAR!!! RESA4
//      KLAR!!! RESA4


if not(hittaden) then begin

IF Form1.ComboBox2.ItemIndex>=19 then begin  //ifall den kan söka tidigare
posi:=pos('&time=',postdata);
tmpchar:=copy(postdata,posi+7,1);
if not((tmpchar='0') or(tmpchar='1') or (tmpchar='2') or (tmpchar='3') or (tmpchar='4') or (tmpchar='5') or (tmpchar='6') or (tmpchar='7') or (tmpchar='8') or (tmpchar='9'))
then begin
delete(postdata,posi+6,1);
insert(inttostr(form1.ComboBox2.ItemIndex+4),postdata,posi+6);
end
else begin
delete(postdata,posi+6,2);
insert(inttostr(form1.ComboBox2.ItemIndex+4),postdata,posi+6);
end;

// Headern är klar...
form1.IEHTTP1.postStr:=postdata;
form1.IEHTTP1.ExecuteURL('http://www.sj.se/sales/searchTravel.do');
Svarfronserver:=form1.IEHTTP1.result_sl.GetText;

Antalresor:=TaredapoantalResor(Svarfronserver);
Setlength(Resa5,antalresor);

// Låta samtliga Resor fylla sig med data
Integ:=0;
Integ:=Posex('<td width="19" class="time',SvarfronServer,integ+1 );
posi:=integ;
form1.Memo1.Lines.Clear;
form1.Memo1.Lines.Add(SvarfronServer);
For aktivresa := 0 to (antalresor-1) do begin
If aktivresa=(antalresor-1) then   Integ:=Posex('<!-- end /sales/viewTravelsTravelTile.jsp -->',SvarfronServer,integ+1)
else
Integ:=Posex('<td width="19" class="time',SvarfronServer,integ+1 );
tmpstr:= copy(SvarfronServer,posi,integ-posi);
posi:=integ+1;
Resa5[aktivresa]:=TResa.create;
Resa5[aktivresa].fyllupdata(Resa5[aktivresa],tmpstr);
end;


For Forer1:= 0 to Antalresor-1 do
// Ifall det finns biljetter kvar...
IF not((Resa5[Forer1].Tillganglighet='Finns ej')or(Resa5[Forer1].Tillganglighet='Slut/Finns ej')) then
For Forer2:= 0 to Resa5[Forer1].Antalenkresor-1 do begin
If (Resan.Separatresa[0]=Resa5[Forer1].separatresa[Forer2]) and (Resan.TagModoNr[0]=Resa5[Forer1].Tagmodonr[Forer2]) then
begin
hittaden:=true;
Dennaresapris:=Resa5[Forer1].Pris;
If billigasthittils>strtoint(Resa5[Forer1].Pris) then begin
billigasthittils:=strtoint(Resa5[Forer1].Pris);
billigasteresa:=Franplats;
end;
end;end;end;end;


PrisLabel:=TLabel.Create(Form1.TabSheet2);
PrisLabel.Parent:=Form1.TabSheet3;
PrisLabel.Left:=72;
PrisLabel.Top:=Topplats;
If Dennaresapris='0' then
PrisLabel.Caption:=Kallelsenamn+':  Ingen liknande resa hittades vid '+Kallelsenamn
else
PrisLabel.Caption:=Kallelsenamn+':  '+Dennaresapris;
Topplats:=Topplats+16;











end;



Constructor TResa.create;
begin
end;

procedure TResa.kontrolleraifallgiltig(Resan  :Tresa);
Var Giltig  :boolean;
begin
Giltig:=True;
If not((copy(Resan.TagModoNr[0],0,6)='X 2000')) then
Giltig:=false;
IF (Resan.Tillganglighet='Finns ej')or(Resan.Tillganglighet='Slut/Finns ej') then
Giltig:=false;
Resan.Giltig:=giltig;
end;

procedure TResa.rengorseperatresa(Resan:TResa);
var forer : byte;
    Integ : Integer;
begin
//  å-ä-ö = %C3%A5-%C3%A4-%C3%B6    (=Ã¥-Ã¤-Ã¶)

for forer:=0 to Resan.Antalenkresor-1 do begin
delete(Resan.Separatresa[forer],6,6);
Integ:=pos('-',Resan.Separatresa[forer]);
delete(Resan.Separatresa[forer],Integ+1,6);
delete(Resan.Separatresa[forer],Integ+6,6);
Insert(' ',Resan.Separatresa[forer],6);
Integ:=posex(':',Resan.Separatresa[forer],4);
Insert(' ',Resan.Separatresa[forer],Integ+3);

Integ:= pos('Ã¥',Resan.Separatresa[forer]);
if not(integ=0) then
begin
delete(Resan.Separatresa[forer],Integ,2);
Insert('å',Resan.Separatresa[forer],integ); end;

Integ:= pos('Ã¥',Resan.Separatresa[forer]);
if not(integ=0) then
begin
delete(Resan.Separatresa[forer],Integ,2);
Insert('å',Resan.Separatresa[forer],integ); end;

Integ:= pos('Ã¤',Resan.Separatresa[forer]);
if not(integ=0) then
begin
delete(Resan.Separatresa[forer],Integ,2);
Insert('ä',Resan.Separatresa[forer],integ); end;

Integ:= pos('Ã¤',Resan.Separatresa[forer]);
if not(integ=0) then
begin
delete(Resan.Separatresa[forer],Integ,2);
Insert('ä',Resan.Separatresa[forer],integ); end;

Integ:= pos('Ã¶',Resan.Separatresa[forer]);
if not(integ=0) then
begin
delete(Resan.Separatresa[forer],Integ,2);
Insert('ö',Resan.Separatresa[forer],integ); end;

Integ:= pos('Ã¶',Resan.Separatresa[forer]);
if not(integ=0) then
begin
delete(Resan.Separatresa[forer],Integ,2);
Insert('ö',Resan.Separatresa[forer],integ); end;


end;
end;




procedure TForm1.Button1Click(Sender: TObject);
begin
Sokovisaresultat;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
form1.Memo1.Lines.SaveToFile('D:\a.htm');
end;



procedure TForm1.FormCreate(Sender: TObject);
begin
Form1.DateTimePicker1.Date:=Now;
end;



procedure TForm1.Button3Click(Sender: TObject);
begin
Jamforresor(Resor[strtoint(form1.Edit1.Text)-1]);
end;

end.


