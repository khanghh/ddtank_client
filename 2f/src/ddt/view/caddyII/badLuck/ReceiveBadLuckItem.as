package ddt.view.caddyII.badLuck
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class ReceiveBadLuckItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleFrameImage;
      
      private var _RsortTxt:FilterFrameText;
      
      private var _RnameTxt:FilterFrameText;
      
      private var _RgoosTxt:FilterFrameText;
      
      private var _topThteeBit:ScaleFrameImage;
      
      private var _cell:BaseCell;
      
      public function ReceiveBadLuckItem(){super();}
      
      private function initView() : void{}
      
      public function update(param1:int, param2:String, param3:InventoryItemInfo) : void{}
      
      override public function get height() : Number{return 0;}
      
      public function dispose() : void{}
   }
}
