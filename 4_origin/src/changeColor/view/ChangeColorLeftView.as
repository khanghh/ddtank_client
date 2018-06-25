package changeColor.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.ChangeColorModel;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.view.ColorEditor;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.ICharacter;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import road7th.utils.StringHelper;
   
   public class ChangeColorLeftView extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _charaterBack:MovieImage;
      
      private var _charaterBack1:MovieImage;
      
      private var _controlBack:MovieImage;
      
      private var _title:DisplayObject;
      
      private var _charater:ICharacter;
      
      private var _hideHat:SelectedCheckButton;
      
      private var _hideGlass:SelectedCheckButton;
      
      private var _hideSuit:SelectedCheckButton;
      
      private var _hideWing:SelectedCheckButton;
      
      private var _cell:ColorEditCell;
      
      private var _cellBg:Scale9CornerImage;
      
      private var _colorEditor:ColorEditor;
      
      private var _model:ChangeColorModel;
      
      private var _checkBg:MovieImage;
      
      private var _itemChanged:Boolean;
      
      public function ChangeColorLeftView()
      {
         super();
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _charaterBack = null;
         _controlBack = null;
         _cell = null;
         _charater = null;
         _colorEditor = null;
         _model = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function set model(value:ChangeColorModel) : void
      {
         _model = value;
         dataUpdate();
      }
      
      public function reset() : void
      {
         if(_model.currentItem == null)
         {
            return;
         }
         restoreItem();
         restoreCharacter();
         _model.changed = false;
         _model.currentItem = null;
      }
      
      public function setCurrentItem(cell:BagCell) : void
      {
         SoundManager.instance.play("008");
         if(_cell.bagCell != null || cell.info == null)
         {
            _model.initColor = null;
            _model.initSkinColor = null;
            if(_cell.bagCell)
            {
               _cell.bagCell.locked = false;
            }
         }
         _cell.bagCell = cell;
         cell.locked = true;
         updateColorPanel();
      }
      
      private function __cellChangedHandler(evt:Event) : void
      {
         if((evt.target as BagCell).info && _model.currentItem == null)
         {
            _model.currentItem = _cell.bagCell.itemInfo;
            savaItemInfo();
            updateCharator();
         }
         else if((evt.target as BagCell).info == null)
         {
            reset();
         }
         updateColorPanel();
      }
      
      private function __hideGalssChange(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _model.self.setGlassHide(_hideGlass.selected);
      }
      
      private function __hideHatChange(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _model.self.setHatHide(_hideHat.selected);
      }
      
      private function __hideSuitChange(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _model.self.setSuiteHide(_hideSuit.selected);
      }
      
      private function __hideWingChange(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _model.self.wingHide = _hideWing.selected;
      }
      
      private function __setColor(evt:Event) : void
      {
         if(_model.currentItem)
         {
            if(_colorEditor.selectedType == 2)
            {
               setItemSkin(_model.currentItem,_colorEditor.selectedSkin.toString());
            }
            else
            {
               setItemColor(_model.currentItem,_colorEditor.selectedColor.toString());
            }
            _model.changed = true;
         }
      }
      
      private function dataUpdate() : void
      {
         initView();
         initEvents();
      }
      
      private function initEvents() : void
      {
         _cell.addEventListener("change",__cellChangedHandler);
         _colorEditor.addEventListener("change",__setColor);
         _colorEditor.addEventListener("reductiveColor",__reductiveColor);
         _hideHat.addEventListener("click",__hideHatChange);
         _hideGlass.addEventListener("click",__hideGalssChange);
         _hideSuit.addEventListener("click",__hideSuitChange);
         _hideWing.addEventListener("click",__hideWingChange);
      }
      
      private function initView() : void
      {
         var rec:* = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("changeColor.rightViewBg");
         addChild(_bg);
         _charaterBack = ComponentFactory.Instance.creatComponentByStylename("changeColor.leftViewBg");
         addChild(_charaterBack);
         _charaterBack1 = ComponentFactory.Instance.creatComponentByStylename("changeColor.leftViewBg2");
         addChild(_charaterBack1);
         _controlBack = ComponentFactory.Instance.creatComponentByStylename("changeColor.leftViewBg1");
         addChild(_controlBack);
         _checkBg = ComponentFactory.Instance.creatComponentByStylename("changeColor.checkBg");
         addChild(_checkBg);
         _title = ComponentFactory.Instance.creatBitmap("asset.changeColor.title");
         addChild(_title);
         rec = ComponentFactory.Instance.creatCustomObject("changeColor.leftViewBgImgRec");
         ObjectUtils.copyPropertyByRectangle(_bg,rec);
         _charater = CharactoryFactory.createCharacter(_model.self);
         rec = ComponentFactory.Instance.creatCustomObject("changeColor.charaterRec");
         ObjectUtils.copyPropertyByRectangle(_charater as DisplayObject,rec);
         _charater.show(false,-1);
         _charater.showGun = false;
         addChild(_charater as DisplayObject);
         _cellBg = ComponentFactory.Instance.creatComponentByStylename("ColorEditCell.Bg");
         addChild(_cellBg);
         var colorCell:Sprite = new Sprite();
         colorCell.graphics.beginFill(0,0);
         colorCell.graphics.drawRect(0,0,90,90);
         colorCell.graphics.endFill();
         _cell = new ColorEditCell(colorCell);
         rec = ComponentFactory.Instance.creatCustomObject("changeColor.colorEditCellRec");
         ObjectUtils.copyPropertyByRectangle(_cell as DisplayObject,rec);
         addChild(_cell);
         _colorEditor = ComponentFactory.Instance.creatCustomObject("changeColor.ColorEdit");
         rec = ComponentFactory.Instance.creatCustomObject("changeColor.colorEditorRec");
         ObjectUtils.copyPropertyByRectangle(_colorEditor as DisplayObject,rec);
         addChild(_colorEditor);
         _hideHat = ComponentFactory.Instance.creatComponentByStylename("personanHideHatCheckBox");
         rec = ComponentFactory.Instance.creatCustomObject("changeColor.hideHatRec");
         ObjectUtils.copyPropertyByRectangle(_hideHat as DisplayObject,rec);
         _hideHat.text = LanguageMgr.GetTranslation("shop.ShopIITryDressView.hideHat");
         _hideHat.selected = _model.self.getHatHide();
         addChild(_hideHat);
         _hideGlass = ComponentFactory.Instance.creatComponentByStylename("personanHideHatCheckBox");
         rec = ComponentFactory.Instance.creatCustomObject("changeColor.hideGlassRec");
         ObjectUtils.copyPropertyByRectangle(_hideGlass as DisplayObject,rec);
         _hideGlass.text = LanguageMgr.GetTranslation("tank.view.changeColor.ChangeColorLeftView.glass");
         _hideGlass.selected = _model.self.getGlassHide();
         addChild(_hideGlass);
         _hideSuit = ComponentFactory.Instance.creatComponentByStylename("personanHideHatCheckBox");
         rec = ComponentFactory.Instance.creatCustomObject("changeColor.hideSuitRec");
         ObjectUtils.copyPropertyByRectangle(_hideSuit as DisplayObject,rec);
         _hideSuit.text = LanguageMgr.GetTranslation("tank.view.changeColor.ChangeColorLeftView.suit");
         _hideSuit.selected = _model.self.getSuitesHide();
         addChild(_hideSuit);
         _hideWing = ComponentFactory.Instance.creatComponentByStylename("personanHideWingCheckBox");
         rec = ComponentFactory.Instance.creatCustomObject("changeColor.hideWingRec");
         ObjectUtils.copyPropertyByRectangle(_hideWing as DisplayObject,rec);
         _hideWing.text = LanguageMgr.GetTranslation("tank.view.changeColor.ChangeColorLeftView.wing");
         _hideWing.selected = _model.self.wingHide;
         addChild(_hideWing);
         updateColorPanel();
      }
      
      private function removeEvents() : void
      {
         _cell.removeEventListener("change",__cellChangedHandler);
         _colorEditor.removeEventListener("change",__setColor);
         _colorEditor.removeEventListener("reductiveColor",__reductiveColor);
      }
      
      private function restoreCharacter() : void
      {
         _model.self.setPartStyle(_model.currentItem.CategoryID,!!_model.self.Sex?1:2,PlayerManager.Instance.Self.getPartStyle(_model.currentItem.CategoryID),PlayerManager.Instance.Self.getPartColor(_model.currentItem.CategoryID),true);
         _model.self.setPartColor(_model.currentItem.CategoryID,PlayerManager.Instance.Self.getPartColor(_model.currentItem.CategoryID));
         _model.self.setSkinColor(PlayerManager.Instance.Self.Skin);
      }
      
      private function restoreItem() : void
      {
         _model.restoreItem();
      }
      
      private function savaItemInfo() : void
      {
         _model.savaItemInfo();
      }
      
      private function setItemColor(item:InventoryItemInfo, color:String) : void
      {
         if(item.Color == "||")
         {
            item.Color = "";
         }
         var _temp:Array = item.Color.split("|");
         _temp[_cell.editLayer - 1] = String(color);
         var tempColor_1:String = _temp.join("|").replace(/\|$/,"");
         item.Color = tempColor_1;
         _cell.setColor(tempColor_1);
         _model.self.setPartColor(_model.currentItem.CategoryID,tempColor_1);
         _model.self.setSkinColor(_model.self.getSkinColor());
      }
      
      private function setItemSkin(item:InventoryItemInfo, color:String) : void
      {
         var temp:Array = item.Color.split("|");
         temp[1] = color;
         var tempColor:String = temp.join("|");
         item.Skin = color;
         _model.self.setSkinColor(color);
      }
      
      public function setInitColor() : void
      {
         _model.self.setPartColor(_model.currentItem.CategoryID,_model.initColor);
         _cell.itemInfo.Color = _model.initColor;
      }
      
      public function setInitSkinColor() : void
      {
         _model.self.setSkinColor(_model.initSkinColor);
         _cell.itemInfo.Skin = _model.initSkinColor;
      }
      
      private function checkColorChanged(initColor:String, nowColor:String) : Boolean
      {
         var i:int = 0;
         var b1:Boolean = false;
         var b2:Boolean = false;
         var temp1:Array = initColor.split("|");
         var temp2:Array = nowColor.split("|");
         var count:int = Math.max(temp1.length,temp2.length);
         for(i = 0; i < count; )
         {
            b1 = !StringHelper.isNullOrEmpty(temp1[i]) && temp1[i] != "undefined";
            b2 = !StringHelper.isNullOrEmpty(temp2[i]) && temp2[i] != "undefined";
            if((b1 || b2) && temp1[i] != temp2[i])
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      protected function __reductiveColor(event:Event) : void
      {
         var bool1:Boolean = false;
         var bool2:Boolean = false;
         if(_colorEditor.selectedType == 1)
         {
            setItemColor(_model.currentItem,"");
         }
         else
         {
            setItemSkin(_model.currentItem,"");
         }
         if(_cell.info)
         {
            bool1 = checkColorChanged(_model.initColor,_cell.itemInfo.Color);
            bool2 = checkColorChanged(_model.initSkinColor,_cell.itemInfo.Skin);
            if(bool1 || bool2)
            {
               _model.changed = true;
            }
            else
            {
               _model.changed = false;
            }
         }
         else
         {
            _model.changed = false;
         }
      }
      
      private function updateCharator() : void
      {
         _model.self.setPartStyle(_model.currentItem.CategoryID,_model.currentItem.NeedSex,_model.currentItem.TemplateID,_model.currentItem.Color);
         if(_model.currentItem.CategoryID == 6 || _model.currentItem.Skin != "")
         {
            _model.self.setSkinColor(_cell.bagCell.itemInfo.Skin);
         }
         else
         {
            _model.self.setSkinColor(_model.self.getSkinColor());
         }
      }
      
      private function updateColorPanel() : void
      {
         var _temp:* = null;
         if(_cell.info == null)
         {
            _colorEditor.skinEditable = false;
            _colorEditor.colorEditable = false;
         }
         else
         {
            _colorEditor.reset();
            _temp = _cell.itemInfo.Color.split("|");
            _colorEditor.colorRestorable = _temp.length > _cell.editLayer - 1 && !StringHelper.isNullOrEmpty(_temp[_cell.editLayer - 1]) && _temp[_cell.editLayer - 1] != "undefined";
            _colorEditor.skinRestorable = !StringHelper.isNullOrEmpty(_cell.itemInfo.Skin) && _cell.itemInfo.Skin != "undefined";
            _itemChanged = _colorEditor.colorRestorable || _colorEditor.skinRestorable;
            if(_cell.info.CategoryID == 6)
            {
               if(EquipType.isEditable(_cell.info))
               {
                  _colorEditor.colorEditable = true;
               }
               _colorEditor.skinEditable = true;
            }
            else
            {
               _colorEditor.colorEditable = true;
            }
            _colorEditor.editColor();
            if(!_model.initColor)
            {
               _model.initColor = _cell.itemInfo.Color;
            }
            if(!_model.initSkinColor)
            {
               _model.initSkinColor = _cell.itemInfo.Skin;
            }
            if(_colorEditor.selectedType == 2)
            {
               _colorEditor.editSkin();
            }
         }
         if(_colorEditor.skinEditable == false)
         {
            _colorEditor.selectedType = 1;
         }
         if(!_colorEditor.colorEditable && _colorEditor.skinEditable)
         {
            _colorEditor.selectedType = 2;
         }
      }
   }
}
