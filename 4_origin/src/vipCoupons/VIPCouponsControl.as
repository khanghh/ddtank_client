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
      
      public function VIPCouponsControl(target:IEventDispatcher = null)
      {
         super(target);
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
      
      private function __openViewHandler(evt:CEvent) : void
      {
         _bagType = evt.data[0];
         _place = evt.data[1];
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
      
      protected function _responseHandle(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      protected function __sendHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var playerName:String = _frame.getnameInput.text;
         if(playerName == "")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("flowerGiving.flowerSendFrame.nameInputTxt"));
            return;
         }
         var vipCount:int = 0;
         vipCount = getItemCount(12568);
         if(vipCount <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("game.vipCoupons.sendVip.vipCouponsCount"));
            return;
         }
         var content:String = _frame.content.text;
         content = StringHelper.trim(content);
         content = FilterWordManager.filterWrod(content);
         content = StringHelper.rePlaceHtmlTextField(content);
         SocketManager.Instance.out.sendVipCoupons(_bagType,_place,1,content,playerName);
         dispose();
      }
      
      private function getItemCount(temId:int) : int
      {
         return PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(temId);
      }
      
      private function __useVipCouponsHandler(evt:CEvent) : void
      {
         if(_baseAlerFrame)
         {
            _baseAlerFrame.removeEventListener("response",__frameEvent);
            _baseAlerFrame.dispose();
            _baseAlerFrame = null;
         }
         _bagType = evt.data[0];
         _place = evt.data[1];
         _baseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("game.vipCoupons.useVipCouponsMgs"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
         _baseAlerFrame.addEventListener("response",__frameEvent);
      }
      
      private function __frameEvent(evt:FrameEvent) : void
      {
         var info:* = null;
         SoundManager.instance.play("008");
         if(_baseAlerFrame)
         {
            _baseAlerFrame.removeEventListener("response",__frameEvent);
            _baseAlerFrame.dispose();
            _baseAlerFrame = null;
         }
         if(evt.responseCode == 3)
         {
            info = ItemManager.fillByID(12569);
            SocketManager.Instance.out.sendUseCard(_bagType,_place,[info.TemplateID],info.PayType);
         }
      }
      
      private function __tasteVipCouponsHandler(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         var value:int = pkg.readInt();
         PlayerManager.Instance.Self.vipDiscount = value;
         var curDate:Date = TimeManager.Instance.Now();
         PlayerManager.Instance.Self.vipDiscountValidity = curDate;
         _baseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("game.vipCoupons.tasteVipCouponsMgs",100 - value * 10),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
         _baseAlerFrame.addEventListener("response",__tasteVipHandler);
      }
      
      private function __tasteVipHandler(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(_baseAlerFrame)
         {
            _baseAlerFrame.removeEventListener("response",__tasteVipHandler);
            _baseAlerFrame.dispose();
            _baseAlerFrame = null;
         }
         if(evt.responseCode == 3)
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
