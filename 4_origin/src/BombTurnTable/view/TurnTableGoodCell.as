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
      
      public function TurnTableGoodCell(info:BombTurnTableGoodInfo, quality:int)
      {
         _info = info;
         _index = info.place;
         _temID = info.templateId;
         _state = info.isReceive;
         _quality = quality;
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
         var count:int = 0;
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
            count = _cell.itemInfo.Count;
            if(count > 1)
            {
               _goodCount.text = count.toString();
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
         var info:InventoryItemInfo = new InventoryItemInfo();
         info.TemplateID = _temID;
         info.IsBinds = true;
         info.Count = _info.goodCount;
         info = ItemManager.fill(info);
         info.BindType = 4;
         var cell:BagCell = new BagCell(0,info,true);
         cell.setBgVisible(false);
         cell.setContentSize(57,57);
         cell.setCountNotVisible();
         return cell;
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
