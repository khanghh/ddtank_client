package Indiana
{
   import Indiana.analyzer.IndianaGoodsItemInfo;
   import Indiana.analyzer.IndianaShopItemInfo;
   import Indiana.item.AttributeItem;
   import Indiana.item.IndianaSkillItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PetSkillManager;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import horse.HorseControl;
   import pet.data.PetSkillTemplateInfo;
   
   public class IndianaDetaileView extends Sprite implements Disposeable
   {
       
      
      private var _itemName:FilterFrameText;
      
      private var _itemNameValue:AttributeItem;
      
      private var _dis:FilterFrameText;
      
      private var _disValue:AttributeItem;
      
      private var _attribute:FilterFrameText;
      
      private var _info:IndianaShopItemInfo;
      
      private var _itemInfo:IndianaGoodsItemInfo;
      
      private var _vbox:VBox;
      
      private var _scoller:ScrollPanel;
      
      private var _contain:Sprite;
      
      private var _petskillContain:Sprite;
      
      private var _validityTxt:FilterFrameText;
      
      private var _validityValue:AttributeItem;
      
      private var _bangState:FilterFrameText;
      
      private var _bangvalu:AttributeItem;
      
      private var _attributeX:int;
      
      public function IndianaDetaileView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _contain = new Sprite();
         _petskillContain = new Sprite();
         PositionUtils.setPos(_petskillContain,"indiana.detail.skill.pos");
         _itemName = ComponentFactory.Instance.creatComponentByStylename("indiana.detailtitle.Txt");
         _itemName.text = LanguageMgr.GetTranslation("Indiana.shop.item.type");
         _dis = ComponentFactory.Instance.creatComponentByStylename("indiana.detailtitle.Txt");
         _dis.text = LanguageMgr.GetTranslation("consortion.consortionMailFrame.explainText");
         _attribute = ComponentFactory.Instance.creatComponentByStylename("indiana.detailtitle.Txt");
         _validityTxt = ComponentFactory.Instance.creatComponentByStylename("indiana.detailtitle.Txt");
         _validityTxt.text = LanguageMgr.GetTranslation("Indiana.validity.details");
         _bangState = ComponentFactory.Instance.creatComponentByStylename("indiana.detailtitle.Txt");
         _bangState.text = LanguageMgr.GetTranslation("Indiana.bandState");
         _scoller = ComponentFactory.Instance.creatComponentByStylename("indiana.scroll.detailpanel");
         _itemNameValue = new AttributeItem();
         _disValue = new AttributeItem();
         _disValue.setWidth(180);
         _validityValue = new AttributeItem();
         _bangvalu = new AttributeItem();
         PositionUtils.setPos(_itemName,"itemName.pos");
         PositionUtils.setPos(_itemNameValue,"itemNameValue.pos");
         PositionUtils.setPos(_dis,"itemDis.pos");
         PositionUtils.setPos(_disValue,"itemDisValue.pos");
         PositionUtils.setPos(_attribute,"itemattribute.pos");
         PositionUtils.setPos(_validityTxt,"validitytitle.pos");
         PositionUtils.setPos(_bangState,"bandtile.pos");
         PositionUtils.setPos(_validityValue,"validityvalue.pos");
         PositionUtils.setPos(_bangvalu,"bandvalue.pos");
         _attributeX = _attribute.x;
         _vbox = new VBox();
         _vbox.spacing = 2;
         _vbox.x = 166;
         _vbox.y = 120;
         addChild(_scoller);
         _contain.addChild(_itemName);
         _contain.addChild(_itemNameValue);
         _contain.addChild(_dis);
         _contain.addChild(_disValue);
         _contain.addChild(_attribute);
         _contain.addChild(_validityValue);
         _contain.addChild(_bangvalu);
         _contain.addChild(_vbox);
         _contain.addChild(_petskillContain);
         _scoller.setView(_contain);
         _contain.addChild(_validityTxt);
         _contain.addChild(_bangState);
      }
      
      public function setInfo(param1:IndianaShopItemInfo) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         _info = param1;
         if(_info)
         {
            _itemInfo = IndianaDataManager.instance.getIndianaGoodsItemInfoByshopId(_info.ShopId);
            _itemNameValue.setDis(getType(_itemInfo.GoodType));
            if(_itemInfo.GoodType == 2)
            {
               _attribute.text = LanguageMgr.GetTranslation("ddt.pets.petSkill") + ":";
               _attribute.x = 105;
            }
            else
            {
               _attribute.text = LanguageMgr.GetTranslation("beadProp") + ":";
               _attribute.x = _attributeX;
            }
            if(_itemInfo.GoodType == 3)
            {
               _attribute.visible = false;
            }
            else
            {
               _attribute.visible = true;
            }
            _loc3_ = _itemInfo.Desc == ""?LanguageMgr.GetTranslation("ddt.fram.helperItem.Text"):_itemInfo.Desc;
            _disValue.setDis(_loc3_);
            if(_disValue.textField.textWidth > 180)
            {
               _disValue.setWidth(_disValue.textField.textWidth + 10);
            }
            else
            {
               _disValue.setWidth(180);
            }
            if(_info.Validity == 0)
            {
               _loc3_ = LanguageMgr.GetTranslation("shop.ShopIIShoppingCarItem.forever");
            }
            else
            {
               _loc3_ = _info.Validity.toString();
            }
            _validityValue.setDis(_loc3_);
            if(_info.IsBind == 1)
            {
               _loc3_ = LanguageMgr.GetTranslation("Indiana.banding");
            }
            else
            {
               _loc3_ = LanguageMgr.GetTranslation("Indiana.notBanding");
            }
            _bangvalu.setDis(_loc3_);
            _loc2_ = ItemManager.Instance.getTemplateById(_itemInfo.GoodsID);
            setAttribute(_loc2_);
         }
      }
      
      private function clearContain() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         if(_vbox)
         {
            _vbox.clearAllChild();
         }
         if(_petskillContain)
         {
            _loc1_ = _petskillContain.numChildren;
            while(_petskillContain.numChildren > 0)
            {
               _loc2_ = _petskillContain.removeChildAt(0);
               ObjectUtils.disposeObject(_loc2_);
               _loc2_ = null;
            }
         }
      }
      
      private function setAttribute(param1:ItemTemplateInfo) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(param1)
         {
            clearContain();
            if(_itemInfo.GoodType == 2)
            {
               setPetSkill();
            }
            else if(_itemInfo.GoodType == 7)
            {
               setHorse();
            }
            else
            {
               if(_itemInfo.GoodType == 1 && param1.Property7 != "")
               {
                  _loc3_ = new AttributeItem();
                  _loc2_ = LanguageMgr.GetTranslation("damage") + ":" + param1.Property7;
                  _loc3_.setDis(_loc2_);
                  _vbox.addChild(_loc3_);
               }
               if(param1.Attack > 0)
               {
                  _loc3_ = new AttributeItem();
                  _loc2_ = LanguageMgr.GetTranslation("activationPotential.propertyDescTxt1") + ":" + param1.Attack;
                  _loc3_.setDis(_loc2_);
                  _vbox.addChild(_loc3_);
               }
               if(param1.Defence > 0)
               {
                  _loc3_ = new AttributeItem();
                  _loc2_ = LanguageMgr.GetTranslation("activationPotential.propertyDescTxt2") + ":" + param1.Defence;
                  _loc3_.setDis(_loc2_);
                  _vbox.addChild(_loc3_);
               }
               if(param1.Agility > 0)
               {
                  _loc3_ = new AttributeItem();
                  _loc2_ = LanguageMgr.GetTranslation("activationPotential.propertyDescTxt3") + ":" + param1.Agility;
                  _loc3_.setDis(_loc2_);
                  _vbox.addChild(_loc3_);
               }
               if(param1.Luck > 0)
               {
                  _loc3_ = new AttributeItem();
                  _loc2_ = LanguageMgr.GetTranslation("activationPotential.propertyDescTxt4") + ":" + param1.Luck;
                  _loc3_.setDis(_loc2_);
                  _vbox.addChild(_loc3_);
               }
               _loc3_ = new AttributeItem();
               _loc3_.visible = false;
               _vbox.addChild(_loc3_);
            }
         }
         this._scoller.displayObjectViewport.invalidateView();
      }
      
      private function setHorse() : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc1_:Array = LanguageMgr.GetTranslation("horse.horsePicCherish.peopertyTxt").split(",");
         var _loc4_:Array = HorseControl.instance.getHorsePicCherishAddProperty(int(_itemInfo.Remark));
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            if(int(_loc4_[_loc5_]) > 0)
            {
               _loc3_ = new AttributeItem();
               _loc2_ = _loc1_[_loc5_] + _loc4_[_loc5_];
               _loc3_.setDis(_loc2_);
               _vbox.addChild(_loc3_);
            }
            _loc5_++;
         }
         _loc3_ = new AttributeItem();
         _loc3_.visible = false;
         _vbox.addChild(_loc3_);
      }
      
      private function setPetSkill() : void
      {
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:int = _itemInfo.Remark.split("|")[0];
         var _loc1_:Array = _itemInfo.Remark.split("|")[1].split(",");
         var _loc5_:int = _loc1_.length;
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc6_ = PetSkillManager.getSkillByID(_loc1_[_loc7_]);
            _loc3_ = new IndianaSkillItem(_loc6_,_loc7_,false);
            var _loc8_:* = 0.7;
            _loc3_.scaleY = _loc8_;
            _loc3_.scaleX = _loc8_;
            _loc3_.isLock = false;
            _loc3_.x = 63 * (_loc7_ % 4);
            _loc3_.y = 63 * (int(_loc7_ / 4));
            _loc3_.McType = 2;
            _loc3_.setExclusiveSkillMc();
            _petskillContain.addChild(_loc3_);
            _loc7_++;
         }
         if(_loc5_ > 0)
         {
            _loc4_ = new AttributeItem();
            _loc4_.visible = false;
            _loc4_.y = 63 * Math.ceil(_loc5_ / 4);
            _petskillContain.addChild(_loc4_);
         }
      }
      
      private function addBottomItem(param1:DisplayObject) : void
      {
      }
      
      private function getType(param1:int) : String
      {
         var _loc2_:* = null;
         switch(int(param1) - 1)
         {
            case 0:
               _loc2_ = LanguageMgr.GetTranslation("tank.auctionHouse.view.BrowseLeftMenuView.Weapon");
               break;
            case 1:
               _loc2_ = LanguageMgr.GetTranslation("Indiana.detaile.pet");
               break;
            case 2:
               _loc2_ = LanguageMgr.GetTranslation("tank.auctionHouse.view.BrowseLeftMenuView.Prop");
               break;
            case 3:
               _loc2_ = LanguageMgr.GetTranslation("tank.data.EquipType.wing");
               break;
            case 4:
               _loc2_ = LanguageMgr.GetTranslation("playerDress.sort1");
               break;
            case 5:
               _loc2_ = LanguageMgr.GetTranslation("tank.data.EquipType.offhand");
               break;
            case 6:
               _loc2_ = LanguageMgr.GetTranslation("tank.menu.mounts");
         }
         return _loc2_;
      }
      
      public function dispose() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         ObjectUtils.disposeAllChildren(this);
         _itemName = null;
         _itemNameValue = null;
         _dis = null;
         _disValue = null;
         _attribute = null;
         _info = null;
         _itemInfo = null;
         _vbox = null;
      }
   }
}
