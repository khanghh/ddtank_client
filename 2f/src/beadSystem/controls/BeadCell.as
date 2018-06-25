package beadSystem.controls{   import bagAndInfo.bag.BagView;   import bagAndInfo.cell.BagCell;   import bagAndInfo.cell.DragEffect;   import baglocked.BaglockedManager;   import beadSystem.beadSystemManager;   import beadSystem.data.BeadEvent;   import beadSystem.model.BeadModel;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.events.CEvent;   import ddt.events.CellEvent;   import ddt.manager.BeadTemplateManager;   import ddt.manager.DragManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.view.tips.GoodTipInfo;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.MovieClip;   import flash.events.Event;   import flash.utils.getQualifiedClassName;   import store.view.embed.EmbedStoneCell;   import store.view.embed.EmbedUpLevelCell;      public class BeadCell extends BagCell   {                   private var _lockIcon:Bitmap;            private var _nameTxt:FilterFrameText;            private var _beadFeedMC:MovieClip;            private var _beadInfo:InventoryItemInfo;            private var _itemInfo:InventoryItemInfo;            private var beadFeedBtn:BeadFeedButton;            public function BeadCell(index:int, $info:ItemTemplateInfo = null, showLoading:Boolean = true, showTip:Boolean = true, bg:DisplayObject = null) { super(null,null,null,null); }
            public function get beadPlace() : int { return 0; }
            override public function dragDrop(effect:DragEffect) : void { }
            protected function __onBindRespones1(pEvent:FrameEvent) : void { }
            public function set itemInfo(value:InventoryItemInfo) : void { }
            override public function get itemInfo() : InventoryItemInfo { return null; }
            override public function dragStop(effect:DragEffect) : void { }
            override public function set locked(value:Boolean) : void { }
            public function FeedBead() : void { }
            private function __onCreateComplete(e:CEvent) : void { }
            private function insteadString(res:String, des:String) : String { return null; }
            private function boxPrompts() : void { }
            protected function __onConfigResponse(event:FrameEvent) : void { }
            protected function __onBindRespones(pEvent:FrameEvent) : void { }
            protected function __onFeedResponse(event:FrameEvent) : void { }
            private function __onFeedComplete(pEvent:Event) : void { }
            private function __onFeedStart(pEvent:Event) : void { }
            public function LockBead() : Boolean { return false; }
            private function onStack2(event:FrameEvent) : void { }
            override public function set info(value:ItemTemplateInfo) : void { }
            override public function dragStart() : void { }
            private function dragHidePicTxt() : void { }
            private function dragShowPicTxt() : void { }
            override protected function initTip() : void { }
            override public function dispose() : void { }
   }}