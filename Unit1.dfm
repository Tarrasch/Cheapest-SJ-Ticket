object Form1: TForm1
  Left = 0
  Top = 0
  Width = 521
  Height = 755
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 24
    Width = 513
    Height = 697
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Normal s'#246'kning'
      object Label7: TLabel
        Left = 32
        Top = 448
        Width = 28
        Height = 13
        Caption = 'Klass:'
      end
      object Button1: TButton
        Left = 416
        Top = 624
        Width = 75
        Height = 25
        Caption = 'S'#246'k'
        TabOrder = 0
        OnClick = Button1Click
      end
      object GroupBox1: TGroupBox
        Left = 24
        Top = 16
        Width = 457
        Height = 129
        Caption = 'Destination'
        TabOrder = 1
        object RadioButton1: TRadioButton
          Left = 32
          Top = 40
          Width = 145
          Height = 17
          Caption = 'Stockholm till G'#246'teborg'
          Checked = True
          TabOrder = 0
          TabStop = True
        end
        object RadioButton2: TRadioButton
          Left = 32
          Top = 80
          Width = 137
          Height = 17
          Caption = 'G'#246'teborg till Stockholm'
          TabOrder = 1
        end
      end
      object GroupBox2: TGroupBox
        Left = 24
        Top = 160
        Width = 457
        Height = 145
        Caption = 'Avg'#229'ngstid'
        TabOrder = 2
        object DateTimePicker1: TDateTimePicker
          Left = 208
          Top = 76
          Width = 186
          Height = 21
          Date = 38942.001822002310000000
          Time = 38942.001822002310000000
          TabOrder = 0
        end
        object ComboBox1: TComboBox
          Left = 24
          Top = 36
          Width = 145
          Height = 21
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 1
          Text = 'Jag vill resa efter'
          Items.Strings = (
            'Jag vill resa efter'
            'Jag vill vara framme senast')
        end
        object ComboBox2: TComboBox
          Left = 24
          Top = 76
          Width = 145
          Height = 21
          DropDownCount = 24
          ItemHeight = 13
          TabOrder = 2
          Text = 'Tid'
          Items.Strings = (
            '00.00'
            '01.00'
            '02.00'
            '03.00'
            '04.00'
            '05.00'
            '06.00'
            '07.00'
            '08.00'
            '09.00'
            '10.00'
            '11.00'
            '12.00'
            '13.00'
            '14.00'
            '15.00'
            '16.00'
            '17.00'
            '18.00'
            '19.00'
            '20.00'
            '21.00'
            '22.00'
            '23.00')
        end
      end
      object GroupBox3: TGroupBox
        Left = 24
        Top = 320
        Width = 457
        Height = 113
        Caption = 'Resen'#228'rer'
        TabOrder = 3
        object Label2: TLabel
          Left = 88
          Top = 24
          Width = 49
          Height = 13
          Caption = 'Ungdomar'
        end
        object Label3: TLabel
          Left = 168
          Top = 24
          Width = 56
          Height = 13
          Caption = 'Studerande'
        end
        object Label4: TLabel
          Left = 248
          Top = 24
          Width = 57
          Height = 13
          Caption = 'Pension'#228'rer'
        end
        object Label5: TLabel
          Left = 336
          Top = 24
          Width = 22
          Height = 13
          Caption = 'Barn'
        end
        object Label1: TLabel
          Left = 24
          Top = 24
          Width = 30
          Height = 13
          Caption = 'Vuxna'
        end
        object ComboBox3: TComboBox
          Left = 24
          Top = 56
          Width = 41
          Height = 21
          DropDownCount = 10
          ItemHeight = 13
          ItemIndex = 1
          TabOrder = 0
          Text = '1st'
          Items.Strings = (
            '0st'
            '1st'
            '2st'
            '3st'
            '4st'
            '5st'
            '6st'
            '7st'
            '8st'
            '9st')
        end
        object ComboBox4: TComboBox
          Left = 88
          Top = 56
          Width = 41
          Height = 21
          DropDownCount = 10
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 1
          Text = '0st'
          Items.Strings = (
            '0st'
            '1st'
            '2st'
            '3st'
            '4st'
            '5st'
            '6st'
            '7st'
            '8st'
            '9st')
        end
        object ComboBox5: TComboBox
          Left = 168
          Top = 56
          Width = 41
          Height = 21
          DropDownCount = 10
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 2
          Text = '0st'
          Items.Strings = (
            '0st'
            '1st'
            '2st'
            '3st'
            '4st'
            '5st'
            '6st'
            '7st'
            '8st'
            '9st')
        end
        object ComboBox6: TComboBox
          Left = 248
          Top = 56
          Width = 41
          Height = 21
          DropDownCount = 10
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 3
          Text = '0st'
          Items.Strings = (
            '0st'
            '1st'
            '2st'
            '3st'
            '4st'
            '5st'
            '6st'
            '7st'
            '8st'
            '9st')
        end
        object ComboBox7: TComboBox
          Left = 336
          Top = 56
          Width = 41
          Height = 21
          DropDownCount = 10
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 4
          Text = '0st'
          Items.Strings = (
            '0st'
            '1st'
            '2st'
            '3st'
            '4st'
            '5st'
            '6st'
            '7st'
            '8st'
            '9st')
        end
      end
      object ComboBox8: TComboBox
        Left = 32
        Top = 480
        Width = 145
        Height = 21
        ItemHeight = 13
        ItemIndex = 3
        TabOrder = 4
        Text = '2a klass'
        Items.Strings = (
          '1a klass Plus'
          '1a klass'
          '1a klass just nu'
          '2a klass'
          '2a klass '#246'ppen'
          '2a klass just nu'
          'sista minuten')
      end
      object Memo1: TMemo
        Left = 288
        Top = 480
        Width = 185
        Height = 89
        Lines.Strings = (
          '')
        TabOrder = 5
      end
      object Button2: TButton
        Left = 400
        Top = 544
        Width = 75
        Height = 25
        Caption = 'Button2'
        TabOrder = 6
        OnClick = Button2Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Resultat'
      ImageIndex = 1
      object Button3: TButton
        Left = 416
        Top = 632
        Width = 75
        Height = 25
        Caption = 'V'#228'lj'
        TabOrder = 0
        Visible = False
        OnClick = Button3Click
      end
      object Edit1: TEdit
        Left = 272
        Top = 632
        Width = 137
        Height = 21
        TabOrder = 1
        Text = 'Skriv Resan h'#228'r (nummer)'
        Visible = False
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Nya Priser :)'
      ImageIndex = 2
      object Label6: TLabel
        Left = 24
        Top = 24
        Width = 77
        Height = 13
        Caption = 'S'#246'kningar klara:'
      end
      object Label8: TLabel
        Left = 72
        Top = 96
        Width = 31
        Height = 13
        Caption = 'Label8'
      end
      object ProgressBar1: TProgressBar
        Left = 24
        Top = 40
        Width = 73
        Height = 17
        Max = 7
        TabOrder = 0
      end
    end
  end
  object IEHTTP1: TIEHTTP
    URL = 'http://www.sj.se/sales/searchTravel.do'
    Timeout = 90
    TimerIntervalSeconds = 0
    BlockingMode = True
    RequestMethod = 'POST'
    MultipartPOST = False
    Left = 488
  end
  object MainMenu1: TMainMenu
    Left = 464
  end
end
