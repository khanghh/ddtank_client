package vip.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class VipFrameHeadOne extends Sprite implements Disposeable
   {
       
      
      private var _topBG:ScaleBitmapImage;
      
      private var _buyPackageBtn:BaseButton;
      
      private var _dueDataWord:FilterFrameText;
      
      private var _dueData:FilterFrameText;
      
      private var _buyPackageTxt:FilterFrameText;
      
      private var _buyPackageTxt1:FilterFrameText;
      
      private var _price:int = 6680;
      
      public function VipFrameHeadOne()
      {
         super();
         _init();
         addEvent();
      }
      
      private function _init() : void
      {
         _topBG = ComponentFactory.Instance.creatComponentByStylename("VIPFrame.topBG1");
         _buyPackageBtn = ComponentFactory.Instance.creatComponentByStylename("vip.buyPackageBtn");
         _buyPackageTxt = ComponentFactory.Instance.creatComponentByStylename("vip.buyPackageTxt");
         _buyPackageTxt.text = LanguageMgr.GetTranslation("ddt.vip.vipFrameHead.text");
         _buyPackageTxt1 = ComponentFactory.Instance.creatComponentByStylename("vip.buyPackageTxt");
         PositionUtils.setPos(_buyPackageTxt1,"buyPackagePos");
         _buyPackageTxt1.text = LanguageMgr.GetTranslation("ddt.vip.vipFrameHead.text1");
         _dueDataWord = ComponentFactory.Instance.creatComponentByStylename("VipStatusView.dueDateFontTxt");
         _dueDataWord.text = LanguageMgr.GetTranslation("ddt.vip.dueDateFontTxt");
         PositionUtils.setPos(_dueDataWord,"dueDataWordTxtPos");
         _dueData = ComponentFactory.Instance.creat("VipStatusView.dueDate");
         PositionUtils.setPos(_dueData,"dueDataTxtPos");
         addChild(_topBG);
         addChild(_buyPackageBtn);
         addChild(_buyPackageTxt);
         addChild(_buyPackageTxt1);
         addChild(_dueDataWord);
         addChild(_dueData);
         upView();
      }
      
      private function addEvent() : void
      {
         PlayerManager.Instance.Self.addEventListener("propertychange",__propertyChange);
         _buyPackageBtn.addEventListener("click",__onBuyClick);
      }
      
      private function __onBuyClick(event:MouseEvent) : void
      {
         event.stopImmediatePropagation();
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PlayerManager.Instance.Self.Money < _price)
         {
            LeavePageManager.showFillFrame();
            return;
         }
         var alert1:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.vip.view.buyVipGift"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
         alert1.mouseEnabled = false;
         alert1.addEventListener("response",_responseI);
      }
      
      private function _responseI(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (event.currentTarget as BaseAlerFrame).removeEventListener("response",_responseI);
         if(event.responseCode == 3 || event.responseCode == 2)
         {
            dobuy();
         }
         ObjectUtils.disposeObject(event.target);
      }
      
      private function dobuy() : void
      {
         var items:Array = [];
         var types:Array = [];
         var colors:Array = [];
         var dresses:Array = [];
         var places:Array = [];
         var goodsTypes:Array = [];
         var _info:ItemTemplateInfo = ItemManager.Instance.getTemplateById(112164);
         items.push(_info.TemplateID);
         types.push("1");
         colors.push("");
         dresses.push("");
         places.push("");
         goodsTypes.push("1");
         SocketManager.Instance.out.sendBuyGoods(items,types,colors,places,dresses,null,0,goodsTypes);
      }
      
      private function removeEvent() : void
      {
         PlayerManager.Instance.Self.removeEventListener("propertychange",__propertyChange);
         _buyPackageBtn.removeEventListener("click",__onBuyClick);
      }
      
      private function __propertyChange(event:PlayerPropertyEvent) : void
      {
         if(event.changedProperties["isVip"] || event.changedProperties["VipExpireDay"] || event.changedProperties["VIPNextLevelDaysNeeded"])
         {
            upView();
         }
      }
      
      private function upView() : void
      {
         var date:Date = PlayerManager.Instance.Self.VIPExpireDay as Date;
         _dueData.text = date.fullYear + "-" + (date.month + 1) + "-" + date.date;
         if(!PlayerManager.Instance.Self.IsVIP)
         {
            _dueData.text = "";
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_topBG)
         {
            ObjectUtils.disposeObject(_topBG);
         }
         _topBG = null;
         if(_buyPackageTxt)
         {
            ObjectUtils.disposeObject(_buyPackageTxt);
         }
         _buyPackageTxt = null;
         if(_buyPackageTxt1)
         {
            ObjectUtils.disposeObject(_buyPackageTxt1);
         }
         _buyPackageTxt1 = null;
      }
   }
}
