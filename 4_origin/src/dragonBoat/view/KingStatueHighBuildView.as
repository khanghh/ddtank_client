package dragonBoat.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   
   public class KingStatueHighBuildView extends BaseAlerFrame
   {
      
      private static const BUILD_COST:int = 100;
       
      
      private var _desc:FilterFrameText;
      
      private var _ownMoney:FilterFrameText;
      
      private var _txt:FilterFrameText;
      
      private var _inputBg:Bitmap;
      
      private var _inputText:FilterFrameText;
      
      private var _bottomPromptTxt:FilterFrameText;
      
      private var _coins:int;
      
      private var _type:int;
      
      public function KingStatueHighBuildView()
      {
         super();
      }
      
      public function init2(type:int) : void
      {
         _type = type;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var title:* = null;
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         escEnable = true;
         _desc = ComponentFactory.Instance.creat("consortion.taskFrame.textWordI");
         PositionUtils.setPos(_desc,"kingStatue.consumeFrame2.descPos");
         _desc.text = LanguageMgr.GetTranslation("kingStatue.ownedMoney");
         _ownMoney = ComponentFactory.Instance.creatComponentByStylename("core.MyConsortiaTax.totalTicketTxt");
         PositionUtils.setPos(_ownMoney,"kingStatue.consumeFrame2.ownMoneyPos");
         _ownMoney.text = String(PlayerManager.Instance.Self.Money);
         _txt = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.normalPromptTxt");
         PositionUtils.setPos(_txt,"kingStatue.consumeFrame2.txtPos");
         _inputBg = ComponentFactory.Instance.creatBitmap("asset.dragonBoat.mainFrame.normal.inputBg");
         PositionUtils.setPos(_inputBg,"kingStatue.consumeFrame.inputBg2Pos");
         _inputText = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.normalInputTxt");
         PositionUtils.setPos(_inputText,"kingStatue.consumeFrame.inputTxt2Pos");
         _inputText.text = "1";
         _bottomPromptTxt = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.consumePromptTxt2");
         PositionUtils.setPos(_bottomPromptTxt,"kingStatue.consumeFrame2.tipsPos");
         switch(int(_type))
         {
            case 0:
               title = LanguageMgr.GetTranslation("ddt.dragonBoat.highBuildTxt");
               _txt.text = LanguageMgr.GetTranslation("kingStatue.highBuild");
               _bottomPromptTxt.text = LanguageMgr.GetTranslation("kingStatue.highBuildTips");
               break;
            case 1:
               title = LanguageMgr.GetTranslation("ddt.dragonBoat.highDecorateTxt");
               _txt.text = LanguageMgr.GetTranslation("kingStatue.highDecorate");
               _bottomPromptTxt.text = LanguageMgr.GetTranslation("kingStatue.highDecorateTips");
               break;
            case 2:
               title = LanguageMgr.GetTranslation("laurel.highFerilizeTxt");
               _txt.text = LanguageMgr.GetTranslation("laurel.highFerilizeTxt");
               _bottomPromptTxt.text = LanguageMgr.GetTranslation("laurel.highFerilizeTips");
               break;
            case 3:
               title = LanguageMgr.GetTranslation("laurel.highPrayTxt");
               _txt.text = LanguageMgr.GetTranslation("laurel.highPrayTxt");
               _bottomPromptTxt.text = LanguageMgr.GetTranslation("laurel.highPrayTips");
               break;
            case 4:
               title = LanguageMgr.GetTranslation("floatParade.highFerilizeTxt");
               _txt.text = LanguageMgr.GetTranslation("floatParade.highFerilizeTxt");
               _bottomPromptTxt.text = LanguageMgr.GetTranslation("floatParade.highFerilizeTips");
               break;
            case 5:
               title = LanguageMgr.GetTranslation("floatParade.highPrayTxt");
               _txt.text = LanguageMgr.GetTranslation("floatParadehighPrayTxt");
               _bottomPromptTxt.text = LanguageMgr.GetTranslation("floatParade.highPrayTips");
               break;
            case 6:
               title = LanguageMgr.GetTranslation("ddtking.highFerilizeTxt");
               _txt.text = LanguageMgr.GetTranslation("ddtking.highFerilizeTxt");
               _bottomPromptTxt.text = LanguageMgr.GetTranslation("ddtking.highFerilizeTips");
         }
         var alertInfo:AlertInfo = new AlertInfo(title,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
         alertInfo.moveEnable = false;
         alertInfo.autoDispose = false;
         alertInfo.sound = "008";
         alertInfo.type = 0;
         info = alertInfo;
         addToContent(_desc);
         addToContent(_ownMoney);
         addToContent(_txt);
         addToContent(_inputBg);
         addToContent(_inputText);
         addToContent(_bottomPromptTxt);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",responseHandler,false,0,true);
         _inputText.addEventListener("change",inputTextChangeHandler,false,0,true);
         _inputText.addEventListener("keyDown",inputKeyDownHandler,false,0,true);
      }
      
      private function inputTextChangeHandler(event:Event) : void
      {
         var num:int = _inputText.text;
         if(num < 1)
         {
            _inputText.text = "1";
         }
      }
      
      private function responseHandler(event:FrameEvent) : void
      {
         var cost:* = null;
         var text:* = null;
         var alert:* = null;
         SoundManager.instance.playButtonSound();
         _coins = 100 * int(_inputText.text);
         if(event.responseCode == 2 || event.responseCode == 3)
         {
            cost = _coins + LanguageMgr.GetTranslation("money");
            text = LanguageMgr.GetTranslation("ddtKing.affirmSpend",cost);
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),text,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
            alert.addEventListener("response",__onResponse);
         }
         else
         {
            dispose();
         }
      }
      
      protected function __onResponse(event:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(event.responseCode == 2 || event.responseCode == 3)
         {
            enterKeyHandler();
         }
         var alert:BaseAlerFrame = event.target as BaseAlerFrame;
         alert.removeEventListener("response",__onResponse);
         alert.dispose();
         alert = null;
      }
      
      private function enterKeyHandler() : void
      {
         if(PlayerManager.Instance.Self.Money < _coins)
         {
            LeavePageManager.showFillFrame();
            return;
         }
         SocketManager.Instance.out.sendDragonBoatBuildOrDecorate(2,int(_inputText.text),false);
         dispose();
      }
      
      private function inputKeyDownHandler(event:KeyboardEvent) : void
      {
         if(event.keyCode == 13)
         {
            enterKeyHandler();
         }
         else if(event.keyCode == 27)
         {
            dispose();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",responseHandler);
         _inputText.removeEventListener("change",inputTextChangeHandler);
         _inputText.removeEventListener("keyDown",inputKeyDownHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_desc);
         _desc = null;
         ObjectUtils.disposeObject(_ownMoney);
         _ownMoney = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_inputBg);
         _inputBg = null;
         ObjectUtils.disposeObject(_inputText);
         _inputText = null;
         super.dispose();
      }
   }
}
