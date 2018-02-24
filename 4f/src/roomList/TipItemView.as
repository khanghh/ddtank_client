package roomList
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TipItemView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _bgII:ScaleBitmapImage;
      
      private var _value:int;
      
      private var _cellWidth:int;
      
      private var _cellheight:int;
      
      public function TipItemView(param1:Bitmap, param2:int, param3:int, param4:int){super();}
      
      private function init() : void{}
      
      protected function __itemOut(param1:MouseEvent) : void{}
      
      protected function __itemOver(param1:MouseEvent) : void{}
      
      public function get value() : int{return 0;}
      
      public function dispose() : void{}
   }
}
