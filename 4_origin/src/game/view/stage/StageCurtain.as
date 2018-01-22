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
      
      public function StageCurtain()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         visible = false;
         graphics.clear();
         graphics.beginFill(0);
         graphics.drawRect(0,0,2000,2000);
      }
      
      public function fadeIn(param1:uint = 25) : void
      {
         StageReferance.stage.addChild(this);
         visible = true;
         alpha = 0;
         _duration = param1;
         _life = 0;
         addEventListener("enterFrame",__updateFadeIn);
      }
      
      public function fadeOut(param1:uint = 25) : void
      {
         StageReferance.stage.addChild(this);
         visible = true;
         alpha = 1;
         _duration = param1;
         _life = 0;
         addEventListener("enterFrame",__updateFadeOut);
      }
      
      private function __updateFadeIn(param1:Event) : void
      {
         if(_life == _duration)
         {
            dispatchEvent(new Event("fadein"));
            removeEventListener("enterFrame",__updateFadeIn);
            alpha = 1;
            end();
         }
         var _loc2_:Number = _life / _duration;
         alpha = _loc2_;
         _life = Number(_life) + 1;
      }
      
      private function __updateFadeOut(param1:Event) : void
      {
         if(_life == _duration)
         {
            dispatchEvent(new Event("fadeout"));
            removeEventListener("enterFrame",__updateFadeOut);
            alpha = 0;
            end();
         }
         var _loc2_:Number = _life / _duration;
         alpha = 1 - _loc2_;
         _life = Number(_life) + 1;
      }
      
      private function end() : void
      {
         this.parent.removeChild(this);
         dispatchEvent(new Event("complete"));
      }
      
      public function play(param1:uint = 25) : void
      {
         StageReferance.stage.addChild(this);
         visible = true;
         alpha = 0;
         _duration = param1;
         _life = 0;
         addEventListener("enterFrame",__updatePlay);
      }
      
      private function __updatePlay(param1:Event) : void
      {
         if(_life == _duration)
         {
            removeEventListener("enterFrame",__updatePlay);
            alpha = 0;
            end();
         }
         var _loc2_:Number = _life / _duration;
         if(_loc2_ < 0.2)
         {
            alpha = _loc2_ / 0.2;
         }
         else
         {
            alpha = 1 - _loc2_ / 0.8;
         }
         _life = Number(_life) + 1;
      }
   }
}
