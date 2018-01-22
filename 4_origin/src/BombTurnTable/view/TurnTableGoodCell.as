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
      
      public function TurnTableGoodCell(param1:BombTurnTableGoodInfo, param2:int)
      {
         _info = param1;
         _index = param1.place;
         _temID = param1.templateId;
         _state = param1.isReceive;
         _quality = param2;
         super();
         initView();
      }
      
      protected function initView() : void
      {
         if(_temID > 0)
         {
            createGoodView();
         }
         else
         {
            createSpecialGoodView();
         }
      }
      
      protected function createGoodView() : void
      {
         var _loc1_:int = 0;
         _bg = ComponentFactory.Instance.creatBitmap("asset.bombTurnTable.goodbg.quality" + _quality);
         addChild(_bg);
         _cell = createCell();
         addChild(_cell);
         _goodCount = ComponentFactory.Instance.creatComponentByStylename("BagCellCountText");
         _goodCount.mouseEnabled = false;
         _goodCount.rotationZ = 0;
         _goodCount.x = 51;
         _goodCount.y = 41;
         addChild(_goodCount);
         if(_cell)
         {
            _loc1_ = _cell.itemInfo.Count;
            if(_loc1_ > 1)
            {
               _goodCount.text = _loc1_.toString();
            }
         }
      }
      
      protected function createSpecialGoodView() : void
      {
         if(_temID == -1)
         {
            _icon = ComponentFactory.Instance.creatBitmap("asset.bombTurnTable.upgrade");
            _icon.smoothing = true;
         }
         else if(_temID == -2)
         {
            _icon = ComponentFactory.Instance.creatBitmap("asset.bombTurnTable.degrade");
            _icon.smoothing = true;
         }
         addChild(_icon);
      }
      
      protected function createCell() : BagCell
      {
         var _loc2_:InventoryItemInfo = new InventoryItemInfo();
         _loc2_.TemplateID = _temID;
         _loc2_.IsBinds = true;
         _loc2_.Count = _info.goodCount;
         _loc2_ = ItemManager.fill(_loc2_);
         _loc2_.BindType = 4;
         var _loc1_:BagCell = new BagCell(0,_loc2_,true);
         _loc1_.setBgVisible(false);
         _loc1_.setContentSize(57,57);
         _loc1_.setCountNotVisible();
         return _loc1_;
      }
      
      public function get info() : BombTurnTableGoodInfo
      {
         return _info;
      }
      
      public function getGoodName() : String
      {
         if(_cell)
         {
            return _cell.info.Name;
         }
         return "";
      }
      
      public function place() : int
      {
         return _index;
      }
      
      public function dispose() : void
      {
         _index = 0;
         _temID = 0;
         _state = 0;
         _quality = 0;
         _info = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_icon)
         {
            ObjectUtils.disposeObject(_icon);
         }
         _icon = null;
         if(_cell)
         {
            ObjectUtils.disposeObject(_cell);
         }
         _cell = null;
         if(_selectMc)
         {
            ObjectUtils.disposeObject(_selectMc);
         }
         _selectMc = null;
         if(_goodCount)
         {
            ObjectUtils.disposeObject(_goodCount);
         }
         _goodCount = null;
      }
   }
}
