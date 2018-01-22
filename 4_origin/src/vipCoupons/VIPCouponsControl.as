package vipCoupons
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.AssetModuleLoader;
   import ddt.utils.FilterWordManager;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import road7th.comm.PackageIn;
   import road7th.utils.StringHelper;
   import vip.VipController;
   import vipCoupons.view.VIPCouponsFrame;
   
   public class VIPCouponsControl extends EventDispatcher
   {
      
      private static var _instance:VIPCouponsControl;
       
      
      private var _frame:VIPCouponsFrame;
      
      private var _baseAlerFrame:BaseAlerFrame;
      
      private var _bagType:int;
      
      private var _place:int;
      
      public function VIPCouponsControl(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : VIPCouponsControl
      {
         if(_instance == null)
         {
            _instance = new VIPCouponsControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         VIPCouponsManager.instance.addEventListener("vipCouponesOpenView",__openViewHandler);
         VIPCouponsManager.instance.addEventListener("useVipCoupons",__useVipCouponsHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(183),__tasteVipCouponsHandler);
      }
      
      private function __openViewHandler(param1:CEvent) : void
      {
         _bagType = param1.data[0];
         _place = param1.data[1];
         AssetModuleLoader.addModelLoader("vipCoupons",6);
         AssetModuleLoader.startCodeLoader(openFrame);
      }
      
      private function openFrame() : void
      {
         if(_frame)
         {
            ObjectUtils.disposeObject(_frame);
            _frame = null;
         }
         _frame = ComponentFactory.Instance.creatComponentByStylename("vipCoupons.mainFrame");
         LayerManager.Instance.addToLayer(_frame,3,true,1,true);
         if(_frame)
         {
            _frame.setVipPlace(_bagType,_place);
            _frame.addEventListener("response",_responseHandle);
            _frame.getSendButton.addEventListener("click",__sendHandler);
         }
      }
      
      protected function _responseHandle(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      protected function __sendHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc3_:String = _frame.getnameInput.text;
         if(_loc3_ == "")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("flowerGiving.flowerSendFrame.nameInputTxt"));
            return;
         }
         var _loc4_:int = 0;
         _loc4_ = getItemCount(12568);
         if(_loc4_ <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("game.vipCoupons.sendVip.vipCouponsCount"));
            return;
         }
         var _loc2_:String = _frame.content.text;
         _loc2_ = StringHelper.trim(_loc2_);
         _loc2_ = FilterWordManager.filterWrod(_loc2_);
         _loc2_ = StringHelper.rePlaceHtmlTextField(_loc2_);
         SocketManager.Instance.out.sendVipCoupons(_bagType,_place,1,_loc2_,_loc3_);
         dispose();
      }
      
      private function getItemCount(param1:int) : int
      {
         return PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(param1);
      }
      
      private function __useVipCouponsHandler(param1:CEvent) : void
      {
         if(_baseAlerFrame)
         {
            _baseAlerFrame.removeEventListener("response",__frameEvent);
            _baseAlerFrame.dispose();
            _baseAlerFrame = null;
         }
         _bagType = param1.data[0];
         _place = param1.data[1];
         _baseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("game.vipCoupons.useVipCouponsMgs"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
         _baseAlerFrame.addEventListener("response",__frameEvent);
      }
      
      private function __frameEvent(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(_baseAlerFrame)
         {
            _baseAlerFrame.removeEventListener("response",__frameEvent);
            _baseAlerFrame.dispose();
            _baseAlerFrame = null;
         }
         if(param1.responseCode == 3)
         {
            _loc2_ = ItemManager.fillByID(12569);
            SocketManager.Instance.out.sendUseCard(_bagType,_place,[_loc2_.TemplateID],_loc2_.PayType);
         }
      }
      
      private function __tasteVipCouponsHandler(param1:PkgEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         var _loc3_:int = _loc4_.readInt();
         PlayerManager.Instance.Self.vipDiscount = _loc3_;
         var _loc2_:Date = TimeManager.Instance.Now();
         PlayerManager.Instance.Self.vipDiscountValidity = _loc2_;
         _baseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("game.vipCoupons.tasteVipCouponsMgs",100 - _loc3_ * 10),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
         _baseAlerFrame.addEventListener("response",__tasteVipHandler);
      }
      
      private function __tasteVipHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(_baseAlerFrame)
         {
            _baseAlerFrame.removeEventListener("response",__tasteVipHandler);
            _baseAlerFrame.dispose();
            _baseAlerFrame = null;
         }
         if(param1.responseCode == 3)
         {
            VipController.instance.show();
         }
      }
      
      public function dispose() : void
      {
         if(_frame)
         {
            _frame.getSendButton.removeEventListener("click",__sendHandler);
            _frame.removeEventListener("response",_responseHandle);
            ObjectUtils.disposeObject(_frame);
            _frame = null;
         }
      }
   }
}
