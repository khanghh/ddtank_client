package gemstone.views
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class GemtstonePrompt extends Frame
   {
       
      
      private var _btn:SimpleBitmapButton;
      
      private var _goodsContent:Bitmap;
      
      private var _goods:Bitmap;
      
      public function GemtstonePrompt(){super();}
      
      protected function clickHander(param1:MouseEvent) : void{}
      
      private function response(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
