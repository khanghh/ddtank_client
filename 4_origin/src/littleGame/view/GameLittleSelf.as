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
      
      public function GameLittleSelf(self:LittleSelf)
      {
         _self = self;
         super(self);
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
      
      private function __soundChanged(event:Event) : void
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
      
      private function __getScore(event:LittleLivingEvent) : void
      {
         SoundManager.instance.play("165");
         var shape:ScoreShape = new ScoreShape();
         shape.setScore(event.paras[0]);
         shape.x = -shape.width >> 1;
         shape.y = -180;
         addChild(shape);
         TweenLite.to(shape,0.3,{
            "delay":1,
            "alpha":0,
            "y":-320,
            "onComplete":ObjectUtils.disposeObject,
            "onCompleteParams":[shape]
         });
      }
   }
}
