package superWinner.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class DicesBanner extends Sprite implements Disposeable
   {
       
      
      private var _diceArr:Vector.<MovieClip>;
      
      private var _space:Number;
      
      public function DicesBanner(space:Number = 37.8)
      {
         _diceArr = new Vector.<MovieClip>(6,true);
         super();
         _space = space;
         init();
      }
      
      private function init() : void
      {
         var i:int = 0;
         var dice:* = null;
         for(i = 0; i < 6; )
         {
            dice = ComponentFactory.Instance.creat("asset.superWinner.smallDice");
            dice.x = i * _space;
            dice.gotoAndStop(6);
            _diceArr[i] = dice;
            addChild(dice);
            i++;
         }
      }
      
      public function showLastDices(val:Vector.<int>) : void
      {
         var i:* = 0;
         for(i = uint(0); i < 6; )
         {
            _diceArr[i].gotoAndStop(val[i]);
            i++;
         }
      }
      
      public function dispose() : void
      {
         _diceArr = null;
         ObjectUtils.removeChildAllChildren(this);
      }
   }
}
