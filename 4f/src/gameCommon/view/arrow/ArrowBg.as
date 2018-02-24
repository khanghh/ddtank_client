package gameCommon.view.arrow
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class ArrowBg extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      public var arrowSub:ArrowSub;
      
      private var _ruling:Bitmap;
      
      public function ArrowBg(){super();}
      
      public function dispose() : void{}
   }
}
