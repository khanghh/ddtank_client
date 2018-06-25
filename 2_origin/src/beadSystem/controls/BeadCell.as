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
      
      public function BeadCell(index:int, $info:ItemTemplateInfo = null, showLoading:Boolean = true, showTip:Boolean = true, bg:DisplayObject = null)
      {
         super(index,$info,showLoading,!!bg?bg:ComponentFactory.Instance.creatBitmap("bagAndInfo.cell.bagCellBgAsset"));
      }
      
      public function get beadPlace() : int
      {
         return _place;
      }
      
      override public function dragDrop(effect:DragEffect) : void
      {
         var info:* = null;
         var bindAlert:* = null;
         var str:String = getQualifiedClassName(effect.source);
         if(effect.source is EmbedUpLevelCell)
         {
            effect.action = "none";
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
         else if(effect.data is InventoryItemInfo && !(effect.source is BeadAdvanceCell) && str != "beadSystem.views::BeadAdvanceInfoCell")
         {
            info = effect.data as InventoryItemInfo;
            if(effect.source is BeadCell)
            {
               SocketManager.Instance.out.sendBeadEquip(info.Place,this.beadPlace);
               DragManager.acceptDrag(this);
               return;
            }
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            _beadInfo = info;
            effect.action = "none";
            DragManager.acceptDrag(this);
            if(this.itemInfo && !this.itemInfo.IsBinds && effect.source != BeadCell)
            {
               bindAlert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.beadSystem.useBindBead"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
               bindAlert.addEventListener("response",__onBindRespones1);
            }
            else
            {
               SocketManager.Instance.out.sendBeadEquip(info.Place,this.beadPlace);
            }
         }
         else if(effect.source is BeadLockButton)
         {
            DragManager.acceptDrag(this);
         }
         else if(effect.source is BeadFeedButton)
         {
            DragManager.acceptDrag(this);
         }
      }
      
      protected function __onBindRespones1(pEvent:FrameEvent) : void
      {
         switch(int(pEvent.responseCode))
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
         pEvent.currentTarget.removeEventListener("response",__onBindRespones);
         ObjectUtils.disposeObject(pEvent.currentTarget);
      }
      
      public function set itemInfo(value:InventoryItemInfo) : void
      {
         _itemInfo = value;
      }
      
      override public function get itemInfo() : InventoryItemInfo
      {
         return _itemInfo;
      }
      
      override public function dragStop(effect:DragEffect) : void
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
         if(effect.action == "move")
         {
            locked = false;
            dragShowPicTxt();
         }
         if(effect.action == "move" && !effect.target)
         {
            effect.action = "none";
            if(!(effect.target is EmbedStoneCell) || !(effect.target is EmbedUpLevelCell))
            {
               if(!effect.target)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.beadCanntDestory"));
               }
            }
            locked = false;
         }
         dragShowPicTxt();
         super.dragStop(effect);
      }
      
      override public function set locked(value:Boolean) : void
      {
         .super.locked = value;
         if(value)
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
      
      private function __onCreateComplete(e:CEvent) : void
      {
         var promptAlert:* = null;
         beadSystemManager.Instance.removeEventListener("createComplete",__onCreateComplete);
         if(e.data.type == "infoframe")
         {
            promptAlert = e.data.spr;
            promptAlert["setBeadName"](this.tipData["beadName"]);
            LayerManager.Instance.addToLayer(promptAlert,1,true,1);
            promptAlert["textInput"].setFocus();
            promptAlert.addEventListener("response",__onConfigResponse);
         }
      }
      
      private function insteadString(res:String, des:String) : String
      {
         return res.slice(res.lastIndexOf(des) + 1,res.length);
      }
      
      private function boxPrompts() : void
      {
         var bindAlert:* = null;
         var alert:* = null;
         var showExp:* = null;
         if(this.itemInfo.IsBinds && !BeadModel.isBeadCellIsBind)
         {
            bindAlert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.beadSystem.useBindBead"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
            bindAlert.addEventListener("response",__onBindRespones);
         }
         else
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.beadSystem.FeedBeadConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
            showExp = ComponentFactory.Instance.creatComponentByStylename("beadSystem.feedBeadShowExpTextOneFeed");
            showExp.htmlText = LanguageMgr.GetTranslation("ddt.beadSystem.feedBeadGetExp",_itemInfo.Hole2);
            alert.addChild(showExp);
            alert.addEventListener("response",__onFeedResponse);
         }
      }
      
      protected function __onConfigResponse(event:FrameEvent) : void
      {
         var alertInfo:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         SoundManager.instance.playButtonSound();
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               if(alertInfo["textInput"].text == "YES" || alertInfo["textInput"].text == "yes")
               {
                  boxPrompts();
                  alertInfo.removeEventListener("response",__onFeedResponse);
                  ObjectUtils.disposeObject(alertInfo);
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.feedBeadPromptInfo"));
               }
         }
      }
      
      protected function __onBindRespones(pEvent:FrameEvent) : void
      {
         var alert:* = null;
         var showExp:* = null;
         SoundManager.instance.playButtonSound();
         switch(int(pEvent.responseCode))
         {
            case 0:
               break;
            default:
               break;
            default:
               break;
            case 3:
            case 4:
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.beadSystem.FeedBeadConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
               showExp = ComponentFactory.Instance.creatComponentByStylename("beadSystem.feedBeadShowExpTextOneFeed");
               showExp.htmlText = LanguageMgr.GetTranslation("ddt.beadSystem.feedBeadGetExp",itemInfo.Hole2);
               alert.addChild(showExp);
               alert.addEventListener("response",__onFeedResponse);
         }
         pEvent.currentTarget.removeEventListener("response",__onBindRespones);
         ObjectUtils.disposeObject(pEvent.currentTarget);
      }
      
      protected function __onFeedResponse(event:FrameEvent) : void
      {
         (parent.parent as BagView).beadFeedBtn.dragAgain();
         SoundManager.instance.play("008");
         switch(int(event.responseCode) - 2)
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
         event.currentTarget.removeEventListener("response",__onFeedResponse);
         ObjectUtils.disposeObject(event.currentTarget);
      }
      
      private function __onFeedComplete(pEvent:Event) : void
      {
         _beadFeedMC.removeEventListener("startFeedBead",__onFeedStart);
         _beadFeedMC.removeEventListener("feedComplete",__onFeedComplete);
         _beadFeedMC.stop();
         ObjectUtils.disposeObject(_beadFeedMC);
         _beadFeedMC = null;
      }
      
      private function __onFeedStart(pEvent:Event) : void
      {
         var arr:Array = [];
         arr.push(this._place);
         SocketManager.Instance.out.sendBeadUpgrade(arr);
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
      
      private function onStack2(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = event.target as BaseAlerFrame;
         alert.removeEventListener("response",onStack2);
         alert.dispose();
      }
      
      override public function set info(value:ItemTemplateInfo) : void
      {
         var pageIndex:int = 0;
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
         .super.info = value;
         if(value)
         {
            if(!_nameTxt)
            {
               _nameTxt = ComponentFactory.Instance.creatComponentByStylename("beadSystem.beadCell.name");
               _nameTxt.mouseEnabled = false;
               addChild(_nameTxt);
            }
            _nameTxt.text = BeadTemplateManager.Instance.GetBeadInfobyID(value.TemplateID).Name;
            _nameTxt.visible = true;
            this.setChildIndex(_nameTxt,this.numChildren - 1);
            tipStyle = "core.GoodsTip";
            _tipData = new GoodTipInfo();
            GoodTipInfo(_tipData).itemInfo = _info;
            if(this.itemInfo.Hole2 > 0)
            {
               GoodTipInfo(_tipData).exp = itemInfo.Hole2;
               GoodTipInfo(_tipData).upExp = ServerConfigManager.instance.getBeadUpgradeExp()[itemInfo.Hole1 + 1];
               GoodTipInfo(_tipData).beadName = itemInfo.Name + "-" + BeadTemplateManager.Instance.GetBeadInfobyID(value.TemplateID).Name + "Lv" + itemInfo.Hole1;
            }
            else
            {
               GoodTipInfo(_tipData).exp = ServerConfigManager.instance.getBeadUpgradeExp()[BeadTemplateManager.Instance.GetBeadInfobyID(itemInfo.TemplateID).BaseLevel];
               GoodTipInfo(_tipData).upExp = ServerConfigManager.instance.getBeadUpgradeExp()[BeadTemplateManager.Instance.GetBeadInfobyID(itemInfo.TemplateID).BaseLevel + 1];
               GoodTipInfo(_tipData).beadName = itemInfo.Name + "-" + BeadTemplateManager.Instance.GetBeadInfobyID(value.TemplateID).Name + "Lv" + BeadTemplateManager.Instance.GetBeadInfobyID(itemInfo.TemplateID).BaseLevel;
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
               pageIndex = 1;
            }
            else if(this.beadPlace >= 82 && this.beadPlace <= 131)
            {
               pageIndex = 2;
            }
            else if(this.beadPlace >= 132 && this.beadPlace <= 181)
            {
               pageIndex = 3;
            }
            dispatchEvent(new BeadEvent("beadCellChanged",pageIndex));
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
