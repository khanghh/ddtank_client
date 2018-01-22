package vip.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddtBuried.BuriedManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import vip.VipController;
   
   public class VipGrowUpFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _titleBm:Bitmap;
      
      private var _halfYearBtn:SelectedButton;
      
      private var _threeMonthBtn:SelectedButton;
      
      private var _oneMonthBtn:SelectedButton;
      
      private var _openVipTimeBtnGroup:SelectedButtonGroup;
      
      private var _discountIcon:Image;
      
      private var _openVipTip1:FilterFrameText;
      
      private var _openVipTip2:FilterFrameText;
      
      private var _openVipBtn:BaseButton;
      
      protected var payNum:int = 0;
      
      protected var time:String = "";
      
      private var _confirmFrame:BaseAlerFrame;
      
      private var _moneyConfirm:BaseAlerFrame;
      
      protected var days:int = 0;
      
      public function VipGrowUpFrame()
      {
         super();
         initView();
         initEvent();
         _openVipTimeBtnGroup.selectIndex = 0;
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.vipGrowUpFrame.bg");
         addToContent(_bg);
         _titleBm = ComponentFactory.Instance.creatBitmap("asset.vipGrowUpFrame.title");
         addToContent(_titleBm);
         _halfYearBtn = ComponentFactory.Instance.creatComponentByStylename("vip.VipGrowUpFrame.halfYearBtn");
         addToContent(_halfYearBtn);
         _threeMonthBtn = ComponentFactory.Instance.creatComponentByStylename("vip.VipGrowUpFrame.threeMonthBtn");
         addToContent(_threeMonthBtn);
         _oneMonthBtn = ComponentFactory.Instance.creatComponentByStylename("vip.VipGrowUpFrame.oneMonthBtn");
         addToContent(_oneMonthBtn);
         _discountIcon = ComponentFactory.Instance.creatComponentByStylename("vip.VipGrowUpFrame.discountIcon");
         addToContent(_discountIcon);
         _openVipTimeBtnGroup = new SelectedButtonGroup();
         _openVipTimeBtnGroup.addSelectItem(_halfYearBtn);
         _openVipTimeBtnGroup.addSelectItem(_threeMonthBtn);
         _openVipTimeBtnGroup.addSelectItem(_oneMonthBtn);
         _openVipTip1 = ComponentFactory.Instance.creatComponentByStylename("vip.VipGrowUpFrame.openVipTip1");
         _openVipTip1.text = LanguageMgr.GetTranslation("vip.VipGrowUpFrame.openVipTipMsg",6);
         addToContent(_openVipTip1);
         _openVipTip2 = ComponentFactory.Instance.creatComponentByStylename("vip.VipGrowUpFrame.openVipTip2");
         _openVipTip2.text = LanguageMgr.GetTranslation("vip.VipGrowUpFrame.openVipTipMsg",4);
         addToContent(_openVipTip2);
         _openVipBtn = ComponentFactory.Instance.creatComponentByStylename("vip.VipGrowUpFrame.OpenVipBtn");
         addToContent(_openVipBtn);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _openVipTimeBtnGroup.addEventListener("change",__upPayNum);
         _openVipBtn.addEventListener("click",__openVipBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         if(_openVipTimeBtnGroup)
         {
            _openVipTimeBtnGroup.removeEventListener("change",__upPayNum);
         }
         if(_openVipBtn)
         {
            _openVipBtn.removeEventListener("click",__openVipBtnClickHandler);
         }
      }
      
      private function __upPayNum(param1:Event) : void
      {
         SoundManager.instance.play("008");
         upPayMoneyText();
      }
      
      protected function upPayMoneyText() : void
      {
         payNum = 0;
         time = "";
         switch(int(_openVipTimeBtnGroup.selectIndex))
         {
            case 0:
               payNum = ServerConfigManager.instance.VIPRenewalPrice[2];
               time = "6个月";
               break;
            case 1:
               payNum = ServerConfigManager.instance.VIPRenewalPrice[1];
               time = "3个月";
               break;
            case 2:
               payNum = ServerConfigManager.instance.VIPRenewalPrice[0];
               time = "1个月";
         }
      }
      
      private function __openVipBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("ddt.vip.vipView.confirmforSelf",time,payNum);
         _confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("ddt.vip.vipFrame.ConfirmTitle"),_loc2_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,1,null,"SimpleAlert",30,true);
         _confirmFrame.moveEnable = false;
         _confirmFrame.addEventListener("response",__confirm);
      }
      
      private function __confirm(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               if(BuriedManager.Instance.checkMoney(_confirmFrame.isBand,payNum))
               {
                  return;
               }
               sendVip();
               upPayMoneyText();
               break;
         }
         _confirmFrame.removeEventListener("response",__confirm);
         _confirmFrame.dispose();
         if(_confirmFrame.parent)
         {
            _confirmFrame.parent.removeChild(_confirmFrame);
         }
      }
      
      protected function sendVip() : void
      {
         days = 0;
         switch(int(_openVipTimeBtnGroup.selectIndex))
         {
            case 0:
               days = 180;
               break;
            case 1:
               days = 90;
               break;
            case 2:
               days = 30;
         }
         send();
      }
      
      protected function send() : void
      {
         VipController.instance.sendOpenVip(PlayerManager.Instance.Self.NickName,days,_confirmFrame.isBand);
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               this.dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _bg = null;
         _titleBm = null;
         _openVipBtn = null;
         _halfYearBtn = null;
         _threeMonthBtn = null;
         _oneMonthBtn = null;
         _openVipTimeBtnGroup = null;
         _discountIcon = null;
         _openVipTip1 = null;
         _openVipTip2 = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
