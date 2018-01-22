package littleGame.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class LittleSoundButton extends Sprite implements Disposeable
   {
       
      
      private var _back:DisplayObject;
      
      private var _state:int = -1;
      
      public function LittleSoundButton()
      {
         super();
         buttonMode = true;
         mouseChildren = false;
         configUI();
         addEvent();
      }
      
      private function addEvent() : void
      {
         addEventListener("mouseOver",__mouseOver);
         addEventListener("mouseOut",__mouseOut);
      }
      
      private function __mouseOut(param1:MouseEvent) : void
      {
         filters = null;
      }
      
      private function __mouseOver(param1:MouseEvent) : void
      {
         filters = ComponentFactory.Instance.creatFilters("lightFilter");
      }
      
      private function configUI() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("littleGame.SoundBack");
         addChild(_back);
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(param1:int) : void
      {
         if(_state == param1)
         {
            return;
         }
         _state = param1;
         DisplayUtils.setFrame(_back,_state);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__mouseOver);
         removeEventListener("mouseOut",__mouseOut);
      }
   }
}
