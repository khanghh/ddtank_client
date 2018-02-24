package email.view
{
   import bagAndInfo.cell.DragEffect;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.email.EmailInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   class DiamondBase extends Sprite implements Disposeable
   {
      
      private static var CELL_HEIGHT:int = 45;
      
      private static var CELL_WIDTH:int = 45;
       
      
      protected var _info:EmailInfo;
      
      public var diamondBg:ScaleBitmapImage;
      
      public var chargedImg:Bitmap;
      
      public var centerMC:ScaleFrameImage;
      
      public var countTxt:FilterFrameText;
      
      private var _index:int;
      
      public var _cell:EmaillBagCell;
      
      function DiamondBase(){super();}
      
      protected function initView() : void{}
      
      public function get index() : int{return 0;}
      
      public function set index(param1:int) : void{}
      
      public function get info() : EmailInfo{return null;}
      
      public function set info(param1:EmailInfo) : void{}
      
      public function forSendedCell() : void{}
      
      public function dragDrop(param1:DragEffect) : void{}
      
      protected function addEvent() : void{}
      
      protected function removeEvent() : void{}
      
      protected function update() : void{}
      
      public function dispose() : void{}
   }
}
