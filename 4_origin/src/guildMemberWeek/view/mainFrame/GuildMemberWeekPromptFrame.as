package guildMemberWeek.view.mainFrame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   import guildMemberWeek.manager.GuildMemberWeekManager;
   
   public class GuildMemberWeekPromptFrame extends BaseAlerFrame
   {
       
      
      private var _txt:FilterFrameText;
      
      private var _Rankingtxt:FilterFrameText;
      
      private var _YesButton:TextButton;
      
      public function GuildMemberWeekPromptFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _txt = ComponentFactory.Instance.creatComponentByStylename("guildMemberWeek.alert.txt");
         _Rankingtxt = ComponentFactory.Instance.creatComponentByStylename("guildMemberWeek.alertRanking.txt");
         _Rankingtxt.text = String(GuildMemberWeekManager.instance.model.MyRanking);
         _YesButton = ComponentFactory.Instance.creatComponentByStylename("ddtstore.HelpFrame.EnterBtn");
         _YesButton.text = LanguageMgr.GetTranslation("ok");
         _YesButton.x = (430 - _YesButton.width) / 2;
         _YesButton.y = 118;
         addToContent(_txt);
         addToContent(_Rankingtxt);
         addToContent(_YesButton);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__response);
         _YesButton.addEventListener("click",__yesClickHander);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",__response);
         _YesButton.removeEventListener("click",__yesClickHander);
      }
      
      public function setPromptFrameTxt(param1:String) : void
      {
         _txt.htmlText = param1;
      }
      
      private function __response(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(param1.responseCode == 0 || param1.responseCode == 1 || param1.responseCode == 2)
         {
            GuildMemberWeekManager.instance.CloseShowTop10PromptFrame();
         }
      }
      
      private function __yesClickHander(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         GuildMemberWeekManager.instance.CloseShowTop10PromptFrame();
      }
      
      override public function dispose() : void
      {
         removeEvents();
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         _Rankingtxt = null;
         _txt = null;
         _YesButton = null;
         if(_YesButton)
         {
            ObjectUtils.disposeObject(_YesButton);
         }
         _YesButton = null;
      }
   }
}
