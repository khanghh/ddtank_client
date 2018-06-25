package ddt.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import ddtBuried.BuriedManager;
   import ddtBuried.event.BuriedEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class BuriedBox extends Sprite
   {
       
      
      private var _mc:MovieClip;
      
      private var _winTime:uint;
      
      public function BuriedBox()
      {
         super();
      }
      
      public function initView(type:int, mcName:String = "buried.shaizi.boxOpen") : void
      {
         _mc = ComponentFactory.Instance.creat(mcName + type);
         _mc.x = 508;
         _mc.y = -30;
         _mc.gotoAndStop(1);
         addChild(_mc);
         _mc.addFrameScript(119,playOver);
         SoundManager.instance.pauseMusic();
         SoundManager.instance.play("1001");
         _winTime = setTimeout(startMusic,3000);
      }
      
      private function startMusic() : void
      {
         SoundManager.instance.resumeMusic();
         SoundManager.instance.stop("1001");
      }
      
      public function play() : void
      {
         _mc.gotoAndPlay(1);
      }
      
      private function playOver() : void
      {
         _mc.gotoAndStop(1);
         this.visible = false;
         BuriedManager.Instance.dispatchEvent(new BuriedEvent("boxmovie_over"));
      }
      
      public function dispose() : void
      {
         clearTimeout(_winTime);
         if(_mc)
         {
            _mc.stop();
         }
         while(_mc.numChildren)
         {
            ObjectUtils.disposeObject(_mc.getChildAt(0));
         }
         ObjectUtils.disposeObject(_mc);
         _mc = null;
      }
   }
}
