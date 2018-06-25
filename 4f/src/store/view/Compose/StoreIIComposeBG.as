package store.view.Compose{   import bagAndInfo.cell.BagCell;   import baglocked.BaglockedManager;   import com.pickgliss.effect.EffectManager;   import com.pickgliss.effect.IEffect;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.manager.NoviceDataManager;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.command.QuickBuyFrame;   import ddt.data.EquipType;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.quest.QuestInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.HelpFrameUtils;   import ddt.view.common.BuyItemButton;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.utils.Dictionary;   import quest.TaskManager;   import store.IStoreViewBG;   import store.ShowSuccessRate;   import store.StoneCell;   import store.StoreCell;   import store.StoreDragInArea;   import store.view.ConsortiaRateManager;   import store.view.StoneCellFrame;   import store.view.shortcutBuy.ShortcutBuyFrame;   import store.view.strength.MySmithLevel;   import trainer.controller.NewHandQueue;   import trainer.controller.WeakGuildManager;   import trainer.data.Step;   import trainer.view.NewHandContainer;      public class StoreIIComposeBG extends Sprite implements IStoreViewBG   {            private static const ITEMS:Array = [11004,11008,11012,11016];            public static const COMPOSE_TOP:int = 50;                   private var _area:StoreDragInArea;            private var _items:Array;            private var _bg:MutipleImage;            private var _luckyStoneCell:StoneCellFrame;            private var _strengthStoneCell:StoneCellFrame;            private var _equipmentCell:StoneCellFrame;            private var _compose_btn:BaseButton;            private var _compose_btn_shineEffect:IEffect;            private var _composeHelp:BaseButton;            private var cpsArr:MutipleImage;            private var _cBuyluckyBtn:BuyItemButton;            private var _buyStoneBtn:TextButton;            private var _composeTitle:Bitmap;            private var _pointArray:Vector.<Point>;            private var _showSuccessRate:ShowSuccessRate;            private var _consortiaSmith:MySmithLevel;            public var composeRate:Array;            public function StoreIIComposeBG() { super(); }
            private function init() : void { }
            private function getCellsPoint() : void { }
            public function dragDrop(source:BagCell) : void { }
            public function startShine(cellId:int) : void { }
            public function refreshData(items:Dictionary) : void { }
            public function updateData() : void { }
            public function stopShine() : void { }
            private function initEvent() : void { }
            private function userGuide() : void { }
            private function preWeaponTip() : void { }
            private function exeWeaponTip() : Boolean { return false; }
            private function finWeaponTip() : void { }
            private function preStoneTip() : void { }
            private function exeStoneTip() : Boolean { return false; }
            private function finStoneTip() : void { }
            private function disposeUserGuide() : void { }
            private function __buyStone(evt:MouseEvent) : void { }
            private function showArr() : void { }
            private function hideArr() : void { }
            public function get area() : Array { return null; }
            private function __composeClick(evt:MouseEvent) : void { }
            private function _responseV(evt:FrameEvent) : void { }
            private function _responseI(e:FrameEvent) : void { }
            private function sendSocket() : void { }
            private function checkTipBindType() : Boolean { return false; }
            private function __itemInfoChange(evt:Event) : void { }
            private function _showDontClickTip() : Boolean { return false; }
            private function getCountRate() : Number { return 0; }
            private function getCountRateI() : void { }
            public function consortiaRate() : void { }
            private function _consortiaLoadComplete(e:Event) : void { }
            public function show() : void { }
            public function hide() : void { }
            public function dispose() : void { }
   }}