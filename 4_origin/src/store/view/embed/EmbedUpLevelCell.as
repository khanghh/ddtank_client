package store.view.embed
{
   import bagAndInfo.cell.BaseCell;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import beadSystem.beadSystemManager;
   import beadSystem.controls.BeadAdvanceCell;
   import beadSystem.data.BeadEvent;
   import beadSystem.model.BeadModel;
   import beadSystem.tips.BeadUpgradeTip;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.ShineObject;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
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
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getQualifiedClassName;
   
   public class EmbedUpLevelCell extends BaseCell
   {
       
      
      private var _shiner:ShineObject;
      
      private var _beadPic:MovieClip;
      
      private var _dragBeadPic:MovieClip;
      
      private var _invenItemInfo:InventoryItemInfo;
      
      private var _nameTxt:FilterFrameText;
      
      private var _lockIcon:Bitmap;
      
      private var _upTip:BeadUpgradeTip;
      
      private var _previewArray:Bitmap;
      
      private var _upgradeMC:MovieClip;
      
      private var _max:int = 21;
      
      private var _itemInfo:InventoryItemInfo;
      
      public function EmbedUpLevelCell()
      {
         var _loc1_:Bitmap = ComponentFactory.Instance.creatBitmap("beadSystem.upgradeBG");
         super(_loc1_);
         _shiner = new ShineObject(ComponentFactory.Instance.creat("asset.ddtstore.EmbedStoneCellShine"));
         var _loc2_:* = false;
         _shiner.visible = _loc2_;
         _loc2_ = _loc2_;
         _shiner.mouseEnabled = _loc2_;
         _shiner.mouseChildren = _loc2_;
         addChild(_shiner);
         PlayerManager.Instance.Self.embedUpLevelCell = this;
         beadSystemManager.Instance.addEventListener("playUpgradeMC",__startPlay);
      }
      
      private function __startPlay(param1:Event) : void
      {
         if(!_upgradeMC)
         {
            _upgradeMC = ClassUtils.CreatInstance("beadSystem.upgrade.MC");
            _upgradeMC.x = 451;
            _upgradeMC.y = 125;
            _upgradeMC.addEventListener("upgradeBeadComplete",__onUpgradeComplete);
            LayerManager.Instance.addToLayer(_upgradeMC,0,false,1,true);
            _upgradeMC.gotoAndPlay(1);
         }
      }
      
      private function __onUpgradeComplete(param1:Event) : void
      {
         _upgradeMC.removeEventListener("upgradeBeadComplete",__onUpgradeComplete);
         _upgradeMC.stop();
         ObjectUtils.disposeObject(_upgradeMC);
         _upgradeMC = null;
      }
      
      override public function set info(param1:ItemTemplateInfo) : void
      {
         .super.info = param1;
         if(_info)
         {
            _tipData = null;
            locked = false;
            disposeBeadPic();
         }
         _info = param1;
         if(_info)
         {
            if(!_nameTxt)
            {
               _nameTxt = ComponentFactory.Instance.creatComponentByStylename("beadSystem.beadCellEquip.name");
               _nameTxt.mouseEnabled = false;
               addChild(_nameTxt);
            }
            tipStyle = "beadSystem.tips.BeadUpgradeTip";
            _tipData = new GoodTipInfo();
            GoodTipInfo(_tipData).itemInfo = _info;
            if(this.itemInfo.Hole2 > 0)
            {
               GoodTipInfo(_tipData).exp = itemInfo.Hole2;
               GoodTipInfo(_tipData).upExp = ServerConfigManager.instance.getBeadUpgradeExp()[itemInfo.Hole1 + 1];
               GoodTipInfo(_tipData).beadName = info.Name + "-" + BeadTemplateManager.Instance.GetBeadInfobyID(param1.TemplateID).Name + "Lv" + itemInfo.Hole1;
            }
            else
            {
               GoodTipInfo(_tipData).exp = ServerConfigManager.instance.getBeadUpgradeExp()[BeadTemplateManager.Instance.GetBeadInfobyID(itemInfo.TemplateID).BaseLevel];
               GoodTipInfo(_tipData).upExp = ServerConfigManager.instance.getBeadUpgradeExp()[BeadTemplateManager.Instance.GetBeadInfobyID(itemInfo.TemplateID).BaseLevel + 1];
               GoodTipInfo(_tipData).beadName = info.Name + "-" + BeadTemplateManager.Instance.GetBeadInfobyID(param1.TemplateID).Name + "Lv" + BeadTemplateManager.Instance.GetBeadInfobyID(itemInfo.TemplateID).BaseLevel;
            }
            if(this.invenItemInfo.IsUsed)
            {
               if(_lockIcon)
               {
                  _lockIcon.visible = true;
                  setChildIndex(_lockIcon,numChildren - 1);
               }
               else
               {
                  _lockIcon = ComponentFactory.Instance.creatBitmap("asset.beadSystem.beadInset.lockIcon1");
                  _lockIcon.x = 5;
                  _lockIcon.y = 5;
                  this.addChild(_lockIcon);
                  setChildIndex(_lockIcon,numChildren - 1);
               }
            }
            else if(_lockIcon)
            {
               _lockIcon.visible = false;
            }
            BeadModel.isBeadCellIsBind = itemInfo.IsBinds;
         }
         else
         {
            if(_lockIcon)
            {
               _lockIcon.visible = false;
            }
            disposeDragBeadPic();
         }
         BeadModel.beadCanUpgrade = param1 == null?false:true;
         dispatchEvent(new BeadEvent("beadCellChanged",-1,param1));
      }
      
      public function set itemInfo(param1:InventoryItemInfo) : void
      {
         BeadModel.upgradeCellInfo = param1;
         _itemInfo = param1;
      }
      
      public function get itemInfo() : InventoryItemInfo
      {
         return _itemInfo;
      }
      
      private function createBeadPic(param1:ItemTemplateInfo) : void
      {
         if(_invenItemInfo.Hole1 > 0)
         {
            _beadPic = ClassUtils.CreatInstance("beadSystem.beadMC" + beadSystemManager.Instance.getBeadMcIndex(this.itemInfo.Hole1));
            _beadPic.scaleX = 1;
            _beadPic.scaleY = 1;
            _beadPic.x = 2;
            _beadPic.y = 2;
            addChild(_beadPic);
         }
         else
         {
            _beadPic = ComponentFactory.Instance.creat("beadSystem.bead" + beadSystemManager.Instance.getBeadMcIndex(BeadTemplateManager.Instance.GetBeadInfobyID(this.info.TemplateID).BaseLevel));
            _beadPic.scaleX = 1;
            _beadPic.scaleY = 1;
            _beadPic.x = 2;
            _beadPic.y = 2;
            addChild(_beadPic);
         }
      }
      
      private function disposeBeadPic() : void
      {
         if(_beadPic)
         {
            ObjectUtils.disposeObject(_beadPic);
            _beadPic = null;
         }
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
         var _loc3_:* = null;
         var _loc2_:String = getQualifiedClassName(param1.source);
         if(param1.source is BeadAdvanceCell || _loc2_ == "beadSystem.views::BeadAdvanceInfoCell")
         {
            return;
         }
         if(PlayerManager.Instance.Self.bagLocked)
         {
            DragManager.acceptDrag(this);
            BaglockedManager.Instance.show();
            return;
         }
         _loc3_ = param1.data as InventoryItemInfo;
         if(_loc3_.Hole1 == _max)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.mostHightLevel"));
            return;
         }
         if(_loc3_.Hole1 == 1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.lvOneCanntUpgrade"));
         }
         if(_loc3_ && param1.action != "split")
         {
            this._invenItemInfo = _loc3_;
            this._itemInfo = _loc3_;
            this.info = _loc3_;
            SocketManager.Instance.out.sendBeadEquip(_loc3_.Place,31);
         }
         DragManager.acceptDrag(this);
      }
      
      override public function dragStart() : void
      {
         SoundManager.instance.play("008");
         if(_info && !locked && stage && _allowDrag)
         {
            if(DragManager.startDrag(this,_info,createDragImg(),stage.mouseX,stage.mouseY,"move"))
            {
               dragHidePicTxt();
            }
         }
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         super.onMouseOut(param1);
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         if(_upTip)
         {
            _upTip.showTip(info);
         }
         super.onMouseOver(param1);
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
         super.dragStop(param1);
      }
      
      override protected function onMouseClick(param1:MouseEvent) : void
      {
         dispatchEvent(new CellEvent("itemclick",this));
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
      
      public function get invenItemInfo() : InventoryItemInfo
      {
         return _invenItemInfo;
      }
      
      public function set invenItemInfo(param1:InventoryItemInfo) : void
      {
         _invenItemInfo = param1;
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
         if(this.invenItemInfo.IsUsed && _lockIcon)
         {
            _lockIcon.visible = true;
         }
      }
      
      override public function dispose() : void
      {
         if(this.info)
         {
            SocketManager.Instance.out.sendBeadEquip(31,-1);
         }
         if(_beadPic)
         {
            disposeBeadPic();
         }
         if(_dragBeadPic)
         {
            disposeDragBeadPic();
         }
         if(_shiner)
         {
            ObjectUtils.disposeObject(_shiner);
         }
         _shiner = null;
         if(_upgradeMC)
         {
            ObjectUtils.disposeObject(_upgradeMC);
         }
         _upgradeMC = null;
         beadSystemManager.Instance.removeEventListener("playUpgradeMC",__startPlay);
         super.dispose();
      }
   }
}
