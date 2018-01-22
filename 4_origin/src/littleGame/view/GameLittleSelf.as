package littleGame.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import littleGame.LittleGameManager;
   import littleGame.character.LittleGameCharacter;
   import littleGame.events.LittleLivingEvent;
   import littleGame.model.LittleSelf;
   
   public class GameLittleSelf extends GameLittlePlayer
   {
       
      
      private var _self:LittleSelf;
      
      public function GameLittleSelf(param1:LittleSelf)
      {
         _self = param1;
         super(param1);
      }
      
      override protected function createBody() : void
      {
         super.createBody();
         if(_body)
         {
            LittleGameCharacter(_body).soundEnabled = LittleGameManager.Instance.Current.soundEnabled;
         }
      }
      
      override protected function addEvent() : void
      {
         super.addEvent();
         _self.addEventListener("getscore",__getScore);
         LittleGameManager.Instance.Current.addEventListener("soundEnabledChanged",__soundChanged);
      }
      
      private function __soundChanged(param1:Event) : void
      {
         if(_body)
         {
            LittleGameCharacter(_body).soundEnabled = LittleGameManager.Instance.Current.soundEnabled;
         }
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         _self.removeEventListener("getscore",__getScore);
         LittleGameManager.Instance.Current.removeEventListener("soundEnabledChanged",__soundChanged);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _self = null;
      }
      
      private function __getScore(param1:LittleLivingEvent) : void
      {
         SoundManager.instance.play("165");
         var _loc2_:ScoreShape = new ScoreShape();
         _loc2_.setScore(param1.paras[0]);
         _loc2_.x = -_loc2_.width >> 1;
         _loc2_.y = -180;
         addChild(_loc2_);
         TweenLite.to(_loc2_,0.3,{
            "delay":1,
            "alpha":0,
            "y":-320,
            "onComplete":ObjectUtils.disposeObject,
            "onCompleteParams":[_loc2_]
         });
      }
   }
}
