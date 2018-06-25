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
      
      public function BagCell(index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null, mouseOverEffBoolean:Boolean = true)
      {
         placeArr = [0,1,2];
         _mouseOverEffBoolean = mouseOverEffBoolean;
         super(!!bg?bg:ComponentFactory.Instance.creatBitmap("bagAndInfo.cell.bagCellBgAsset"),info,showLoading);
         _place = index;
      }
      
      public function setBgVisible(bool:Boolean) : void
      {
         _bg.visible = bool;
      }
      
      public function set mouseOverEffBoolean(boolean:Boolean) : void
      {
         _mouseOverEffBoolean = boolean;
      }
      
      public function get bagType() : int
      {
         return _bagType;
      }
      
      public function set bagType(value:int) : void
      {
         _bagType = value;
      }
      
      public function get isShowIsUsedBitmap() : Boolean
      {
         return _isShowIsUsedBitmap;
      }
      
      public function set isShowIsUsedBitmap(value:*) : void
      {
         _isShowIsUsedBitmap = value;
         if(value && _isShowIsUsedBitmap && isUsed)
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
      
      public function set isUsed(value:Boolean) : void
      {
         _isUsed = value;
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
         var mcLevel:int = itemInfo.MagicLevel >= EnchantManager.instance.infoVec.length?int(itemInfo.MagicLevel / 10):int(itemInfo.MagicLevel / 10) + 1;
         _enchantMc = ComponentFactory.Instance.creat(_enchantMcName + mcLevel);
         PositionUtils.setPos(_enchantMc,_enchantMcPosStr);
         addChild(_enchantMc);
      }
      
      override public function set info(value:ItemTemplateInfo) : void
      {
         .super.info = value;
         if(itemInfo && itemInfo.CategoryID != 73)
         {
            isUsed = itemInfo.BagType == 0 && (itemInfo.Place < 17 || itemInfo.Place == 18);
         }
         if(bagType == 43)
         {
            isUsed = (itemInfo.ItemID == PlayerManager.Instance.curcentId && itemInfo.getRemainDate()) > 0?true:false;
         }
         if(value && _isShowIsUsedBitmap && isUsed)
         {
            addIsUsedBitmap();
         }
         else if(!value)
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
      
      override protected function onMouseClick(evt:MouseEvent) : void
      {
      }
      
      override protected function onMouseOver(evt:MouseEvent) : void
      {
      }
      
      override protected function onMouseOut(evt:MouseEvent) : void
      {
         super.onMouseOut(evt);
         updateBgVisible(false);
      }
      
      public function onParentMouseOver(cellMouseOverBgEff:Bitmap) : void
      {
         if(!_cellMouseOverBg)
         {
            _cellMouseOverBg = cellMouseOverBgEff;
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
      
      protected function updateBgVisible(visible:Boolean) : void
      {
         if(_cellMouseOverBg)
         {
            _cellMouseOverBg.visible = visible;
            _cellMouseOverFormer.visible = visible;
            setChildIndex(_cellMouseOverFormer,numChildren - 1);
         }
      }
      
      override public function dragDrop(effect:DragEffect) : void
      {
         var temStr:* = null;
         var info:* = null;
         var alert:* = null;
         if(effect.source is SkillItem)
         {
            return;
         }
         if(effect.source)
         {
            temStr = getQualifiedClassName(effect.source);
            if(temStr == "petsBag.petsAdvanced::PetsAwakenEquipCell")
            {
               return;
            }
         }
         if(new CmdCheckBagLockedPSWNeeds().excute(0) == true)
         {
            effect.action = "none";
            super.dragStop(effect);
            return;
         }
         if(effect.data is InventoryItemInfo)
         {
            info = effect.data as InventoryItemInfo;
            if(locked)
            {
               if(info == this.info)
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
               if(_bagType == 11 || info.BagType == 11)
               {
                  if(effect.action == "split")
                  {
                     effect.action = "none";
                  }
                  else if(_bagType != 11)
                  {
                     if(DressUtils.isDress(info))
                     {
                        SocketManager.Instance.out.sendMoveGoods(11,info.Place,0,-1,1);
                     }
                     else
                     {
                        SocketManager.Instance.out.sendMoveGoods(11,info.Place,_bagType,place,info.Count);
                     }
                     effect.action = "none";
                  }
                  else if(_bagType == info.BagType)
                  {
                     if(place >= PlayerManager.Instance.Self.consortiaInfo.StoreLevel * 10)
                     {
                        effect.action = "none";
                     }
                     else
                     {
                        SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,info.BagType,place,info.Count);
                     }
                  }
                  else if(PlayerManager.Instance.Self.consortiaInfo.StoreLevel < 1)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.club.ConsortiaClubView.cellDoubleClick"));
                     effect.action = "none";
                  }
                  else
                  {
                     if(info.BagType == 21 || info.BagType == 41)
                     {
                        MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortionBank.goodsNotDrag"));
                     }
                     else
                     {
                        SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,_bagType,place,info.Count);
                     }
                     effect.action = "none";
                  }
               }
               else if(_bagType == 51 || info.BagType == 51)
               {
                  if(effect.action == "split")
                  {
                     effect.action = "none";
                  }
                  else if(_bagType != 51)
                  {
                     if(DressUtils.isDress(info))
                     {
                        SocketManager.Instance.out.sendMoveGoods(51,info.Place,0,-1,1);
                     }
                     else
                     {
                        SocketManager.Instance.out.sendMoveGoods(51,info.Place,_bagType,place,info.Count);
                     }
                     effect.action = "none";
                  }
                  else if(_bagType == info.BagType)
                  {
                     if(place >= MagicHouseModel.instance.depotCount)
                     {
                        effect.action = "none";
                     }
                     else
                     {
                        SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,info.BagType,place,info.Count);
                     }
                  }
                  else
                  {
                     SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,_bagType,place,info.Count);
                     effect.action = "none";
                  }
               }
               else if(info.BagType == _bagType)
               {
                  if(!itemInfo)
                  {
                     if(info.isMoveSpace)
                     {
                        if(!PetsBagManager.instance().petModel.currentPetInfo)
                        {
                           SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,info.BagType,place,info.Count);
                           effect.action = "none";
                           return;
                        }
                        if(info.CategoryID == 50 && int(info.Property2) <= PetsBagManager.instance().petModel.currentPetInfo.Level && info.Place == 0)
                        {
                           SocketManager.Instance.out.delPetEquip(PetsBagManager.instance().petModel.currentPetInfo.Place,0);
                           PetsBagManager.instance().isEquip = false;
                        }
                        else if(info.CategoryID == 51 && int(info.Property2) <= PetsBagManager.instance().petModel.currentPetInfo.Level && info.Place == 1)
                        {
                           SocketManager.Instance.out.delPetEquip(PetsBagManager.instance().petModel.currentPetInfo.Place,1);
                           PetsBagManager.instance().isEquip = false;
                        }
                        else if(info.CategoryID == 52 && int(info.Property2) <= PetsBagManager.instance().petModel.currentPetInfo.Level && info.Place == 2)
                        {
                           SocketManager.Instance.out.delPetEquip(PetsBagManager.instance().petModel.currentPetInfo.Place,2);
                           PetsBagManager.instance().isEquip = false;
                        }
                        else
                        {
                           SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,info.BagType,place,info.Count);
                        }
                     }
                     effect.action = "none";
                     return;
                  }
                  if(info.CategoryID == itemInfo.CategoryID && info.Place <= 30 && (info.BindType == 1 || info.BindType == 2 || info.BindType == 3) && itemInfo.IsBinds == false && EquipType.canEquip(info))
                  {
                     alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.bagII.BagIIView.BindsInfo"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
                     alert.addEventListener("response",__onCellResponse);
                     temInfo = info;
                  }
                  else if(EquipType.isHealStone(info))
                  {
                     if(PlayerManager.Instance.Self.Grade >= int(info.Property1))
                     {
                        SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,info.BagType,place,info.Count);
                        effect.action = "none";
                     }
                     else if(PlayerManager.Instance.Self.Grade < int(info.Property1) && info.Place > 30)
                     {
                        SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,info.BagType,place,info.Count);
                        effect.action = "none";
                     }
                     else if(effect.action == "move")
                     {
                        if(effect.source is BagCell)
                        {
                           BagCell(effect.source).locked = false;
                        }
                     }
                     else
                     {
                        MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.HealStone.ErrorGrade",info.Property1));
                     }
                  }
                  else
                  {
                     if(!PetsBagManager.instance().petModel.currentPetInfo)
                     {
                        SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,info.BagType,place,info.Count);
                        effect.action = "none";
                        return;
                     }
                     if(PetsBagManager.instance().isEquip)
                     {
                        PetsBagManager.instance().isEquip = false;
                        effect.action = "none";
                        DragManager.acceptDrag(this);
                        return;
                     }
                     if(info.CategoryID == 50 && int(info.Property2) <= PetsBagManager.instance().petModel.currentPetInfo.Level && info.Place == 0)
                     {
                        SocketManager.Instance.out.delPetEquip(PetsBagManager.instance().petModel.currentPetInfo.Place,0);
                     }
                     else if(info.CategoryID == 51 && int(info.Property2) <= PetsBagManager.instance().petModel.currentPetInfo.Level && info.Place == 1)
                     {
                        SocketManager.Instance.out.delPetEquip(PetsBagManager.instance().petModel.currentPetInfo.Place,1);
                     }
                     else if(info.CategoryID == 52 && int(info.Property2) <= PetsBagManager.instance().petModel.currentPetInfo.Level && info.Place == 2)
                     {
                        SocketManager.Instance.out.delPetEquip(PetsBagManager.instance().petModel.currentPetInfo.Place,2);
                     }
                     else
                     {
                        SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,info.BagType,place,info.Count);
                     }
                     if(!isPetBagCellMove(effect.source as BagCell,this))
                     {
                        effect.action = "none";
                     }
                  }
               }
               else if(info.BagType == 12)
               {
                  if(info.CategoryID == 20 || info.CategoryID == 53 || info.CategoryID == 34 || info.CategoryID == 78)
                  {
                     SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,_bagType,place,info.Count);
                  }
                  effect.action = "none";
               }
               else
               {
                  effect.action = "none";
               }
               DragManager.acceptDrag(this);
            }
         }
         else if(effect.data is SellGoodsBtn)
         {
            if(!locked && _info && this._bagType != 11 && this._bagType != 511)
            {
               locked = true;
               DragManager.acceptDrag(this);
            }
         }
         else if(effect.data is ContinueGoodsBtn)
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
         else if(effect.data is BreakGoodsBtn)
         {
            if(!locked && _info)
            {
               DragManager.acceptDrag(this);
            }
         }
      }
      
      private function isPetBagCellMove(source:BagCell, target:BagCell) : Boolean
      {
         var targetInfo:InventoryItemInfo = target.info as InventoryItemInfo;
         var sourceInfo:InventoryItemInfo = source.info as InventoryItemInfo;
         if(placeArr.indexOf(targetInfo.Place) != -1 && placeArr.indexOf(sourceInfo.Place) == -1)
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
      
      override public function dragStop(effect:DragEffect) : void
      {
         var equipPlace:int = 0;
         var targetCell:* = null;
         SoundManager.instance.play("008");
         dispatchEvent(new CellEvent("dragStop",null,true));
         var $info:ItemTemplateInfo = effect.data as ItemTemplateInfo;
         if(effect.action == "none" && effect.target != null)
         {
            if($info.CategoryID == 50 || $info.CategoryID == 51 || $info.CategoryID == 52)
            {
               if(effect.target is BagCell)
               {
                  targetCell = effect.target as BagCell;
                  if($info.CategoryID == targetCell.info.CategoryID)
                  {
                     if(placeArr.indexOf(($info as InventoryItemInfo).Place) != -1)
                     {
                        equipPlace = targetCell.itemInfo.Place;
                     }
                     else
                     {
                        equipPlace = ($info as InventoryItemInfo).Place;
                     }
                     SocketManager.Instance.out.addPetEquip(equipPlace,PetsBagManager.instance().petModel.currentPetInfo.Place,0);
                  }
               }
               else if(($info as InventoryItemInfo).getRemainDate() > 0)
               {
                  SocketManager.Instance.out.addPetEquip(($info as InventoryItemInfo).Place,PetsBagManager.instance().petModel.currentPetInfo.Place,0);
               }
            }
         }
         if(effect.action == "move" && effect.target != null)
         {
            if($info.CategoryID == 50 || $info.CategoryID == 51 || $info.CategoryID == 52)
            {
               effect.action = "none";
               super.dragStop(effect);
            }
            return;
         }
         if(effect.action == "move" && effect.target == null)
         {
            if($info.CategoryID == 50 || $info.CategoryID == 51 || $info.CategoryID == 52)
            {
               effect.action = "none";
               super.dragStop(effect);
            }
            else if($info && ($info as InventoryItemInfo).BagType == 11)
            {
               effect.action = "none";
               super.dragStop(effect);
            }
            else if($info && ($info as InventoryItemInfo).BagType == 12)
            {
               locked = false;
            }
            else if($info && ($info as InventoryItemInfo).BagType == 21)
            {
               locked = false;
            }
            else if($info && $info.CategoryID == 74)
            {
               locked = false;
            }
            else if($info.CategoryID == 34)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.bagAndInfo.sell.CanNotSell"));
               effect.action = "none";
               super.dragStop(effect);
            }
            else
            {
               locked = false;
               sellItem($info as InventoryItemInfo);
            }
         }
         else if(effect.action == "split" && effect.target == null)
         {
            locked = false;
         }
         else if(effect.target is FarmFieldBlock)
         {
            locked = false;
            if($info.Property1 != "31")
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
            super.dragStop(effect);
         }
      }
      
      public function dragCountStart(count:int) : void
      {
         var info:* = null;
         var action:* = null;
         if(_info && !locked && stage && count != 0)
         {
            info = itemInfo;
            action = "move";
            if(count != itemInfo.Count)
            {
               info = new InventoryItemInfo();
               info.ItemID = itemInfo.ItemID;
               info.BagType = itemInfo.BagType;
               info.Place = itemInfo.Place;
               info.IsBinds = itemInfo.IsBinds;
               info.BeginDate = itemInfo.BeginDate;
               info.ValidDate = itemInfo.ValidDate;
               info.Count = count;
               info.NeedSex = itemInfo.NeedSex;
               action = "split";
            }
            if(DragManager.startDrag(this,info,createDragImg(),stage.mouseX,stage.mouseY,action))
            {
               locked = true;
            }
         }
      }
      
      public function sellItem($info:InventoryItemInfo = null) : void
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
            showSellFrame($info);
         }
      }
      
      private function showSellFrame($info:InventoryItemInfo) : void
      {
         if(_sellFrame == null)
         {
            _sellFrame = ComponentFactory.Instance.creatComponentByStylename("sellGoodsFrame");
            _sellFrame.itemInfo = $info;
            _sellFrame.addEventListener("cancel",disposeSellFrame);
            _sellFrame.addEventListener("ok",disposeSellFrame);
         }
         LayerManager.Instance.addToLayer(_sellFrame,2,true,1);
      }
      
      private function disposeSellFrame(event:Event) : void
      {
         if(_sellFrame)
         {
            _sellFrame.dispose();
            _sellFrame.removeEventListener("cancel",disposeSellFrame);
            _sellFrame.removeEventListener("ok",disposeSellFrame);
         }
         _sellFrame = null;
      }
      
      protected function __onCellResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = evt.target as BaseAlerFrame;
         alert.removeEventListener("response",__onCellResponse);
         if(evt.responseCode == 2 || evt.responseCode == 3)
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
         var result:AlertInfo = new AlertInfo();
         result.autoDispose = true;
         var _loc2_:Boolean = true;
         result.showSubmit = _loc2_;
         result.showCancel = _loc2_;
         result.enterEnable = true;
         result.escEnable = true;
         result.moveEnable = false;
         result.title = LanguageMgr.GetTranslation("AlertDialog.Info");
         result.data = LanguageMgr.GetTranslation("tank.view.bagII.SellGoodsBtn.sure").replace("{0}",InventoryItemInfo(_info).Count * _info.ReclaimValue + (_info.ReclaimType == 1?LanguageMgr.GetTranslation("shop.ShopIIShoppingCarItem.gold"):_info.ReclaimType == 2?LanguageMgr.GetTranslation("tank.gameover.takecard.gifttoken"):""));
         return result;
      }
      
      private function confirmCancel() : void
      {
         locked = false;
      }
      
      public function get place() : int
      {
         return _place;
      }
      
      public function set place(value:int) : void
      {
         _place = value;
      }
      
      public function get itemInfo() : InventoryItemInfo
      {
         return _info as InventoryItemInfo;
      }
      
      public function replaceBg(bg:Sprite) : void
      {
         _bg = bg;
      }
      
      public function setCount(num:*) : void
      {
         if(_tbxCount)
         {
            _tbxCount.text = String(num);
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
      
      public function set BGVisible(value:Boolean) : void
      {
         _bg.visible = value;
      }
      
      private function __cancelBtn(event:SetPassEvent) : void
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
      
      public function set markId(value:int) : void
      {
         _markId = value;
      }
      
      public function get tbxCount() : FilterFrameText
      {
         return _tbxCount;
      }
   }
}
