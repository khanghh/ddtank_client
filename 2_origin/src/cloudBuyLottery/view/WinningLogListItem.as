package cloudBuyLottery.view
{
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import shop.view.ShopItemCell;
   
   public class WinningLogListItem extends Sprite implements Disposeable
   {
       
      
      private var _itemCell:ShopItemCell;
      
      private var _shopItemInfo:WinningLogItemInfo;
      
      private var _itemID:int;
      
      private var _bg:Bitmap;
      
      private var _cellImg:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _txt:FilterFrameText;
      
      public function WinningLogListItem()
      {
         super();
      }
      
      public function initView(param1:String, param2:int = 0) : void
      {
         param2++;
         if(param2 % 2 == 0)
         {
            _bg = ComponentFactory.Instance.creatBitmap("asset.IndividualLottery.cellBg");
            addChild(_bg);
         }
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("WinningLogListItem.nameTxt");
         _nameTxt.text = param1;
         _txt = ComponentFactory.Instance.creatComponentByStylename("WinningLogListItem.txt");
         _txt.text = LanguageMgr.GetTranslation("WinningLogListItem.txt.LG");
         _cellImg = ComponentFactory.Instance.creatBitmap("asset.IndividualLottery.goodsCell");
         _itemCell = creatItemCell();
         _itemCell.buttonMode = true;
         _itemCell.cellSize = 46;
         PositionUtils.setPos(_itemCell,"WinningLogListItem.cellPos");
         addChild(_cellImg);
         addChild(_itemCell);
         addChild(_nameTxt);
         addChild(_txt);
      }
      
      protected function creatItemCell() : ShopItemCell
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,46,46);
         _loc1_.graphics.endFill();
         return CellFactory.instance.createShopItemCell(_loc1_,null,true,true) as ShopItemCell;
      }
      
      public function set shopItemInfo(param1:WinningLogItemInfo) : void
      {
         var _loc2_:* = null;
         if(_shopItemInfo)
         {
            _shopItemInfo.removeEventListener("change",__updateShopItem);
         }
         _shopItemInfo = param1;
         if(_shopItemInfo)
         {
            _loc2_ = new InventoryItemInfo();
            ObjectUtils.copyProperties(_loc2_,_shopItemInfo.TemplateInfo);
            _loc2_.ValidDate = _shopItemInfo.validate;
            _loc2_.StrengthenLevel = _shopItemInfo.property[0];
            _loc2_.AttackCompose = _shopItemInfo.property[1];
            _loc2_.DefendCompose = _shopItemInfo.property[2];
            _loc2_.LuckCompose = _shopItemInfo.property[3];
            _loc2_.AgilityCompose = _shopItemInfo.property[4];
            _loc2_.IsBinds = true;
            _itemID = _shopItemInfo.TemplateID;
            _itemCell.info = _loc2_;
            _itemCell.buttonMode = true;
            _shopItemInfo.addEventListener("change",__updateShopItem);
         }
         else
         {
            _itemCell.info = null;
            _itemCell.buttonMode = false;
         }
      }
      
      private function __updateShopItem(param1:Event) : void
      {
         _itemCell.info = _shopItemInfo.TemplateInfo;
      }
      
      public function get itemID() : int
      {
         return _itemID;
      }
      
      public function set itemID(param1:int) : void
      {
         _itemID = param1;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_itemCell);
         _itemCell = null;
         _shopItemInfo = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
