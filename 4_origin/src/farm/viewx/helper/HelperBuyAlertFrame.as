package farm.viewx.helper
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   
   public class HelperBuyAlertFrame extends BaseAlerFrame
   {
       
      
      private var _bgTilte:DisplayObject;
      
      private var _alertTip:FilterFrameText;
      
      public function HelperBuyAlertFrame()
      {
         super();
         var alertInfo:AlertInfo = new AlertInfo();
         alertInfo.title = LanguageMgr.GetTranslation("ddt.farms.helper.buyTxt");
         alertInfo.bottomGap = 37;
         alertInfo.buttonGape = 65;
         alertInfo.customPos = ComponentFactory.Instance.creat("farm.refreshPetAlertBtnPos");
         this.info = alertInfo;
         moveEnable = false;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bgTilte = ComponentFactory.Instance.creat("assets.farm.titleSmall");
         addChild(_bgTilte);
         PositionUtils.setPos(_bgTilte,"farm.refreshPetAlertTitlePos");
         _alertTip = ComponentFactory.Instance.creatComponentByStylename("farm.text.refreshPetAlertTips");
         addToContent(_alertTip);
         PositionUtils.setPos(_alertTip,"farm.helper.alertTipPos");
         _alertTip.text = LanguageMgr.GetTranslation("ddt.farms.helper.buyTxt1");
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__framePesponse);
      }
      
      protected function __framePesponse(event:FrameEvent) : void
      {
         removeEventListener("response",__framePesponse);
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               dispose();
            default:
               dispose();
            default:
               dispose();
         }
         dispose();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__framePesponse);
      }
      
      override public function dispose() : void
      {
         if(_bgTilte)
         {
            ObjectUtils.disposeObject(_bgTilte);
            _bgTilte = null;
         }
         if(_alertTip)
         {
            ObjectUtils.disposeObject(_alertTip);
            _alertTip = null;
         }
         super.dispose();
      }
   }
}
