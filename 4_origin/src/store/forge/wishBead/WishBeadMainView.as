package store.forge.wishBead
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.BagEvent;
   import ddt.events.CellEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class WishBeadMainView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _bagList:WishBeadBagListView;
      
      private var _proBagList:WishBeadBagListView;
      
      private var _leftDrapSprite:WishBeadLeftDragSprite;
      
      private var _rightDrapSprite:WishBeadRightDragSprite;
      
      private var _itemCell:WishBeadItemCell;
      
      private var _equipCell:WishBeadEquipCell;
      
      private var _continuousBtn:SelectedCheckButton;
      
      private var _doBtn:SimpleBitmapButton;
      
      private var _tip:WishTips;
      
      private var _helpBtn:BaseButton;
      
      private var _isDispose:Boolean = false;
      
      private var _equipBagInfo:BagInfo;
      
      public function WishBeadMainView()
      {
         super();
         this.mouseEnabled = false;
         initView();
         initEvent();
         createAcceptDragSprite();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.wishBead.leftViewBg");
         _bagList = new WishBeadBagListView(0,7,21);
         PositionUtils.setPos(_bagList,"wishBeadMainView.bagListPos");
         refreshBagList();
         _proBagList = new WishBeadBagListView(1,7,21);
         PositionUtils.setPos(_proBagList,"wishBeadMainView.proBagListPos");
         _proBagList.setData(WishBeadManager.instance.getWishBeadItemData());
         _equipCell = new WishBeadEquipCell(0,null,true,new Bitmap(new BitmapData(60,60,true,0)),false);
         _equipCell.BGVisible = false;
         PositionUtils.setPos(_equipCell,"wishBeadMainView.equipCellPos");
         _equipCell.setContentSize(68,68);
         _equipCell.PicPos = new Point(-3,-5);
         _itemCell = new WishBeadItemCell(0,null,true,new Bitmap(new BitmapData(60,60,true,0)),false);
         PositionUtils.setPos(_itemCell,"wishBeadMainView.itemCellPos");
         _itemCell.BGVisible = false;
         _continuousBtn = ComponentFactory.Instance.creatComponentByStylename("wishBeadMainView.continuousBtn");
         _doBtn = ComponentFactory.Instance.creatComponentByStylename("wishBeadMainView.doBtn");
         _doBtn.enable = false;
         var _loc1_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("wishBeadMainView.tipTxt");
         _loc1_.text = LanguageMgr.GetTranslation("wishBeadMainView.tipTxt");
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"wishBead.NodeBtn",null,LanguageMgr.GetTranslation("wishBead.wishBeadHelp.say"),"asset.awardSystem.wishBeadHelp",404,524);
         addChild(_bg);
         addChild(_bagList);
         addChild(_proBagList);
         addChild(_equipCell);
         addChild(_itemCell);
         addChild(_loc1_);
         addChild(_continuousBtn);
         addChild(_doBtn);
         _tip = ComponentFactory.Instance.creat("store.forge.wishBead.WishTip");
         LayerManager.Instance.getLayerByType(0).addChild(_tip);
      }
      
      private function refreshBagList() : void
      {
         _equipBagInfo = WishBeadManager.instance.getCanWishBeadData();
         _bagList.setData(_equipBagInfo);
      }
      
      private function initEvent() : void
      {
         _bagList.addEventListener("itemclick",cellClickHandler,false,0,true);
         _bagList.addEventListener("doubleclick",__cellDoubleClick,false,0,true);
         _equipCell.addEventListener("change",itemEquipChangeHandler,false,0,true);
         _proBagList.addEventListener("itemclick",cellClickHandler,false,0,true);
         _proBagList.addEventListener("doubleclick",__cellDoubleClick,false,0,true);
         _itemCell.addEventListener("change",itemEquipChangeHandler,false,0,true);
         _doBtn.addEventListener("click",doHandler,false,0,true);
         SocketManager.Instance.addEventListener(PkgEvent.format(106),__showTip);
         PlayerManager.Instance.Self.PropBag.addEventListener("update",propInfoChangeHandler);
         PlayerManager.Instance.Self.Bag.addEventListener("update",bagInfoChangeHandler);
      }
      
      private function bagInfoChangeHandler(param1:BagEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:Dictionary = param1.changedSlots;
         var _loc8_:int = 0;
         var _loc7_:* = _loc4_;
         for each(var _loc5_ in _loc4_)
         {
            _loc3_ = _loc5_;
         }
         if(_loc3_ && !PlayerManager.Instance.Self.Bag.items[_loc3_.Place])
         {
            if(_equipCell.info && (_equipCell.info as InventoryItemInfo).Place == _loc3_.Place)
            {
               _equipCell.info = null;
            }
            else
            {
               refreshBagList();
            }
         }
         else
         {
            _loc2_ = WishBeadManager.instance.getCanWishBeadData();
            if(_loc2_.items.length != _equipBagInfo.items.length)
            {
               _equipBagInfo = _loc2_;
               _bagList.setData(_equipBagInfo);
            }
         }
         var _loc6_:InventoryItemInfo = _equipCell.itemInfo;
         if(_loc6_ && _loc6_.isGold)
         {
            _equipCell.info = null;
            _equipCell.info = _loc6_;
         }
      }
      
      private function propInfoChangeHandler(param1:BagEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:Dictionary = param1.changedSlots;
         var _loc7_:int = 0;
         var _loc6_:* = _loc4_;
         for each(var _loc5_ in _loc4_)
         {
            _loc3_ = _loc5_;
         }
         if(_loc3_ && !PlayerManager.Instance.Self.PropBag.items[_loc3_.Place])
         {
            if(_itemCell.info && (_itemCell.info as InventoryItemInfo).Place == _loc3_.Place)
            {
               _itemCell.info = null;
            }
            else
            {
               _proBagList.setData(WishBeadManager.instance.getWishBeadItemData());
            }
         }
         else
         {
            if(!_itemCell || !_itemCell.info)
            {
               return;
            }
            _loc2_ = _itemCell.info as InventoryItemInfo;
            if(!PlayerManager.Instance.Self.PropBag.items[_loc2_.Place])
            {
               _itemCell.info = null;
            }
            else
            {
               _itemCell.setCount(_loc2_.Count);
            }
         }
      }
      
      private function __showTip(param1:PkgEvent) : void
      {
         _tip.isDisplayerTip = true;
         var _loc2_:int = param1.pkg.readInt();
         switch(int(_loc2_))
         {
            case 0:
               _continuousBtn.selected = false;
               _tip.showSuccess(judgeAgain);
               break;
            case 1:
               _tip.showFail(judgeAgain);
               break;
            default:
            default:
            default:
               judgeDoBtnStatus(false);
               break;
            case 5:
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("wishBead.notCanWish"));
               judgeDoBtnStatus(false);
               break;
            case 6:
            default:
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("wishBead.equipIsGold"));
               judgeDoBtnStatus(false);
               break;
            case 8:
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("wishBead.remainTimeShort"));
               judgeDoBtnStatus(false);
         }
      }
      
      private function judgeAgain() : void
      {
         if(_isDispose)
         {
            return;
         }
         if(_continuousBtn.selected)
         {
            if((_itemCell.info as InventoryItemInfo).Count <= 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("wishBead.noBead"));
               return;
            }
            sendMess();
         }
         else
         {
            judgeDoBtnStatus(false);
         }
      }
      
      private function doHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(!_equipCell.info)
         {
            return;
         }
         if(!_itemCell.info)
         {
            return;
         }
         if((_itemCell.info as InventoryItemInfo).Count <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("wishBead.noBead"));
            return;
         }
         if(!(_equipCell.info as InventoryItemInfo).IsBinds)
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.bagII.BagIIView.BindsInfo"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
            _loc2_.moveEnable = false;
            _loc2_.addEventListener("response",__confirm,false,0,true);
         }
         else
         {
            sendMess();
         }
      }
      
      private function __confirm(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__confirm);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            sendMess();
         }
      }
      
      private function sendMess() : void
      {
         _doBtn.enable = false;
         var _loc1_:InventoryItemInfo = _equipCell.info as InventoryItemInfo;
         var _loc2_:InventoryItemInfo = _itemCell.info as InventoryItemInfo;
         SocketManager.Instance.out.sendWishBeadEquip(_loc1_.Place,_loc1_.BagType,_loc1_.TemplateID,_loc2_.Place,_loc2_.BagType,_loc2_.TemplateID);
      }
      
      private function itemEquipChangeHandler(param1:Event) : void
      {
         _continuousBtn.selected = false;
         judgeDoBtnStatus(true);
      }
      
      private function judgeDoBtnStatus(param1:Boolean) : void
      {
         if(_equipCell.info && _itemCell.info)
         {
            if(WishBeadManager.instance.getIsEquipMatchWishBead(_itemCell.info.TemplateID,_equipCell.info.CategoryID,param1))
            {
               _doBtn.enable = true;
            }
            else
            {
               _doBtn.enable = false;
            }
         }
         else
         {
            _doBtn.enable = false;
         }
      }
      
      protected function __cellDoubleClick(param1:CellEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:String = "";
         if(param1.target == _proBagList)
         {
            _loc2_ = "wishBead_item_move";
         }
         else
         {
            _loc2_ = "wishBead_equip_move";
         }
         var _loc3_:WishBeadEvent = new WishBeadEvent(_loc2_);
         var _loc4_:BagCell = param1.data as BagCell;
         _loc3_.info = _loc4_.info as InventoryItemInfo;
         _loc3_.moveType = 1;
         WishBeadManager.instance.dispatchEvent(_loc3_);
      }
      
      private function cellClickHandler(param1:CellEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BagCell = param1.data as BagCell;
         _loc2_.dragStart();
      }
      
      private function createAcceptDragSprite() : void
      {
         _leftDrapSprite = new WishBeadLeftDragSprite();
         _leftDrapSprite.mouseEnabled = false;
         _leftDrapSprite.mouseChildren = false;
         _leftDrapSprite.graphics.beginFill(0,0);
         _leftDrapSprite.graphics.drawRect(0,0,347,404);
         _leftDrapSprite.graphics.endFill();
         PositionUtils.setPos(_leftDrapSprite,"wishBeadMainView.leftDrapSpritePos");
         addChild(_leftDrapSprite);
         _rightDrapSprite = new WishBeadRightDragSprite();
         _rightDrapSprite.mouseEnabled = false;
         _rightDrapSprite.mouseChildren = false;
         _rightDrapSprite.graphics.beginFill(0,0);
         _rightDrapSprite.graphics.drawRect(0,0,374,407);
         _rightDrapSprite.graphics.endFill();
         PositionUtils.setPos(_rightDrapSprite,"wishBeadMainView.rightDrapSpritePos");
         addChild(_rightDrapSprite);
      }
      
      override public function set visible(param1:Boolean) : void
      {
         .super.visible = param1;
         if(param1)
         {
            if(!_isDispose)
            {
               refreshListData();
               PlayerManager.Instance.Self.PropBag.addEventListener("update",propInfoChangeHandler);
               PlayerManager.Instance.Self.Bag.addEventListener("update",bagInfoChangeHandler);
            }
         }
         else
         {
            clearCellInfo();
            PlayerManager.Instance.Self.PropBag.removeEventListener("update",propInfoChangeHandler);
            PlayerManager.Instance.Self.Bag.removeEventListener("update",bagInfoChangeHandler);
         }
      }
      
      public function clearCellInfo() : void
      {
         if(_equipCell)
         {
            _equipCell.clearInfo();
         }
         if(_itemCell)
         {
            _itemCell.clearInfo();
         }
      }
      
      public function refreshListData() : void
      {
         if(_bagList)
         {
            refreshBagList();
         }
         if(_proBagList)
         {
            _proBagList.setData(WishBeadManager.instance.getWishBeadItemData());
         }
      }
      
      private function removeEvent() : void
      {
         _bagList.removeEventListener("itemclick",cellClickHandler);
         _bagList.removeEventListener("doubleclick",__cellDoubleClick);
         _equipCell.removeEventListener("change",itemEquipChangeHandler);
         _proBagList.removeEventListener("itemclick",cellClickHandler);
         _proBagList.removeEventListener("doubleclick",__cellDoubleClick);
         _itemCell.removeEventListener("change",itemEquipChangeHandler);
         _doBtn.removeEventListener("click",doHandler);
         SocketManager.Instance.removeEventListener(PkgEvent.format(106),__showTip);
         PlayerManager.Instance.Self.PropBag.removeEventListener("update",propInfoChangeHandler);
         PlayerManager.Instance.Self.Bag.removeEventListener("update",bagInfoChangeHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeObject(_tip);
         _tip = null;
         _bg = null;
         _bagList = null;
         _proBagList = null;
         _leftDrapSprite = null;
         _rightDrapSprite = null;
         _itemCell = null;
         _equipCell = null;
         _continuousBtn = null;
         _doBtn = null;
         _helpBtn = null;
         _equipBagInfo = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _isDispose = true;
      }
   }
}
