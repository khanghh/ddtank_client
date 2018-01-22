package store.view.embed
{
   import bagAndInfo.cell.BaseCell;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import beadSystem.beadSystemManager;
   import beadSystem.controls.BeadAdvanceCell;
   import beadSystem.model.BeadModel;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.ShineObject;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.events.CellEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.BeadTemplateManager;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.tips.GoodTipInfo;
   import ddt.view.tips.MultipleLineTip;
   import ddt.view.tips.OneLineTip;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getQualifiedClassName;
   import road7th.utils.MovieClipWrapper;
   import store.events.EmbedBackoutEvent;
   
   public class EmbedStoneCell extends BaseCell
   {
      
      public static const Close:int = -1;
      
      public static const Empty:int = 0;
      
      public static const Full:int = 1;
      
      public static const ATTACK:int = 1;
      
      public static const DEFENSE:int = 2;
      
      public static const ATTRIBUTE:int = 3;
      
      public static const BEAD_STATE_CHANGED:String = "beadEmbed";
       
      
      private var _id:int;
      
      private var _state:int = -1;
      
      private var _stoneType:int;
      
      private var _shiner:ShineObject;
      
      private var _tipPanel:Sprite;
      
      private var _tipDerial:Boolean;
      
      private var tipSprite:Sprite;
      
      private var _tipOne:MultipleLineTip;
      
      private var _tipTwo:OneLineTip;
      
      private var _openGrid:ScaleFrameImage;
      
      private var _openBG:Bitmap;
      
      private var _closeStrip:Bitmap;
      
      private var _SelectedImage:Image;
      
      private var _holeLv:int = -1;
      
      private var _holeExp:int = -1;
      
      private var _dragBeadPic:MovieClip;
      
      private var _nameTxt:FilterFrameText;
      
      private var _lockIcon:Bitmap;
      
      private var _selected:Boolean = false;
      
      private var _isOpend:Boolean = false;
      
      private var _itemInfo:InventoryItemInfo;
      
      private var _beadInfo:InventoryItemInfo;
      
      private var _Player:PlayerInfo;
      
      public function EmbedStoneCell(param1:int, param2:int)
      {
         var _loc4_:* = null;
         var _loc3_:Sprite = new Sprite();
         if(param1 == 31)
         {
            _loc4_ = ComponentFactory.Instance.creatBitmap("beadSystem.upgradeBG");
         }
         else
         {
            _loc4_ = ComponentFactory.Instance.creatBitmap("asset.ddtstore.EmbedCellBG");
         }
         _loc3_.addChild(_loc4_);
         super(_loc3_,_info);
         _id = param1;
         _stoneType = param2;
         _shiner = new ShineObject(ComponentFactory.Instance.creat("asset.ddtstore.EmbedStoneCellShine"));
         var _loc5_:* = false;
         _shiner.visible = _loc5_;
         _loc5_ = _loc5_;
         _shiner.mouseEnabled = _loc5_;
         _shiner.mouseChildren = _loc5_;
         addChild(_shiner);
         if(_id != 31)
         {
            _openBG = ComponentFactory.Instance.creatBitmap("beadSystem.embedBG");
            addChildAt(_openBG,0);
         }
         if(_id <= 12)
         {
            _closeStrip = ComponentFactory.Instance.creatBitmap("beadSystem.unOpenedBG");
         }
         else
         {
            _closeStrip = ComponentFactory.Instance.creatBitmap("beadSystem.disopened.bg");
         }
         addChild(_closeStrip);
         if(_id < 6)
         {
            open();
         }
         _tipOne = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.MultipleLineTip");
         _tipTwo = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCellCloseTip");
         _tipTwo.tipData = LanguageMgr.GetTranslation("tank.store.embedCell.closeOpenHole");
         if(_id > 12 && _id != 31)
         {
            _SelectedImage = ComponentFactory.Instance.creatComponentByStylename("beadSystem.openHoleSelectedImage");
            _SelectedImage.visible = false;
            addChild(_SelectedImage);
         }
         initEvents();
         if(_id <= 12 && _id >= 4)
         {
            setTipTwoData(_id);
         }
      }
      
      private function setTipTwoData(param1:int) : void
      {
         switch(int(param1) - 6)
         {
            case 0:
               _tipTwo.tipData = LanguageMgr.GetTranslation("ddt.beadSystem.tipLvOpenHole",15);
               PlayerManager.Instance.Self.addEventListener("propertychange",__changeHandler);
               if(PlayerManager.Instance.Self.Grade >= 15)
               {
                  open();
               }
               if(otherPlayer)
               {
                  if(otherPlayer.Grade < 15)
                  {
                     close();
                  }
                  else
                  {
                     open();
                  }
               }
               break;
            case 1:
               _tipTwo.tipData = LanguageMgr.GetTranslation("ddt.beadSystem.tipLvOpenHole",18);
               PlayerManager.Instance.Self.addEventListener("propertychange",__changeHandler);
               if(PlayerManager.Instance.Self.Grade >= 18)
               {
                  open();
               }
               if(otherPlayer)
               {
                  if(otherPlayer.Grade < 18)
                  {
                     close();
                  }
                  else
                  {
                     open();
                  }
               }
               break;
            case 2:
               _tipTwo.tipData = LanguageMgr.GetTranslation("ddt.beadSystem.tipLvOpenHole",21);
               PlayerManager.Instance.Self.addEventListener("propertychange",__changeHandler);
               if(PlayerManager.Instance.Self.Grade >= 21)
               {
                  open();
               }
               if(otherPlayer)
               {
                  if(otherPlayer.Grade < 21)
                  {
                     close();
                  }
                  else
                  {
                     open();
                  }
               }
               break;
            case 3:
               _tipTwo.tipData = LanguageMgr.GetTranslation("ddt.beadSystem.tipLvOpenHole",24);
               PlayerManager.Instance.Self.addEventListener("propertychange",__changeHandler);
               if(PlayerManager.Instance.Self.Grade >= 24)
               {
                  open();
               }
               if(otherPlayer)
               {
                  if(otherPlayer.Grade < 24)
                  {
                     close();
                  }
                  else
                  {
                     open();
                  }
               }
               break;
            case 4:
               _tipTwo.tipData = LanguageMgr.GetTranslation("ddt.beadSystem.tipLvOpenHole",27);
               PlayerManager.Instance.Self.addEventListener("propertychange",__changeHandler);
               if(PlayerManager.Instance.Self.Grade >= 27)
               {
                  open();
               }
               if(otherPlayer)
               {
                  if(otherPlayer.Grade < 27)
                  {
                     close();
                  }
                  else
                  {
                     open();
                  }
               }
               break;
            case 5:
               _tipTwo.tipData = LanguageMgr.GetTranslation("ddt.beadSystem.tipLvOpenHole",30);
               PlayerManager.Instance.Self.addEventListener("propertychange",__changeHandler);
               if(PlayerManager.Instance.Self.Grade >= 30)
               {
                  open();
               }
               if(otherPlayer)
               {
                  if(otherPlayer.Grade < 30)
                  {
                     close();
                  }
                  else
                  {
                     open();
                  }
               }
               break;
            case 6:
               _tipTwo.tipData = LanguageMgr.GetTranslation("ddt.beadSystem.tipLvOpenHole",33);
               PlayerManager.Instance.Self.addEventListener("propertychange",__changeHandler);
               if(PlayerManager.Instance.Self.Grade >= 33)
               {
                  open();
               }
               if(otherPlayer)
               {
                  if(otherPlayer.Grade < 33)
                  {
                     close();
                  }
                  else
                  {
                     open();
                  }
               }
         }
      }
      
      public function LockBead() : Boolean
      {
         if(!this.itemInfo)
         {
            return false;
         }
         if(!this.itemInfo.IsUsed)
         {
            if(_lockIcon)
            {
               _lockIcon.visible = true;
               setChildIndex(_lockIcon,numChildren - 1);
            }
            else
            {
               _lockIcon = ComponentFactory.Instance.creatBitmap("asset.beadSystem.beadInset.lockIcon1");
               var _loc1_:* = 0.7;
               _lockIcon.scaleY = _loc1_;
               _lockIcon.scaleX = _loc1_;
               this.addChild(_lockIcon);
               setChildIndex(_lockIcon,numChildren - 1);
            }
            SocketManager.Instance.out.sendBeadLock(this.ID);
         }
         else
         {
            if(_lockIcon)
            {
               _lockIcon.visible = false;
            }
            SocketManager.Instance.out.sendBeadLock(this.ID);
         }
         return true;
      }
      
      private function __changeHandler(param1:PlayerPropertyEvent) : void
      {
         PlayerManager.Instance.Self.removeEventListener("propertychange",__changeHandler);
         setTipTwoData(ID);
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         if(_SelectedImage)
         {
            _SelectedImage.visible = param1;
         }
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function holeLvUp() : void
      {
         var _loc1_:MovieClip = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedHoleExpUp");
         var _loc3_:* = 0.4;
         _loc1_.scaleY = _loc3_;
         _loc1_.scaleX = _loc3_;
         _loc1_.y = 42;
         var _loc2_:MovieClipWrapper = new MovieClipWrapper(_loc1_,true,true);
         addChild(_loc2_.movie);
         BeadModel.isHoleOpendComplete = false;
      }
      
      public function get ID() : int
      {
         return _id;
      }
      
      override public function get allowDrag() : Boolean
      {
         return true;
      }
      
      private function initEvents() : void
      {
         addEventListener("interactive_click",__clickHandler);
         addEventListener("interactive_double_click",__doubleClick);
         DoubleClickManager.Instance.enableDoubleClick(this);
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         if(!_Player)
         {
            if(_state != -1 && _info == null)
            {
               _tipOne.x = localToGlobal(new Point(width,height)).x + 8;
               _tipOne.y = localToGlobal(new Point(width,height)).y + 8;
               LayerManager.Instance.addToLayer(_tipOne,2);
               return;
            }
            if(!isOpend && _info == null)
            {
               _tipTwo.x = localToGlobal(new Point(width,height)).x + 8;
               _tipTwo.y = localToGlobal(new Point(width,height)).y + 8;
               LayerManager.Instance.addToLayer(_tipTwo,2);
            }
         }
      }
      
      private function __clickHandler(param1:InteractiveEvent) : void
      {
         dispatchEvent(new CellEvent("itemclick",this));
      }
      
      private function __doubleClick(param1:InteractiveEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(_info)
         {
            dispatchEvent(new CellEvent("doubleclick",this));
         }
      }
      
      public function showTip(param1:MouseEvent) : void
      {
      }
      
      public function closeTip(param1:MouseEvent) : void
      {
         super.onMouseOut(param1);
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         if(_state == 1 && !_tipDerial && _info != null)
         {
            dispatchEvent(new EmbedBackoutEvent("embedBackoutDownItemOut",this._id,info.TemplateID));
         }
         if(_state != -1 && _info == null)
         {
            if(_tipOne.parent)
            {
               _tipOne.parent.removeChild(_tipOne);
            }
            return;
         }
         if(!isOpend && _info == null)
         {
            super.onMouseOut(param1);
            if(_tipTwo.parent)
            {
               _tipTwo.parent.removeChild(_tipTwo);
            }
         }
      }
      
      public function open() : void
      {
         if(_stoneType == -1)
         {
            return;
         }
         _state = 0;
         if(_closeStrip)
         {
            _closeStrip.visible = false;
         }
         _isOpend = true;
      }
      
      public function get isOpend() : Boolean
      {
         return _isOpend;
      }
      
      public function set HoleExp(param1:int) : void
      {
         _holeExp = param1;
      }
      
      public function get HoleExp() : int
      {
         return _holeExp;
      }
      
      public function set HoleLv(param1:int) : void
      {
         _holeLv = param1;
         if(_holeLv >= 0 && _stoneType == 3 && _id > 4)
         {
            switch(int(_holeLv) - 1)
            {
               case 0:
                  _tipOne.tipData = LanguageMgr.GetTranslation("tank.store.embedCell.Hole",_holeLv,4);
                  break;
               case 1:
                  _tipOne.tipData = LanguageMgr.GetTranslation("tank.store.embedCell.Hole",_holeLv,8);
                  break;
               case 2:
                  _tipOne.tipData = LanguageMgr.GetTranslation("tank.store.embedCell.Hole",_holeLv,12);
                  break;
               case 3:
                  _tipOne.tipData = LanguageMgr.GetTranslation("tank.store.embedCell.Hole",_holeLv,16);
                  break;
               case 4:
                  _tipOne.tipData = LanguageMgr.GetTranslation("tank.store.embedCell.Hole",_holeLv,19);
                  break;
               case 5:
                  _tipOne.tipData = LanguageMgr.GetTranslation("tank.store.embedCell.Hole",_holeLv,20);
            }
         }
         if(_holeLv > 0)
         {
            this.open();
         }
      }
      
      public function get HoleLv() : int
      {
         return _holeLv;
      }
      
      public function set StoneType(param1:int) : void
      {
         var _loc2_:* = null;
         _stoneType = param1;
         if(this.ID != 31)
         {
            switch(int(_stoneType) - 1)
            {
               case 0:
                  _loc2_ = LanguageMgr.GetTranslation("tank.store.embedCell.attack");
                  break;
               case 1:
                  _loc2_ = LanguageMgr.GetTranslation("tank.store.embedCell.defense");
                  break;
               case 2:
                  _loc2_ = LanguageMgr.GetTranslation("tank.store.embedCell.attribute");
            }
            if(_loc2_)
            {
               _tipOne.tipData = _loc2_;
            }
         }
         else
         {
            _tipOne.tipData = LanguageMgr.GetTranslation("ddt.beadSystem.tipFeedHole");
         }
      }
      
      public function get StoneType() : int
      {
         return _stoneType;
      }
      
      override public function dragStart() : void
      {
         if(_info && !locked && stage && _allowDrag)
         {
            if(DragManager.startDrag(this,_info,createDragImg(),stage.mouseX,stage.mouseY,"move"))
            {
               locked = true;
               dragHidePicTxt();
               _openBG.visible = true;
            }
         }
      }
      
      private function dragHidePicTxt() : void
      {
         _nameTxt.visible = false;
         if(_lockIcon)
         {
            _lockIcon.visible = false;
         }
      }
      
      private function dragShowPicTxt() : void
      {
         _nameTxt.visible = true;
         if(this.itemInfo.IsUsed && _lockIcon)
         {
            _lockIcon.visible = true;
         }
      }
      
      public function set itemInfo(param1:InventoryItemInfo) : void
      {
         _itemInfo = param1;
      }
      
      public function get itemInfo() : InventoryItemInfo
      {
         return _itemInfo;
      }
      
      override public function set info(param1:ItemTemplateInfo) : void
      {
         var _loc2_:* = null;
         if(_info)
         {
            _tipData = null;
            locked = false;
            if(_nameTxt)
            {
               _nameTxt.htmlText = "";
               _nameTxt.visible = false;
            }
         }
         .super.info = param1;
         _info = param1;
         if(_info)
         {
            if(!_nameTxt)
            {
               _nameTxt = ComponentFactory.Instance.creatComponentByStylename("beadSystem.beadCellEquip.name");
               _nameTxt.mouseEnabled = false;
               addChild(_nameTxt);
            }
            this.setChildIndex(_nameTxt,this.numChildren - 1);
            _loc2_ = beadSystemManager.Instance.getBeadNameTextFormatStyle(this.itemInfo.Hole1);
            _nameTxt.textFormatStyle = _loc2_;
            _nameTxt.visible = true;
            tipStyle = "core.GoodsTip";
            _tipData = new GoodTipInfo();
            GoodTipInfo(_tipData).itemInfo = _info;
            if(this.itemInfo.Hole2 > 0)
            {
               GoodTipInfo(_tipData).exp = itemInfo.Hole2;
               GoodTipInfo(_tipData).upExp = ServerConfigManager.instance.getBeadUpgradeExp()[itemInfo.Hole1 + 1];
               GoodTipInfo(_tipData).beadName = info.Name + "-" + BeadTemplateManager.Instance.GetBeadInfobyID(param1.TemplateID).Name + "Lv" + itemInfo.Hole1;
               _nameTxt.htmlText = BeadTemplateManager.Instance.GetBeadInfobyID(param1.TemplateID).Name + "Lv" + itemInfo.Hole1;
            }
            else
            {
               GoodTipInfo(_tipData).exp = ServerConfigManager.instance.getBeadUpgradeExp()[BeadTemplateManager.Instance.GetBeadInfobyID(itemInfo.TemplateID).BaseLevel];
               GoodTipInfo(_tipData).upExp = ServerConfigManager.instance.getBeadUpgradeExp()[BeadTemplateManager.Instance.GetBeadInfobyID(itemInfo.TemplateID).BaseLevel + 1];
               _nameTxt.htmlText = BeadTemplateManager.Instance.GetBeadInfobyID(param1.TemplateID).Name + "Lv" + BeadTemplateManager.Instance.GetBeadInfobyID(itemInfo.TemplateID).BaseLevel;
               GoodTipInfo(_tipData).beadName = info.Name + "-" + BeadTemplateManager.Instance.GetBeadInfobyID(param1.TemplateID).Name + "Lv" + BeadTemplateManager.Instance.GetBeadInfobyID(itemInfo.TemplateID).BaseLevel;
            }
            if(this.itemInfo.IsUsed)
            {
               if(_lockIcon)
               {
                  _lockIcon.visible = true;
                  setChildIndex(_lockIcon,numChildren - 1);
               }
               else
               {
                  _lockIcon = ComponentFactory.Instance.creatBitmap("asset.beadSystem.beadInset.lockIcon1");
                  var _loc3_:* = 0.7;
                  _lockIcon.scaleY = _loc3_;
                  _lockIcon.scaleX = _loc3_;
                  this.addChild(_lockIcon);
               }
            }
            else if(_lockIcon)
            {
               _lockIcon.visible = false;
            }
         }
         else
         {
            if(_lockIcon)
            {
               _lockIcon.visible = false;
            }
            disposeDragBeadPic();
            if(_nameTxt)
            {
               _nameTxt.visible = false;
            }
         }
         if(_openBG)
         {
            if(param1)
            {
               _openBG.visible = false;
            }
            else
            {
               _openBG.visible = true;
            }
         }
      }
      
      public function close() : void
      {
         _state = -1;
         if(_closeStrip)
         {
            _closeStrip.visible = true;
         }
         info = null;
         tipData = null;
      }
      
      override protected function onMouseClick(param1:MouseEvent) : void
      {
      }
      
      private function disposeDragBeadPic() : void
      {
         if(_dragBeadPic)
         {
            _dragBeadPic.gotoAndStop(_dragBeadPic.totalFrames);
            ObjectUtils.disposeObject(_dragBeadPic);
            _dragBeadPic = null;
         }
      }
      
      override public function dragDrop(param1:DragEffect) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:String = getQualifiedClassName(param1.source);
         if(param1.source is BeadAdvanceCell || _loc2_ == "beadSystem.views::BeadAdvanceInfoCell")
         {
            return;
         }
         if(this.isOpend)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               DragManager.acceptDrag(this);
               BaglockedManager.Instance.show();
               return;
            }
            _loc4_ = param1.data as InventoryItemInfo;
            if(_loc4_ && param1.action != "split")
            {
               param1.action = "none";
               if(this.ID != 31 && !isRightType(_loc4_))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.store.matte.notType"));
               }
               else if(!beadSystemManager.Instance.judgeLevel(_loc4_.Hole1,this._holeLv) && 13 <= this.ID && this.ID <= 18)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.tipDonotAdaptLevel"));
               }
               else
               {
                  _beadInfo = _loc4_;
                  if(this.itemInfo && int(this.itemInfo.Hole1) == 21 && !(param1.source is EmbedStoneCell) && param1.source is EmbedUpLevelCell)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.mostHightLevel"));
                     return;
                  }
                  if(this.itemInfo && int(this.itemInfo.Hole1) == 1 && !(param1.source is EmbedStoneCell) && param1.source is EmbedUpLevelCell)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.lvOneCanntUpgrade"));
                  }
                  if(!this._beadInfo.IsBinds)
                  {
                     _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.beadSystem.useBindBead"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
                     _loc3_.addEventListener("response",__onBindRespones);
                  }
                  else
                  {
                     this.itemInfo = _loc4_;
                     this.info = _loc4_;
                     SocketManager.Instance.out.sendBeadEquip(_loc4_.Place,this._id);
                  }
                  dispatchEvent(new Event("beadEmbed"));
                  _tipDerial = false;
               }
            }
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.tipNoAccessEquipBead"));
         }
         DragManager.acceptDrag(this);
      }
      
      protected function __onBindRespones(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               break;
            case 2:
            case 3:
            case 4:
               this.itemInfo = _beadInfo;
               this.info = _beadInfo;
               if(this.StoneType == int(_beadInfo.Property2))
               {
                  SocketManager.Instance.out.sendBeadEquip(_beadInfo.Place,this._id);
                  break;
               }
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.store.matte.notType"));
               break;
         }
         param1.currentTarget.removeEventListener("response",__onBindRespones);
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      override public function dragStop(param1:DragEffect) : void
      {
         SoundManager.instance.play("008");
         if(param1.action == "move" && !param1.target)
         {
            param1.action = "none";
         }
         disposeDragBeadPic();
         dragShowPicTxt();
         if(this.ID != 31)
         {
            if(_openBG)
            {
               _openBG.visible = false;
            }
         }
         locked = false;
         super.dragStop(param1);
      }
      
      private function isRightType(param1:InventoryItemInfo) : Boolean
      {
         return param1.Property2 == _stoneType.toString();
      }
      
      public function get tipDerial() : Boolean
      {
         return _tipDerial;
      }
      
      public function set tipDerial(param1:Boolean) : void
      {
         _tipDerial = param1;
      }
      
      public function startShine() : void
      {
         var _loc1_:* = 0.8;
         _shiner.scaleY = _loc1_;
         _shiner.scaleX = _loc1_;
         _loc1_ = 3;
         _shiner.y = _loc1_;
         _shiner.x = _loc1_;
         _shiner.visible = true;
         _shiner.shine();
      }
      
      public function stopShine() : void
      {
         _shiner.stopShine();
         _shiner.visible = false;
      }
      
      public function hasDrill() : Boolean
      {
         return EquipType.isDrill(_info as InventoryItemInfo);
      }
      
      public function get otherPlayer() : PlayerInfo
      {
         return _Player;
      }
      
      public function set otherPlayer(param1:PlayerInfo) : void
      {
         _Player = param1;
         if(_Player)
         {
            if(_id <= 12 && _id >= 4)
            {
               setTipTwoData(_id);
            }
         }
      }
      
      override protected function updateSize(param1:Sprite) : void
      {
         if(param1)
         {
            param1.scaleX = 0.8;
            param1.scaleY = 0.8;
            if(_picPos != null)
            {
               param1.x = _picPos.x;
            }
            else
            {
               param1.x = param1.x - param1.width / 2 + _contentWidth / 2;
            }
            if(_picPos != null)
            {
               param1.y = _picPos.y;
            }
            else
            {
               param1.y = param1.y - param1.height / 2 + _contentHeight / 2;
            }
         }
      }
      
      override public function dispose() : void
      {
         removeEventListener("interactive_double_click",__doubleClick);
         removeEventListener("interactive_click",__clickHandler);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__changeHandler);
         DoubleClickManager.Instance.disableDoubleClick(this);
         if(_tipOne)
         {
            ObjectUtils.disposeObject(_tipOne);
         }
         _tipOne = null;
         if(_tipTwo)
         {
            ObjectUtils.disposeObject(_tipTwo);
         }
         _tipTwo = null;
         if(_shiner)
         {
            ObjectUtils.disposeObject(_shiner);
         }
         _shiner = null;
         if(_openGrid)
         {
            ObjectUtils.disposeObject(_openGrid);
         }
         _openGrid = null;
         if(_closeStrip)
         {
            ObjectUtils.disposeObject(_closeStrip);
         }
         _closeStrip = null;
         ObjectUtils.disposeObject(_SelectedImage);
         _SelectedImage = null;
         super.dispose();
      }
      
      public function get state() : int
      {
         return _state;
      }
   }
}
