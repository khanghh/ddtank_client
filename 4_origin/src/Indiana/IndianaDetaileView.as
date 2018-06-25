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
      
      public function setInfo(info:IndianaShopItemInfo) : void
      {
         var str:* = null;
         var tempinfo:* = null;
         _info = info;
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
            str = _itemInfo.Desc == ""?LanguageMgr.GetTranslation("ddt.fram.helperItem.Text"):_itemInfo.Desc;
            _disValue.setDis(str);
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
               str = LanguageMgr.GetTranslation("shop.ShopIIShoppingCarItem.forever");
            }
            else
            {
               str = _info.Validity.toString();
            }
            _validityValue.setDis(str);
            if(_info.IsBind == 1)
            {
               str = LanguageMgr.GetTranslation("Indiana.banding");
            }
            else
            {
               str = LanguageMgr.GetTranslation("Indiana.notBanding");
            }
            _bangvalu.setDis(str);
            tempinfo = ItemManager.Instance.getTemplateById(_itemInfo.GoodsID);
            setAttribute(tempinfo);
         }
      }
      
      private function clearContain() : void
      {
         var len:int = 0;
         var displayer:* = null;
         if(_vbox)
         {
            _vbox.clearAllChild();
         }
         if(_petskillContain)
         {
            len = _petskillContain.numChildren;
            while(_petskillContain.numChildren > 0)
            {
               displayer = _petskillContain.removeChildAt(0);
               ObjectUtils.disposeObject(displayer);
               displayer = null;
            }
         }
      }
      
      private function setAttribute(value:ItemTemplateInfo) : void
      {
         var attributeItem:* = null;
         var str:* = null;
         if(value)
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
               if(_itemInfo.GoodType == 1 && value.Property7 != "")
               {
                  attributeItem = new AttributeItem();
                  str = LanguageMgr.GetTranslation("damage") + ":" + value.Property7;
                  attributeItem.setDis(str);
                  _vbox.addChild(attributeItem);
               }
               if(value.Attack > 0)
               {
                  attributeItem = new AttributeItem();
                  str = LanguageMgr.GetTranslation("activationPotential.propertyDescTxt1") + ":" + value.Attack;
                  attributeItem.setDis(str);
                  _vbox.addChild(attributeItem);
               }
               if(value.Defence > 0)
               {
                  attributeItem = new AttributeItem();
                  str = LanguageMgr.GetTranslation("activationPotential.propertyDescTxt2") + ":" + value.Defence;
                  attributeItem.setDis(str);
                  _vbox.addChild(attributeItem);
               }
               if(value.Agility > 0)
               {
                  attributeItem = new AttributeItem();
                  str = LanguageMgr.GetTranslation("activationPotential.propertyDescTxt3") + ":" + value.Agility;
                  attributeItem.setDis(str);
                  _vbox.addChild(attributeItem);
               }
               if(value.Luck > 0)
               {
                  attributeItem = new AttributeItem();
                  str = LanguageMgr.GetTranslation("activationPotential.propertyDescTxt4") + ":" + value.Luck;
                  attributeItem.setDis(str);
                  _vbox.addChild(attributeItem);
               }
               attributeItem = new AttributeItem();
               attributeItem.visible = false;
               _vbox.addChild(attributeItem);
            }
         }
         this._scoller.displayObjectViewport.invalidateView();
      }
      
      private function setHorse() : void
      {
         var attributeItem:* = null;
         var i:int = 0;
         var str:* = null;
         var pTxtList:Array = LanguageMgr.GetTranslation("horse.horsePicCherish.peopertyTxt").split(",");
         var pValueList:Array = HorseControl.instance.getHorsePicCherishAddProperty(int(_itemInfo.Remark));
         for(i = 0; i < pTxtList.length; )
         {
            if(int(pValueList[i]) > 0)
            {
               attributeItem = new AttributeItem();
               str = pTxtList[i] + pValueList[i];
               attributeItem.setDis(str);
               _vbox.addChild(attributeItem);
            }
            i++;
         }
         attributeItem = new AttributeItem();
         attributeItem.visible = false;
         _vbox.addChild(attributeItem);
      }
      
      private function setPetSkill() : void
      {
         var petInfo:* = null;
         var i:int = 0;
         var item:* = null;
         var temp:* = null;
         var petId:int = _itemInfo.Remark.split("|")[0];
         var skillIds:Array = _itemInfo.Remark.split("|")[1].split(",");
         var len:int = skillIds.length;
         for(i = 0; i < len; )
         {
            petInfo = PetSkillManager.getSkillByID(skillIds[i]);
            item = new IndianaSkillItem(petInfo,i,false);
            var _loc8_:* = 0.7;
            item.scaleY = _loc8_;
            item.scaleX = _loc8_;
            item.isLock = false;
            item.x = 63 * (i % 4);
            item.y = 63 * (int(i / 4));
            item.McType = 2;
            item.setExclusiveSkillMc();
            _petskillContain.addChild(item);
            i++;
         }
         if(len > 0)
         {
            temp = new AttributeItem();
            temp.visible = false;
            temp.y = 63 * Math.ceil(len / 4);
            _petskillContain.addChild(temp);
         }
      }
      
      private function addBottomItem(contain:DisplayObject) : void
      {
      }
      
      private function getType(type:int) : String
      {
         var str:* = null;
         switch(int(type) - 1)
         {
            case 0:
               str = LanguageMgr.GetTranslation("tank.auctionHouse.view.BrowseLeftMenuView.Weapon");
               break;
            case 1:
               str = LanguageMgr.GetTranslation("Indiana.detaile.pet");
               break;
            case 2:
               str = LanguageMgr.GetTranslation("tank.auctionHouse.view.BrowseLeftMenuView.Prop");
               break;
            case 3:
               str = LanguageMgr.GetTranslation("tank.data.EquipType.wing");
               break;
            case 4:
               str = LanguageMgr.GetTranslation("playerDress.sort1");
               break;
            case 5:
               str = LanguageMgr.GetTranslation("tank.data.EquipType.offhand");
               break;
            case 6:
               str = LanguageMgr.GetTranslation("tank.menu.mounts");
         }
         return str;
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
