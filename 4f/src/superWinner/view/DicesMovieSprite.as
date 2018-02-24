package superWinner.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class DicesMovieSprite extends Sprite implements Disposeable
   {
       
      
      private const DICE_STYLE:Array = [1,0];
      
      private var _dices:MovieClip;
      
      private var _finalDices:MovieClip;
      
      private var _movieDices:MovieClip;
      
      private var _currentDices:Vector.<int>;
      
      public function DicesMovieSprite(){super();}
      
      private function init() : void{}
      
      public function resetDice() : void{}
      
      public function playMovie(param1:Vector.<int>) : void{}
      
      private function onFrame(param1:Event) : void{}
      
      private function stopMovieDices() : void{}
      
      private function showDices() : void{}
      
      public function dispose() : void{}
   }
}
