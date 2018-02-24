package petsBag.view.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class StarBar extends Sprite implements Disposeable
   {
      
      public static var SPACE:Number = 0.2;
      
      public static var TOTAL_STAR:int = 6;
       
      
      private var _starImgVec:Vector.<Bitmap>;
      
      public function StarBar(){super();}
      
      public function starNum(param1:int, param2:String = "assets.petsBag.star") : void{}
      
      private function update() : void{}
      
      private function remove() : void{}
      
      public function dispose() : void{}
   }
}
