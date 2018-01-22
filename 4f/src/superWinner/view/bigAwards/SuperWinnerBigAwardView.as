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
      
      public function SuperWinnerBigAwardView(){super();}
      
      private function init() : void{}
      
      private function showTip(param1:MouseEvent) : void{}
      
      private function hideTip(param1:MouseEvent) : void{}
      
      private function initEvent() : void{}
      
      private function flushAwards(param1:SuperWinnerEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
