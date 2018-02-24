package bombKing.components
{
   import bombKing.data.BKingPlayerInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class BKingLine extends Sprite implements Disposeable
   {
       
      
      private var _darkLine:Bitmap;
      
      private var _lightLine:Bitmap;
      
      private var _place:int;
      
      public function BKingLine(param1:int){super();}
      
      private function initView() : void{}
      
      public function set info(param1:BKingPlayerInfo) : void{}
      
      public function dispose() : void{}
   }
}
