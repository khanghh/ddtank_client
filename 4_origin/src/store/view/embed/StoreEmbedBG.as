package store.view.embed
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.bagStore.BagStore;
   import ddt.command.QuickBuyFrame;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.ShortcutBuyEvent;
   import ddt.events.StoreEmbedEvent;
   import ddt.manager.DragManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import road7th.data.DictionaryData;
   import store.IStoreViewBG;
   import store.StoneCell;
   import store.StoreCell;
   import store.StoreDragInArea;
   import store.data.StoreModel;
   import store.events.EmbedBackoutEvent;
   import store.events.EmbedEvent;
   import store.events.StoreIIEvent;
   
   public class StoreEmbedBG extends Sprite implements IStoreViewBG
   {
      
      public static const EMBED_MONEY:Number = 2000;
      
      public static const EMBED_BACKOUT_MONEY:Number = 500;
      
      public static const FIVE:int = 5;
      
      public static const SIX:int = 6;
      
      public static const NEED_GOLD:int = 2000;
       
      
      private var _items:Array;
      
      private var _area:StoreDragInArea;
      
      private var _stoneCells:Vector.<EmbedStoneCell>;
      
      private var _embedItemCell:EmbedItemCell;
      
      private var _quick:QuickBuyFrame;
      
      private var _embedBackoutDownItem:TextButton;
      
      private var _openFiveHoleBtn:MultipleButton;
      
      private var _openSixHoleBtn:MultipleButton;
      
      private var _embedStoneCell:EmbedStoneCell;
      
      private var _embedBackoutMouseIcon:ScaleFrameImage;
      
      private var _help:BaseButton;
      
      private var _embedBackoutBtn:EmbedBackoutButton;
      
      private var _bg:Image;
      
      private var _equipmentCellText:FilterFrameText;
      
      private var _currentHolePlace:int;
      
      private var _templateID:int;
      
      private var _pointArray:Vector.<Point>;
      
      private var _drill:InventoryItemInfo;
      
      private var _embedTxt:Bitmap;
      
      private var _hole5ExpBar:HoleExpBar;
      
      private var _hole6ExpBar:HoleExpBar;
      
      private var _stoneInfo:InventoryItemInfo;
      
      private var _openHoleNumber:int = 0;
      
      private var _drillPlace:int = 0;
      
      private var _itemPlace:int = 0;
      
      private var _drillID:int;
      
      private var _isEmbedBreak:Boolean = false;
      
      public function StoreEmbedBG()
      {
         super();
         init();
         initEvents();
      }
      
      public function holeLvUp(hole:int) : void
      {
         _stoneCells[hole].holeLvUp();
      }
      
      private function init() : void
      {
         var i:int = 0;
         var stoneCell:* = null;
         _embedTxt = ComponentFactory.Instance.creatBitmap("asset.ddtstore.embedTxt");
         PositionUtils.setPos(_embedTxt,"asset.ddtstore.embedTxtPos");
         addChild(_embedTxt);
         _bg = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreEmbedBG.EquipmentCellBg");
         addChild(_bg);
         _equipmentCellText = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreEmbedBG.EquipmentCellText");
         _equipmentCellText.text = LanguageMgr.GetTranslation("store.Strength.StrengthenEquipmentCellText");
         addChild(_equipmentCellText);
         _help = HelpFrameUtils.Instance.simpleHelpButton(this,"ddtstore.HelpButton",null,LanguageMgr.GetTranslation("tank.view.store.matteHelp.title"),"ddtstore.HelpFrame.EmbedText",404,484);
         _embedBackoutBtn = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedBackoutButton");
         _embedBackoutBtn.text = LanguageMgr.GetTranslation("store.Embed.BackoutText");
         addChild(_embedBackoutBtn);
         _embedBackoutDownItem = ComponentFactory.Instance.creatComponentByStylename("ddttore.StoreEmbedBG.EmbedBackoutDownBtn");
         _embedBackoutDownItem.text = LanguageMgr.GetTranslation("store.Embed.BackoutDownText");
         _openFiveHoleBtn = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreEmbedBG.EmbedOpenHoleFive");
         _openFiveHoleBtn.text = LanguageMgr.GetTranslation("store.Embed.OpenHoleText");
         _openSixHoleBtn = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreEmbedBG.EmbedOpenHoleSix");
         _openSixHoleBtn.text = LanguageMgr.GetTranslation("store.Embed.OpenHoleText");
         var _loc3_:Boolean = true;
         _openSixHoleBtn.transparentEnable = _loc3_;
         _openFiveHoleBtn.transparentEnable = _loc3_;
         _loc3_ = false;
         _openSixHoleBtn.visible = _loc3_;
         _openFiveHoleBtn.visible = _loc3_;
         addChild(_openFiveHoleBtn);
         addChild(_openSixHoleBtn);
         _hole5ExpBar = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.Hole5ExpBar");
         addChild(_hole5ExpBar);
         _hole6ExpBar = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.Hole6ExpBar");
         addChild(_hole6ExpBar);
         _items = [];
         _stoneCells = new Vector.<EmbedStoneCell>();
         getCellsPoint();
         _embedItemCell = new EmbedItemCell(0);
         _embedItemCell.x = _pointArray[0].x;
         _embedItemCell.y = _pointArray[0].y;
         addChild(_embedItemCell);
         _items.push(_embedItemCell);
         _area = new StoreDragInArea(_items);
         addChildAt(_area,0);
         for(i = 1; i < 7; )
         {
            stoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[i,-1]);
            stoneCell.x = _pointArray[i].x;
            stoneCell.y = _pointArray[i].y;
            addChild(stoneCell);
            stoneCell.mouseChildren = false;
            stoneCell.addEventListener("embed",__embed);
            stoneCell.addEventListener("embedBackout",__EmbedBackout);
            stoneCell.addEventListener("embedBackoutDownItemOver",__EmbedBackoutDownItemOver);
            stoneCell.addEventListener("embedBackoutDownItemOut",__EmbedBackoutDownItemOut);
            stoneCell.addEventListener("embedBackoutDownItemDown",__EmbedBackoutDownItemDown);
            _stoneCells.push(stoneCell);
            i++;
         }
         hide();
      }
      
      private function initEvents() : void
      {
         _embedItemCell.addEventListener("change",__itemInfoChange);
         _embedItemCell.addEventListener("itemChange",__itemChange);
         _embedBackoutBtn.addEventListener("click",__embedBackoutBtnClick);
         _openFiveHoleBtn.addEventListener("click",_openFiveHoleClick);
         _openSixHoleBtn.addEventListener("click",_openSixHoleClick);
      }
      
      private function __itemChange(evt:StoreEmbedEvent) : void
      {
         if(!_stoneCells[5 - 1].hasDrill())
         {
         }
         if(!_stoneCells[6 - 1].hasDrill())
         {
         }
      }
      
      private function getCellsPoint() : void
      {
         var i:int = 0;
         var point:* = null;
         _pointArray = new Vector.<Point>();
         for(i = 0; i < 7; )
         {
            point = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.Embedpoint" + i);
            _pointArray.push(point);
            i++;
         }
      }
      
      private function __embedBackoutBtnClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         evt.stopImmediatePropagation();
         _embedBackoutBtn.mouseEnabled = false;
         _embedBackoutBtn.isAction = true;
         _embedBackoutMouseIcon = ComponentFactory.Instance.creatComponentByStylename("ddttore.StoreEmbedBG.embedBackoutMouseIcon");
         _embedBackoutMouseIcon.setFrame(1);
         DragManager.startDrag(_embedBackoutBtn,_embedBackoutBtn,_embedBackoutMouseIcon,evt.stageX,evt.stageY,"move",false,true);
      }
      
      private function __itemInfoChange(evt:Event) : void
      {
         var i:int = 0;
         for(i = 0; i < _stoneCells.length; )
         {
            _stoneCells[i].close();
            var _loc3_:Boolean = false;
            _openSixHoleBtn.visible = _loc3_;
            _openFiveHoleBtn.visible = _loc3_;
            i++;
         }
         if(_embedItemCell.info != null)
         {
            initHoleType();
            updateHoles();
            dispatchEvent(new StoreIIEvent("embedInfoChange"));
         }
      }
      
      private function initHoleType() : void
      {
         var j:int = 0;
         var info:InventoryItemInfo = _embedItemCell.itemInfo;
         var arr:Array = info.Hole.split("|");
         for(j = 0; j < _stoneCells.length; )
         {
            _stoneCells[j].StoneType = arr[j].split(",")[1];
            j++;
         }
      }
      
      private function updateHoles() : void
      {
         var i:int = 0;
         var info:InventoryItemInfo = _embedItemCell.itemInfo;
         var tmpArr:Array = info.Hole.split("|");
         for(i = 0; i < tmpArr.length; )
         {
            if((info.StrengthenLevel >= int(String(tmpArr[i]).split(",")[0]) || info["Hole" + (i + 1)] >= 0) && i < 4)
            {
               _stoneCells[i].open();
               _stoneCells[i].tipDerial = true;
               if(info["Hole" + (i + 1)] != 0)
               {
                  _stoneCells[i].info = ItemManager.Instance.getTemplateById(info["Hole" + (i + 1)]);
                  _stoneCells[i].tipDerial = false;
               }
            }
            else
            {
               _stoneCells[i].close();
               _stoneCells[i].tipDerial = false;
            }
            i++;
         }
         updateOpenFiveSixHole();
      }
      
      private function updateOpenFiveSixHole() : void
      {
         var info:InventoryItemInfo = _embedItemCell.itemInfo;
         var arr:Array = info.Hole.split("|");
         if(info.Hole5Level > 0 || info.Hole5 > 0)
         {
            _stoneCells[5 - 1].open();
            _stoneCells[5 - 1].info = ItemManager.Instance.getTemplateById(info.Hole5);
         }
         if(info.Hole6Level > 0 || info.Hole6 > 0)
         {
            _stoneCells[6 - 1].open();
            _stoneCells[6 - 1].info = ItemManager.Instance.getTemplateById(info.Hole6);
         }
         var _loc3_:* = info.Hole5Level < StoreModel.getHoleMaxOpLv() && _embedItemCell.info != null;
         _openFiveHoleBtn.visible = _loc3_;
         _hole5ExpBar.visible = _loc3_;
         _loc3_ = info.Hole6Level < StoreModel.getHoleMaxOpLv() && _embedItemCell.info != null;
         _openSixHoleBtn.visible = _loc3_;
         _hole6ExpBar.visible = _loc3_;
      }
      
      private function confirmIsBindWhenOpenHole() : void
      {
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.bagII.BagIIView.BindsInfo"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
         alert.addEventListener("response",__confireIsBindWhenOpenHoleResponse);
      }
      
      private function __confireIsBindWhenOpenHoleResponse(event:FrameEvent) : void
      {
         var alert:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",__confireIsBindWhenOpenHoleResponse);
         alert.dispose();
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               break;
            case 2:
            case 3:
            case 4:
               sendOpenHole(_itemPlace,_openHoleNumber,_drill.TemplateID);
         }
      }
      
      private function getDrillByLevel(level:int) : InventoryItemInfo
      {
         var items:DictionaryData = PlayerManager.Instance.Self.PropBag.items;
         var _loc5_:int = 0;
         var _loc4_:* = items;
         for each(var item in items)
         {
            if(EquipType.isDrill(item) && item.Level == level + 1)
            {
               return item;
            }
         }
         return null;
      }
      
      private function _openFiveHoleClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var item:InventoryItemInfo = InventoryItemInfo(_embedItemCell.info);
         if(item.Hole5Level >= StoreModel.getHoleMaxOpLv())
         {
            return;
         }
         _drill = getDrillByLevel(InventoryItemInfo(PlayerManager.Instance.Self.StoreBag.items[0]).Hole5Level);
         if(_drill == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.Embed.OpenHole.NoDrill",InventoryItemInfo(PlayerManager.Instance.Self.StoreBag.items[0]).Hole5Level + 1));
         }
         else
         {
            _openHoleNumber = 5;
            if(!item.IsBinds && _drill.IsBinds)
            {
               confirmIsBindWhenOpenHole();
            }
            else
            {
               sendOpenHole(_itemPlace,_openHoleNumber,_drill.TemplateID);
            }
         }
      }
      
      private function _openSixHoleClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var item:InventoryItemInfo = InventoryItemInfo(_embedItemCell.info);
         if(item.Hole6Level >= StoreModel.getHoleMaxOpLv())
         {
            return;
         }
         _drill = getDrillByLevel(InventoryItemInfo(PlayerManager.Instance.Self.StoreBag.items[0]).Hole6Level);
         if(_drill == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.Embed.OpenHole.NoDrill",InventoryItemInfo(PlayerManager.Instance.Self.StoreBag.items[0]).Hole6Level + 1));
         }
         else
         {
            _openHoleNumber = 6;
            if(!item.IsBinds && _drill.IsBinds)
            {
               confirmIsBindWhenOpenHole();
            }
            else
            {
               sendOpenHole(_itemPlace,_openHoleNumber,_drill.TemplateID);
            }
         }
      }
      
      public function openHoleSucces(place:int, stoneBag:int, count:int) : void
      {
         SocketManager.Instance.out.sendMoveGoods(12,place,stoneBag,-1,count,true);
      }
      
      private function _showAlert() : void
      {
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("store.StoreIIComposeBG.use"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
         alert.addEventListener("response",_responseVI);
      }
      
      private function sendOpenHole(itemPlace:int, number:int, drill:int) : void
      {
         SocketManager.Instance.out.sendItemOpenFiveSixHole(itemPlace,number,drill);
         _drill = null;
      }
      
      private function getOpenHoleStone() : InventoryItemInfo
      {
         var skyInfo:InventoryItemInfo = PlayerManager.Instance.Self.PropBag.findFistItemByTemplateId(11036);
         var gndInfo:InventoryItemInfo = PlayerManager.Instance.Self.PropBag.findFistItemByTemplateId(11035);
         return skyInfo != null?skyInfo:gndInfo;
      }
      
      private function _responseVI(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (evt.currentTarget as BaseAlerFrame).removeEventListener("response",_responseVI);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
         }
         ObjectUtils.disposeObject(evt.currentTarget);
      }
      
      public function dragDrop(source:BagCell) : void
      {
         var ds:* = null;
         var i:int = 0;
         if(source == null)
         {
            return;
         }
         var info:InventoryItemInfo = source.info as InventoryItemInfo;
         var _loc6_:int = 0;
         var _loc5_:* = _items;
         for each(ds in _items)
         {
            if(ds.info == info)
            {
               ds.info = null;
               source.locked = false;
               return;
            }
         }
         var _loc8_:int = 0;
         var _loc7_:* = _items;
         for each(ds in _items)
         {
            if(ds)
            {
               if(ds is StoneCell)
               {
                  if(ds.info == null)
                  {
                     if((ds as StoneCell).types.indexOf(info.Property1) > -1 && info.CategoryID == 11)
                     {
                        SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,12,ds.index,1);
                        return;
                     }
                  }
               }
               else if(ds is EmbedItemCell)
               {
                  for(i = 1; i < 7; )
                  {
                     if(info.CategoryID == 1 || info.CategoryID == 5 || info.CategoryID == 7)
                     {
                        __itemChange(null);
                        SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,12,ds.index,1);
                        return;
                     }
                     i++;
                  }
                  continue;
               }
               continue;
            }
         }
      }
      
      private function __embed(evt:EmbedEvent) : void
      {
         var alert:* = null;
         evt.stopImmediatePropagation();
         _currentHolePlace = evt.CellID;
         if(!_embedItemCell.itemInfo.IsBinds && _stoneCells[_currentHolePlace - 1].itemInfo.IsBinds)
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("store.StoreIIComposeBG.use"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
            alert.addEventListener("response",_responseIII);
         }
         else
         {
            __embed2();
         }
      }
      
      private function _responseIII(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var frame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",_responseIII);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            sendEmbed();
         }
         else
         {
            cancelEmbed1();
         }
         ObjectUtils.disposeObject(evt.target);
      }
      
      private function cancelEmbed1() : void
      {
         updateHoles();
      }
      
      private function __embed2() : void
      {
         if(_embedItemCell.itemInfo["Hole" + _currentHolePlace] != 0)
         {
         }
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("store.Embed.EmbedAlertFrame.EmbedTipText"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,1);
         alert.addEventListener("response",_responseII);
      }
      
      private function _responseII(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var frame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",_responseII);
         ObjectUtils.disposeObject(evt.currentTarget);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            sendEmbed();
         }
         else
         {
            updateHoles();
         }
      }
      
      private function __EmbedBackout(evt:EmbedBackoutEvent) : void
      {
         _currentHolePlace = evt.CellID;
         _templateID = evt.TemplateID;
         __EmbedBackoutFrame(evt);
      }
      
      private function __EmbedBackoutFrame(evt:Event) : void
      {
         SoundManager.instance.play("008");
         evt.stopImmediatePropagation();
         if(_embedStoneCell && evt.type == "click")
         {
            _embedStoneCell.closeTip(evt as MouseEvent);
         }
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("store.Embed.EmbedAlertFrame.TipText",500),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,1);
         alert.addEventListener("response",_response);
         if(_embedBackoutMouseIcon)
         {
            ObjectUtils.disposeObject(_embedBackoutMouseIcon);
            _embedBackoutMouseIcon = null;
         }
      }
      
      private function _response(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var frame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",_response);
         ObjectUtils.disposeObject(evt.target);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            sendEmbedBackout();
         }
         else
         {
            updateHoles();
            stage.focus = this;
         }
      }
      
      private function __EmbedBackoutDownItemOver(evt:EmbedBackoutEvent) : void
      {
         evt.stopImmediatePropagation();
         _currentHolePlace = evt.CellID;
         _templateID = evt.TemplateID;
         if(!_embedBackoutBtn.isAction && !contains(_embedBackoutDownItem))
         {
            _embedStoneCell = evt.target as EmbedStoneCell;
            _embedBackoutDownItem.x = evt.target.x;
            _embedBackoutDownItem.y = evt.target.y + evt.target.height + 8;
            addChild(_embedBackoutDownItem);
            _embedBackoutDownItem.addEventListener("click",__EmbedBackoutFrame);
            _embedBackoutDownItem.addEventListener("mouseOver",__EmbedShowTip);
            _embedBackoutDownItem.addEventListener("mouseOut",__EmbedBackoutDownItemOutGo);
         }
      }
      
      private function __EmbedShowTip(evt:MouseEvent) : void
      {
         if(_embedStoneCell)
         {
            _embedStoneCell.showTip(evt);
         }
      }
      
      private function __EmbedBackoutDownItemDown(evt:EmbedBackoutEvent) : void
      {
         if(_embedBackoutMouseIcon)
         {
            _embedBackoutMouseIcon.setFrame(2);
         }
      }
      
      private function __EmbedBackoutDownItemOut(evt:EmbedBackoutEvent) : void
      {
         if(_embedBackoutDownItem && (mouseY >= _embedBackoutDownItem.y && mouseY <= _embedBackoutDownItem.y + _embedBackoutDownItem.height && (mouseX >= _embedBackoutDownItem.x && mouseX <= _embedBackoutDownItem.x + _embedBackoutDownItem.width)))
         {
            return;
         }
         __EmbedBackoutDownItemOutGo(evt);
      }
      
      private function __EmbedBackoutDownItemOutGo(evt:Event) : void
      {
         if(_embedBackoutBtn != null && !_embedBackoutBtn.isAction && _embedBackoutDownItem && contains(_embedBackoutDownItem))
         {
            if(_embedStoneCell && evt != null && evt.type == "mouseOut")
            {
               _embedStoneCell.closeTip(evt as MouseEvent);
            }
            _embedBackoutDownItem.removeEventListener("mouseOver",__EmbedShowTip);
            _embedBackoutDownItem.removeEventListener("click",__EmbedBackoutFrame);
            _embedBackoutDownItem.removeEventListener("mouseOut",__EmbedBackoutDownItemOutGo);
            removeChild(_embedBackoutDownItem);
         }
      }
      
      public function refreshData(items:Dictionary) : void
      {
         _stoneCells[5 - 1].close();
         _stoneCells[6 - 1].close();
         _embedItemCell.info = PlayerManager.Instance.Self.StoreBag.items[0];
         if(_embedItemCell.info == null)
         {
            var _loc2_:Boolean = false;
            _hole6ExpBar.visible = _loc2_;
            _hole5ExpBar.visible = _loc2_;
         }
      }
      
      public function sendEmbed() : void
      {
         var alert:* = null;
         if(PlayerManager.Instance.Self.Gold < 2000)
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.view.GoldInadequate"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            alert.moveEnable = false;
            alert.addEventListener("response",_responseV);
            return;
         }
      }
      
      private function _responseV(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (evt.currentTarget as BaseAlerFrame).removeEventListener("response",_responseV);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            okFastPurchaseGold();
         }
         else
         {
            cancelFastPurchaseGold();
         }
         ObjectUtils.disposeObject(evt.currentTarget);
      }
      
      private function okFastPurchaseGold() : void
      {
         _quick = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
         _quick.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
         _quick.itemID = 11233;
         _quick.addEventListener("shortcutBuy",__shortCutBuyHandler);
         _quick.addEventListener("shortcutBuyMoneyOk",__shortCutBuyMoneyOkHandler);
         _quick.addEventListener("shortcutBuyMoneyCancel",__shortCutBuyMoneyCancelHandler);
         _quick.addEventListener("removedFromStage",removeFromStageHandler);
         LayerManager.Instance.addToLayer(_quick,2,true,1);
      }
      
      private function cancelQuickBuy() : void
      {
         updateHoles();
      }
      
      private function removeFromStageHandler(event:Event) : void
      {
         BagStore.instance.reduceTipPanelNumber();
      }
      
      private function __shortCutBuyHandler(evt:ShortcutBuyEvent) : void
      {
         evt.stopImmediatePropagation();
         __embed2();
      }
      
      private function __shortCutBuyMoneyOkHandler(evt:ShortcutBuyEvent) : void
      {
         evt.stopImmediatePropagation();
         updateHoles();
      }
      
      private function __shortCutBuyMoneyCancelHandler(evt:ShortcutBuyEvent) : void
      {
         evt.stopImmediatePropagation();
         updateHoles();
      }
      
      private function cancelFastPurchaseGold() : void
      {
         updateHoles();
      }
      
      public function sendEmbedBackout() : void
      {
         var alert:* = null;
         if(PlayerManager.Instance.Self.Money < 500)
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.comon.lack"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
            alert.addEventListener("response",_responseIV);
            return;
         }
         __EmbedBackoutDownItemOutGo(null);
         SocketManager.Instance.out.sendItemEmbedBackout(_currentHolePlace,_templateID);
      }
      
      private function _responseIV(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (evt.currentTarget as BaseAlerFrame).removeEventListener("response",_responseIV);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
         cancelEmbed1();
         ObjectUtils.disposeObject(evt.currentTarget);
      }
      
      private function cancelEmbedBackout() : void
      {
      }
      
      private function removeEvents() : void
      {
         var i:int = 0;
         for(i = 1; i < 7; )
         {
            _stoneCells[i - 1].removeEventListener("embed",__embed);
            _stoneCells[i - 1].removeEventListener("embedBackout",__EmbedBackout);
            _stoneCells[i - 1].removeEventListener("embedBackoutDownItemOver",__EmbedBackoutDownItemOver);
            _stoneCells[i - 1].removeEventListener("embedBackoutDownItemOut",__EmbedBackoutDownItemOut);
            _stoneCells[i - 1].removeEventListener("embedBackoutDownItemDown",__EmbedBackoutDownItemDown);
            i++;
         }
         _embedItemCell.removeEventListener("change",__itemInfoChange);
         _embedItemCell.removeEventListener("itemChange",__itemChange);
         _embedBackoutBtn.removeEventListener("click",__embedBackoutBtnClick);
         _openFiveHoleBtn.removeEventListener("click",_openFiveHoleClick);
         _openSixHoleBtn.removeEventListener("click",_openSixHoleClick);
      }
      
      public function updateData() : void
      {
      }
      
      public function get area() : Array
      {
         return _items;
      }
      
      public function startShine() : void
      {
         _embedItemCell.startShine();
      }
      
      public function stoneStartShine(type:int, target:InventoryItemInfo) : void
      {
         var i:int = 0;
         var holeState:int = 0;
         var str:* = null;
         var tmpArr:* = null;
         if(PlayerManager.Instance.Self.StoreBag.items[0] == null)
         {
            return;
         }
         var info:InventoryItemInfo = _embedItemCell.itemInfo;
         var strHoleList:Array = info.Hole.split("|");
         for(i = 0; i < _stoneCells.length; )
         {
            holeState = info["Hole" + (i + 1)];
            if(i < 4)
            {
               str = String(strHoleList[i]);
               tmpArr = str.split(",");
               if(info["Hole" + (i + 1)] >= 0 && (_stoneCells[i] as EmbedStoneCell).StoneType == type)
               {
                  _stoneCells[i].startShine();
               }
            }
            else if((_stoneCells[i] as EmbedStoneCell).StoneType == type && info["Hole" + (i + 1) + "Level"] > 0)
            {
               _stoneCells[i].startShine();
            }
            i++;
         }
      }
      
      public function stopShine() : void
      {
         _embedItemCell.stopShine();
         var _loc3_:int = 0;
         var _loc2_:* = _stoneCells;
         for each(var item in _stoneCells)
         {
            item.stopShine();
         }
      }
      
      public function show() : void
      {
         this.visible = true;
         refreshData(null);
      }
      
      public function hide() : void
      {
         var i:int = 0;
         this.visible = false;
         for(i = 1; i < 7; )
         {
            _stoneCells[i - 1].close();
            i++;
         }
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         removeEvents();
         _items = null;
         _embedStoneCell = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_equipmentCellText)
         {
            ObjectUtils.disposeObject(_equipmentCellText);
         }
         _equipmentCellText = null;
         if(_area)
         {
            ObjectUtils.disposeObject(_area);
         }
         _area = null;
         if(_embedItemCell)
         {
            ObjectUtils.disposeObject(_embedItemCell);
         }
         _embedItemCell = null;
         if(_embedBackoutBtn)
         {
            ObjectUtils.disposeObject(_embedBackoutBtn);
         }
         _embedBackoutBtn = null;
         if(_help)
         {
            ObjectUtils.disposeObject(_help);
         }
         _help = null;
         if(_openFiveHoleBtn)
         {
            ObjectUtils.disposeObject(_openFiveHoleBtn);
         }
         _openFiveHoleBtn = null;
         if(_openSixHoleBtn)
         {
            ObjectUtils.disposeObject(_openSixHoleBtn);
         }
         _openSixHoleBtn = null;
         if(_hole5ExpBar)
         {
            ObjectUtils.disposeObject(_hole5ExpBar);
         }
         _hole5ExpBar = null;
         if(_hole6ExpBar)
         {
            ObjectUtils.disposeObject(_hole6ExpBar);
         }
         _hole6ExpBar = null;
         if(_embedBackoutDownItem)
         {
            _embedBackoutDownItem.removeEventListener("mouseOver",__EmbedShowTip);
            _embedBackoutDownItem.removeEventListener("click",__EmbedBackoutFrame);
            _embedBackoutDownItem.removeEventListener("mouseOut",__EmbedBackoutDownItemOutGo);
            ObjectUtils.disposeObject(_embedBackoutDownItem);
         }
         _embedBackoutDownItem = null;
         if(_embedBackoutMouseIcon)
         {
            ObjectUtils.disposeObject(_embedBackoutMouseIcon);
         }
         _embedBackoutMouseIcon = null;
         for(i = 1; i < 7; )
         {
            ObjectUtils.disposeObject(_stoneCells[i - 1]);
            _stoneCells[i - 1] = null;
            i++;
         }
         _stoneCells = null;
         _pointArray = null;
         if(_quick)
         {
            _quick.removeEventListener("shortcutBuy",__shortCutBuyHandler);
            _quick.removeEventListener("shortcutBuyMoneyOk",__shortCutBuyMoneyOkHandler);
            _quick.removeEventListener("shortcutBuyMoneyCancel",__shortCutBuyMoneyCancelHandler);
            _quick.removeEventListener("removedFromStage",removeFromStageHandler);
            if(_quick.parent)
            {
               _quick.parent.removeChild(_quick);
            }
         }
         _quick = null;
         if(_embedTxt)
         {
            ObjectUtils.disposeObject(_embedTxt);
         }
         _embedTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
