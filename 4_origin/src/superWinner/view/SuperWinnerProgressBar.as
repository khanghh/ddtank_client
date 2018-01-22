package superWinner.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import superWinner.controller.SuperWinnerController;
   import superWinner.event.SuperWinnerEvent;
   
   public class SuperWinnerProgressBar extends Sprite implements Disposeable
   {
       
      
      private var _movie:MovieClip;
      
      private var _outLight:MovieClip;
      
      private var _changeColor:MovieClip;
      
      private var _light1:MovieClip;
      
      private var _light2:MovieClip;
      
      public function SuperWinnerProgressBar()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _movie = ComponentFactory.Instance.creat("asset.superWinner.ProgressBar");
         _outLight = _movie["outLight"];
         _changeColor = _movie["changeColor"];
         _light1 = _movie["light1"];
         _light2 = _movie["light2"];
         resetProgressBar();
         addChild(_movie);
      }
      
      public function resetProgressBar() : void
      {
         _movie.gotoAndStop(1);
         _outLight.gotoAndStop(1);
         _changeColor.gotoAndStop(1);
         _light1.gotoAndStop(1);
         _light2.gotoAndStop(1);
         _outLight.visible = false;
         _light1.visible = false;
         _light2.visible = false;
      }
      
      public function playBar() : void
      {
         _outLight.gotoAndPlay(1);
         _light1.gotoAndPlay(1);
         _light2.gotoAndPlay(1);
         _outLight.visible = true;
         _light1.visible = true;
         _light2.visible = true;
         _changeColor.gotoAndPlay(1);
         _movie.gotoAndPlay(1);
         _movie.addEventListener("enterFrame",frameBar);
         this.filters = null;
      }
      
      private function stopBar() : void
      {
         _movie.removeEventListener("enterFrame",frameBar);
         _movie.gotoAndStop(250);
         _outLight.gotoAndStop(1);
         _changeColor.gotoAndStop(1);
         _light1.gotoAndStop(1);
         _light2.gotoAndStop(1);
         _outLight.visible = false;
         _light1.visible = false;
         _light2.visible = false;
      }
      
      private function frameBar(param1:Event) : void
      {
         if(_movie.currentFrame >= 250)
         {
            resetProgressBar();
            this.filters = ComponentFactory.Instance.creatFilters("grayFilter");
            SuperWinnerController.instance.model.dispatchEvent(new SuperWinnerEvent("progress_time_up"));
         }
      }
      
      public function dispose() : void
      {
         resetProgressBar();
         if(_movie.hasEventListener("enterFrame"))
         {
            _movie.removeEventListener("enterFrame",frameBar);
         }
         ObjectUtils.removeChildAllChildren(this);
         _movie = null;
         _outLight = null;
         _changeColor = null;
         _light1 = null;
         _light2 = null;
      }
   }
}
