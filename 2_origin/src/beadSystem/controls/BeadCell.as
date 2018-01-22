package beadSystem.controls
{
   import bagAndInfo.bag.BagView;
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import beadSystem.beadSystemManager;
   import beadSystem.data.BeadEvent;
   import beadSystem.model.BeadModel;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CEvent;
   import ddt.events.CellEvent;
   import ddt.manager.BeadTemplateManager;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.tips.GoodTipInfo;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.utils.getQualifiedClassName;
   import store.view.embed.EmbedStoneCell;
   import store.view.embed.EmbedUpLevelCell;
   
   public class BeadCell extends BagCell
   {
       
      
      private var _lockIcon:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _beadFeedMC:MovieClip;
      
      private var _beadInfo:InventoryItemInfo;
      
      private var _itemInfo:InventoryItemInfo;
      
      private var beadFeedBtn:BeadFeedButton;
      
      public function BeadCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:Boolean = true, param5:DisplayObject = null)
      {
         super(param1,param2,param3,!!param5?param5:ComponentFactory.Instance.creatBitmap("bagAndInfo.cell.bagCellBgAsset"));
      }
      
      public function get beadPlace() : int
      {
         return _place;
      }
      
      override public function dragDrop(param1:DragEffect) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:String = getQualifiedClassName(param1.source);
         if(param1.source is EmbedUpLevelCell)
         {
            param1.action = "none";
            DragManager.acceptDrag(this);
            if(this.itemInfo && int(this.itemInfo.Hole1) == 21)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.mostHightLevel"));
               return;
            }
            if(this.itemInfo && int(this.itemInfo.Hole1) == 1)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.lvOneCanntUpgrade"));
            }
            SocketManager.Instance.out.sendBeadEquip(31,this.beadPlace);
         }
         else if(param1.data is InventoryItemInfo && !(param1.source is BeadAdvanceCell) && _loc2_ != "beadSystem.views::BeadAdvanceInfoCell")
         {
            _loc4_ = param1.data as InventoryItemInfo;
            if(param1.source is BeadCell)
            {
               SocketManager.Instance.out.sendBeadEquip(_loc4_.Place,this.beadPlace);
               DragManager.acceptDrag(this);
               return;
            }
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            _beadInfo = _loc4_;
            param1.action = "none";
            DragManager.acceptDrag(this);
            if(this.itemInfo && !this.itemInfo.IsBinds && param1.source != BeadCell)
            {
               _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.beadSystem.useBindBead"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
               _loc3_.addEventListener("response",__onBindRespones1);
            }
            else
            {
               SocketManager.Instance.out.sendBeadEquip(_loc4_.Place,this.beadPlace);
            }
         }
         else if(param1.source is BeadLockButton)
         {
            DragManager.acceptDrag(this);
         }
         else if(param1.source is BeadFeedButton)
         {
            DragManager.acceptDrag(this);
         }
      }
      
      protected function __onBindRespones1(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               break;
            case 2:
            case 3:
            case 4:
               if(_beadInfo.Property2 == this.info.Property2)
               {
                  SocketManager.Instance.out.sendBeadEquip(_beadInfo.Place,this.beadPlace);
                  break;
               }
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.store.matte.notType"));
               break;
         }
         param1.currentTarget.removeEventListener("response",__onBindRespones);
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      public function set itemInfo(param1:InventoryItemInfo) : void
      {
         _itemInfo = param1;
      }
      
      override public function get itemInfo() : InventoryItemInfo
      {
         return _itemInfo;
      }
      
      override public function dragStop(param1:DragEffect) : void
      {
         SoundManager.instance.play("008");
         dispatchEvent(new CellEvent("dragStop",null,true));
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            locked = false;
            dragShowPicTxt();
            return;
         }
         if(param1.action == "move")
         {
            locked = false;
            dragShowPicTxt();
         }
         if(param1.action == "move" && !param1.target)
         {
            param1.action = "none";
            if(!(param1.target is EmbedStoneCell) || !(param1.target is EmbedUpLevelCell))
            {
               if(!param1.target)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.beadCanntDestory"));
               }
            }
            locked = false;
         }
         dragShowPicTxt();
         super.dragStop(param1);
      }
      
      override public function set locked(param1:Boolean) : void
      {
         .super.locked = param1;
         if(param1)
         {
            if(_cellMouseOverFormer)
            {
               _cellMouseOverFormer.visible = true;
            }
         }
         else if(_cellMouseOverFormer)
         {
            _cellMouseOverFormer.visible = false;
         }
      }
      
      public function FeedBead() : void
      {
         if(!itemInfo.IsUsed)
         {
            if(BeadModel.beadCanUpgrade && this.info)
            {
               if(int(PlayerManager.Instance.Self.embedUpLevelCell.itemInfo.Hole1) == 21)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.mostHightLevel"));
                  return;
               }
               if(_itemInfo.Hole1 >= 13 || BeadTemplateManager.Instance.GetBeadInfobyID(_itemInfo.TemplateID).Type3 > 0)
               {
                  beadSystemManager.Instance.addEventListener("createComplete",__onCreateComplete);
                  beadSystemManager.Instance.showFrame("infoframe");
                  return;
               }
               boxPrompts();
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.tipNoFeedBead"));
            }
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.tipLocked"));
         }
      }
      
      private function __onCreateComplete(param1:CEvent) : void
      {
         var _loc2_:* = null;
         beadSystemManager.Instance.removeEventListener("createComplete",__onCreateComplete);
         if(param1.data.type == "infoframe")
         {
            _loc2_ = param1.data.spr;
            _loc2_["setBeadName"](this.tipData["beadName"]);
            LayerManager.Instance.addToLayer(_loc2_,1,true,1);
            _loc2_["textInput"].setFocus();
            _loc2_.addEventListener("response",__onConfigResponse);
         }
      }
      
      private function insteadString(param1:String, param2:String) : String
      {
         return param1.slice(param1.lastIndexOf(param2) + 1,param1.length);
      }
      
      private function boxPrompts() : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(this.itemInfo.IsBinds && !BeadModel.isBeadCellIsBind)
         {
            _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.beadSystem.useBindBead"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
            _loc3_.addEventListener("response",__onBindRespones);
         }
         else
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.beadSystem.FeedBeadConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("beadSystem.feedBeadShowExpTextOneFeed");
            _loc1_.htmlText = LanguageMgr.GetTranslation("ddt.beadSystem.feedBeadGetExp",_itemInfo.Hole2);
            _loc2_.addChild(_loc1_);
            _loc2_.addEventListener("response",__onFeedResponse);
         }
      }
      
      protected function __onConfigResponse(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         SoundManager.instance.playButtonSound();
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               if(_loc2_["textInput"].text == "YES" || _loc2_["textInput"].text == "yes")
               {
                  boxPrompts();
                  _loc2_.removeEventListener("response",__onFeedResponse);
                  ObjectUtils.disposeObject(_loc2_);
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.feedBeadPromptInfo"));
               }
         }
      }
      
      protected function __onBindRespones(param1:FrameEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         SoundManager.instance.playButtonSound();
         switch(int(param1.responseCode))
         {
            case 0:
               break;
            default:
               break;
            default:
               break;
            case 3:
            case 4:
               _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.beadSystem.FeedBeadConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("beadSystem.feedBeadShowExpTextOneFeed");
               _loc2_.htmlText = LanguageMgr.GetTranslation("ddt.beadSystem.feedBeadGetExp",itemInfo.Hole2);
               _loc3_.addChild(_loc2_);
               _loc3_.addEventListener("response",__onFeedResponse);
         }
         param1.currentTarget.removeEventListener("response",__onBindRespones);
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      protected function __onFeedResponse(param1:FrameEvent) : void
      {
         (parent.parent as BagView).beadFeedBtn.dragAgain();
         SoundManager.instance.play("008");
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               if(!_beadFeedMC)
               {
                  _beadFeedMC = ClassUtils.CreatInstance("beadSystem.feed.MC");
                  _beadFeedMC.gotoAndPlay(1);
                  _beadFeedMC.x = -10;
                  _beadFeedMC.y = 130;
                  _beadFeedMC.addEventListener("startFeedBead",__onFeedStart);
                  _beadFeedMC.addEventListener("feedComplete",__onFeedComplete);
                  addChild(_beadFeedMC);
                  break;
               }
         }
         param1.currentTarget.removeEventListener("response",__onFeedResponse);
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function __onFeedComplete(param1:Event) : void
      {
         _beadFeedMC.removeEventListener("startFeedBead",__onFeedStart);
         _beadFeedMC.removeEventListener("feedComplete",__onFeedComplete);
         _beadFeedMC.stop();
         ObjectUtils.disposeObject(_beadFeedMC);
         _beadFeedMC = null;
      }
      
      private function __onFeedStart(param1:Event) : void
      {
         var _loc2_:Array = [];
         _loc2_.push(this._place);
         SocketManager.Instance.out.sendBeadUpgrade(_loc2_);
         if(this.itemInfo.Hole2 + BeadModel.upgradeCellInfo.Hole2 >= ServerConfigManager.instance.getBeadUpgradeExp()[BeadModel.upgradeCellInfo.Hole1 + 1])
         {
            beadSystemManager.Instance.dispatchEvent(new BeadEvent("playUpgradeMC"));
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
            SocketManager.Instance.out.sendBeadLock(this._place);
         }
         else
         {
            if(_lockIcon)
            {
               _lockIcon.visible = false;
            }
            SocketManager.Instance.out.sendBeadLock(this._place);
            this.itemInfo.IsUsed = false;
         }
         return true;
      }
      
      private function onStack2(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.target as BaseAlerFrame;
         _loc2_.removeEventListener("response",onStack2);
         _loc2_.dispose();
      }
      
      override public function set info(param1:ItemTemplateInfo) : void
      {
         var _loc2_:int = 0;
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
         if(param1)
         {
            if(!_nameTxt)
            {
               _nameTxt = ComponentFactory.Instance.creatComponentByStylename("beadSystem.beadCell.name");
               _nameTxt.mouseEnabled = false;
               addChild(_nameTxt);
            }
            _nameTxt.text = BeadTemplateManager.Instance.GetBeadInfobyID(param1.TemplateID).Name;
            _nameTxt.visible = true;
            this.setChildIndex(_nameTxt,this.numChildren - 1);
            tipStyle = "core.GoodsTip";
            _tipData = new GoodTipInfo();
            GoodTipInfo(_tipData).itemInfo = _info;
            if(this.itemInfo.Hole2 > 0)
            {
               GoodTipInfo(_tipData).exp = itemInfo.Hole2;
               GoodTipInfo(_tipData).upExp = ServerConfigManager.instance.getBeadUpgradeExp()[itemInfo.Hole1 + 1];
               GoodTipInfo(_tipData).beadName = itemInfo.Name + "-" + BeadTemplateManager.Instance.GetBeadInfobyID(param1.TemplateID).Name + "Lv" + itemInfo.Hole1;
            }
            else
            {
               GoodTipInfo(_tipData).exp = ServerConfigManager.instance.getBeadUpgradeExp()[BeadTemplateManager.Instance.GetBeadInfobyID(itemInfo.TemplateID).BaseLevel];
               GoodTipInfo(_tipData).upExp = ServerConfigManager.instance.getBeadUpgradeExp()[BeadTemplateManager.Instance.GetBeadInfobyID(itemInfo.TemplateID).BaseLevel + 1];
               GoodTipInfo(_tipData).beadName = itemInfo.Name + "-" + BeadTemplateManager.Instance.GetBeadInfobyID(param1.TemplateID).Name + "Lv" + BeadTemplateManager.Instance.GetBeadInfobyID(itemInfo.TemplateID).BaseLevel;
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
            if(this.beadPlace >= 32 && this.beadPlace <= 81)
            {
               _loc2_ = 1;
            }
            else if(this.beadPlace >= 82 && this.beadPlace <= 131)
            {
               _loc2_ = 2;
            }
            else if(this.beadPlace >= 132 && this.beadPlace <= 181)
            {
               _loc2_ = 3;
            }
            dispatchEvent(new BeadEvent("beadCellChanged",_loc2_));
         }
         else
         {
            if(_lockIcon)
            {
               _lockIcon.visible = false;
            }
            if(_nameTxt)
            {
               _nameTxt.visible = false;
            }
         }
      }
      
      override public function dragStart() : void
      {
         if(_info && !locked && stage && _allowDrag)
         {
            if(DragManager.startDrag(this,_info,createDragImg(),stage.mouseX + 10,stage.mouseY + 10,"move"))
            {
               locked = true;
               dragHidePicTxt();
               if(_info && _pic.numChildren > 0)
               {
                  dispatchEvent(new CellEvent("dragStart",this.info,true));
               }
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
      
      override protected function initTip() : void
      {
         tipDirctions = "7,6,2,1,5,4,0,3,6";
         tipGapV = 0;
         tipGapH = 0;
      }
      
      override public function dispose() : void
      {
         if(_nameTxt)
         {
            ObjectUtils.disposeObject(_nameTxt);
         }
         _nameTxt = null;
         if(_lockIcon)
         {
            ObjectUtils.disposeObject(_lockIcon);
         }
         _lockIcon = null;
         if(_beadFeedMC)
         {
            ObjectUtils.disposeObject(_beadFeedMC);
         }
         _beadFeedMC = null;
         super.dispose();
      }
   }
}
