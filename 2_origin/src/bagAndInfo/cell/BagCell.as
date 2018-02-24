package bagAndInfo.cell
{
   import bagAndInfo.bag.BreakGoodsBtn;
   import bagAndInfo.bag.ContinueGoodsBtn;
   import bagAndInfo.bag.SellGoodsBtn;
   import bagAndInfo.bag.SellGoodsFrame;
   import baglocked.BaglockedManager;
   import baglocked.SetPassEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.cmd.CmdCheckBagLockedPSWNeeds;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CellEvent;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import enchant.EnchantManager;
   import farm.viewx.FarmFieldBlock;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.utils.getQualifiedClassName;
   import magicHouse.MagicHouseModel;
   import petsBag.PetsBagManager;
   import petsBag.view.item.SkillItem;
   import playerDress.components.DressUtils;
   
   public class BagCell extends BaseCell
   {
       
      
      protected var _place:int;
      
      protected var _tbxCount:FilterFrameText;
      
      protected var _bgOverDate:Bitmap;
      
      protected var _cellMouseOverBg:Bitmap;
      
      protected var _cellMouseOverFormer:Bitmap;
      
      private var _mouseOverEffBoolean:Boolean;
      
      protected var _bagType:int;
      
      protected var _isShowIsUsedBitmap:Boolean;
      
      protected var _isUsed:Boolean;
      
      protected var _isUsedBitmap:Bitmap;
      
      protected var _enchantMc:MovieClip;
      
      protected var _enchantMcName:String = "asset.enchant.level";
      
      protected var _enchantMcPosStr:String = "enchant.levelMcPos";
      
      private var placeArr:Array;
      
      protected var temInfo:InventoryItemInfo;
      
      private var _sellFrame:SellGoodsFrame;
      
      private var _markId:int = 0;
      
      public function BagCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:DisplayObject = null, param5:Boolean = true)
      {
         placeArr = [0,1,2];
         _mouseOverEffBoolean = param5;
         super(!!param4?param4:ComponentFactory.Instance.creatBitmap("bagAndInfo.cell.bagCellBgAsset"),param2,param3);
         _place = param1;
      }
      
      public function setBgVisible(param1:Boolean) : void
      {
         _bg.visible = param1;
      }
      
      public function set mouseOverEffBoolean(param1:Boolean) : void
      {
         _mouseOverEffBoolean = param1;
      }
      
      public function get bagType() : int
      {
         return _bagType;
      }
      
      public function set bagType(param1:int) : void
      {
         _bagType = param1;
      }
      
      public function get isShowIsUsedBitmap() : Boolean
      {
         return _isShowIsUsedBitmap;
      }
      
      public function set isShowIsUsedBitmap(param1:*) : void
      {
         _isShowIsUsedBitmap = param1;
         if(param1 && _isShowIsUsedBitmap && isUsed)
         {
            addIsUsedBitmap();
         }
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         locked = false;
         _bgOverDate = ComponentFactory.Instance.creatBitmap("bagAndInfo.cell.overDateBgAsset");
         if(_mouseOverEffBoolean == true)
         {
            _cellMouseOverBg = ComponentFactory.Instance.creatBitmap("bagAndInfo.cell.bagCellOverBgAsset");
            _cellMouseOverFormer = ComponentFactory.Instance.creatBitmap("bagAndInfo.cell.bagCellOverShareBG");
            addChild(_cellMouseOverBg);
            addChild(_cellMouseOverFormer);
         }
         addChild(_bgOverDate);
         _tbxCount = ComponentFactory.Instance.creatComponentByStylename("BagCellCountText");
         _tbxCount.mouseEnabled = false;
         addChild(_tbxCount);
         updateCount();
         checkOverDate();
         updateBgVisible(false);
      }
      
      public function set isUsed(param1:Boolean) : void
      {
         _isUsed = param1;
      }
      
      public function get isUsed() : Boolean
      {
         return _isUsed;
      }
      
      protected function addIsUsedBitmap() : void
      {
         _isUsedBitmap = ComponentFactory.Instance.creat("asset.store.isUsedBitmap");
         _isUsedBitmap.x = 22;
         _isUsedBitmap.y = 1;
         addChild(_isUsedBitmap);
      }
      
      protected function addEnchantMc() : void
      {
         var _loc1_:int = itemInfo.MagicLevel >= EnchantManager.instance.infoVec.length?int(itemInfo.MagicLevel / 10):int(itemInfo.MagicLevel / 10) + 1;
         _enchantMc = ComponentFactory.Instance.creat(_enchantMcName + _loc1_);
         PositionUtils.setPos(_enchantMc,_enchantMcPosStr);
         addChild(_enchantMc);
      }
      
      override public function set info(param1:ItemTemplateInfo) : void
      {
         .super.info = param1;
         if(itemInfo && itemInfo.CategoryID != 73)
         {
            isUsed = itemInfo.BagType == 0 && (itemInfo.Place < 17 || itemInfo.Place == 18);
         }
         if(bagType == 43)
         {
            isUsed = (itemInfo.ItemID == PlayerManager.Instance.curcentId && itemInfo.getRemainDate()) > 0?true:false;
         }
         if(param1 && _isShowIsUsedBitmap && isUsed)
         {
            addIsUsedBitmap();
         }
         else if(!param1)
         {
            if(_isUsedBitmap)
            {
               ObjectUtils.disposeObject(_isUsedBitmap);
            }
            _isUsedBitmap = null;
         }
         deleteEnchantMc();
         if(itemInfo && itemInfo.isCanEnchant() && itemInfo.MagicLevel > 0)
         {
            addEnchantMc();
         }
         updateCount();
         checkOverDate();
      }
      
      public function deleteEnchantMc() : void
      {
         if(_enchantMc)
         {
            _enchantMc.stop();
            _enchantMc.parent.removeChild(_enchantMc);
            _enchantMc = null;
         }
      }
      
      override protected function onMouseClick(param1:MouseEvent) : void
      {
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         super.onMouseOut(param1);
         updateBgVisible(false);
      }
      
      public function onParentMouseOver(param1:Bitmap) : void
      {
         if(!_cellMouseOverBg)
         {
            _cellMouseOverBg = param1;
            addChild(_cellMouseOverBg);
            super.setChildIndex(_cellMouseOverBg,1);
            updateBgVisible(true);
         }
      }
      
      public function onParentMouseOut() : void
      {
         if(_cellMouseOverBg)
         {
            updateBgVisible(false);
            _cellMouseOverBg = null;
         }
      }
      
      protected function updateBgVisible(param1:Boolean) : void
      {
         if(_cellMouseOverBg)
         {
            _cellMouseOverBg.visible = param1;
            _cellMouseOverFormer.visible = param1;
            setChildIndex(_cellMouseOverFormer,numChildren - 1);
         }
      }
      
      override public function dragDrop(param1:DragEffect) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         if(param1.source is SkillItem)
         {
            return;
         }
         if(param1.source)
         {
            _loc3_ = getQualifiedClassName(param1.source);
            if(_loc3_ == "petsBag.petsAdvanced::PetsAwakenEquipCell")
            {
               return;
            }
         }
         if(new CmdCheckBagLockedPSWNeeds().excute(0) == true)
         {
            param1.action = "none";
            super.dragStop(param1);
            return;
         }
         if(param1.data is InventoryItemInfo)
         {
            _loc4_ = param1.data as InventoryItemInfo;
            if(locked)
            {
               if(_loc4_ == this.info)
               {
                  this.locked = false;
                  DragManager.acceptDrag(this);
               }
               else
               {
                  DragManager.acceptDrag(this,"none");
               }
            }
            else
            {
               if(_bagType == 11 || _loc4_.BagType == 11)
               {
                  if(param1.action == "split")
                  {
                     param1.action = "none";
                  }
                  else if(_bagType != 11)
                  {
                     if(DressUtils.isDress(_loc4_))
                     {
                        SocketManager.Instance.out.sendMoveGoods(11,_loc4_.Place,0,-1,1);
                     }
                     else
                     {
                        SocketManager.Instance.out.sendMoveGoods(11,_loc4_.Place,_bagType,place,_loc4_.Count);
                     }
                     param1.action = "none";
                  }
                  else if(_bagType == _loc4_.BagType)
                  {
                     if(place >= PlayerManager.Instance.Self.consortiaInfo.StoreLevel * 10)
                     {
                        param1.action = "none";
                     }
                     else
                     {
                        SocketManager.Instance.out.sendMoveGoods(_loc4_.BagType,_loc4_.Place,_loc4_.BagType,place,_loc4_.Count);
                     }
                  }
                  else if(PlayerManager.Instance.Self.consortiaInfo.StoreLevel < 1)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.club.ConsortiaClubView.cellDoubleClick"));
                     param1.action = "none";
                  }
                  else
                  {
                     if(_loc4_.BagType == 21 || _loc4_.BagType == 41)
                     {
                        MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortionBank.goodsNotDrag"));
                     }
                     else
                     {
                        SocketManager.Instance.out.sendMoveGoods(_loc4_.BagType,_loc4_.Place,_bagType,place,_loc4_.Count);
                     }
                     param1.action = "none";
                  }
               }
               else if(_bagType == 51 || _loc4_.BagType == 51)
               {
                  if(param1.action == "split")
                  {
                     param1.action = "none";
                  }
                  else if(_bagType != 51)
                  {
                     if(DressUtils.isDress(_loc4_))
                     {
                        SocketManager.Instance.out.sendMoveGoods(51,_loc4_.Place,0,-1,1);
                     }
                     else
                     {
                        SocketManager.Instance.out.sendMoveGoods(51,_loc4_.Place,_bagType,place,_loc4_.Count);
                     }
                     param1.action = "none";
                  }
                  else if(_bagType == _loc4_.BagType)
                  {
                     if(place >= MagicHouseModel.instance.depotCount)
                     {
                        param1.action = "none";
                     }
                     else
                     {
                        SocketManager.Instance.out.sendMoveGoods(_loc4_.BagType,_loc4_.Place,_loc4_.BagType,place,_loc4_.Count);
                     }
                  }
                  else
                  {
                     SocketManager.Instance.out.sendMoveGoods(_loc4_.BagType,_loc4_.Place,_bagType,place,_loc4_.Count);
                     param1.action = "none";
                  }
               }
               else if(_loc4_.BagType == _bagType)
               {
                  if(!itemInfo)
                  {
                     if(_loc4_.isMoveSpace)
                     {
                        if(!PetsBagManager.instance().petModel.currentPetInfo)
                        {
                           SocketManager.Instance.out.sendMoveGoods(_loc4_.BagType,_loc4_.Place,_loc4_.BagType,place,_loc4_.Count);
                           param1.action = "none";
                           return;
                        }
                        if(_loc4_.CategoryID == 50 && int(_loc4_.Property2) <= PetsBagManager.instance().petModel.currentPetInfo.Level && _loc4_.Place == 0)
                        {
                           SocketManager.Instance.out.delPetEquip(PetsBagManager.instance().petModel.currentPetInfo.Place,0);
                           PetsBagManager.instance().isEquip = false;
                        }
                        else if(_loc4_.CategoryID == 51 && int(_loc4_.Property2) <= PetsBagManager.instance().petModel.currentPetInfo.Level && _loc4_.Place == 1)
                        {
                           SocketManager.Instance.out.delPetEquip(PetsBagManager.instance().petModel.currentPetInfo.Place,1);
                           PetsBagManager.instance().isEquip = false;
                        }
                        else if(_loc4_.CategoryID == 52 && int(_loc4_.Property2) <= PetsBagManager.instance().petModel.currentPetInfo.Level && _loc4_.Place == 2)
                        {
                           SocketManager.Instance.out.delPetEquip(PetsBagManager.instance().petModel.currentPetInfo.Place,2);
                           PetsBagManager.instance().isEquip = false;
                        }
                        else
                        {
                           SocketManager.Instance.out.sendMoveGoods(_loc4_.BagType,_loc4_.Place,_loc4_.BagType,place,_loc4_.Count);
                        }
                     }
                     param1.action = "none";
                     return;
                  }
                  if(_loc4_.CategoryID == itemInfo.CategoryID && _loc4_.Place <= 30 && (_loc4_.BindType == 1 || _loc4_.BindType == 2 || _loc4_.BindType == 3) && itemInfo.IsBinds == false && EquipType.canEquip(_loc4_))
                  {
                     _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.bagII.BagIIView.BindsInfo"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
                     _loc2_.addEventListener("response",__onCellResponse);
                     temInfo = _loc4_;
                  }
                  else if(EquipType.isHealStone(_loc4_))
                  {
                     if(PlayerManager.Instance.Self.Grade >= int(_loc4_.Property1))
                     {
                        SocketManager.Instance.out.sendMoveGoods(_loc4_.BagType,_loc4_.Place,_loc4_.BagType,place,_loc4_.Count);
                        param1.action = "none";
                     }
                     else if(PlayerManager.Instance.Self.Grade < int(_loc4_.Property1) && _loc4_.Place > 30)
                     {
                        SocketManager.Instance.out.sendMoveGoods(_loc4_.BagType,_loc4_.Place,_loc4_.BagType,place,_loc4_.Count);
                        param1.action = "none";
                     }
                     else if(param1.action == "move")
                     {
                        if(param1.source is BagCell)
                        {
                           BagCell(param1.source).locked = false;
                        }
                     }
                     else
                     {
                        MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.HealStone.ErrorGrade",_loc4_.Property1));
                     }
                  }
                  else
                  {
                     if(!PetsBagManager.instance().petModel.currentPetInfo)
                     {
                        SocketManager.Instance.out.sendMoveGoods(_loc4_.BagType,_loc4_.Place,_loc4_.BagType,place,_loc4_.Count);
                        param1.action = "none";
                        return;
                     }
                     if(PetsBagManager.instance().isEquip)
                     {
                        PetsBagManager.instance().isEquip = false;
                        param1.action = "none";
                        DragManager.acceptDrag(this);
                        return;
                     }
                     if(_loc4_.CategoryID == 50 && int(_loc4_.Property2) <= PetsBagManager.instance().petModel.currentPetInfo.Level && _loc4_.Place == 0)
                     {
                        SocketManager.Instance.out.delPetEquip(PetsBagManager.instance().petModel.currentPetInfo.Place,0);
                     }
                     else if(_loc4_.CategoryID == 51 && int(_loc4_.Property2) <= PetsBagManager.instance().petModel.currentPetInfo.Level && _loc4_.Place == 1)
                     {
                        SocketManager.Instance.out.delPetEquip(PetsBagManager.instance().petModel.currentPetInfo.Place,1);
                     }
                     else if(_loc4_.CategoryID == 52 && int(_loc4_.Property2) <= PetsBagManager.instance().petModel.currentPetInfo.Level && _loc4_.Place == 2)
                     {
                        SocketManager.Instance.out.delPetEquip(PetsBagManager.instance().petModel.currentPetInfo.Place,2);
                     }
                     else
                     {
                        SocketManager.Instance.out.sendMoveGoods(_loc4_.BagType,_loc4_.Place,_loc4_.BagType,place,_loc4_.Count);
                     }
                     if(!isPetBagCellMove(param1.source as BagCell,this))
                     {
                        param1.action = "none";
                     }
                  }
               }
               else if(_loc4_.BagType == 12)
               {
                  if(_loc4_.CategoryID == 20 || _loc4_.CategoryID == 53 || _loc4_.CategoryID == 34)
                  {
                     SocketManager.Instance.out.sendMoveGoods(_loc4_.BagType,_loc4_.Place,_bagType,place,_loc4_.Count);
                  }
                  param1.action = "none";
               }
               else
               {
                  param1.action = "none";
               }
               DragManager.acceptDrag(this);
            }
         }
         else if(param1.data is SellGoodsBtn)
         {
            if(!locked && _info && this._bagType != 11 && this._bagType != 511)
            {
               locked = true;
               DragManager.acceptDrag(this);
            }
         }
         else if(param1.data is ContinueGoodsBtn)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            if(!locked && _info && this._bagType != 11 && this._bagType != 511)
            {
               locked = true;
               DragManager.acceptDrag(this,"none");
            }
         }
         else if(param1.data is BreakGoodsBtn)
         {
            if(!locked && _info)
            {
               DragManager.acceptDrag(this);
            }
         }
      }
      
      private function isPetBagCellMove(param1:BagCell, param2:BagCell) : Boolean
      {
         var _loc3_:InventoryItemInfo = param2.info as InventoryItemInfo;
         var _loc4_:InventoryItemInfo = param1.info as InventoryItemInfo;
         if(placeArr.indexOf(_loc3_.Place) != -1 && placeArr.indexOf(_loc4_.Place) == -1)
         {
            return false;
         }
         return true;
      }
      
      private function sendDefy() : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.canEquip(temInfo))
         {
            SocketManager.Instance.out.sendMoveGoods(temInfo.BagType,temInfo.Place,temInfo.BagType,place,temInfo.Count);
         }
      }
      
      override public function dragStart() : void
      {
         super.dragStart();
         if(_info && _pic.numChildren > 0)
         {
            dispatchEvent(new CellEvent("dragStart",this.info,true));
         }
      }
      
      override public function dragStop(param1:DragEffect) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         SoundManager.instance.play("008");
         dispatchEvent(new CellEvent("dragStop",null,true));
         var _loc4_:ItemTemplateInfo = param1.data as ItemTemplateInfo;
         if(param1.action == "none" && param1.target != null)
         {
            if(_loc4_.CategoryID == 50 || _loc4_.CategoryID == 51 || _loc4_.CategoryID == 52)
            {
               if(param1.target is BagCell)
               {
                  _loc3_ = param1.target as BagCell;
                  if(_loc4_.CategoryID == _loc3_.info.CategoryID)
                  {
                     if(placeArr.indexOf((_loc4_ as InventoryItemInfo).Place) != -1)
                     {
                        _loc2_ = _loc3_.itemInfo.Place;
                     }
                     else
                     {
                        _loc2_ = (_loc4_ as InventoryItemInfo).Place;
                     }
                     SocketManager.Instance.out.addPetEquip(_loc2_,PetsBagManager.instance().petModel.currentPetInfo.Place,0);
                  }
               }
               else if((_loc4_ as InventoryItemInfo).getRemainDate() > 0)
               {
                  SocketManager.Instance.out.addPetEquip((_loc4_ as InventoryItemInfo).Place,PetsBagManager.instance().petModel.currentPetInfo.Place,0);
               }
            }
         }
         if(param1.action == "move" && param1.target != null)
         {
            if(_loc4_.CategoryID == 50 || _loc4_.CategoryID == 51 || _loc4_.CategoryID == 52)
            {
               param1.action = "none";
               super.dragStop(param1);
            }
            return;
         }
         if(param1.action == "move" && param1.target == null)
         {
            if(_loc4_.CategoryID == 50 || _loc4_.CategoryID == 51 || _loc4_.CategoryID == 52)
            {
               param1.action = "none";
               super.dragStop(param1);
            }
            else if(_loc4_ && (_loc4_ as InventoryItemInfo).BagType == 11)
            {
               param1.action = "none";
               super.dragStop(param1);
            }
            else if(_loc4_ && (_loc4_ as InventoryItemInfo).BagType == 12)
            {
               locked = false;
            }
            else if(_loc4_ && (_loc4_ as InventoryItemInfo).BagType == 21)
            {
               locked = false;
            }
            else if(_loc4_ && _loc4_.CategoryID == 74)
            {
               locked = false;
            }
            else if(_loc4_.CategoryID == 34)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.bagAndInfo.sell.CanNotSell"));
               param1.action = "none";
               super.dragStop(param1);
            }
            else
            {
               locked = false;
               sellItem(_loc4_ as InventoryItemInfo);
            }
         }
         else if(param1.action == "split" && param1.target == null)
         {
            locked = false;
         }
         else if(param1.target is FarmFieldBlock)
         {
            locked = false;
            if(_loc4_.Property1 != "31")
            {
               sellItem();
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.beadCanntDestory"));
            }
         }
         else
         {
            super.dragStop(param1);
         }
      }
      
      public function dragCountStart(param1:int) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(_info && !locked && stage && param1 != 0)
         {
            _loc3_ = itemInfo;
            _loc2_ = "move";
            if(param1 != itemInfo.Count)
            {
               _loc3_ = new InventoryItemInfo();
               _loc3_.ItemID = itemInfo.ItemID;
               _loc3_.BagType = itemInfo.BagType;
               _loc3_.Place = itemInfo.Place;
               _loc3_.IsBinds = itemInfo.IsBinds;
               _loc3_.BeginDate = itemInfo.BeginDate;
               _loc3_.ValidDate = itemInfo.ValidDate;
               _loc3_.Count = param1;
               _loc3_.NeedSex = itemInfo.NeedSex;
               _loc2_ = "split";
            }
            if(DragManager.startDrag(this,_loc3_,createDragImg(),stage.mouseX,stage.mouseY,_loc2_))
            {
               locked = true;
            }
         }
      }
      
      public function sellItem(param1:InventoryItemInfo = null) : void
      {
         if(EquipType.isValuableEquip(info))
         {
            if(PlayerManager.Instance.Self.bagPwdState)
            {
               if(PlayerManager.Instance.Self.bagLocked)
               {
                  BaglockedManager.Instance.show();
                  BaglockedManager.Instance.addEventListener("cancelBtn",__cancelBtn);
                  return;
               }
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.SellGoodsBtn.CantSellEquip1"));
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.SellGoodsBtn.CantSellEquip1"));
               return;
            }
         }
         else if(EquipType.isPetSpeciallFood(info))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.bagAndInfo.sell.CanNotSell"));
         }
         else
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            showSellFrame(param1);
         }
      }
      
      private function showSellFrame(param1:InventoryItemInfo) : void
      {
         if(_sellFrame == null)
         {
            _sellFrame = ComponentFactory.Instance.creatComponentByStylename("sellGoodsFrame");
            _sellFrame.itemInfo = param1;
            _sellFrame.addEventListener("cancel",disposeSellFrame);
            _sellFrame.addEventListener("ok",disposeSellFrame);
         }
         LayerManager.Instance.addToLayer(_sellFrame,2,true,1);
      }
      
      private function disposeSellFrame(param1:Event) : void
      {
         if(_sellFrame)
         {
            _sellFrame.dispose();
            _sellFrame.removeEventListener("cancel",disposeSellFrame);
            _sellFrame.removeEventListener("ok",disposeSellFrame);
         }
         _sellFrame = null;
      }
      
      protected function __onCellResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.target as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onCellResponse);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            if(EquipType.isHealStone(info))
            {
               if(PlayerManager.Instance.Self.Grade >= int(info.Property1))
               {
                  sendDefy();
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.HealStone.ErrorGrade",info.Property1));
               }
            }
            else
            {
               sendDefy();
            }
         }
      }
      
      private function getAlertInfo() : AlertInfo
      {
         var _loc1_:AlertInfo = new AlertInfo();
         _loc1_.autoDispose = true;
         var _loc2_:Boolean = true;
         _loc1_.showSubmit = _loc2_;
         _loc1_.showCancel = _loc2_;
         _loc1_.enterEnable = true;
         _loc1_.escEnable = true;
         _loc1_.moveEnable = false;
         _loc1_.title = LanguageMgr.GetTranslation("AlertDialog.Info");
         _loc1_.data = LanguageMgr.GetTranslation("tank.view.bagII.SellGoodsBtn.sure").replace("{0}",InventoryItemInfo(_info).Count * _info.ReclaimValue + (_info.ReclaimType == 1?LanguageMgr.GetTranslation("shop.ShopIIShoppingCarItem.gold"):_info.ReclaimType == 2?LanguageMgr.GetTranslation("tank.gameover.takecard.gifttoken"):""));
         return _loc1_;
      }
      
      private function confirmCancel() : void
      {
         locked = false;
      }
      
      public function get place() : int
      {
         return _place;
      }
      
      public function set place(param1:int) : void
      {
         _place = param1;
      }
      
      public function get itemInfo() : InventoryItemInfo
      {
         return _info as InventoryItemInfo;
      }
      
      public function replaceBg(param1:Sprite) : void
      {
         _bg = param1;
      }
      
      public function setCount(param1:*) : void
      {
         if(_tbxCount)
         {
            _tbxCount.text = String(param1);
            _tbxCount.visible = true;
            _tbxCount.x = _contentWidth - _tbxCount.width;
            _tbxCount.y = _contentHeight - _tbxCount.height;
            addChild(_tbxCount);
         }
      }
      
      public function getCount() : int
      {
         return int(_tbxCount.text);
      }
      
      public function refreshTbxPos() : void
      {
         _tbxCount.x = _pic.x + _contentWidth - _tbxCount.width - 4;
         _tbxCount.y = _pic.y + _contentHeight - _tbxCount.height - 2;
      }
      
      public function setCountNotVisible() : void
      {
         if(_tbxCount)
         {
            _tbxCount.visible = false;
         }
      }
      
      public function updateCount() : void
      {
         if(_tbxCount)
         {
            if(_info && itemInfo && itemInfo.MaxCount > 1)
            {
               _tbxCount.text = String(itemInfo.Count);
               _tbxCount.visible = true;
               addChild(_tbxCount);
            }
            else
            {
               _tbxCount.visible = false;
            }
         }
      }
      
      public function checkOverDate() : void
      {
         if(_bgOverDate)
         {
            if(itemInfo && itemInfo.getRemainDate() <= 0)
            {
               _bgOverDate.visible = true;
               addChild(_bgOverDate);
               grayPic();
            }
            else
            {
               _bgOverDate.visible = false;
               lightPic();
            }
         }
      }
      
      public function grayPic() : void
      {
         _pic.filters = [new ColorMatrixFilter([0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0])];
      }
      
      public function lightPic() : void
      {
         if(_pic)
         {
            _pic.filters = [];
         }
      }
      
      public function set BGVisible(param1:Boolean) : void
      {
         _bg.visible = param1;
      }
      
      private function __cancelBtn(param1:SetPassEvent) : void
      {
         BaglockedManager.Instance.removeEventListener("cancelBtn",__cancelBtn);
         disposeSellFrame(null);
      }
      
      override public function dispose() : void
      {
         deleteEnchantMc();
         if(_isUsedBitmap)
         {
            ObjectUtils.disposeObject(_isUsedBitmap);
         }
         _isUsedBitmap = null;
         if(_tbxCount)
         {
            ObjectUtils.disposeObject(_tbxCount);
         }
         _tbxCount = null;
         if(_bgOverDate)
         {
            ObjectUtils.disposeObject(_bgOverDate);
         }
         _bgOverDate = null;
         if(_cellMouseOverBg)
         {
            ObjectUtils.disposeObject(_cellMouseOverBg);
         }
         _cellMouseOverBg = null;
         if(_cellMouseOverFormer)
         {
            ObjectUtils.disposeObject(_cellMouseOverFormer);
         }
         _cellMouseOverFormer = null;
         super.dispose();
      }
      
      public function get markId() : int
      {
         return _markId;
      }
      
      public function set markId(param1:int) : void
      {
         _markId = param1;
      }
      
      public function get tbxCount() : FilterFrameText
      {
         return _tbxCount;
      }
   }
}
