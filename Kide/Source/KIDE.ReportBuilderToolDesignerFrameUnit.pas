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
unit KIDE.ReportBuilderToolDesignerFrameUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, KIDE.DownloadFileToolDesignerFrameUnit,
  KIDE.BaseFrameUnit, KIDE.CodeEditorFrameUnit, Vcl.ExtCtrls, Vcl.Tabs, EF.Tree,
  {$IFDEF REPORTBUILDER}Kitto.Ext.ReportBuilderTools,{$ENDIF}
  Vcl.StdCtrls, Kitto.Metadata.Models, System.Actions, Vcl.ActnList,
  Vcl.ComCtrls, Vcl.ToolWin;

type
  TReportBuilderToolDesignerFrame = class(TDownloadFileToolDesignerFrame)
    ReportBuilderlToolGroupBox: TGroupBox;
    _TemplateFileName: TLabeledEdit;
    _Design: TCheckBox;
  strict private
  protected
    class function SuitsNode(const ANode: TEFNode): Boolean; override;
    procedure UpdateDesignPanel(const AForce: Boolean = False); override;
    procedure CleanupDefaultsToEditNode; override;
  public
  end;

implementation

uses
  KIDE.EditNodeBaseFrameUnit;

{$R *.dfm}

{ TReportBuilderToolDesignerFrame }

procedure TReportBuilderToolDesignerFrame.CleanupDefaultsToEditNode;
begin
  inherited;
  CleanupBooleanNode('Design');
end;

class function TReportBuilderToolDesignerFrame.SuitsNode(const ANode: TEFNode): Boolean;
{$IFDEF REPORTBUILDER}
var
  LControllerClass: TClass;
  {$ENDIF}
begin
  {$IFDEF REPORTBUILDER}
    Assert(Assigned(ANode));
    LControllerClass := GetControllerClass(ANode);
    Result := Assigned(LControllerClass) and
      LControllerClass.InheritsFrom(TReportBuilderToolController);
  {$ELSE}
    Result := False
  {$ENDIF}
end;

procedure TReportBuilderToolDesignerFrame.UpdateDesignPanel(const AForce: Boolean);
begin
  inherited;
  HideFileNameEdit;
end;

initialization
  TEditNodeFrameRegistry.Instance.RegisterClass(TReportBuilderToolDesignerFrame.GetClassId, TReportBuilderToolDesignerFrame);

finalization
  TEditNodeFrameRegistry.Instance.UnregisterClass(TReportBuilderToolDesignerFrame.GetClassId);

end.