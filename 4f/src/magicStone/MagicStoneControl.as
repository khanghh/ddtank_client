package magicStone{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.PkgEvent;   import ddt.manager.SocketManager;   import ddt.utils.AssetModuleLoader;   import flash.display.MovieClip;   import flash.events.Event;   import flash.events.EventDispatcher;   import magicStone.components.MgStoneCell;   import magicStone.event.MagicStoneEvent;   import magicStone.stoneExploreView.StoneExploreModel;   import magicStone.views.MagicStoneInfoView;   import magicStone.views.MagicStoneMainView;   import magicStone.views.MagicStoneShopFrame;   import road7th.comm.PackageIn;      public class MagicStoneControl extends EventDispatcher   {            public static const SHOWEXPLOREVIEW:String = "showExploreView";            private static var _instance:MagicStoneControl;                   public var singleFeedFunc:Function;            public var singleFeedCell:MgStoneCell;            public var mgStoneScore:int = 0;            private var _infoView:MagicStoneInfoView;            private var _shopFrame:MagicStoneShopFrame;            private var _upgradeMC:MovieClip;            public var isNoPrompt:Boolean;            public var isBatNoPrompt:Boolean;            public var isBand:Boolean;            public var isBatBand:Boolean;            public var magicStoneView:MagicStoneMainView;            public var isDoubleScore:Boolean;            private var _model:StoneExploreModel;            public function MagicStoneControl() { super(); }
            public static function get instance() : MagicStoneControl { return null; }
            public function setup() : void { }
            private function __MagicStoneMonsterInfo(event:CrazyTankSocketEvent) : void { }
            private function __getMagicStoneDoubleScore(event:CrazyTankSocketEvent) : void { }
            protected function __disposeView(event:MagicStoneEvent) : void { }
            private function __openView(event:MagicStoneEvent) : void { }
            private function openMagicStoneView() : void { }
            protected function __getMagicStoneScore(event:PkgEvent) : void { }
            public function playUpgradeMc() : void { }
            protected function __disposeUpgradeMC(event:Event) : void { }
            public function get infoView() : MagicStoneInfoView { return null; }
            public function set infoView(value:MagicStoneInfoView) : void { }
            public function get shopFrame() : MagicStoneShopFrame { return null; }
            public function set shopFrame(value:MagicStoneShopFrame) : void { }
            public function get model() : StoneExploreModel { return null; }
            public function set model(value:StoneExploreModel) : void { }
   }}