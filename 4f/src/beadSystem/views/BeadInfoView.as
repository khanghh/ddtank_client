package beadSystem.views{   import baglocked.BaglockedManager;   import beadSystem.beadSystemManager;   import beadSystem.controls.BeadFeedProgress;   import beadSystem.controls.DrillItemInfo;   import beadSystem.controls.DrillSelectButton;   import beadSystem.data.BeadEvent;   import beadSystem.model.BeadModel;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.list.DropList;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.events.CellEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.HelpFrameUtils;   import ddt.view.character.ShowCharacter;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import quest.TaskManager;   import road7th.data.DictionaryData;   import store.data.HoleExpModel;   import store.view.embed.EmbedStoneCell;   import store.view.embed.EmbedUpLevelCell;   import store.view.embed.HoleExpBar;   import trainer.view.NewHandContainer;      public class BeadInfoView extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _character:ShowCharacter;            private var _pointArray:Vector.<Point>;            private var _progressLevel:BeadFeedProgress;            private var _holeExpBar:HoleExpBar;            public var _beadGetView:BeadGetView;            private var _openHoleBtn:TextButton;            private var _Cells:DictionaryData;            private var _HoleOpen:DictionaryData;            private var _stateList:DropList;            private var _stateSelectBtn:DrillSelectButton;            private var _beadHoleModel:HoleExpModel;            private var _beadUpGradeTxt:FilterFrameText;            private var _beadFeedCell:EmbedUpLevelCell;            private var _helpButton:BaseButton;            private var _max:int = 21;            private var _beadEnter:TextButton;            private var _frame:BeadAdvancedFrame;            public function BeadInfoView() { super(); }
            private function beadGuide() : void { }
            private function initView() : void { }
            override public function set visible(value:Boolean) : void { }
            private function loadStateList() : void { }
            private function __stateSelectClick(event:MouseEvent) : void { }
            private function drillSortFun(a:DrillItemInfo, b:DrillItemInfo) : int { return 0; }
            private function __feedCellChanged(pEvent:BeadEvent) : void { }
            private function __onOpenHoleClick(pEvent:MouseEvent) : void { }
            private function toShowNumberSelect(index:int, templateID:int) : void { }
            private function updateBtn() : void { }
            public function startShine(info:ItemTemplateInfo) : void { }
            public function stopShine() : void { }
            private function getSelectedHoleIndex() : int { return 0; }
            private function getHoleIndex(pID:int) : int { return 0; }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __beadEnterClickHandler(evt:MouseEvent) : void { }
            private function openBeadAvanceFrame() : void { }
            protected function __onPropBagUpdate(event:Event) : void { }
            private function __hideStateList(event:MouseEvent) : void { }
            private function __onOpenHole(pEvent:BeadEvent) : void { }
            private function initHoleExp() : void { }
            private function __LightBtn(pEvent:BeadEvent) : void { }
            private function __beadCellChanged(pEvent:Event) : void { }
            private function updateHoleProgress() : void { }
            protected function __clickHandler(evt:CellEvent) : void { }
            private function showDrill(value:int) : void { }
            private function __doubleClickHandler(event:CellEvent) : void { }
            private function getCellsPoint() : void { }
            private function initBeadEquip() : void { }
            private function __onFeedCellClick(pEvent:CellEvent) : void { }
            public function dispose() : void { }
   }}