package gameCommon.view.smallMap
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import road7th.utils.MovieClipWrapper;
   
   public class GameTurnButton extends TextButton
   {
       
      
      private var _turnShine:MovieClipWrapper;
      
      private var _container:DisplayObjectContainer;
      
      public var isFirst:Boolean = true;
      
      public function GameTurnButton(container:DisplayObjectContainer)
      {
         _container = container;
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         var shineMovie:MovieClip = ComponentFactory.Instance.creat("asset.game.smallmap.TurnShine");
         shineMovie.x = 27;
         shineMovie.y = 7;
         _turnShine = new MovieClipWrapper(shineMovie);
      }
      
      public function shine() : void
      {
         if(parent == null && _container)
         {
            _container.addChild(this);
         }
         if(_turnShine && _turnShine.movie)
         {
            addChildAt(_turnShine.movie,0);
            _turnShine.addEventListener("complete",__shineComplete);
            _turnShine.gotoAndPlay(1);
         }
      }
      
      private function __shineComplete(evt:Event) : void
      {
         _turnShine.removeEventListener("complete",__shineComplete);
         if(_turnShine.movie.parent)
         {
            _turnShine.movie.parent.removeChild(_turnShine.movie);
         }
      }
      
      override public function get width() : Number
      {
         if(_back)
         {
            return _back.width;
         }
         return 60;
      }
      
      override public function dispose() : void
      {
         _container = null;
         if(_turnShine)
         {
            _turnShine.removeEventListener("complete",__shineComplete);
            ObjectUtils.disposeObject(_turnShine);
            _turnShine = null;
         }
         super.dispose();
      }
   }
}
