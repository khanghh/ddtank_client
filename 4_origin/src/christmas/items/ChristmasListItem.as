package christmas.items
{
   import bagAndInfo.cell.CellFactory;
   import christmas.ChristmasCoreController;
   import christmas.ChristmasCoreManager;
   import christmas.info.ChristmasSystemItemsInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import shop.view.ShopItemCell;
   
   public class ChristmasListItem extends Sprite implements Disposeable
   {
      
      public static var isCreate:Boolean;
       
      
      private var _info:ChristmasSystemItemsInfo;
      
      private var _bg:Bitmap;
      
      private var _countTxt:FilterFrameText;
      
      private var _itemCell:ShopItemCell;
      
      private var _receiveBtn:BaseButton;
      
      private var _shopItemInfo:ChristmasSystemItemsInfo;
      
      public var _poorTxt:FilterFrameText;
      
      private var _itemID:int;
      
      private var _snowPackNum:int;
      
      private var _receiveOK:Bitmap;
      
      public function ChristmasListItem()
      {
         super();
      }
      
      public function initView(index:int = 0) : void
      {
         var newBnt:* = null;
         var newReceiveBnt:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("christmas.list.Back");
         _receiveOK = ComponentFactory.Instance.creatBitmap("asset.makingSnowmen.receiveOK");
         _receiveOK.visible = false;
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("christmas.list.countTxt");
         _itemCell = creatItemCell();
         _itemCell.buttonMode = true;
         _itemCell.cellSize = 46;
         PositionUtils.setPos(_itemCell,"christmasListItem.cellPos");
         addChild(_bg);
         addChild(_countTxt);
         addChild(_itemCell);
         if(index >= ChristmasCoreManager.instance.model.packsLen - 1)
         {
            _poorTxt = ComponentFactory.Instance.creatComponentByStylename("christmas.list.poorTxt");
            _receiveBtn = ComponentFactory.Instance.creat("christmas.makingSnowmen.lockBtn");
            newBnt = ChristmasCoreManager.instance.returnComponentBnt(_receiveBtn,LanguageMgr.GetTranslation("christmas.receiveBtn.tip"));
            addChild(newBnt);
            addChild(_poorTxt);
         }
         else
         {
            _receiveBtn = ComponentFactory.Instance.creat("christmas.makingSnowmen.receiveBtn");
            if(ChristmasCoreManager.instance.CanGetGift(index) && ChristmasCoreManager.instance.model.snowPackNum[index] > ChristmasCoreManager.instance.model.count)
            {
               newReceiveBnt = ChristmasCoreManager.instance.returnComponentBnt(_receiveBtn,LanguageMgr.GetTranslation("christmas.listItem.num"));
               addChild(newReceiveBnt);
            }
            else if(ChristmasCoreManager.instance.CanGetGift(index) && ChristmasCoreManager.instance.model.snowPackNum[index] <= ChristmasCoreManager.instance.model.count)
            {
               addChild(_receiveBtn);
            }
            else
            {
               _receiveOK.visible = true;
               if(_receiveBtn)
               {
                  ObjectUtils.disposeObject(_receiveBtn);
                  _receiveBtn = null;
               }
            }
         }
         addChild(_receiveOK);
         grayButton();
         initEvent();
      }
      
      private function initEvent() : void
      {
         if(_receiveBtn)
         {
            _receiveBtn.addEventListener("click",__shopViewItemBtnClick);
         }
      }
      
      public function initText(num:int, index:int) : void
      {
         _snowPackNum = num;
         _countTxt.text = LanguageMgr.GetTranslation("christmas.list.countTxt.LG",num);
      }
      
      protected function creatItemCell() : ShopItemCell
      {
         var sp:Sprite = new Sprite();
         sp.graphics.beginFill(16777215,0);
         sp.graphics.drawRect(0,0,46,46);
         sp.graphics.endFill();
         return CellFactory.instance.createShopItemCell(sp,null,true,true) as ShopItemCell;
      }
      
      private function __shopViewItemBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(ChristmasCoreController.instance.model.count < snowPackNum)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("christmas.listItem.num"));
            return;
         }
         SocketManager.Instance.out.sendButChristmasGoods(_shopItemInfo.TemplateID);
      }
      
      public function set shopItemInfo(value:ChristmasSystemItemsInfo) : void
      {
         if(_shopItemInfo)
         {
            _shopItemInfo.removeEventListener("change",__updateShopItem);
         }
         _shopItemInfo = value;
         if(_shopItemInfo)
         {
            _itemID = _shopItemInfo.TemplateID;
            _itemCell.info = _shopItemInfo.TemplateInfo;
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
      
      public function receiveOK() : void
      {
         _receiveOK.visible = true;
         if(_receiveBtn)
         {
            ObjectUtils.disposeObject(_receiveBtn);
            _receiveBtn = null;
         }
      }
      
      public function grayButton() : void
      {
         if(_receiveBtn)
         {
            _receiveBtn.mouseChildren = false;
            _receiveBtn.mouseEnabled = false;
            _receiveBtn.enable = false;
         }
      }
      
      public function recoverButton() : void
      {
         if(_receiveBtn)
         {
            _receiveBtn.mouseChildren = true;
            _receiveBtn.mouseEnabled = true;
            _receiveBtn.enable = true;
         }
      }
      
      public function specialButton() : void
      {
         if(_receiveBtn)
         {
            ObjectUtils.disposeObject(_receiveBtn);
            _receiveBtn = null;
         }
         _receiveBtn = ComponentFactory.Instance.creat("christmas.makingSnowmen.receiveBtn");
         addChild(_receiveBtn);
         _receiveBtn.addEventListener("click",__shopViewItemBtnClick);
         _receiveBtn.mouseChildren = true;
         _receiveBtn.mouseEnabled = true;
         _receiveBtn.enable = true;
      }
      
      private function removeEvent() : void
      {
         if(_receiveBtn)
         {
            _receiveBtn.removeEventListener("click",__shopViewItemBtnClick);
         }
         if(_shopItemInfo)
         {
            _shopItemInfo.removeEventListener("change",__updateShopItem);
         }
      }
      
      public function get itemID() : int
      {
         return _itemID;
      }
      
      public function set itemID(value:int) : void
      {
         _itemID = value;
      }
      
      public function get snowPackNum() : int
      {
         return _snowPackNum;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_itemCell);
         _itemCell = null;
         ObjectUtils.disposeObject(_receiveBtn);
         _receiveBtn = null;
         _shopItemInfo = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
