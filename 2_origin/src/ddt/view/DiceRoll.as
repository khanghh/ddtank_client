package ddt.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddtBuried.BuriedManager;
   import ddtBuried.event.BuriedEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class DiceRoll extends Sprite
   {
       
      
      private var _mc:MovieClip;
      
      private var cFrame:String;
      
      public function DiceRoll()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _mc = ComponentFactory.Instance.creat("asset.ddtcore.newshaizi.movie");
         _mc.gotoAndStop(1);
         _mc.x = 476;
         _mc.y = 295;
         addChild(_mc);
         _mc.addFrameScript(22,goFrame);
         _mc.addFrameScript(23,mcover);
         _mc.addFrameScript(24,mcover);
         _mc.addFrameScript(25,mcover);
         _mc.addFrameScript(26,mcover);
         _mc.addFrameScript(27,mcover);
         _mc.addFrameScript(28,mcover);
      }
      
      public function play() : void
      {
         _mc.play();
      }
      
      private function goFrame() : void
      {
         _mc.gotoAndStop(cFrame);
      }
      
      public function resetFrame() : void
      {
         _mc.gotoAndStop(1);
      }
      
      public function setCrFrame(param1:String) : void
      {
         cFrame = param1;
      }
      
      private function mcover() : void
      {
         BuriedManager.Instance.dispatchEvent(new BuriedEvent("diceover"));
      }
      
      public function dispose() : void
      {
         if(_mc)
         {
            _mc.gotoAndStop(1);
            while(_mc.numChildren)
            {
               _mc.removeChildAt(0);
            }
         }
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
      }
   }
}
