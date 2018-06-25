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
         var tipTxt:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("wishBeadMainView.tipTxt");
         tipTxt.text = LanguageMgr.GetTranslation("wishBeadMainView.tipTxt");
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"wishBead.NodeBtn",null,LanguageMgr.GetTranslation("wishBead.wishBeadHelp.say"),"asset.awardSystem.wishBeadHelp",404,524);
         addChild(_bg);
         addChild(_bagList);
         addChild(_proBagList);
         addChild(_equipCell);
         addChild(_itemCell);
         addChild(tipTxt);
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
      
      private function bagInfoChangeHandler(event:BagEvent) : void
      {
         var changeItemInfo:* = null;
         var tmp2:* = null;
         var changedSlots:Dictionary = event.changedSlots;
         var _loc8_:int = 0;
         var _loc7_:* = changedSlots;
         for each(var tmp in changedSlots)
         {
            changeItemInfo = tmp;
         }
         if(changeItemInfo && !PlayerManager.Instance.Self.Bag.items[changeItemInfo.Place])
         {
            if(_equipCell.info && (_equipCell.info as InventoryItemInfo).Place == changeItemInfo.Place)
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
            tmp2 = WishBeadManager.instance.getCanWishBeadData();
            if(tmp2.items.length != _equipBagInfo.items.length)
            {
               _equipBagInfo = tmp2;
               _bagList.setData(_equipBagInfo);
            }
         }
         var tmpInfo:InventoryItemInfo = _equipCell.itemInfo;
         if(tmpInfo && tmpInfo.isGold)
         {
            _equipCell.info = null;
            _equipCell.info = tmpInfo;
         }
      }
      
      private function propInfoChangeHandler(event:BagEvent) : void
      {
         var changeItemInfo:* = null;
         var tmpItemInfo:* = null;
         var changedSlots:Dictionary = event.changedSlots;
         var _loc7_:int = 0;
         var _loc6_:* = changedSlots;
         for each(var tmp in changedSlots)
         {
            changeItemInfo = tmp;
         }
         if(changeItemInfo && !PlayerManager.Instance.Self.PropBag.items[changeItemInfo.Place])
         {
            if(_itemCell.info && (_itemCell.info as InventoryItemInfo).Place == changeItemInfo.Place)
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
            tmpItemInfo = _itemCell.info as InventoryItemInfo;
            if(!PlayerManager.Instance.Self.PropBag.items[tmpItemInfo.Place])
            {
               _itemCell.info = null;
            }
            else
            {
               _itemCell.setCount(tmpItemInfo.Count);
            }
         }
      }
      
      private function __showTip(evt:PkgEvent) : void
      {
         _tip.isDisplayerTip = true;
         var result:int = evt.pkg.readInt();
         switch(int(result))
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
      
      private function doHandler(event:MouseEvent) : void
      {
         var confirmFrame:* = null;
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
            confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.bagII.BagIIView.BindsInfo"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
            confirmFrame.moveEnable = false;
            confirmFrame.addEventListener("response",__confirm,false,0,true);
         }
         else
         {
            sendMess();
         }
      }
      
      private function __confirm(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",__confirm);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            sendMess();
         }
      }
      
      private function sendMess() : void
      {
         _doBtn.enable = false;
         var equipInfo:InventoryItemInfo = _equipCell.info as InventoryItemInfo;
         var itemInfo:InventoryItemInfo = _itemCell.info as InventoryItemInfo;
         SocketManager.Instance.out.sendWishBeadEquip(equipInfo.Place,equipInfo.BagType,equipInfo.TemplateID,itemInfo.Place,itemInfo.BagType,itemInfo.TemplateID);
      }
      
      private function itemEquipChangeHandler(event:Event) : void
      {
         _continuousBtn.selected = false;
         judgeDoBtnStatus(true);
      }
      
      private function judgeDoBtnStatus(isShowTip:Boolean) : void
      {
         if(_equipCell.info && _itemCell.info)
         {
            if(WishBeadManager.instance.getIsEquipMatchWishBead(_itemCell.info.TemplateID,_equipCell.info.CategoryID,isShowTip))
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
      
      protected function __cellDoubleClick(evt:CellEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var tmpStr:String = "";
         if(evt.target == _proBagList)
         {
            tmpStr = "wishBead_item_move";
         }
         else
         {
            tmpStr = "wishBead_equip_move";
         }
         var event:WishBeadEvent = new WishBeadEvent(tmpStr);
         var cell:BagCell = evt.data as BagCell;
         event.info = cell.info as InventoryItemInfo;
         event.moveType = 1;
         WishBeadManager.instance.dispatchEvent(event);
      }
      
      private function cellClickHandler(event:CellEvent) : void
      {
         SoundManager.instance.play("008");
         var cell:BagCell = event.data as BagCell;
         cell.dragStart();
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
      
      override public function set visible(value:Boolean) : void
      {
         .super.visible = value;
         if(value)
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
