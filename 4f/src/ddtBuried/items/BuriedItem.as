package ddtBuried.items
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class BuriedItem extends Sprite implements Disposeable
   {
       
      
      private var _txt:FilterFrameText;
      
      private var _back:Bitmap;
      
      private var _icon:Bitmap;
      
      public function BuriedItem(param1:String, param2:String){super();}
      
      private function initView(param1:String, param2:String) : void{}
      
      public function upDateTxt(param1:String) : void{}
      
      public function dispose() : void{}
   }
}
