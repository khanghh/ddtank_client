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
      
      public function DicesBanner(param1:Number = 37.8)
      {
         _diceArr = new Vector.<MovieClip>(6,true);
         super();
         _space = param1;
         init();
      }
      
      private function init() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = ComponentFactory.Instance.creat("asset.superWinner.smallDice");
            _loc1_.x = _loc2_ * _space;
            _loc1_.gotoAndStop(6);
            _diceArr[_loc2_] = _loc1_;
            addChild(_loc1_);
            _loc2_++;
         }
      }
      
      public function showLastDices(param1:Vector.<int>) : void
      {
         var _loc2_:* = 0;
         _loc2_ = uint(0);
         while(_loc2_ < 6)
         {
            _diceArr[_loc2_].gotoAndStop(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      public function dispose() : void
      {
         _diceArr = null;
         ObjectUtils.removeChildAllChildren(this);
      }
   }
}
