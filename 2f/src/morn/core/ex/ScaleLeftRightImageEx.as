package morn.core.ex
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import morn.core.components.Component;
   
   public class ScaleLeftRightImageEx extends Component
   {
       
      
      private var _bitmaps:Vector.<Bitmap>;
      
      private var _cutRect:String = "1,100";
      
      private var _skin:String;
      
      public function ScaleLeftRightImageEx(){super();}
      
      public function set skin(param1:String) : void{}
      
      override protected function changeSize() : void{}
      
      private function resetBitmaps() : void{}
      
      private function drawImage() : void{}
      
      protected function clearImages() : void{}
      
      override public function dispose() : void{}
   }
}
