package littleGame.menu
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class SwitchButton extends Sprite implements Disposeable
   {
       
      
      private var _back:DisplayObject;
      
      private var _fore:DisplayObject;
      
      public function SwitchButton()
      {
         super();
         buttonMode = true;
         configUI();
         addEvent();
      }
      
      private function configUI() : void
      {
         _back = addChild(ComponentFactory.Instance.creatComponentByStylename("littleGame.SwitchButton.back"));
         _fore = addChild(ComponentFactory.Instance.creatBitmap("asset.littleGame.menu.switchBtn2"));
      }
      
      private function addEvent() : void
      {
         addEventListener("mouseOver",__mouseOver);
         addEventListener("mouseOut",__mouseOut);
      }
      
      private function __mouseOut(param1:MouseEvent) : void
      {
         _fore.visible = false;
      }
      
      private function __mouseOver(param1:MouseEvent) : void
      {
         _fore.visible = true;
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__mouseOver);
         removeEventListener("mouseOut",__mouseOut);
      }
      
      public function set mode(param1:int) : void
      {
         DisplayUtils.setFrame(_back,param1);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_fore);
         _fore = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
