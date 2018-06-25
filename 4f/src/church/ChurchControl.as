package church{   import church.view.weddingRoom.frame.WeddingRoomGiftFrameView;   import com.pickgliss.ui.ComponentFactory;   import ddt.events.PkgEvent;   import ddt.manager.SocketManager;   import flash.events.Event;   import flash.events.EventDispatcher;      public class ChurchControl extends EventDispatcher   {            private static var _instance:ChurchControl;                   private var _weddingRoomGiftFrameView:WeddingRoomGiftFrameView;            public function ChurchControl() { super(); }
            public static function get instance() : ChurchControl { return null; }
            public function setup() : void { }
            private function __showGiftView(e:PkgEvent) : void { }
            private function closeRoomGift(evt:Event = null) : void { }
            public function closeRefundView() : void { }
   }}