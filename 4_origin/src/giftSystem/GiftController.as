package giftSystem
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import giftSystem.view.ClearingInterface;
   import giftSystem.view.GiftFrame;
   
   public class GiftController extends EventDispatcher
   {
      
      private static var _instance:GiftController;
       
      
      private var _giftFrame:GiftFrame;
      
      private var _CI:ClearingInterface;
      
      public function GiftController(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get Instance() : GiftController
      {
         if(_instance == null)
         {
            _instance = new GiftController();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(221),__sendStatus);
         GiftManager.Instance.addEventListener("giftOpenView",__onOpenView);
      }
      
      private function __onOpenView(event:GiftEvent) : void
      {
         new HelperUIModuleLoad().loadUIModule(["ddtbagandinfo"],onLoaded);
      }
      
      private function onLoaded() : void
      {
         _giftFrame = new GiftFrame();
         _giftFrame.backStyle = "SimpleFrameBackgound";
         _giftFrame.titleStyle = "FrameTitleTextStyle";
         _giftFrame.titleOuterRectPosString = "15,10,5";
         _giftFrame.closeInnerRectString = "44,19,6,30,14";
         _giftFrame.closestyle = "core.closebt";
         _giftFrame.width = 894;
         _giftFrame.height = 524;
         LayerManager.Instance.addToLayer(_giftFrame,3,true,2);
      }
      
      public function hideGiftFrame() : void
      {
         if(_giftFrame)
         {
            _giftFrame.dispose();
            _giftFrame = null;
            dispatchEvent(new Event("close"));
         }
      }
      
      private function __sendStatus(event:PkgEvent) : void
      {
         var sended:Boolean = event.pkg.readBoolean();
         if(sended)
         {
            GiftManager.Instance.loadRecord("GiftSendLog.ashx",PlayerManager.Instance.Self.ID);
         }
         dispatchEvent(new GiftEvent("sendGiftReturn",sended.toString()));
      }
      
      public function openClearingInterface(info:ShopItemInfo) : void
      {
         _CI = null;
         _CI = ComponentFactory.Instance.creatComponentByStylename("ClearingInterface");
         _CI.setName(GiftManager.Instance.rebackName);
         _CI.info = info;
         LayerManager.Instance.addToLayer(_CI,3,true,1);
      }
   }
}
