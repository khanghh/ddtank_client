package prayIndiana.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import prayIndiana.PrayIndianaManager;
   
   public class PrayGoodsView extends Sprite
   {
       
      
      private var _goodsFrameArr:Array;
      
      private var _cell:BagCell;
      
      private var _cellArr:Array;
      
      private var _goodItemContainerAll:Array;
      
      private var _goodsItemSprite:Sprite;
      
      public function PrayGoodsView(){super();}
      
      private function initView() : void{}
      
      public function setInfo(param1:Array) : void{}
      
      private function removeEvnet() : void{}
      
      public function dispose() : void{}
      
      public function get goodItemContainerAll() : Array{return null;}
      
      public function set goodItemContainerAll(param1:Array) : void{}
      
      public function get cellArr() : Array{return null;}
      
      public function set cellArr(param1:Array) : void{}
      
      public function get goodsItemSprite() : Sprite{return null;}
      
      public function set goodsItemSprite(param1:Sprite) : void{}
   }
}
