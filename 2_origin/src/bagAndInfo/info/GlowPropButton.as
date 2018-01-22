package bagAndInfo.info
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class GlowPropButton extends PropButton
   {
       
      
      private var _overGraphics:DisplayObject;
      
      private var _showOverGraphics:Boolean = true;
      
      public function GlowPropButton()
      {
         super();
         addEvent();
         _tipStyle = "core.ChatacterPropTxtTips";
      }
      
      public function get showOverGraphics() : Boolean
      {
         return _showOverGraphics;
      }
      
      public function set showOverGraphics(param1:Boolean) : void
      {
         _showOverGraphics = param1;
      }
      
      override protected function addChildren() : void
      {
         if(!_back)
         {
            _back = ComponentFactory.Instance.creatBitmap("bagAndInfo.info.prop_up");
            addChild(_back);
         }
         if(!_overGraphics)
         {
            _overGraphics = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.info.light");
            _overGraphics.visible = false;
            addChild(_overGraphics);
         }
      }
      
      public function setOverGraphicsPosition(param1:Point) : void
      {
         if(!param1)
         {
            return;
         }
         _overGraphics.x = param1.x;
         _overGraphics.y = param1.y;
      }
      
      private function addEvent() : void
      {
         addEventListener("rollOver",__onMouseRollover);
         addEventListener("rollOut",__onMouseRollout);
      }
      
      private function __onMouseRollover(param1:MouseEvent) : void
      {
         _overGraphics.visible = true && _showOverGraphics;
      }
      
      private function __onMouseRollout(param1:MouseEvent) : void
      {
         _overGraphics.visible = false && _showOverGraphics;
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__onMouseRollover);
         removeEventListener("rollOut",__onMouseRollout);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_overGraphics)
         {
            ObjectUtils.disposeObject(_overGraphics);
            _overGraphics = null;
         }
         super.dispose();
      }
   }
}
