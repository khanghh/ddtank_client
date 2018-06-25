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
      
      public function fadeIn(duration:uint = 25) : void
      {
         StageReferance.stage.addChild(this);
         visible = true;
         alpha = 0;
         _duration = duration;
         _life = 0;
         addEventListener("enterFrame",__updateFadeIn);
      }
      
      public function fadeOut(duration:uint = 25) : void
      {
         StageReferance.stage.addChild(this);
         visible = true;
         alpha = 1;
         _duration = duration;
         _life = 0;
         addEventListener("enterFrame",__updateFadeOut);
      }
      
      private function __updateFadeIn(evt:Event) : void
      {
         if(_life == _duration)
         {
            dispatchEvent(new Event("fadein"));
            removeEventListener("enterFrame",__updateFadeIn);
            alpha = 1;
            end();
         }
         var progress:Number = _life / _duration;
         alpha = progress;
         _life = Number(_life) + 1;
      }
      
      private function __updateFadeOut(evt:Event) : void
      {
         if(_life == _duration)
         {
            dispatchEvent(new Event("fadeout"));
            removeEventListener("enterFrame",__updateFadeOut);
            alpha = 0;
            end();
         }
         var progress:Number = _life / _duration;
         alpha = 1 - progress;
         _life = Number(_life) + 1;
      }
      
      private function end() : void
      {
         this.parent.removeChild(this);
         dispatchEvent(new Event("complete"));
      }
      
      public function play(duration:uint = 25) : void
      {
         StageReferance.stage.addChild(this);
         visible = true;
         alpha = 0;
         _duration = duration;
         _life = 0;
         addEventListener("enterFrame",__updatePlay);
      }
      
      private function __updatePlay(e:Event) : void
      {
         if(_life == _duration)
         {
            removeEventListener("enterFrame",__updatePlay);
            alpha = 0;
            end();
         }
         var progress:Number = _life / _duration;
         if(progress < 0.2)
         {
            alpha = progress / 0.2;
         }
         else
         {
            alpha = 1 - progress / 0.8;
         }
         _life = Number(_life) + 1;
      }
   }
}
