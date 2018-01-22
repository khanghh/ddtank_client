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
      
      public function holeLvUp(param1:int) : void
      {
         _stoneCells[param1].holeLvUp();
      }
      
      private function init() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
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
         _loc2_ = 1;
         while(_loc2_ < 7)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[_loc2_,-1]);
            _loc1_.x = _pointArray[_loc2_].x;
            _loc1_.y = _pointArray[_loc2_].y;
            addChild(_loc1_);
            _loc1_.mouseChildren = false;
            _loc1_.addEventListener("embed",__embed);
            _loc1_.addEventListener("embedBackout",__EmbedBackout);
            _loc1_.addEventListener("embedBackoutDownItemOver",__EmbedBackoutDownItemOver);
            _loc1_.addEventListener("embedBackoutDownItemOut",__EmbedBackoutDownItemOut);
            _loc1_.addEventListener("embedBackoutDownItemDown",__EmbedBackoutDownItemDown);
            _stoneCells.push(_loc1_);
            _loc2_++;
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
      
      private function __itemChange(param1:StoreEmbedEvent) : void
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
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _pointArray = new Vector.<Point>();
         _loc2_ = 0;
         while(_loc2_ < 7)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.Embedpoint" + _loc2_);
            _pointArray.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function __embedBackoutBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         param1.stopImmediatePropagation();
         _embedBackoutBtn.mouseEnabled = false;
         _embedBackoutBtn.isAction = true;
         _embedBackoutMouseIcon = ComponentFactory.Instance.creatComponentByStylename("ddttore.StoreEmbedBG.embedBackoutMouseIcon");
         _embedBackoutMouseIcon.setFrame(1);
         DragManager.startDrag(_embedBackoutBtn,_embedBackoutBtn,_embedBackoutMouseIcon,param1.stageX,param1.stageY,"move",false,true);
      }
      
      private function __itemInfoChange(param1:Event) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _stoneCells.length)
         {
            _stoneCells[_loc2_].close();
            var _loc3_:Boolean = false;
            _openSixHoleBtn.visible = _loc3_;
            _openFiveHoleBtn.visible = _loc3_;
            _loc2_++;
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
         var _loc2_:int = 0;
         var _loc3_:InventoryItemInfo = _embedItemCell.itemInfo;
         var _loc1_:Array = _loc3_.Hole.split("|");
         _loc2_ = 0;
         while(_loc2_ < _stoneCells.length)
         {
            _stoneCells[_loc2_].StoneType = _loc1_[_loc2_].split(",")[1];
            _loc2_++;
         }
      }
      
      private function updateHoles() : void
      {
         var _loc2_:int = 0;
         var _loc3_:InventoryItemInfo = _embedItemCell.itemInfo;
         var _loc1_:Array = _loc3_.Hole.split("|");
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            if((_loc3_.StrengthenLevel >= int(String(_loc1_[_loc2_]).split(",")[0]) || _loc3_["Hole" + (_loc2_ + 1)] >= 0) && _loc2_ < 4)
            {
               _stoneCells[_loc2_].open();
               _stoneCells[_loc2_].tipDerial = true;
               if(_loc3_["Hole" + (_loc2_ + 1)] != 0)
               {
                  _stoneCells[_loc2_].info = ItemManager.Instance.getTemplateById(_loc3_["Hole" + (_loc2_ + 1)]);
                  _stoneCells[_loc2_].tipDerial = false;
               }
            }
            else
            {
               _stoneCells[_loc2_].close();
               _stoneCells[_loc2_].tipDerial = false;
            }
            _loc2_++;
         }
         updateOpenFiveSixHole();
      }
      
      private function updateOpenFiveSixHole() : void
      {
         var _loc2_:InventoryItemInfo = _embedItemCell.itemInfo;
         var _loc1_:Array = _loc2_.Hole.split("|");
         if(_loc2_.Hole5Level > 0 || _loc2_.Hole5 > 0)
         {
            _stoneCells[5 - 1].open();
            _stoneCells[5 - 1].info = ItemManager.Instance.getTemplateById(_loc2_.Hole5);
         }
         if(_loc2_.Hole6Level > 0 || _loc2_.Hole6 > 0)
         {
            _stoneCells[6 - 1].open();
            _stoneCells[6 - 1].info = ItemManager.Instance.getTemplateById(_loc2_.Hole6);
         }
         var _loc3_:* = _loc2_.Hole5Level < StoreModel.getHoleMaxOpLv() && _embedItemCell.info != null;
         _openFiveHoleBtn.visible = _loc3_;
         _hole5ExpBar.visible = _loc3_;
         _loc3_ = _loc2_.Hole6Level < StoreModel.getHoleMaxOpLv() && _embedItemCell.info != null;
         _openSixHoleBtn.visible = _loc3_;
         _hole6ExpBar.visible = _loc3_;
      }
      
      private function confirmIsBindWhenOpenHole() : void
      {
         var _loc1_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.bagII.BagIIView.BindsInfo"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
         _loc1_.addEventListener("response",__confireIsBindWhenOpenHoleResponse);
      }
      
      private function __confireIsBindWhenOpenHoleResponse(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__confireIsBindWhenOpenHoleResponse);
         _loc2_.dispose();
         switch(int(param1.responseCode))
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
      
      private function getDrillByLevel(param1:int) : InventoryItemInfo
      {
         var _loc2_:DictionaryData = PlayerManager.Instance.Self.PropBag.items;
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for each(var _loc3_ in _loc2_)
         {
            if(EquipType.isDrill(_loc3_) && _loc3_.Level == param1 + 1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      private function _openFiveHoleClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:InventoryItemInfo = InventoryItemInfo(_embedItemCell.info);
         if(_loc2_.Hole5Level >= StoreModel.getHoleMaxOpLv())
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
            if(!_loc2_.IsBinds && _drill.IsBinds)
            {
               confirmIsBindWhenOpenHole();
            }
            else
            {
               sendOpenHole(_itemPlace,_openHoleNumber,_drill.TemplateID);
            }
         }
      }
      
      private function _openSixHoleClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:InventoryItemInfo = InventoryItemInfo(_embedItemCell.info);
         if(_loc2_.Hole6Level >= StoreModel.getHoleMaxOpLv())
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
            if(!_loc2_.IsBinds && _drill.IsBinds)
            {
               confirmIsBindWhenOpenHole();
            }
            else
            {
               sendOpenHole(_itemPlace,_openHoleNumber,_drill.TemplateID);
            }
         }
      }
      
      public function openHoleSucces(param1:int, param2:int, param3:int) : void
      {
         SocketManager.Instance.out.sendMoveGoods(12,param1,param2,-1,param3,true);
      }
      
      private function _showAlert() : void
      {
         var _loc1_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("store.StoreIIComposeBG.use"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
         _loc1_.addEventListener("response",_responseVI);
      }
      
      private function sendOpenHole(param1:int, param2:int, param3:int) : void
      {
         SocketManager.Instance.out.sendItemOpenFiveSixHole(param1,param2,param3);
         _drill = null;
      }
      
      private function getOpenHoleStone() : InventoryItemInfo
      {
         var _loc1_:InventoryItemInfo = PlayerManager.Instance.Self.PropBag.findFistItemByTemplateId(11036);
         var _loc2_:InventoryItemInfo = PlayerManager.Instance.Self.PropBag.findFistItemByTemplateId(11035);
         return _loc1_ != null?_loc1_:_loc2_;
      }
      
      private function _responseVI(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_responseVI);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      public function dragDrop(param1:BagCell) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         if(param1 == null)
         {
            return;
         }
         var _loc4_:InventoryItemInfo = param1.info as InventoryItemInfo;
         var _loc6_:int = 0;
         var _loc5_:* = _items;
         for each(_loc2_ in _items)
         {
            if(_loc2_.info == _loc4_)
            {
               _loc2_.info = null;
               param1.locked = false;
               return;
            }
         }
         var _loc8_:int = 0;
         var _loc7_:* = _items;
         for each(_loc2_ in _items)
         {
            if(_loc2_)
            {
               if(_loc2_ is StoneCell)
               {
                  if(_loc2_.info == null)
                  {
                     if((_loc2_ as StoneCell).types.indexOf(_loc4_.Property1) > -1 && _loc4_.CategoryID == 11)
                     {
                        SocketManager.Instance.out.sendMoveGoods(_loc4_.BagType,_loc4_.Place,12,_loc2_.index,1);
                        return;
                     }
                  }
               }
               else if(_loc2_ is EmbedItemCell)
               {
                  _loc3_ = 1;
                  while(_loc3_ < 7)
                  {
                     if(_loc4_.CategoryID == 1 || _loc4_.CategoryID == 5 || _loc4_.CategoryID == 7)
                     {
                        __itemChange(null);
                        SocketManager.Instance.out.sendMoveGoods(_loc4_.BagType,_loc4_.Place,12,_loc2_.index,1);
                        return;
                     }
                     _loc3_++;
                  }
                  continue;
               }
               continue;
            }
         }
      }
      
      private function __embed(param1:EmbedEvent) : void
      {
         var _loc2_:* = null;
         param1.stopImmediatePropagation();
         _currentHolePlace = param1.CellID;
         if(!_embedItemCell.itemInfo.IsBinds && _stoneCells[_currentHolePlace - 1].itemInfo.IsBinds)
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("store.StoreIIComposeBG.use"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
            _loc2_.addEventListener("response",_responseIII);
         }
         else
         {
            __embed2();
         }
      }
      
      private function _responseIII(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",_responseIII);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            sendEmbed();
         }
         else
         {
            cancelEmbed1();
         }
         ObjectUtils.disposeObject(param1.target);
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
         var _loc1_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("store.Embed.EmbedAlertFrame.EmbedTipText"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,1);
         _loc1_.addEventListener("response",_responseII);
      }
      
      private function _responseII(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",_responseII);
         ObjectUtils.disposeObject(param1.currentTarget);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            sendEmbed();
         }
         else
         {
            updateHoles();
         }
      }
      
      private function __EmbedBackout(param1:EmbedBackoutEvent) : void
      {
         _currentHolePlace = param1.CellID;
         _templateID = param1.TemplateID;
         __EmbedBackoutFrame(param1);
      }
      
      private function __EmbedBackoutFrame(param1:Event) : void
      {
         SoundManager.instance.play("008");
         param1.stopImmediatePropagation();
         if(_embedStoneCell && param1.type == "click")
         {
            _embedStoneCell.closeTip(param1 as MouseEvent);
         }
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("store.Embed.EmbedAlertFrame.TipText",500),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,1);
         _loc2_.addEventListener("response",_response);
         if(_embedBackoutMouseIcon)
         {
            ObjectUtils.disposeObject(_embedBackoutMouseIcon);
            _embedBackoutMouseIcon = null;
         }
      }
      
      private function _response(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",_response);
         ObjectUtils.disposeObject(param1.target);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            sendEmbedBackout();
         }
         else
         {
            updateHoles();
            stage.focus = this;
         }
      }
      
      private function __EmbedBackoutDownItemOver(param1:EmbedBackoutEvent) : void
      {
         param1.stopImmediatePropagation();
         _currentHolePlace = param1.CellID;
         _templateID = param1.TemplateID;
         if(!_embedBackoutBtn.isAction && !contains(_embedBackoutDownItem))
         {
            _embedStoneCell = param1.target as EmbedStoneCell;
            _embedBackoutDownItem.x = param1.target.x;
            _embedBackoutDownItem.y = param1.target.y + param1.target.height + 8;
            addChild(_embedBackoutDownItem);
            _embedBackoutDownItem.addEventListener("click",__EmbedBackoutFrame);
            _embedBackoutDownItem.addEventListener("mouseOver",__EmbedShowTip);
            _embedBackoutDownItem.addEventListener("mouseOut",__EmbedBackoutDownItemOutGo);
         }
      }
      
      private function __EmbedShowTip(param1:MouseEvent) : void
      {
         if(_embedStoneCell)
         {
            _embedStoneCell.showTip(param1);
         }
      }
      
      private function __EmbedBackoutDownItemDown(param1:EmbedBackoutEvent) : void
      {
         if(_embedBackoutMouseIcon)
         {
            _embedBackoutMouseIcon.setFrame(2);
         }
      }
      
      private function __EmbedBackoutDownItemOut(param1:EmbedBackoutEvent) : void
      {
         if(_embedBackoutDownItem && (mouseY >= _embedBackoutDownItem.y && mouseY <= _embedBackoutDownItem.y + _embedBackoutDownItem.height && (mouseX >= _embedBackoutDownItem.x && mouseX <= _embedBackoutDownItem.x + _embedBackoutDownItem.width)))
         {
            return;
         }
         __EmbedBackoutDownItemOutGo(param1);
      }
      
      private function __EmbedBackoutDownItemOutGo(param1:Event) : void
      {
         if(_embedBackoutBtn != null && !_embedBackoutBtn.isAction && _embedBackoutDownItem && contains(_embedBackoutDownItem))
         {
            if(_embedStoneCell && param1 != null && param1.type == "mouseOut")
            {
               _embedStoneCell.closeTip(param1 as MouseEvent);
            }
            _embedBackoutDownItem.removeEventListener("mouseOver",__EmbedShowTip);
            _embedBackoutDownItem.removeEventListener("click",__EmbedBackoutFrame);
            _embedBackoutDownItem.removeEventListener("mouseOut",__EmbedBackoutDownItemOutGo);
            removeChild(_embedBackoutDownItem);
         }
      }
      
      public function refreshData(param1:Dictionary) : void
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
         var _loc1_:* = null;
         if(PlayerManager.Instance.Self.Gold < 2000)
         {
            _loc1_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.view.GoldInadequate"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            _loc1_.moveEnable = false;
            _loc1_.addEventListener("response",_responseV);
            return;
         }
      }
      
      private function _responseV(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_responseV);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            okFastPurchaseGold();
         }
         else
         {
            cancelFastPurchaseGold();
         }
         ObjectUtils.disposeObject(param1.currentTarget);
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
      
      private function removeFromStageHandler(param1:Event) : void
      {
         BagStore.instance.reduceTipPanelNumber();
      }
      
      private function __shortCutBuyHandler(param1:ShortcutBuyEvent) : void
      {
         param1.stopImmediatePropagation();
         __embed2();
      }
      
      private function __shortCutBuyMoneyOkHandler(param1:ShortcutBuyEvent) : void
      {
         param1.stopImmediatePropagation();
         updateHoles();
      }
      
      private function __shortCutBuyMoneyCancelHandler(param1:ShortcutBuyEvent) : void
      {
         param1.stopImmediatePropagation();
         updateHoles();
      }
      
      private function cancelFastPurchaseGold() : void
      {
         updateHoles();
      }
      
      public function sendEmbedBackout() : void
      {
         var _loc1_:* = null;
         if(PlayerManager.Instance.Self.Money < 500)
         {
            _loc1_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.comon.lack"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
            _loc1_.addEventListener("response",_responseIV);
            return;
         }
         __EmbedBackoutDownItemOutGo(null);
         SocketManager.Instance.out.sendItemEmbedBackout(_currentHolePlace,_templateID);
      }
      
      private function _responseIV(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_responseIV);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
         cancelEmbed1();
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function cancelEmbedBackout() : void
      {
      }
      
      private function removeEvents() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 1;
         while(_loc1_ < 7)
         {
            _stoneCells[_loc1_ - 1].removeEventListener("embed",__embed);
            _stoneCells[_loc1_ - 1].removeEventListener("embedBackout",__EmbedBackout);
            _stoneCells[_loc1_ - 1].removeEventListener("embedBackoutDownItemOver",__EmbedBackoutDownItemOver);
            _stoneCells[_loc1_ - 1].removeEventListener("embedBackoutDownItemOut",__EmbedBackoutDownItemOut);
            _stoneCells[_loc1_ - 1].removeEventListener("embedBackoutDownItemDown",__EmbedBackoutDownItemDown);
            _loc1_++;
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
      
      public function stoneStartShine(param1:int, param2:InventoryItemInfo) : void
      {
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc5_:* = null;
         if(PlayerManager.Instance.Self.StoreBag.items[0] == null)
         {
            return;
         }
         var _loc8_:InventoryItemInfo = _embedItemCell.itemInfo;
         var _loc6_:Array = _loc8_.Hole.split("|");
         _loc7_ = 0;
         while(_loc7_ < _stoneCells.length)
         {
            _loc4_ = _loc8_["Hole" + (_loc7_ + 1)];
            if(_loc7_ < 4)
            {
               _loc3_ = String(_loc6_[_loc7_]);
               _loc5_ = _loc3_.split(",");
               if(_loc8_["Hole" + (_loc7_ + 1)] >= 0 && (_stoneCells[_loc7_] as EmbedStoneCell).StoneType == param1)
               {
                  _stoneCells[_loc7_].startShine();
               }
            }
            else if((_stoneCells[_loc7_] as EmbedStoneCell).StoneType == param1 && _loc8_["Hole" + (_loc7_ + 1) + "Level"] > 0)
            {
               _stoneCells[_loc7_].startShine();
            }
            _loc7_++;
         }
      }
      
      public function stopShine() : void
      {
         _embedItemCell.stopShine();
         var _loc3_:int = 0;
         var _loc2_:* = _stoneCells;
         for each(var _loc1_ in _stoneCells)
         {
            _loc1_.stopShine();
         }
      }
      
      public function show() : void
      {
         this.visible = true;
         refreshData(null);
      }
      
      public function hide() : void
      {
         var _loc1_:int = 0;
         this.visible = false;
         _loc1_ = 1;
         while(_loc1_ < 7)
         {
            _stoneCells[_loc1_ - 1].close();
            _loc1_++;
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
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
         _loc1_ = 1;
         while(_loc1_ < 7)
         {
            ObjectUtils.disposeObject(_stoneCells[_loc1_ - 1]);
            _stoneCells[_loc1_ - 1] = null;
            _loc1_++;
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
