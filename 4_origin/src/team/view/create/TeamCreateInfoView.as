package team.view.create
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import morn.core.handlers.Handler;
   import team.TeamManager;
   import team.event.TeamEvent;
   import team.view.mornui.TeamCreateInfoViewUI;
   
   public class TeamCreateInfoView extends TeamCreateInfoViewUI
   {
       
      
      public function TeamCreateInfoView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         label_coin.text = ServerConfigManager.instance.getTeamCreateCoin.toString();
         btn_esc.clickHandler = new Handler(__onClickEsc);
         btn_cancel.clickHandler = new Handler(__onClickEsc);
         btn_cancel.label = LanguageMgr.GetTranslation("ddt.team.allView.text24");
         btn_checkName.clickHandler = new Handler(__onClickCheckName);
         btn_checkTag.clickHandler = new Handler(__onClickCheckTag);
         var _loc1_:* = LanguageMgr.GetTranslation("ddt.team.allView.text26");
         btn_checkTag.label = _loc1_;
         btn_checkName.label = _loc1_;
         btn_create.clickHandler = new Handler(__onClickCreate);
         btn_create.label = LanguageMgr.GetTranslation("ddt.team.allView.text25");
         SocketManager.Instance.addEventListener(PkgEvent.format(390,17),__onCheckInput);
         TeamManager.instance.addEventListener("updateteaminfo",__onCreateComplete);
         teamText1.text = LanguageMgr.GetTranslation("ddt.team.allView.text22");
         teamText2.text = LanguageMgr.GetTranslation("ddt.team.allView.text20");
         teamText3.text = LanguageMgr.GetTranslation("ddt.team.allView.text21");
         teamText4.text = LanguageMgr.GetTranslation("ddt.team.allView.text23");
         teamText5.text = LanguageMgr.GetTranslation("ddt.team.allView.text27");
      }
      
      private function __onCreateComplete(param1:TeamEvent) : void
      {
         dispose();
      }
      
      private function __onCheckInput(param1:PkgEvent) : void
      {
         var _loc3_:Boolean = param1.pkg.readBoolean();
         var _loc2_:int = param1.pkg.readByte();
         var _loc4_:* = _loc2_ == 0;
         checkChange(!!_loc3_?1:2,_loc4_,_loc2_);
      }
      
      protected function __onClickCheckTag() : void
      {
         SoundManager.instance.playButtonSound();
         SocketManager.Instance.out.sendTeamCheckInput(false,input_tag.text);
      }
      
      protected function __onClickCheckName() : void
      {
         SoundManager.instance.playButtonSound();
         SocketManager.Instance.out.sendTeamCheckInput(true,input_name.text);
      }
      
      protected function __onClickCreate() : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("team.create.confirm",ServerConfigManager.instance.getTeamCreateCoin);
         var _loc1_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc2_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,1,null,"SimpleAlert",60,false);
         _loc1_.addEventListener("response",__onAlertCreate);
      }
      
      private function __onAlertCreate(param1:FrameEvent) : void
      {
         e = param1;
         var alertFrame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alertFrame.removeEventListener("response",__onAlertCreate);
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            var coin:int = ServerConfigManager.instance.getTeamCreateCoin;
            CheckMoneyUtils.instance.checkMoney(false,coin,function():void
            {
               SocketManager.Instance.out.sendTeamCreate(input_name.text,input_tag.text);
            });
         }
         alertFrame.dispose();
      }
      
      protected function __onClickEsc() : void
      {
         SoundManager.instance.playButtonSound();
         dispose();
      }
      
      private function checkTag() : Boolean
      {
         var _loc1_:int = input_tag.text.length;
         if(_loc1_ < 2 || _loc1_ > 8)
         {
            return false;
         }
         return true;
      }
      
      private function checkName() : Boolean
      {
         var _loc1_:int = input_name.text.length;
         if(_loc1_ < 2 || _loc1_ > 12)
         {
            return false;
         }
         return true;
      }
      
      private function checkChange(param1:int, param2:Boolean, param3:int = 0) : void
      {
         var _loc4_:* = null;
         if(!param2)
         {
            _loc4_ = "team.create.inputError" + param3;
            if(param3 == 2)
            {
               _loc4_ = _loc4_ + param1;
            }
         }
         switch(int(param1) - 1)
         {
            case 0:
               clip_checkName.visible = true;
               label_checkName.text = !!param2?"":LanguageMgr.GetTranslation(_loc4_);
               clip_checkName.index = !!param2?0:1;
               break;
            case 1:
               clip_checkTag.visible = true;
               label_checkTag.text = !!param2?"":LanguageMgr.GetTranslation(_loc4_);
               clip_checkTag.index = !!param2?0:1;
         }
      }
      
      override public function dispose() : void
      {
         TeamManager.instance.removeEventListener("updateteaminfo",__onCreateComplete);
         SocketManager.Instance.removeEventListener(PkgEvent.format(390,17),__onCheckInput);
         super.dispose();
      }
   }
}
