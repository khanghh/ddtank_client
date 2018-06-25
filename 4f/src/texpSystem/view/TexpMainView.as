package texpSystem.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.tip.ITip;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.events.BagEvent;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.HelpFrameUtils;   import ddt.view.tips.GoodTipInfo;   import flash.geom.Point;   import morn.core.handlers.Handler;   import quest.TaskManager;   import shop.view.NewShopMultiBugleView;   import texpSystem.TexpEvent;   import texpSystem.controller.TexpManager;   import texpSystem.data.TexpInfo;   import texpSystem.view.mornui.TexpMainViewUI;   import trainer.view.NewHandContainer;      public class TexpMainView extends TexpMainViewUI   {                   private var _texpCell:TexpCell;            private var _currentType:int = -1;            private var _btnHelp:BaseButton;            private var _allInjectSCB:SelectedCheckButton;            public function TexpMainView() { super(); }
            override protected function initialize() : void { }
            private function texpGuide() : void { }
            public function clearInfo() : void { }
            public function startShine() : void { }
            public function stopShine() : void { }
            private function updateLevelLabel() : void { }
            private function __onClickBuyTexp(type:int) : void { }
            private function __onChange(evt:TexpEvent) : void { }
            private function __onPlayerPropertyEventHander(e:PlayerPropertyEvent) : void { }
            private function updateTexpLimitTxt() : void { }
            private function __onUpdateStoreBag(evt:BagEvent) : void { }
            private function updateView() : void { }
            private function __onSelectTabView(selectedIndex:int) : void { }
            private function __onSelectPropertyBtn(index:int) : void { }
            private function __onClickTexp() : void { }
            private function getGoodTipInfo(itemID:int) : GoodTipInfo { return null; }
            override public function dispose() : void { }
   }}