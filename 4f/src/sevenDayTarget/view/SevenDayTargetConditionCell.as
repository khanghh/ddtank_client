package sevenDayTarget.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import sevenDayTarget.controller.NewSevenDayAndNewPlayerManager;
   import sevenDayTarget.model.NewTargetQuestionInfo;
   
   public class SevenDayTargetConditionCell extends Sprite
   {
       
      
      private var _todayQuestInfo:NewTargetQuestionInfo;
      
      private var conditionText:FilterFrameText;
      
      private var conditionUnComplete:Bitmap;
      
      private var conditionComplete:Bitmap;
      
      private var linkText:FilterFrameText;
      
      private var linkSp:Sprite;
      
      public function SevenDayTargetConditionCell(param1:NewTargetQuestionInfo){super();}
      
      public function setView(param1:String, param2:Boolean, param3:Boolean = true) : void{}
      
      public function dispose() : void{}
      
      private function __clickLinkText(param1:MouseEvent) : void{}
   }
}
