{*******************************************************************}
{                                                                   }
{   Kide2 Editor: GUI for Kitto2                                    }
{                                                                   }
{   Copyright (c) 2012-2017 Ethea S.r.l.                            }
{   ALL RIGHTS RESERVED / TUTTI I DIRITTI RISERVATI                 }
{                                                                   }
{*******************************************************************}
{                                                                   }
{   The entire contents of this file is protected by                }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM ETHEA S.R.L.                                }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}
{                                                                   }
{   Il contenuto di questo file � protetto dalle leggi              }
{   internazionali sul Copyright. Sono vietate la riproduzione, il  }
{   reverse-engineering e la distribuzione non autorizzate di tutto }
{   o parte del codice contenuto in questo file. Ogni infrazione    }
{   sar� perseguita civilmente e penalmente a termini di legge.     }
{                                                                   }
{   RESTRIZIONI                                                     }
{                                                                   }
{   SONO VIETATE, SENZA IL CONSENSO SCRITTO DA PARTE DI             }
{   ETHEA S.R.L., LA COPIA, LA VENDITA, LA DISTRIBUZIONE E IL       }
{   TRASFERIMENTO A TERZI, A QUALUNQUE TITOLO, DEL CODICE SORGENTE  }
{   CONTENUTO IN QUESTO FILE E ALTRI FILE AD ESSO COLLEGATI.        }
{                                                                   }
{   SI FACCIA RIFERIMENTO ALLA LICENZA D'USO PER INFORMAZIONI SU    }
{   EVENTUALI RESTRIZIONI ULTERIORI.                                }
{                                                                   }
{*******************************************************************}
unit KIDE.ViewTableFormGridDesignerFrameUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, KIDE.EditNodeBaseFrameUnit,
  Vcl.ExtCtrls, Vcl.Tabs,
  System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.Buttons,
  KIDE.BaseFrameUnit, KIDE.CodeEditorFrameUnit,
  EF.Tree, Vcl.Samples.Spin, Vcl.StdActns,
  KIDE.MainDataModuleUnit;

type
  TViewTableFormGridDesignerFrame = class(TEditNodeBaseFrame)
    FormGridGroupBox: TGroupBox;
    FileOpenLayoutAction: TFileOpen;
    ViewNameSpeedButton: TSpeedButton;
    _Layout: TLabeledEdit;
    procedure FileOpenLayoutActionAccept(Sender: TObject);
    procedure FileOpenLayoutActionBeforeExecute(Sender: TObject);
  private
  protected
    class function SuitsNode(const ANode: TEFNode): Boolean; override;
    procedure UpdateDesignPanel(const AForce: Boolean = False); override;
    procedure CleanupDefaultsToEditNode; override;
    procedure DesignPanelToEditNode; override;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    class function IsViewTableFormOrGridNode(const ANode: TEFNode): Boolean;
  end;

implementation

{$R *.dfm}

uses
  StrUtils,
  EF.Macros,
  Kitto.Ext.Controller, Kitto.Ext.Base,
  Kitto.Ext.Form,
  KIDE.Project, KIDE.Config, KIDE.MainTableControllerDesignerFrameUnit;

{ TViewTableFormControllerDesignerFrame }

procedure TViewTableFormGridDesignerFrame.CleanupDefaultsToEditNode;
begin
  inherited;
  CleanupTextNode('Layout');
end;

constructor TViewTableFormGridDesignerFrame.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TViewTableFormGridDesignerFrame.DesignPanelToEditNode;
begin
  inherited;
end;

procedure TViewTableFormGridDesignerFrame.FileOpenLayoutActionAccept(
  Sender: TObject);
var
  LFileName: string;
begin
  inherited;
  LFileName := ExtractFileName(FileOpenLayoutAction.Dialog.FileName);
  if SameText(ExtractFileExt(LFileName), '.yaml') then
    LFileName := Copy(LFileName, 1, length(LFileName)-5);
  _Layout.Text := LFileName;
end;

procedure TViewTableFormGridDesignerFrame.FileOpenLayoutActionBeforeExecute(
  Sender: TObject);
begin
  inherited;
  FileOpenLayoutAction.Dialog.InitialDir := TProject.CurrentProject.Config.Views.Layouts.Path;
end;

class function TViewTableFormGridDesignerFrame.IsViewTableFormOrGridNode(
  const ANode: TEFNode): Boolean;
begin
  Result := MatchText(ANode.Name, ['Form','Grid']) and (ANode.Parent is TEFNode) and
    TMainTableControllerDesignerFrame.IsViewTableControllerNode(TEFNode(ANode.Parent));
end;

class function TViewTableFormGridDesignerFrame.SuitsNode(
  const ANode: TEFNode): Boolean;
begin
  Assert(Assigned(ANode));
  Result := IsViewTableFormOrGridNode(ANode);
end;

procedure TViewTableFormGridDesignerFrame.UpdateDesignPanel(
  const AForce: Boolean);
begin
  inherited;
  Assert(Assigned(EditNode));
end;

initialization
  TEditNodeFrameRegistry.Instance.RegisterClass(TViewTableFormGridDesignerFrame.GetClassId, TViewTableFormGridDesignerFrame);

finalization
  TEditNodeFrameRegistry.Instance.UnregisterClass(TViewTableFormGridDesignerFrame.GetClassId);

end.