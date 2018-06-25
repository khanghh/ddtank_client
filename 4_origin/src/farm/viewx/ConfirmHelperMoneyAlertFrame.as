package farm.viewx
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddtBuried.BuriedManager;
   import farm.FarmModelController;
   import flash.display.DisplayObject;
   import flash.events.Event;
   
   public class ConfirmHelperMoneyAlertFrame extends BaseAlerFrame
   {
       
      
      private var _addBtn:BaseButton;
      
      private var _removeBtn:BaseButton;
      
      private var _bg3:Scale9CornerImage;
      
      private var _timeTxt:FilterFrameText;
      
      private var _payTxt:FilterFrameText;
      
      private var _bgTitle:DisplayObject;
      
      private var _secondBtnGroup:SelectedButtonGroup;
      
      private var _oneBtn:SelectedCheckButton;
      
      private var _twoBtn:SelectedCheckButton;
      
      private var _showPayMoneyBG:Image;
      
      private var _showPayMoney:FilterFrameText;
      
      private var payNum:int = 0;
      
      private var _moneyConfirm:BaseAlerFrame;
      
      public function ConfirmHelperMoneyAlertFrame()
      {
         super();
         var alertInfo:AlertInfo = new AlertInfo();
         alertInfo.title = LanguageMgr.GetTranslation("ddt.farms.helperMoneyComfirmPnlTitle");
         alertInfo.bottomGap = 37;
         alertInfo.buttonGape = 115;
         alertInfo.customPos = ComponentFactory.Instance.creat("farm.confirmHelperMoneyAlertBtnPos");
         this.info = alertInfo;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bgTitle = ComponentFactory.Instance.creat("assets.farm.titleSmall");
         addChild(_bgTitle);
         PositionUtils.setPos(_bgTitle,PositionUtils.creatPoint("farm.confirmHelperMoneyAlertTitlePos"));
         _bg3 = ComponentFactory.Instance.creatComponentByStylename("farm.confirmHelperMoneyAlertFrame.bg3");
         addToContent(_bg3);
         _timeTxt = ComponentFactory.Instance.creat("farm.helperMoney.timeText");
         _timeTxt.text = LanguageMgr.GetTranslation("ddt.farms.helperMoneyComfirm.timeText");
         addToContent(_timeTxt);
         _payTxt = ComponentFactory.Instance.creat("farm.helperMoney.payText");
         _payTxt.text = LanguageMgr.GetTranslation("ddt.farms.helperMoneyComfirm.payText");
         addToContent(_payTxt);
         _secondBtnGroup = new SelectedButtonGroup(false);
         _oneBtn = ComponentFactory.Instance.creatComponentByStylename("confirmHelperMoneyAlertFrame.selectOne");
         addToContent(_oneBtn);
         _secondBtnGroup.addSelectItem(_oneBtn);
         _twoBtn = ComponentFactory.Instance.creatComponentByStylename("confirmHelperMoneyAlertFrame.selectTwo");
         addToContent(_twoBtn);
         _secondBtnGroup.addSelectItem(_twoBtn);
         _secondBtnGroup.selectIndex = 0;
         _oneBtn.text = LanguageMgr.GetTranslation("ddt.farms.confirmHelperMoneyAlertFrame.selectOneText");
         _twoBtn.text = LanguageMgr.GetTranslation("ddt.farms.confirmHelperMoneyAlertFrame.selectTwoText");
         _showPayMoney = ComponentFactory.Instance.creat("confirmHelperMoneyAlertFrame.showPayMoneyTxt");
         addToContent(_showPayMoney);
         upPayMoneyText();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__framePesponse);
         _secondBtnGroup.addEventListener("change",__upPayNum);
      }
      
      protected function __framePesponse(event:FrameEvent) : void
      {
         var hour:int = 0;
         SoundManager.instance.play("008");
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               hour = 0;
               switch(int(_secondBtnGroup.selectIndex))
               {
                  case 0:
                     hour = FarmModelController.instance.model.payAutoTimeToWeek;
                     break;
                  case 1:
                     hour = FarmModelController.instance.model.payAutoTimeToMonth;
               }
               if(BuriedManager.Instance.checkMoney(false,payNum))
               {
                  return;
               }
               if(PlayerManager.Instance.Self.Money < payNum)
               {
                  _moneyConfirm = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.comon.lack"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
                  _moneyConfirm.moveEnable = false;
                  _moneyConfirm.addEventListener("response",__moneyConfirmHandler);
                  break;
               }
               FarmModelController.instance.helperRenewMoney(hour,false);
               break;
         }
         removeEventListener("response",__framePesponse);
         dispose();
      }
      
      private function __moneyConfirmHandler(evt:FrameEvent) : void
      {
         _moneyConfirm.removeEventListener("response",__moneyConfirmHandler);
         _moneyConfirm.dispose();
         _moneyConfirm = null;
         switch(int(evt.responseCode) - 2)
         {
            case 0:
            case 1:
               LeavePageManager.leaveToFillPath();
         }
      }
      
      private function __upPayNum(e:Event) : void
      {
         SoundManager.instance.play("008");
         upPayMoneyText();
      }
      
      protected function upPayMoneyText() : void
      {
         payNum = 0;
         switch(int(_secondBtnGroup.selectIndex))
         {
            case 0:
               payNum = FarmModelController.instance.model.payAutoMoneyToWeek;
               break;
            case 1:
               payNum = FarmModelController.instance.model.payAutoMoneyToMonth;
         }
         _showPayMoney.htmlText = LanguageMgr.GetTranslation("ddt.farms.confirmHelperMoneyAlertFrame.payMoneyShow",payNum);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__framePesponse);
         if(_secondBtnGroup)
         {
            _secondBtnGroup.removeEventListener("change",__upPayNum);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_timeTxt)
         {
            ObjectUtils.disposeObject(_timeTxt);
            _timeTxt = null;
         }
         if(_showPayMoney)
         {
            ObjectUtils.disposeObject(_showPayMoney);
         }
         _showPayMoney = null;
         if(_secondBtnGroup)
         {
            ObjectUtils.disposeObject(_secondBtnGroup);
         }
         _secondBtnGroup = null;
         if(_oneBtn)
         {
            ObjectUtils.disposeObject(_oneBtn);
         }
         _oneBtn = null;
         if(_twoBtn)
         {
            ObjectUtils.disposeObject(_twoBtn);
         }
         _twoBtn = null;
         if(_addBtn)
         {
            ObjectUtils.disposeObject(_addBtn);
         }
         _addBtn = null;
         if(_removeBtn)
         {
            ObjectUtils.disposeObject(_removeBtn);
         }
         _removeBtn = null;
         if(_bgTitle)
         {
            ObjectUtils.disposeObject(_bgTitle);
         }
         _bgTitle = null;
         if(_bg3)
         {
            ObjectUtils.disposeObject(_bg3);
         }
         _bg3 = null;
         super.dispose();
      }
   }
}
