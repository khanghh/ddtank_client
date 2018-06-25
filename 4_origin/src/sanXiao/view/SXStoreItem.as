package sanXiao.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.pageSelector.IPageItem;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import sanXiao.SanXiaoManager;
   import sanXiao.model.SXStoreItemData;
   
   public class SXStoreItem extends Sprite implements Disposeable, IPageItem
   {
       
      
      private var _bg:Bitmap;
      
      private var _bagCell:BagCell;
      
      private var _titleTxt:FilterFrameText;
      
      private var _priceIcon:Bitmap;
      
      private var _priceText:FilterFrameText;
      
      private var _exchangeBtn:SimpleBitmapButton;
      
      private var _data:SXStoreItemData;
      
      public function SXStoreItem()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("ast.sanxiao.storeBG");
         addChild(_bg);
         var bg:Shape = new Shape();
         bg.graphics.beginFill(0,0);
         bg.graphics.drawRect(0,0,66,66);
         bg.graphics.endFill();
         _bagCell = new BagCell(0,null,true,bg);
         _bagCell.width = 66;
         _bagCell.height = 66;
         _bagCell.tbxCount.scaleX = 1 / _bagCell.scaleX;
         _bagCell.tbxCount.scaleY = 1 / _bagCell.scaleY;
         PositionUtils.setPos(_bagCell.tbxCount,"sanxiao.itemCount");
         PositionUtils.setPos(_bagCell,"sanxiao.storeItemBagCell.pt");
         addChild(_bagCell);
         _titleTxt = ComponentFactory.Instance.creat("sanxiao.storeItemTitle14.Txt");
         PositionUtils.setPos(_titleTxt,"sanxiao.storeItemTitle.pt");
         addChild(_titleTxt);
         _priceIcon = ComponentFactory.Instance.creatBitmap("ast.sanxiao.crystal");
         PositionUtils.setPos(_priceIcon,"sanxiao.storeItemIcon.pt");
         addChild(_priceIcon);
         _priceText = ComponentFactory.Instance.creat("sanxiao.storeItemPrice.Txt");
         PositionUtils.setPos(_priceText,"sanxiao.storeItemPrice.pt");
         addChild(_priceText);
         _exchangeBtn = ComponentFactory.Instance.creat("sanxiao.exchange.btn");
         addChild(_exchangeBtn);
         _exchangeBtn.addEventListener("click",onExchangeClick);
      }
      
      protected function onExchangeClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_data == null)
         {
            return;
         }
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(SanXiaoManager.getInstance().crystalNum < int(_priceText.text))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("sanxiao.crystalNotEnough"),0,true,1);
            return;
         }
         var buyAlert:SXShopBuyView = ComponentFactory.Instance.creatComponentByStylename("sanxiao.QuickBuyAlert");
         buyAlert.setData(_data.TempleteID,_data.TempleteID,_data.price);
         buyAlert.setID(_data.id);
         buyAlert.setBuyNum(_data.remain);
         LayerManager.Instance.addToLayer(buyAlert,2,true,1);
      }
      
      public function updateItem(data:Object = null) : void
      {
         if(data == null)
         {
            _bagCell.info = null;
            _priceText.text = "";
            _titleTxt.text = "";
            _priceIcon.visible = false;
            _exchangeBtn.visible = false;
            return;
         }
         _data = data as SXStoreItemData;
         var __info:InventoryItemInfo = new InventoryItemInfo();
         ObjectUtils.copyProperties(__info,ItemManager.Instance.getTemplateById(_data.TempleteID));
         __info.ValidDate = _data.Valid;
         __info.IsBinds = _data.isBind;
         __info.Count = _data.count;
         __info.Property5 = "1";
         _bagCell.info = __info;
         if(_bagCell.info)
         {
            _titleTxt.text = _bagCell.info.Name + "(" + _data.remain + "/" + _data.total + ")";
         }
         _bagCell.setCount(__info.Count);
         _priceText.text = _data.price.toString();
         _exchangeBtn.enable = _data.remain >= 1;
         _priceIcon.visible = true;
         _exchangeBtn.visible = true;
      }
      
      public function getID() : int
      {
         return !!_bagCell.info?_bagCell.info.TemplateID:0;
      }
      
      public function dispose() : void
      {
         if(_exchangeBtn)
         {
            _exchangeBtn.addEventListener("click",onExchangeClick);
         }
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _bagCell = null;
         _titleTxt = null;
         _priceIcon = null;
         _priceText = null;
         _exchangeBtn = null;
      }
   }
}
