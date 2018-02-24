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
      
      public function DevilTurnCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:DisplayObject = null, param5:Boolean = true)
      {
         super(param1,param2,param3,param4,param5);
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
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
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
