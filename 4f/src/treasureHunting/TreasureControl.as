package treasureHunting{   import com.pickgliss.events.ComponentEvent;   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.analyze.InventoryItemAnalyzer;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.BagEvent;   import ddt.events.PkgEvent;   import ddt.loader.LoaderCreate;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.RouletteManager;   import ddt.manager.SocketManager;   import ddt.utils.HelperDataModuleLoad;   import ddt.view.UIModuleSmallLoading;   import ddt.view.caddyII.CaddyAwardListFrame;   import ddt.view.caddyII.CaddyModel;   import ddt.view.caddyII.LookTrophy;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.MouseEvent;   import flash.utils.Dictionary;   import road7th.comm.PackageIn;   import treasureHunting.event.TreasureEvent;   import treasureHunting.views.TreasureHuntingFrame;      public class TreasureControl extends EventDispatcher   {            private static var _instance:TreasureControl;                   private var _treasureFrame:TreasureHuntingFrame;            private var _func:Function;            private var _funcParams:Array;            private var _bagData:Dictionary;            private var _mask:Sprite;            private var _showPrize:LookTrophy;            private var _listView:CaddyAwardListFrame;            public var isMovieComplete:Boolean = true;            public var isAlert:Boolean = false;            public var lightIndexArr:Array;            public var msgStr:String;            public var countMsg:String;            public function TreasureControl() { super(); }
            public static function get instance() : TreasureControl { return null; }
            public function setup() : void { }
            protected function __onOpenView(event:Event) : void { }
            private function addTreasureFrame() : void { }
            private function loadComplete(analyze:InventoryItemAnalyzer) : void { }
            public function loadTreasureHuntingModule(complete:Function = null, completeParams:Array = null) : void { }
            private function onUimoduleLoadProgress(event:UIModuleEvent) : void { }
            private function loadCompleteHandler(event:UIModuleEvent) : void { }
            private function _update(event:BagEvent) : void { }
            private function onPayForHunting(event:PkgEvent) : void { }
            public function openShowPrize() : void { }
            private function lookTrophy() : void { }
            public function openRankPrize() : void { }
            private function onshowPrizeDispose(event:ComponentEvent) : void { }
            public function addMask() : void { }
            protected function __onRemoveMask(event:TreasureEvent) : void { }
            public function removeMask() : void { }
            private function onMaskClick(event:MouseEvent) : void { }
            public function checkBag() : Boolean { return false; }
            private function removeEvent() : void { }
            public function dispose() : void { }
            public function setFrame(frame:TreasureHuntingFrame) : void { }
   }}