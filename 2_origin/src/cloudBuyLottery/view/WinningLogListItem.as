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
      
      public function initView(name:String, index:int = 0) : void
      {
         index++;
         if(index % 2 == 0)
         {
            _bg = ComponentFactory.Instance.creatBitmap("asset.IndividualLottery.cellBg");
            addChild(_bg);
         }
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("WinningLogListItem.nameTxt");
         _nameTxt.text = name;
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
         var sp:Sprite = new Sprite();
         sp.graphics.beginFill(16777215,0);
         sp.graphics.drawRect(0,0,46,46);
         sp.graphics.endFill();
         return CellFactory.instance.createShopItemCell(sp,null,true,true) as ShopItemCell;
      }
      
      public function set shopItemInfo(value:WinningLogItemInfo) : void
      {
         var tInfo:* = null;
         if(_shopItemInfo)
         {
            _shopItemInfo.removeEventListener("change",__updateShopItem);
         }
         _shopItemInfo = value;
         if(_shopItemInfo)
         {
            tInfo = new InventoryItemInfo();
            ObjectUtils.copyProperties(tInfo,_shopItemInfo.TemplateInfo);
            tInfo.ValidDate = _shopItemInfo.validate;
            tInfo.StrengthenLevel = _shopItemInfo.property[0];
            tInfo.AttackCompose = _shopItemInfo.property[1];
            tInfo.DefendCompose = _shopItemInfo.property[2];
            tInfo.LuckCompose = _shopItemInfo.property[3];
            tInfo.AgilityCompose = _shopItemInfo.property[4];
            tInfo.IsBinds = true;
            _itemID = _shopItemInfo.TemplateID;
            _itemCell.info = tInfo;
            _itemCell.buttonMode = true;
            _shopItemInfo.addEventListener("change",__updateShopItem);
         }
         else
         {
            _itemCell.info = null;
            _itemCell.buttonMode = false;
         }
      }
      
      private function __updateShopItem(event:Event) : void
      {
         _itemCell.info = _shopItemInfo.TemplateInfo;
      }
      
      public function get itemID() : int
      {
         return _itemID;
      }
      
      public function set itemID(value:int) : void
      {
         _itemID = value;
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
