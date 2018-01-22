package exitPrompt
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class ExitButtonItem extends Component
   {
       
      
      private var _bt:BaseButton;
      
      private var _fontBg:Bitmap;
      
      public var fontBgBgUrl:String;
      
      public var coord:String;
      
      private var _light:ScaleBitmapImage;
      
      public function ExitButtonItem(){super();}
      
      override protected function onProppertiesUpdate() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __mouseOverHandler(param1:MouseEvent) : void{}
      
      private function __mouseOutHandler(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
   }
}
