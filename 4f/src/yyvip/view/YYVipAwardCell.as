package yyvip.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class YYVipAwardCell extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _itemCell:BagCell;
      
      private var _countBg:Bitmap;
      
      private var _itemCountTxt:FilterFrameText;
      
      private var _itemNameTxt:FilterFrameText;
      
      public function YYVipAwardCell(param1:Object){super();}
      
      public function dispose() : void{}
   }
}
