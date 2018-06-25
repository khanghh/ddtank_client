package bagAndInfo.bag{   import auctionHouse.view.AuctionBagView;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.Frame;   import ddt.manager.PlayerManager;      public class BagFrames extends Frame   {                   protected var _bagView:BagView;            protected var _emailBagView:AuctionBagView;            protected var _isShow:Boolean;            public function BagFrames() { super(); }
            protected function initView() : void { }
            public function graySortBtn() : void { }
            private function initEvent() : void { }
            private function __responseHandler(evt:FrameEvent) : void { }
            public function get bagView() : BagView { return null; }
            public function get emailBagView() : AuctionBagView { return null; }
            public function show() : void { }
            public function hide() : void { }
            public function get isShow() : Boolean { return false; }
            override public function dispose() : void { }
   }}