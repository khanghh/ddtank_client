package ddt.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class ColorItem extends SelectedButton
   {
       
      
      private var _color:uint;
      
      private var _over:Bitmap;
      
      public function ColorItem()
      {
         super();
      }
      
      public function setup(color:uint) : void
      {
         _color = color;
         init();
         initEvent();
      }
      
      override protected function init() : void
      {
         super.init();
         graphics.beginFill(_color,0);
         graphics.drawRect(0,0,16,16);
         graphics.endFill();
         _over = ComponentFactory.Instance.creatBitmap("asset.ddtshop.ColorItemOver");
         _over.visible = false;
         addChild(_over);
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",__mouseOver);
         addEventListener("mouseOut",__mouseOut);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("mouseOver",__mouseOver);
         removeEventListener("mouseOut",__mouseOut);
      }
      
      private function __mouseOver(evt:MouseEvent) : void
      {
         _over.visible = true;
      }
      
      private function __mouseOut(evt:MouseEvent) : void
      {
         _over.visible = false;
      }
      
      public function getColor() : uint
      {
         return _color;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvents();
         if(_over.parent)
         {
            _over.parent.removeChild(_over);
         }
      }
   }
}
