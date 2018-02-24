package bagAndInfo.cell
{
   import beadSystem.beadSystemManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CellEvent;
   import ddt.interfaces.ICell;
   import ddt.interfaces.IDragable;
   import ddt.manager.BeadTemplateManager;
   import ddt.manager.DragManager;
   import ddt.manager.ServerConfigManager;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.GoodTipInfo;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import magicStone.MagicStoneManager;
   import mark.data.MarkChipData;
   import mark.data.MarkModel;
   
   [Event(name="change",type="flash.events.Event")]
   public class BaseCell extends Sprite implements ICell, ITipedDisplay, Disposeable
   {
       
      
      protected var _bg:DisplayObject;
      
      protected var _contentHeight:Number;
      
      protected var _contentWidth:Number;
      
      protected var _info:ItemTemplateInfo;
      
      protected var _loadingasset:MovieClip;
      
      protected var _pic:CellContentCreator;
      
      protected var _effect:CellMCSpecialEffectCreator;
      
      protected var _picPos:Point;
      
      protected var _showLoading:Boolean;
      
      protected var _showTip:Boolean;
      
      protected var _smallPic:Sprite;
      
      protected var _tipData:Object;
      
      protected var _tipDirection:String;
      
      protected var _tipGapH:int;
      
      protected var _tipGapV:int;
      
      protected var _tipStyle:String;
      
      protected var _allowDrag:Boolean;
      
      private var _overBg:DisplayObject;
      
      protected var _locked:Boolean;
      
      private var _grayFlag:Boolean;
      
      protected var _markStarContainer:HBox;
      
      protected var _markChip:MarkChipData;
      
      public var showStarContainer:Boolean = true;
      
      public function BaseCell(param1:DisplayObject, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:Boolean = true)
      {
         super();
         _bg = param1;
         _showLoading = param3;
         _showTip = param4;
         init();
         initTip();
         initEvent();
         info = param2;
      }
      
      public function set overBg(param1:DisplayObject) : void
      {
         ObjectUtils.disposeObject(_overBg);
         _overBg = param1;
         if(_overBg)
         {
            _overBg.visible = false;
            addChildAt(_overBg,1);
         }
      }
      
      public function get overBg() : DisplayObject
      {
         return _overBg;
      }
      
      public function set PicPos(param1:Point) : void
      {
         _picPos = param1;
         updateSize(_pic);
      }
      
      public function get allowDrag() : Boolean
      {
         return _allowDrag;
      }
      
      public function set allowDrag(param1:Boolean) : void
      {
         _allowDrag = param1;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_markStarContainer)
         {
            _markStarContainer.clearAllChild();
            ObjectUtils.disposeObject(_markStarContainer);
         }
         _markStarContainer = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         clearLoading();
         clearCreatingContent();
         _info = null;
         ShowTipManager.Instance.removeTip(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function dragDrop(param1:DragEffect) : void
      {
      }
      
      public function dragStart() : void
      {
         if(_info && !locked && stage && _allowDrag)
         {
            if(DragManager.startDrag(this,_info,createDragImg(),stage.mouseX,stage.mouseY,"move"))
            {
               locked = true;
            }
         }
      }
      
      public function dragStop(param1:DragEffect) : void
      {
         if(param1.action == "none")
         {
            locked = false;
         }
      }
      
      public function get editLayer() : int
      {
         return _pic.editLayer;
      }
      
      public function getContent() : Sprite
      {
         return _pic;
      }
      
      public function getSmallContent() : Sprite
      {
         var _loc1_:int = 40;
         _pic.height = _loc1_;
         _pic.width = _loc1_;
         return _pic;
      }
      
      public function getSource() : IDragable
      {
         return this;
      }
      
      public function set grayFilters(param1:Boolean) : void
      {
         _grayFlag = param1;
         if(param1)
         {
            filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
         else
         {
            filters = null;
         }
      }
      
      public function get grayFlag() : Boolean
      {
         return _grayFlag;
      }
      
      override public function get height() : Number
      {
         return _bg.height + _bg.y * 2;
      }
      
      public function get info() : ItemTemplateInfo
      {
         if(_info == null)
         {
            return null;
         }
         return _info;
      }
      
      public function set info(param1:ItemTemplateInfo) : void
      {
         if(_info == param1 && !_info)
         {
            return;
         }
         if(_info)
         {
            clearCreatingContent();
            ObjectUtils.disposeObject(_pic);
            _pic = null;
            ObjectUtils.disposeObject(_effect);
            _effect = null;
            clearLoading();
            _tipData = null;
            locked = false;
            if(_markStarContainer)
            {
               _markStarContainer.clearAllChild();
               ObjectUtils.disposeObject(_markStarContainer);
            }
            _markStarContainer = null;
         }
         _info = param1;
         if(_info && _info.CategoryID == 74)
         {
            tipStyle = "mark.MarkChipTip";
            tipDirctions = "7,6,2,1,5,4,0,3,6";
         }
         if(_info)
         {
            if(_showLoading)
            {
               createLoading();
            }
            _pic = new CellContentCreator();
            _pic.info = _info;
            _pic.loadSync(createContentComplete);
            addChild(_pic);
            if((int(_info.Property1) == 9 || int(_info.Property1) == 10) && ((_info.CategoryID == 8 || _info.CategoryID == 9) && isNotWeddingRing(_info)))
            {
               _effect = new CellMCSpecialEffectCreator();
               _effect.info = _info;
               _effect.loadSync(createEffectComplete);
               addChild(_effect);
            }
            setDefaultTipData();
         }
         dispatchEvent(new Event("change"));
      }
      
      public function resetLoadIcon() : void
      {
         clearCreatingContent();
         _pic = new CellContentCreator();
         _pic.info = _info;
         _pic.loadSync(createContentComplete);
         addChild(_pic);
      }
      
      protected function setDefaultTipData() : void
      {
         var _loc1_:* = null;
         if(EquipType.isCardBox(_info))
         {
            tipStyle = "core.CardBoxTipPanel";
            tipData = _info;
         }
         else if(_info.CategoryID != 26 && _info.CategoryID != 74)
         {
            tipStyle = "core.GoodsTip";
            _tipData = new GoodTipInfo();
            GoodTipInfo(_tipData).itemInfo = _info;
            _loc1_ = _info as InventoryItemInfo;
            if(_info.Property1 == "31")
            {
               if(_loc1_ && _loc1_.Hole2 > 0)
               {
                  GoodTipInfo(_tipData).exp = _loc1_.Hole2;
                  GoodTipInfo(_tipData).upExp = ServerConfigManager.instance.getBeadUpgradeExp()[_loc1_.Hole1 + 1];
                  GoodTipInfo(_tipData).beadName = _loc1_.Name + "-" + beadSystemManager.Instance.getBeadName(_loc1_);
               }
               else
               {
                  GoodTipInfo(_tipData).exp = ServerConfigManager.instance.getBeadUpgradeExp()[BeadTemplateManager.Instance.GetBeadInfobyID(info.TemplateID).BaseLevel];
                  GoodTipInfo(_tipData).upExp = ServerConfigManager.instance.getBeadUpgradeExp()[BeadTemplateManager.Instance.GetBeadInfobyID(info.TemplateID).BaseLevel + 1];
                  GoodTipInfo(_tipData).beadName = _info.Name + "-" + BeadTemplateManager.Instance.GetBeadInfobyID(_info.TemplateID).Name + "Lv" + BeadTemplateManager.Instance.GetBeadInfobyID(info.TemplateID).BaseLevel;
               }
            }
            else if(info.Property1 == "81")
            {
               if(_loc1_ && _loc1_.StrengthenExp > 0)
               {
                  GoodTipInfo(_tipData).exp = _loc1_.StrengthenExp - MagicStoneManager.instance.getNeedExp(info.TemplateID,_loc1_.StrengthenLevel);
               }
               else
               {
                  GoodTipInfo(_tipData).exp = 0;
               }
               GoodTipInfo(_tipData).upExp = MagicStoneManager.instance.getNeedExpPerLevel(info.TemplateID,info.Level + 1);
               GoodTipInfo(_tipData).beadName = info.Name + "Lv" + info.Level;
            }
         }
         else if(_info.CategoryID == 74 && _info is InventoryItemInfo)
         {
            _tipData = new MarkChipData();
            _tipData = MarkModel.exchangeMark(_info);
            updateCellStar();
         }
      }
      
      private function isNotWeddingRing(param1:ItemTemplateInfo) : Boolean
      {
         var _loc2_:* = param1.TemplateID;
         if(9022 !== _loc2_)
         {
            if(9122 !== _loc2_)
            {
               if(9222 !== _loc2_)
               {
                  if(9322 !== _loc2_)
                  {
                     if(9422 !== _loc2_)
                     {
                        if(9522 !== _loc2_)
                        {
                           return true;
                        }
                     }
                     addr11:
                     return false;
                  }
                  addr10:
                  §§goto(addr11);
               }
               addr9:
               §§goto(addr10);
            }
            addr8:
            §§goto(addr9);
         }
         §§goto(addr8);
      }
      
      public function get locked() : Boolean
      {
         return _locked;
      }
      
      public function set locked(param1:Boolean) : void
      {
         if(_locked == param1)
         {
            return;
         }
         _locked = param1;
         updateLockState();
         if(_info is InventoryItemInfo)
         {
            _info["lock"] = _locked;
         }
         dispatchEvent(new CellEvent("lockChanged"));
      }
      
      public function setColor(param1:*) : Boolean
      {
         return _pic.setColor(param1);
      }
      
      public function setContentSize(param1:Number, param2:Number) : void
      {
         _contentWidth = param1;
         _contentHeight = param2;
         updateSize(_pic);
         if(_effect && _effect.numChildren > 0)
         {
            _effect.getChildAt(0).scaleX = 1.1;
            _effect.getChildAt(0).scaleY = 1.1;
         }
      }
      
      public function get tipData() : Object
      {
         return _tipData;
      }
      
      public function set tipData(param1:Object) : void
      {
         _tipData = param1;
      }
      
      public function get tipDirctions() : String
      {
         return _tipDirection;
      }
      
      public function set tipDirctions(param1:String) : void
      {
         _tipDirection = param1;
      }
      
      public function get tipGapH() : int
      {
         return _tipGapH;
      }
      
      public function set tipGapH(param1:int) : void
      {
         _tipGapH = param1;
      }
      
      public function get tipGapV() : int
      {
         return _tipGapV;
      }
      
      public function set tipGapV(param1:int) : void
      {
         _tipGapV = param1;
      }
      
      public function get tipStyle() : String
      {
         return _tipStyle;
      }
      
      public function set tipStyle(param1:String) : void
      {
         _tipStyle = param1;
      }
      
      override public function get width() : Number
      {
         return _bg.width;
      }
      
      protected function clearCreatingContent() : void
      {
         if(_pic == null)
         {
            return;
         }
         if(_pic.parent)
         {
            _pic.parent.removeChild(_pic);
         }
         _pic.clearLoader();
         _pic.dispose();
         _pic = null;
      }
      
      protected function createChildren() : void
      {
         _contentWidth = _bg.width - 2;
         _contentHeight = _bg.height - 2;
         addChildAt(_bg,0);
         _pic = new CellContentCreator();
      }
      
      protected function createContentComplete() : void
      {
         clearLoading();
         updateSize(_pic);
      }
      
      protected function createEffectComplete() : void
      {
         if(_effect.width > 0)
         {
            updateSize(_effect);
         }
      }
      
      protected function createDragImg() : DisplayObject
      {
         var _loc1_:* = null;
         if(_pic && _pic.width > 0 && _pic.height > 0)
         {
            _loc1_ = new Bitmap(new BitmapData(_pic.width / _pic.scaleX,_pic.height / _pic.scaleY,true,0));
            _loc1_.bitmapData.draw(_pic);
            return _loc1_;
         }
         return null;
      }
      
      protected function createLoading() : void
      {
         if(_loadingasset == null)
         {
            _loadingasset = ComponentFactory.Instance.creat("bagAndInfo.cell.BaseCellLoadingAsset");
         }
         updateSizeII(_loadingasset);
         PositionUtils.setPos(_loadingasset,"ddt.core.baseCell.loadingPos");
         addChild(_loadingasset);
      }
      
      protected function init() : void
      {
         _allowDrag = true;
         if(_showTip)
         {
            ShowTipManager.Instance.addTip(this);
         }
         createChildren();
      }
      
      protected function initTip() : void
      {
         tipDirctions = "7,6,2,1,5,4,0,3,6";
         tipGapV = 10;
         tipGapH = 10;
      }
      
      protected function initEvent() : void
      {
         addEventListener("click",onMouseClick);
         addEventListener("rollOut",onMouseOut);
         addEventListener("mouseOver",onMouseOver);
      }
      
      protected function onMouseClick(param1:MouseEvent) : void
      {
      }
      
      protected function onMouseOut(param1:MouseEvent) : void
      {
         if(_overBg)
         {
            _overBg.visible = false;
         }
      }
      
      protected function onMouseOver(param1:MouseEvent) : void
      {
         if(_overBg)
         {
            _overBg.visible = true;
         }
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("click",onMouseClick);
         removeEventListener("rollOut",onMouseOut);
         removeEventListener("rollOver",onMouseOver);
      }
      
      protected function updateSize(param1:Sprite) : void
      {
         if(param1)
         {
            param1.width = _contentWidth - 2;
            param1.height = _contentHeight - 2;
            if(_picPos != null)
            {
               param1.x = _picPos.x;
            }
            else
            {
               param1.x = Math.abs(param1.width - _contentWidth) / 2;
            }
            if(_picPos != null)
            {
               param1.y = _picPos.y;
            }
            else
            {
               param1.y = Math.abs(param1.height - _contentHeight) / 2;
            }
         }
      }
      
      protected function clearLoading() : void
      {
         if(_loadingasset)
         {
            _loadingasset.stop();
         }
         ObjectUtils.disposeObject(_loadingasset);
         _loadingasset = null;
      }
      
      public function updateCellStar() : void
      {
         var _loc1_:int = 0;
         if(_info && _info.CategoryID == 74)
         {
            if(!_markStarContainer)
            {
               _markStarContainer = ComponentFactory.Instance.creatComponentByStylename("ddtcorei.cell.starHBox");
            }
            addChild(_markStarContainer);
            _loc1_ = 0;
            if(_info is InventoryItemInfo)
            {
               _loc1_ = (_info as InventoryItemInfo).StrengthenLevel;
            }
            if(_tipData is MarkChipData)
            {
               _loc1_ = (_tipData as MarkChipData).bornLv;
            }
            while(_markStarContainer.numChildren > _loc1_)
            {
               ObjectUtils.disposeObject(_markStarContainer.getChildAt(0));
            }
            while(_markStarContainer.numChildren < _loc1_)
            {
               _markStarContainer.addChild(ComponentFactory.Instance.creatBitmap("asset.mark.littleStar"));
            }
            _markStarContainer.x = this.width / 2 - _markStarContainer.realWidth / 2;
            if(!showStarContainer)
            {
               _markStarContainer.visible = false;
            }
         }
         else if(_markStarContainer)
         {
            while(_markStarContainer.numChildren)
            {
               ObjectUtils.disposeObject(_markStarContainer.getChildAt(0));
            }
         }
      }
      
      private function updateLockState() : void
      {
         if(_locked)
         {
            filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
         else
         {
            filters = null;
         }
      }
      
      protected function updateSizeII(param1:Sprite) : void
      {
      }
   }
}
