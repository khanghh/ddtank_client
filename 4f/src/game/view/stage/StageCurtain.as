package game.view.stage
{
   import com.pickgliss.toplevel.StageReferance;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class StageCurtain extends Sprite
   {
       
      
      private var _playTime:uint;
      
      private var _duration:uint;
      
      private var _life:uint;
      
      public function StageCurtain(){super();}
      
      private function initView() : void{}
      
      public function fadeIn(param1:uint = 25) : void{}
      
      public function fadeOut(param1:uint = 25) : void{}
      
      private function __updateFadeIn(param1:Event) : void{}
      
      private function __updateFadeOut(param1:Event) : void{}
      
      private function end() : void{}
      
      public function play(param1:uint = 25) : void{}
      
      private function __updatePlay(param1:Event) : void{}
   }
}
