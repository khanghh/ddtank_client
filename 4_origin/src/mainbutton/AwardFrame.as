package mainbutton
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.BossBoxManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelperUIModuleLoad;
   import ddt.view.bossbox.AwardsViewII;
   import ddt.view.bossbox.VipInfoTipBox;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import road7th.data.DictionaryData;
   import vip.view.VipViewFrame;
   
   public class AwardFrame extends Frame
   {
       
      
      private var _text:FilterFrameText;
      
      private var _topImgBG:MutipleImage;
      
      private var _vipBtn:BaseButton;
      
      private var _vipInfoTipBox:VipInfoTipBox;
      
      private var awards:AwardsViewII;
      
      private var alertFrame:BaseAlerFrame;
      
      public function AwardFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("ddt.getReward");
         _text = ComponentFactory.Instance.creatComponentByStylename("mainbtn.award.text");
         _text.htmlText = LanguageMgr.GetTranslation("ddt.Reward.get");
         addToContent(_text);
         _topImgBG = ComponentFactory.Instance.creatComponentByStylename("mainbtn.award.topBg");
         addToContent(_topImgBG);
         _vipBtn = ComponentFactory.Instance.creatComponentByStylename("mainbtn.award.vipBigButton");
         addToContent(_vipBtn);
      }
      
      private function addEvent() : void
      {
         _vipBtn.addEventListener("click",__vipOpen);
         addEventListener("response",__confirmResponse);
      }
      
      private function __vipOpen(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         showVipPackage();
      }
      
      private function showVipPackage() : void
      {
         if(PlayerManager.Instance.Self.canTakeVipReward || PlayerManager.Instance.Self.IsVIP == false)
         {
            new HelperUIModuleLoad().loadUIModule(["ddtvipview"],function():void
            {
               _vipInfoTipBox = ComponentFactory.Instance.creat("vip.VipInfoTipFrame");
               _vipInfoTipBox.escEnable = true;
               _vipInfoTipBox.vipAwardGoodsList = getVIPInfoTip(BossBoxManager.instance.inventoryItemList);
               _vipInfoTipBox.addEventListener("response",__responseVipInfoTipHandler);
               LayerManager.Instance.addToLayer(_vipInfoTipBox,3,true,1);
            });
         }
         else
         {
            var incream:int = 0;
            var date:Date = PlayerManager.Instance.Self.systemDate as Date;
            var nowDate:Date = new Date();
            nowDate.setTime(nowDate.getTime() + 86400000);
            alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.vip.vipView.cueDateScript",nowDate.month + 1,nowDate.date),LanguageMgr.GetTranslation("ok"),"",false,false,false,2);
            alertFrame.moveEnable = false;
            alertFrame.addEventListener("response",__alertHandler);
         }
      }
      
      private function getVIPInfoTip(param1:DictionaryData) : Array
      {
         var _loc2_:* = null;
         _loc2_ = PlayerManager.Instance.Self.VIPLevel == 12?[ItemManager.Instance.getTemplateById(int(VipViewFrame._vipChestsArr[PlayerManager.Instance.Self.VIPLevel - 2])),ItemManager.Instance.getTemplateById(int(VipViewFrame._vipChestsArr[PlayerManager.Instance.Self.VIPLevel - 1]))]:[ItemManager.Instance.getTemplateById(int(VipViewFrame._vipChestsArr[PlayerManager.Instance.Self.VIPLevel - 1])),ItemManager.Instance.getTemplateById(int(VipViewFrame._vipChestsArr[PlayerManager.Instance.Self.VIPLevel]))];
         return _loc2_;
      }
      
      private function __responseVipInfoTipHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _vipInfoTipBox.removeEventListener("response",__responseHandler);
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               _vipInfoTipBox.dispose();
               _vipInfoTipBox = null;
               break;
            case 2:
               showAwards(_vipInfoTipBox.selectCellInfo);
               _vipInfoTipBox.dispose();
               _vipInfoTipBox = null;
         }
      }
      
      private function __alertHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         alertFrame.removeEventListener("response",__alertHandler);
         if(alertFrame && alertFrame.parent)
         {
            alertFrame.parent.removeChild(alertFrame);
         }
         if(alertFrame)
         {
            alertFrame.dispose();
         }
         alertFrame = null;
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         awards.removeEventListener("response",__responseHandler);
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               awards.dispose();
               awards = null;
         }
      }
      
      private function showAwards(param1:ItemTemplateInfo) : void
      {
         awards = ComponentFactory.Instance.creat("vip.awardFrame");
         awards.escEnable = true;
         awards.boxType = 2;
         awards.vipAwardGoodsList = _getStrArr(BossBoxManager.instance.inventoryItemList);
         awards.addEventListener("response",__responseHandler);
         awards.addEventListener("_haveBtnClick",__sendReward);
         LayerManager.Instance.addToLayer(awards,3,true,1);
      }
      
      private function _getStrArr(param1:DictionaryData) : Array
      {
         var _loc2_:Array = param1[VipViewFrame._vipChestsArr[PlayerManager.Instance.Self.VIPLevel - 1]];
         return _loc2_;
      }
      
      private function __sendReward(param1:Event) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendDailyAward(3);
         awards.removeEventListener("_haveBtnClick",__sendReward);
         awards.dispose();
         PlayerManager.Instance.Self.canTakeVipReward = false;
      }
      
      private function __confirmResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         removeEventListener("response",__confirmResponse);
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_text);
         _text = null;
         if(_topImgBG)
         {
            ObjectUtils.disposeObject(_topImgBG);
         }
         _topImgBG = null;
         if(_vipBtn)
         {
            ObjectUtils.disposeObject(_vipBtn);
         }
         _vipBtn = null;
         super.dispose();
      }
   }
}
