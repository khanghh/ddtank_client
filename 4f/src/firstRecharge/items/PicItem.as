package firstRecharge.items
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class PicItem extends Sprite
   {
       
      
      private var _back:Bitmap;
      
      private var _btn:SimpleBitmapButton;
      
      private var _icon:Bitmap;
      
      private var _txt:FilterFrameText;
      
      public var id:int;
      
      public function PicItem(){super();}
      
      private function initView() : void{}
      
      public function setTxtStr(param1:String) : void{}
      
      protected function mouseClickHander(param1:MouseEvent) : void{}
      
      public function addIcon(param1:String) : void{}
      
      public function dispose() : void{}
   }
}
