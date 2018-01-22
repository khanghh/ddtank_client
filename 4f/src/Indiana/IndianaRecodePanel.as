package Indiana
{
   import Indiana.item.IndianaRecodeItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class IndianaRecodePanel extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _scroller:ScrollPanel;
      
      private var _vbox:VBox;
      
      public function IndianaRecodePanel(){super();}
      
      private function initEvent() : void{}
      
      private function __recodeUpdata(param1:Event) : void{}
      
      private function initView() : void{}
      
      private function setItem() : void{}
      
      public function clearItem() : void{}
      
      public function dispose() : void{}
   }
}
