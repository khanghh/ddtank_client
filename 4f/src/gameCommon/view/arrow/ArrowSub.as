package gameCommon.view.arrow
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class ArrowSub extends Sprite implements Disposeable
   {
       
      
      private var _center:Bitmap;
      
      public var arrowChonghe_mc:Bitmap;
      
      public var arrow:Bitmap;
      
      public var arrowClone_mc:Bitmap;
      
      private var _halfRound:Bitmap;
      
      public var green_mc:Bitmap;
      
      public var circle_mc:Bitmap;
      
      public function ArrowSub(){super();}
      
      private function initView() : void{}
      
      public function dispose() : void{}
   }
}
