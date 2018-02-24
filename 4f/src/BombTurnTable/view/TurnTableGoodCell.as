package BombTurnTable.view
{
   import BombTurnTable.data.BombTurnTableGoodInfo;
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class TurnTableGoodCell extends Sprite implements Disposeable
   {
       
      
      private var _index:int;
      
      private var _temID:int;
      
      private var _state:int;
      
      private var _quality:int;
      
      private var _bg:Bitmap;
      
      private var _cell:BagCell;
      
      private var _info:BombTurnTableGoodInfo;
      
      protected var _selectMc:MovieClip;
      
      private var _goodCount:FilterFrameText;
      
      private var _icon:Bitmap;
      
      public function TurnTableGoodCell(param1:BombTurnTableGoodInfo, param2:int){super();}
      
      protected function initView() : void{}
      
      protected function createGoodView() : void{}
      
      protected function createSpecialGoodView() : void{}
      
      protected function createCell() : BagCell{return null;}
      
      public function get info() : BombTurnTableGoodInfo{return null;}
      
      public function getGoodName() : String{return null;}
      
      public function place() : int{return 0;}
      
      public function dispose() : void{}
   }
}
