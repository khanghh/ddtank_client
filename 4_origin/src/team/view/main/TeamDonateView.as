package team.view.main
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import morn.core.handlers.Handler;
   import team.view.mornui.TeamDonateViewUI;
   
   public class TeamDonateView extends TeamDonateViewUI
   {
       
      
      private var _price:int;
      
      private var _inputPoint:int;
      
      public function TeamDonateView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         _price = ServerConfigManager.instance.getTeamDonatePrice;
         label_count.text = "X " + _price;
         input_text.restrict = "0-9";
         input_text.changeHandler = new Handler(__onTextInput);
         btn_submit.label = LanguageMgr.GetTranslation("ddt.team.allView.text31");
         btn_submit.clickHandler = new Handler(__onClickSubmit);
         btn_cancel.label = LanguageMgr.GetTranslation("ddt.team.allView.text24");
         btn_esc.clickHandler = new Handler(__onClickClose);
         btn_cancel.clickHandler = new Handler(__onClickClose);
         input_text.setFocus();
         btn_submit.disabled = true;
         teamText1.text = LanguageMgr.GetTranslation("ddt.team.allView.text28");
         teamText2.htmlText = LanguageMgr.GetTranslation("ddt.team.allView.text29",PlayerManager.Instance.Self.Money.toString());
         teamText3.text = LanguageMgr.GetTranslation("ddt.team.allView.text30",0);
         teamText4.text = LanguageMgr.GetTranslation("ddt.team.allView.text32");
      }
      
      protected function __onTextInput() : void
      {
         var _loc1_:int = PlayerManager.Instance.Self.Money / _price;
         input_text.text = int(input_text.text).toString();
         if(int(input_text.text) > _loc1_)
         {
            input_text.text = _loc1_.toString();
         }
         _inputPoint = int(input_text.text);
         teamText3.text = LanguageMgr.GetTranslation("ddt.team.allView.text30",_inputPoint);
         btn_submit.disabled = int(input_text.text) == 0;
      }
      
      private function __onClickSubmit() : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:int = int(input_text.text) * _price;
         var _loc1_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("team.active.donate",_loc2_,_inputPoint),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false,0);
         _loc1_.addEventListener("response",__onAlertSubmit);
      }
      
      private function __onAlertSubmit(param1:FrameEvent) : void
      {
         e = param1;
         var alertFrame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alertFrame.removeEventListener("response",__onAlertSubmit);
         alertFrame.dispose();
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            var price:int = int(input_text.text) * _price;
            CheckMoneyUtils.instance.checkMoney(false,price,function():void
            {
               SocketManager.Instance.out.sendTeamDonate(price);
               dispose();
            });
         }
      }
      
      private function __onClickClose() : void
      {
         SoundManager.instance.playButtonSound();
         dispose();
      }
      
      override public function dispose() : void
      {
         input_text.removeEventListener("textInput",__onTextInput);
         super.dispose();
      }
   }
}
