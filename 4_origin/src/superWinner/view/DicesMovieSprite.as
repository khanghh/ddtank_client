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
         var i:* = 0;
         var dice:* = null;
         var mc:* = null;
         var mc2:* = null;
         stopMovieDices();
         _finalDices.visible = false;
         for(i = uint(1); i <= 6; )
         {
            dice = _finalDices["dice" + i];
            mc = dice["dice0"] as MovieClip;
            mc2 = dice["dice1"] as MovieClip;
            mc.visible = true;
            mc2.visible = true;
            mc.gotoAndStop(1);
            mc2.gotoAndStop(1);
            i++;
         }
      }
      
      public function playMovie(dicePoints:Vector.<int>) : void
      {
         resetDice();
         _currentDices = dicePoints;
         _movieDices.addEventListener("enterFrame",onFrame);
         _movieDices.visible = true;
         _movieDices.gotoAndPlay(1);
      }
      
      private function onFrame(e:Event) : void
      {
         var frame:MovieClip = e.currentTarget as MovieClip;
         if(frame.currentFrame >= 10)
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
         var i:* = 0;
         var randomNum:* = 0;
         var dice:* = null;
         var mc:* = null;
         _finalDices.visible = true;
         for(i = uint(0); i < _currentDices.length; )
         {
            randomNum = uint(Math.round(Math.random()));
            dice = _finalDices["dice" + (i + 1)];
            dice["dice" + DICE_STYLE[randomNum]].visible = false;
            mc = dice["dice" + randomNum] as MovieClip;
            mc.gotoAndStop(_currentDices[i]);
            i++;
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
