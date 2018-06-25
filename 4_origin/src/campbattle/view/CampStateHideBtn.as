package campbattle.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class CampStateHideBtn extends Sprite
   {
      
      public static const HIDE_PLAYER:String = "hidePlayer";
       
      
      private var _mc:MovieClip;
      
      private var _isHide:Boolean = false;
      
      public function CampStateHideBtn()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _mc = ComponentFactory.Instance.creat("asset.worldBoss.hideBtn");
         _mc.buttonMode = true;
         addChild(_mc);
         _mc.mc.gotoAndStop(2);
         _mc.addEventListener("click",mouseClickHander);
      }
      
      public function get isHide() : Boolean
      {
         return _isHide;
      }
      
      private function mouseClickHander(e:MouseEvent) : void
      {
         e.stopImmediatePropagation();
         if(!_isHide)
         {
            _isHide = true;
            _mc.mc.gotoAndStop(2);
         }
         else
         {
            _isHide = false;
            _mc.mc.gotoAndStop(1);
         }
         this.dispatchEvent(new Event("hidePlayer"));
      }
      
      public function turnMC() : void
      {
         _isHide = false;
         _mc.mc.gotoAndStop(1);
      }
      
      public function dispose() : void
      {
         _mc.removeEventListener("click",mouseClickHander);
         ObjectUtils.disposeObject(_mc);
         _mc = null;
      }
   }
}
