package shop.view
{
   import bagAndInfo.cell.CellFactory;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class ShopBugleView extends Sprite implements Disposeable
   {
      
      private static const BUGLE:uint = 3;
      
      private static const GOLD:uint = 0;
      
      private static const TEXP:uint = 6;
      
      public static const DONT_BUY_ANYTHING:String = "dontBuyAnything";
       
      
      private var _frame:BaseAlerFrame;
      
      private var _info:ShopItemInfo;
      
      private var _itemContainer:HBox;
      
      private var _itemGroup:SelectedButtonGroup;
      
      private var _type:int;
      
      private var _buyFrom:int;
      
      public function ShopBugleView($type:int)
      {
         super();
         _type = $type;
         init();
         ChatManager.Instance.focusFuncEnabled = false;
         if(_info)
         {
            LayerManager.Instance.addToLayer(this,3,true,2);
         }
      }
      
      public function dispose() : void
      {
         var item:* = null;
         StageReferance.stage.removeEventListener("keyDown",__onKeyDownd);
         if(_type == 40002)
         {
            KeyboardShortcutsManager.Instance.prohibitNewHandBag(true);
         }
         while(_itemContainer.numChildren > 0)
         {
            item = _itemContainer.getChildAt(0) as ShopBugleViewItem;
            item.removeEventListener("click",__click);
            item.dispose();
            item = null;
         }
         _frame.dispose();
         clearAllItem();
         _frame = null;
         _itemContainer.dispose();
         _itemContainer = null;
         _info = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         ChatManager.Instance.focusFuncEnabled = true;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get info() : ShopItemInfo
      {
         return _info;
      }
      
      protected function __onKeyDownd(e:KeyboardEvent) : void
      {
         var number:int = _itemGroup.selectIndex;
         var max:int = _itemContainer.numChildren;
         if(e.keyCode == 37)
         {
            if(number == 0)
            {
               §§push(0);
            }
            else
            {
               number--;
               §§push(number);
            }
            number = §§pop();
         }
         else if(e.keyCode == 39)
         {
            if(number == max - 1)
            {
               §§push(max - 1);
            }
            else
            {
               number++;
               §§push(number);
            }
            number = §§pop();
         }
         if(_itemGroup.selectIndex != number)
         {
            SoundManager.instance.play("008");
            _itemGroup.selectIndex = number;
         }
         e.stopImmediatePropagation();
         e.stopPropagation();
      }
      
      private function __frameEventHandler(e:FrameEvent) : void
      {
         var item:* = null;
         SoundManager.instance.play("008");
         switch(int(e.responseCode))
         {
            case 0:
            case 1:
               dispatchEvent(new Event("DONT_BUY_ANYTHING"));
               dispose();
               break;
            case 2:
            case 3:
            case 4:
               if(PlayerManager.Instance.Self.bagLocked)
               {
                  BaglockedManager.Instance.show();
                  return;
               }
               item = _itemContainer.getChildAt(_itemGroup.selectIndex) as ShopBugleViewItem;
               if(PlayerManager.Instance.Self.Money < item.money)
               {
                  LeavePageManager.showFillFrame();
                  return;
               }
               SocketManager.Instance.out.sendBuyGoods([_info.GoodsID],[item.type],[""],[0],[false],[""],_buyFrom);
               dispose();
               break;
         }
      }
      
      private function addItem(info:ShopItemInfo, index:int) : void
      {
         var shape:Shape = new Shape();
         shape.graphics.beginFill(16777215,0);
         shape.graphics.drawRect(0,0,70,70);
         shape.graphics.endFill();
         var cell:ShopItemCell = CellFactory.instance.createShopItemCell(shape,info.TemplateInfo) as ShopItemCell;
         PositionUtils.setPos(cell,"ddtshop.BugleViewItemCellPos");
         var item:ShopBugleViewItem = new ShopBugleViewItem(index,info.getTimeToString(index),info.getItemPrice(index).bothMoneyValue,cell);
         item.addEventListener("click",__click);
         _itemContainer.addChild(item);
         _itemGroup.addSelectItem(item);
      }
      
      private function __click(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _itemGroup.selectIndex = _itemContainer.getChildIndex(e.currentTarget as ShopBugleViewItem);
      }
      
      private function addItems() : void
      {
         var id:int = 0;
         if(_type == 11102)
         {
            id = 11102;
            _frame.titleText = LanguageMgr.GetTranslation("tank.dialog.showbugleframe.bigbugletitle");
            _buyFrom = 3;
         }
         else if(_type == 11101)
         {
            id = 11101;
            _frame.titleText = LanguageMgr.GetTranslation("tank.dialog.showbugleframe.smallbugletitle");
            _buyFrom = 3;
         }
         else if(_type == 11100)
         {
            id = 11100;
            _frame.titleText = LanguageMgr.GetTranslation("tank.dialog.showbugleframe.crossbugletitle");
            _buyFrom = 3;
         }
         else if(_type == 11456)
         {
            id = 11456;
            _frame.titleText = LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy");
            _buyFrom = 0;
         }
         else if(_type == 40002)
         {
            id = 40002;
            _frame.titleText = LanguageMgr.GetTranslation("tank.dialog.showbugleframe.texpQuickBuy");
            _buyFrom = 6;
         }
         _info = ShopManager.Instance.getMoneyShopItemByTemplateID(id);
         if(_info)
         {
            if(_info.getItemPrice(1).IsValid)
            {
               addItem(_info,1);
            }
            if(_info.getItemPrice(2).IsValid)
            {
               addItem(_info,2);
            }
            if(_info.getItemPrice(3).IsValid)
            {
               addItem(_info,3);
            }
         }
      }
      
      private function clearAllItem() : void
      {
         var item:* = null;
         while(_itemContainer.numChildren > 0)
         {
            item = _itemContainer.getChildAt(0) as ShopBugleViewItem;
            item.removeEventListener("click",__click);
            item.dispose();
            item = null;
         }
      }
      
      private function init() : void
      {
         _itemGroup = new SelectedButtonGroup();
         _frame = ComponentFactory.Instance.creatComponentByStylename("ddtshop.newBugleFrame");
         _itemContainer = ComponentFactory.Instance.creatComponentByStylename("ddtshop.newBugleViewItemContainer");
         var ai:AlertInfo = new AlertInfo("",LanguageMgr.GetTranslation("tank.dialog.showbugleframe.ok"));
         _frame.info = ai;
         _frame.addToContent(_itemContainer);
         _frame.addEventListener("response",__frameEventHandler);
         addChild(_frame);
         updateView();
         _itemGroup.selectIndex = 0;
         StageReferance.stage.addEventListener("keyDown",__onKeyDownd);
      }
      
      private function updateView() : void
      {
         clearAllItem();
         addItems();
      }
   }
}
