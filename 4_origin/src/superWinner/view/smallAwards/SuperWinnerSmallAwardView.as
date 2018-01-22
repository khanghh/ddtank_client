package superWinner.view.smallAwards
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.geom.Point;
   import superWinner.controller.SuperWinnerController;
   import superWinner.event.SuperWinnerEvent;
   
   public class SuperWinnerSmallAwardView extends Sprite implements Disposeable
   {
       
      
      private var _awardsArr:Vector.<SuperWinnerSmallAward>;
      
      public function SuperWinnerSmallAwardView()
      {
         _awardsArr = new Vector.<SuperWinnerSmallAward>(6,true);
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         _loc3_ = uint(1);
         while(_loc3_ <= 6)
         {
            _loc2_ = new SuperWinnerSmallAward(_loc3_);
            _loc1_ = ComponentFactory.Instance.creatCustomObject("superWinner.smallAward" + _loc3_);
            _loc2_.x = _loc1_.x;
            _loc2_.y = _loc1_.y;
            _awardsArr[_loc3_ - 1] = _loc2_;
            addChild(_loc2_);
            _loc3_++;
         }
      }
      
      private function initEvent() : void
      {
         SuperWinnerController.instance.model.addEventListener("flush_my_awards",flushAwards);
      }
      
      private function flushAwards(param1:SuperWinnerEvent) : void
      {
         var _loc3_:* = 0;
         var _loc2_:Array = SuperWinnerController.instance.model.myAwards;
         _loc3_ = uint(0);
         while(_loc3_ < _awardsArr.length)
         {
            _awardsArr[_loc3_].awardNum = _loc2_[_loc3_];
            _loc3_++;
         }
      }
      
      private function removeEvent() : void
      {
         SuperWinnerController.instance.model.removeEventListener("flush_my_awards",flushAwards);
      }
      
      public function dispose() : void
      {
         _awardsArr = null;
         ObjectUtils.removeChildAllChildren(this);
         removeEvent();
      }
   }
}
