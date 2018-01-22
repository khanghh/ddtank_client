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
      
      public function DicesMovieSprite()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _dices = ComponentFactory.Instance.creat("asset.superWinner.DicesMovie");
         _finalDices = _dices["finalDices"];
         _movieDices = _dices["movieDices"];
         resetDice();
         addChild(_dices);
      }
      
      public function resetDice() : void
      {
         var _loc4_:* = 0;
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         stopMovieDices();
         _finalDices.visible = false;
         _loc4_ = uint(1);
         while(_loc4_ <= 6)
         {
            _loc1_ = _finalDices["dice" + _loc4_];
            _loc2_ = _loc1_["dice0"] as MovieClip;
            _loc3_ = _loc1_["dice1"] as MovieClip;
            _loc2_.visible = true;
            _loc3_.visible = true;
            _loc2_.gotoAndStop(1);
            _loc3_.gotoAndStop(1);
            _loc4_++;
         }
      }
      
      public function playMovie(param1:Vector.<int>) : void
      {
         resetDice();
         _currentDices = param1;
         _movieDices.addEventListener("enterFrame",onFrame);
         _movieDices.visible = true;
         _movieDices.gotoAndPlay(1);
      }
      
      private function onFrame(param1:Event) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         if(_loc2_.currentFrame >= 10)
         {
            stopMovieDices();
            showDices();
         }
      }
      
      private function stopMovieDices() : void
      {
         _movieDices.gotoAndStop(1);
         _movieDices.visible = false;
      }
      
      private function showDices() : void
      {
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         var _loc1_:* = null;
         var _loc2_:* = null;
         _finalDices.visible = true;
         _loc4_ = uint(0);
         while(_loc4_ < _currentDices.length)
         {
            _loc3_ = uint(Math.round(Math.random()));
            _loc1_ = _finalDices["dice" + (_loc4_ + 1)];
            _loc1_["dice" + DICE_STYLE[_loc3_]].visible = false;
            _loc2_ = _loc1_["dice" + _loc3_] as MovieClip;
            _loc2_.gotoAndStop(_currentDices[_loc4_]);
            _loc4_++;
         }
      }
      
      public function dispose() : void
      {
         _dices.removeEventListener("enterFrame",onFrame);
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
