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
      
      public function GuildMemberWeekPromptFrame(){super();}
      
      private function initView() : void{}
      
      private function addEvent() : void{}
      
      private function removeEvents() : void{}
      
      public function setPromptFrameTxt(param1:String) : void{}
      
      private function __response(param1:FrameEvent) : void{}
      
      private function __yesClickHander(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
   }
}
