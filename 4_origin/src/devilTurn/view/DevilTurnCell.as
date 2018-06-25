package devilTurn.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   
   public class DevilTurnCell extends BagCell
   {
       
      
      private var _selectMovie:Bitmap;
      
      private var _selected:Boolean;
      
      public function DevilTurnCell(index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null, mouseOverEffBoolean:Boolean = true)
      {
         super(index,info,showLoading,bg,mouseOverEffBoolean);
         init();
      }
      
      private function init() : void
      {
         _selectMovie = ComponentFactory.Instance.creatBitmap("asset.deviturn.dice.shine");
         _selectMovie.x = -14;
         _selectMovie.y = -15;
         addChild(_selectMovie);
         selected = false;
      }
      
      public function set selected(value:Boolean) : void
      {
         _selected = value;
         _selectMovie.visible = _selected;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_selectMovie);
         _selectMovie = null;
         super.dispose();
      }
   }
}
