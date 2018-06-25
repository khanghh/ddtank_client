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
         var i:* = 0;
         var awards:* = null;
         var point:* = null;
         for(i = uint(1); i <= 6; )
         {
            awards = new SuperWinnerSmallAward(i);
            point = ComponentFactory.Instance.creatCustomObject("superWinner.smallAward" + i);
            awards.x = point.x;
            awards.y = point.y;
            _awardsArr[i - 1] = awards;
            addChild(awards);
            i++;
         }
      }
      
      private function initEvent() : void
      {
         SuperWinnerController.instance.model.addEventListener("flush_my_awards",flushAwards);
      }
      
      private function flushAwards(e:SuperWinnerEvent) : void
      {
         var i:* = 0;
         var awards:Array = SuperWinnerController.instance.model.myAwards;
         for(i = uint(0); i < _awardsArr.length; )
         {
            _awardsArr[i].awardNum = awards[i];
            i++;
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
