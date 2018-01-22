package superWinner.view.bigAwards
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import superWinner.controller.SuperWinnerController;
   import superWinner.event.SuperWinnerEvent;
   
   public class SuperWinnerBigAwardView extends Sprite implements Disposeable
   {
       
      
      private var _awardsArr:Vector.<SuperWinnerBigAward>;
      
      public function SuperWinnerBigAwardView()
      {
         _awardsArr = new Vector.<SuperWinnerBigAward>(6,true);
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         var i:uint = 1;
         while(i <= 6)
         {
            var awards:SuperWinnerBigAward = new SuperWinnerBigAward(i);
            var point:Point = ComponentFactory.Instance.creatCustomObject("superWinner.bigAward" + i);
            awards.x = point.x;
            awards.y = point.y;
            _awardsArr[i - 1] = awards;
            function(param1:SuperWinnerBigAward, param2:uint):void
            {
               param1.addEventListener("rollOver",showTip);
               param1.addEventListener("rollOut",hideTip);
            }(awards,i);
            addChild(awards);
            i = Number(i) + 1;
         }
      }
      
      private function showTip(param1:MouseEvent) : void
      {
         var _loc3_:SuperWinnerBigAward = param1.currentTarget as SuperWinnerBigAward;
         var _loc2_:SuperWinnerEvent = new SuperWinnerEvent("showtip");
         _loc2_.resultData = _loc3_.awardType;
         this.dispatchEvent(_loc2_);
      }
      
      private function hideTip(param1:MouseEvent) : void
      {
         var _loc3_:SuperWinnerBigAward = param1.currentTarget as SuperWinnerBigAward;
         var _loc2_:SuperWinnerEvent = new SuperWinnerEvent("hidetip");
         _loc2_.resultData = _loc3_.awardType;
         this.dispatchEvent(_loc2_);
      }
      
      private function initEvent() : void
      {
         SuperWinnerController.instance.model.addEventListener("flush_awards",flushAwards);
      }
      
      private function flushAwards(param1:SuperWinnerEvent) : void
      {
         var _loc3_:* = 0;
         var _loc2_:Array = SuperWinnerController.instance.model.awards;
         _loc3_ = uint(0);
         while(_loc3_ < _awardsArr.length)
         {
            _awardsArr[_loc3_].awardNum = _loc2_[_loc3_];
            _loc3_++;
         }
      }
      
      private function removeEvent() : void
      {
         SuperWinnerController.instance.model.removeEventListener("flush_awards",flushAwards);
      }
      
      public function dispose() : void
      {
         var _loc2_:* = 0;
         var _loc1_:* = null;
         _loc2_ = uint(0);
         while(_loc2_ < _awardsArr.length)
         {
            _loc1_ = _awardsArr[_loc2_];
            if(_loc1_.hasEventListener("rollOver"))
            {
               _loc1_.removeEventListener("rollOver",showTip);
            }
            if(_loc1_.hasEventListener("rollOut"))
            {
               _loc1_.removeEventListener("rollOut",hideTip);
            }
            _loc2_++;
         }
         _awardsArr = null;
         ObjectUtils.removeChildAllChildren(this);
         removeEvent();
      }
   }
}
