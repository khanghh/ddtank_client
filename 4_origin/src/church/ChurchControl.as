package church
{
   import church.view.weddingRoom.frame.WeddingRoomGiftFrameView;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.events.PkgEvent;
   import ddt.manager.SocketManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class ChurchControl extends EventDispatcher
   {
      
      private static var _instance:ChurchControl;
       
      
      private var _weddingRoomGiftFrameView:WeddingRoomGiftFrameView;
      
      public function ChurchControl()
      {
         super();
      }
      
      public static function get instance() : ChurchControl
      {
         if(!_instance)
         {
            _instance = new ChurchControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(249,12),__showGiftView);
      }
      
      private function __showGiftView(param1:PkgEvent) : void
      {
         param1.pkg.readByte();
         var _loc2_:int = param1.pkg.readInt();
         if(_weddingRoomGiftFrameView)
         {
            if(_weddingRoomGiftFrameView.parent)
            {
               _weddingRoomGiftFrameView.parent.removeChild(_weddingRoomGiftFrameView);
            }
            _weddingRoomGiftFrameView.removeEventListener("close",closeRoomGift);
            _weddingRoomGiftFrameView.dispose();
            _weddingRoomGiftFrameView = null;
         }
         else
         {
            _weddingRoomGiftFrameView = ComponentFactory.Instance.creat("church.weddingRoom.frame.WeddingRoomGiftFrameView");
            _weddingRoomGiftFrameView.addEventListener("close",closeRoomGift);
            _weddingRoomGiftFrameView.txtMoney = _loc2_.toString();
            _weddingRoomGiftFrameView.show();
         }
      }
      
      private function closeRoomGift(param1:Event = null) : void
      {
         if(_weddingRoomGiftFrameView)
         {
            _weddingRoomGiftFrameView.removeEventListener("close",closeRoomGift);
            if(_weddingRoomGiftFrameView.parent)
            {
               _weddingRoomGiftFrameView.parent.removeChild(_weddingRoomGiftFrameView);
            }
            _weddingRoomGiftFrameView.dispose();
         }
         _weddingRoomGiftFrameView = null;
      }
      
      public function closeRefundView() : void
      {
         if(_weddingRoomGiftFrameView)
         {
            if(_weddingRoomGiftFrameView.parent)
            {
               _weddingRoomGiftFrameView.parent.removeChild(_weddingRoomGiftFrameView);
            }
            _weddingRoomGiftFrameView.removeEventListener("close",closeRoomGift);
            _weddingRoomGiftFrameView.dispose();
            _weddingRoomGiftFrameView = null;
         }
      }
   }
}
