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
      
      public function ShopBugleView(param1:int)
      {
         super();
         _type = param1;
         init();
         ChatManager.Instance.focusFuncEnabled = false;
         if(_info)
         {
            LayerManager.Instance.addToLayer(this,3,true,2);
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         StageReferance.stage.removeEventListener("keyDown",__onKeyDownd);
         if(_type == 40002)
         {
            KeyboardShortcutsManager.Instance.prohibitNewHandBag(true);
         }
         while(_itemContainer.numChildren > 0)
         {
            _loc1_ = _itemContainer.getChildAt(0) as ShopBugleViewItem;
            _loc1_.removeEventListener("click",__click);
            _loc1_.dispose();
            _loc1_ = null;
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
      
      protected function __onKeyDownd(param1:KeyboardEvent) : void
      {
         var _loc3_:int = _itemGroup.selectIndex;
         var _loc2_:int = _itemContainer.numChildren;
         if(param1.keyCode == 37)
         {
            if(_loc3_ == 0)
            {
               §§push(0);
            }
            else
            {
               _loc3_--;
               §§push(_loc3_);
            }
            _loc3_ = §§pop();
         }
         else if(param1.keyCode == 39)
         {
            if(_loc3_ == _loc2_ - 1)
            {
               §§push(_loc2_ - 1);
            }
            else
            {
               _loc3_++;
               §§push(_loc3_);
            }
            _loc3_ = §§pop();
         }
         if(_itemGroup.selectIndex != _loc3_)
         {
            SoundManager.instance.play("008");
            _itemGroup.selectIndex = _loc3_;
         }
         param1.stopImmediatePropagation();
         param1.stopPropagation();
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
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
               _loc2_ = _itemContainer.getChildAt(_itemGroup.selectIndex) as ShopBugleViewItem;
               if(PlayerManager.Instance.Self.Money < _loc2_.money)
               {
                  LeavePageManager.showFillFrame();
                  return;
               }
               SocketManager.Instance.out.sendBuyGoods([_info.GoodsID],[_loc2_.type],[""],[0],[false],[""],_buyFrom);
               dispose();
               break;
         }
      }
      
      private function addItem(param1:ShopItemInfo, param2:int) : void
      {
         var _loc5_:Shape = new Shape();
         _loc5_.graphics.beginFill(16777215,0);
         _loc5_.graphics.drawRect(0,0,70,70);
         _loc5_.graphics.endFill();
         var _loc4_:ShopItemCell = CellFactory.instance.createShopItemCell(_loc5_,param1.TemplateInfo) as ShopItemCell;
         PositionUtils.setPos(_loc4_,"ddtshop.BugleViewItemCellPos");
         var _loc3_:ShopBugleViewItem = new ShopBugleViewItem(param2,param1.getTimeToString(param2),param1.getItemPrice(param2).bothMoneyValue,_loc4_);
         _loc3_.addEventListener("click",__click);
         _itemContainer.addChild(_loc3_);
         _itemGroup.addSelectItem(_loc3_);
      }
      
      private function __click(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _itemGroup.selectIndex = _itemContainer.getChildIndex(param1.currentTarget as ShopBugleViewItem);
      }
      
      private function addItems() : void
      {
         var _loc1_:int = 0;
         if(_type == 11102)
         {
            _loc1_ = 11102;
            _frame.titleText = LanguageMgr.GetTranslation("tank.dialog.showbugleframe.bigbugletitle");
            _buyFrom = 3;
         }
         else if(_type == 11101)
         {
            _loc1_ = 11101;
            _frame.titleText = LanguageMgr.GetTranslation("tank.dialog.showbugleframe.smallbugletitle");
            _buyFrom = 3;
         }
         else if(_type == 11100)
         {
            _loc1_ = 11100;
            _frame.titleText = LanguageMgr.GetTranslation("tank.dialog.showbugleframe.crossbugletitle");
            _buyFrom = 3;
         }
         else if(_type == 11456)
         {
            _loc1_ = 11456;
            _frame.titleText = LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy");
            _buyFrom = 0;
         }
         else if(_type == 40002)
         {
            _loc1_ = 40002;
            _frame.titleText = LanguageMgr.GetTranslation("tank.dialog.showbugleframe.texpQuickBuy");
            _buyFrom = 6;
         }
         _info = ShopManager.Instance.getMoneyShopItemByTemplateID(_loc1_);
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
         var _loc1_:* = null;
         while(_itemContainer.numChildren > 0)
         {
            _loc1_ = _itemContainer.getChildAt(0) as ShopBugleViewItem;
            _loc1_.removeEventListener("click",__click);
            _loc1_.dispose();
            _loc1_ = null;
         }
      }
      
      private function init() : void
      {
         _itemGroup = new SelectedButtonGroup();
         _frame = ComponentFactory.Instance.creatComponentByStylename("ddtshop.newBugleFrame");
         _itemContainer = ComponentFactory.Instance.creatComponentByStylename("ddtshop.newBugleViewItemContainer");
         var _loc1_:AlertInfo = new AlertInfo("",LanguageMgr.GetTranslation("tank.dialog.showbugleframe.ok"));
         _frame.info = _loc1_;
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
