package ddtBuried.items
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddtBuried.BuriedControl;
   import ddtBuried.event.BuriedEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class WashCard extends Sprite
   {
       
      
      private var _mc:MovieClip;
      
      public function WashCard()
      {
         super();
         _mc = ComponentFactory.Instance.creat("buried.card.wash");
         addChild(_mc);
         _mc.addFrameScript(65,washOver);
      }
      
      public function resetFrame() : void
      {
         _mc.gotoAndStop(1);
      }
      
      public function play() : void
      {
         _mc.play();
      }
      
      private function washOver() : void
      {
         _mc.stop();
         BuriedControl.Instance.dispatchEvent(new BuriedEvent("card_wash_over"));
      }
      
      public function dispose() : void
      {
         _mc.stop();
         while(_mc.numChildren)
         {
            ObjectUtils.disposeObject(_mc.getChildAt(0));
         }
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
      }
   }
}
