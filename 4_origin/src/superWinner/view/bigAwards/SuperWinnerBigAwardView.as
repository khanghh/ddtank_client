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
         for(var i:uint = 1; i <= 6; )
         {
            var awards:SuperWinnerBigAward = new SuperWinnerBigAward(i);
            var point:Point = ComponentFactory.Instance.creatCustomObject("superWinner.bigAward" + i);
            awards.x = point.x;
            awards.y = point.y;
            _awardsArr[i - 1] = awards;
            function(mc:SuperWinnerBigAward, ii:uint):void
            {
               mc.addEventListener("rollOver",showTip);
               mc.addEventListener("rollOut",hideTip);
            }(awards,i);
            addChild(awards);
            i = Number(i) + 1;
         }
      }
      
      private function showTip(e:MouseEvent) : void
      {
         var award:SuperWinnerBigAward = e.currentTarget as SuperWinnerBigAward;
         var evt:SuperWinnerEvent = new SuperWinnerEvent("showtip");
         evt.resultData = award.awardType;
         this.dispatchEvent(evt);
      }
      
      private function hideTip(e:MouseEvent) : void
      {
         var award:SuperWinnerBigAward = e.currentTarget as SuperWinnerBigAward;
         var evt:SuperWinnerEvent = new SuperWinnerEvent("hidetip");
         evt.resultData = award.awardType;
         this.dispatchEvent(evt);
      }
      
      private function initEvent() : void
      {
         SuperWinnerController.instance.model.addEventListener("flush_awards",flushAwards);
      }
      
      private function flushAwards(e:SuperWinnerEvent) : void
      {
         var i:* = 0;
         var awards:Array = SuperWinnerController.instance.model.awards;
         for(i = uint(0); i < _awardsArr.length; )
         {
            _awardsArr[i].awardNum = awards[i];
            i++;
         }
      }
      
      private function removeEvent() : void
      {
         SuperWinnerController.instance.model.removeEventListener("flush_awards",flushAwards);
      }
      
      public function dispose() : void
      {
         var i:* = 0;
         var mc:* = null;
         for(i = uint(0); i < _awardsArr.length; )
         {
            mc = _awardsArr[i];
            if(mc.hasEventListener("rollOver"))
            {
               mc.removeEventListener("rollOver",showTip);
            }
            if(mc.hasEventListener("rollOut"))
            {
               mc.removeEventListener("rollOut",hideTip);
            }
            i++;
         }
         _awardsArr = null;
         ObjectUtils.removeChildAllChildren(this);
         removeEvent();
      }
   }
}
