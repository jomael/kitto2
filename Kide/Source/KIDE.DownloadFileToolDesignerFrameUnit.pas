{-------------------------------------------------------------------------------
   Copyright 2012-2018 Ethea S.r.l.

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
-------------------------------------------------------------------------------}
unit KIDE.DownloadFileToolDesignerFrameUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, KIDE.EditNodeBaseFrameUnit,
  KIDE.BaseFrameUnit, KIDE.CodeEditorFrameUnit, Vcl.ExtCtrls, Vcl.Tabs,
  System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls,
  EF.Tree,
  KIDE.DataToolDesignerFrameUnit,
  //Download Tools
  Kitto.Ext.StandardControllers, Kitto.Ext.Tools;

type
  TDownloadFileToolDesignerFrame = class(TDataToolDesignerFrame)
    DownloadToolGroupBox: TGroupBox;
    _ClientFileName: TLabeledEdit;
    _FileName: TLabeledEdit;
    _ConfirmationMessage: TLabeledEdit;
    _ContentType: TLabeledEdit;
  private
  protected
    procedure HideFileNameEdit;
    class function SuitsNode(const ANode: TEFNode): Boolean; override;
    procedure CleanupDefaultsToEditNode; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  Kitto.Metadata.Views, Kitto.Ext.Controller;

{ TDownloadFileToolDesignerFrame }

procedure TDownloadFileToolDesignerFrame.CleanupDefaultsToEditNode;
begin
  inherited;
  CleanupTextNode('FileName');
  CleanupTextNode('ConfirmationMessage');
  CleanupTextNode('ContentType');
end;

procedure TDownloadFileToolDesignerFrame.HideFileNameEdit;
begin
  _FileName.Visible := False;
  DownloadToolGroupBox.Height := DownloadToolGroupBox.Height - _FileName.Height -
    _FileName.EditLabel.Height;
end;

class function TDownloadFileToolDesignerFrame.SuitsNode(
  const ANode: TEFNode): Boolean;
var
  LControllerClass: TClass;
begin
  Assert(Assigned(ANode));
  LControllerClass := GetControllerClass(ANode);
  Result := Assigned(LControllerClass) and
    LControllerClass.InheritsFrom(TKExtDownloadFileController);
end;

initialization
  TEditNodeFrameRegistry.Instance.RegisterClass(TDownloadFileToolDesignerFrame.GetClassId, TDownloadFileToolDesignerFrame);

finalization
  TEditNodeFrameRegistry.Instance.UnregisterClass(TDownloadFileToolDesignerFrame.GetClassId);

end.
