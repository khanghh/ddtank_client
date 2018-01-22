package petsBag.petsAdvanced
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class PetsAwakenInfoCell extends Sprite implements Disposeable
   {
       
      
      private var _equipCell:PetsAwakenEquipCell;
      
      private var _awakenSucessMovie:MovieClip;
      
      private var _bg:Bitmap;
      
      public function PetsAwakenInfoCell()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("asset.petsBag.awaken.upgradeBorder");
         addChild(_bg);
         _awakenSucessMovie = ComponentFactory.Instance.creat("asset.petsBg.awakenSucess.movie");
         _awakenSucessMovie.x = -16;
         _awakenSucessMovie.y = -15;
         _awakenSucessMovie.visible = false;
         addChild(_awakenSucessMovie);
      }
      
      public function set iteminfo(param1:InventoryItemInfo) : void
      {
         if(_equipCell == null)
         {
            _equipCell = new PetsAwakenEquipCell(0);
            _equipCell.setContentSize(72,72);
            _equipCell.bgVisible = false;
            _equipCell.x = 12;
            _equipCell.y = 14;
            addChild(_equipCell);
         }
         _equipCell.info = param1;
         _awakenSucessMovie.visible = param1 != null;
      }
      
      public function get cellInfo() : InventoryItemInfo
      {
         if(_equipCell)
         {
            return _equipCell.info as InventoryItemInfo;
         }
         return null;
      }
      
      public function dispose() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_awakenSucessMovie)
         {
            ObjectUtils.disposeObject(_awakenSucessMovie);
         }
         _awakenSucessMovie = null;
         if(_equipCell)
         {
            ObjectUtils.disposeObject(_equipCell);
         }
         _equipCell = null;
      }
   }
}
