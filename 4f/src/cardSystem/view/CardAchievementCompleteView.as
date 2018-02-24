package cardSystem.view
{
   import cardSystem.CardManager;
   import cardSystem.data.CardAchievementInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TextEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class CardAchievementCompleteView extends Sprite implements Disposeable
   {
       
      
      private var _commitBtnTxt:FilterFrameText;
      
      private var _timeOutId:int;
      
      private var _info:CardAchievementInfo;
      
      public function CardAchievementCompleteView(param1:*){super();}
      
      public function show() : void{}
      
      protected function onATS(param1:Event) : void{}
      
      private function initView() : void{}
      
      private function textClickHandler(param1:TextEvent) : void{}
      
      public function dispose() : void{}
   }
}
