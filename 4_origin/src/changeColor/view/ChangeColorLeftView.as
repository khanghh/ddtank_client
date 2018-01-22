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
      
      public function set model(param1:ChangeColorModel) : void
      {
         _model = param1;
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
      
      public function setCurrentItem(param1:BagCell) : void
      {
         SoundManager.instance.play("008");
         if(_cell.bagCell != null || param1.info == null)
         {
            _model.initColor = null;
            _model.initSkinColor = null;
            if(_cell.bagCell)
            {
               _cell.bagCell.locked = false;
            }
         }
         _cell.bagCell = param1;
         param1.locked = true;
         updateColorPanel();
      }
      
      private function __cellChangedHandler(param1:Event) : void
      {
         if((param1.target as BagCell).info && _model.currentItem == null)
         {
            _model.currentItem = _cell.bagCell.itemInfo;
            savaItemInfo();
            updateCharator();
         }
         else if((param1.target as BagCell).info == null)
         {
            reset();
         }
         updateColorPanel();
      }
      
      private function __hideGalssChange(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _model.self.setGlassHide(_hideGlass.selected);
      }
      
      private function __hideHatChange(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _model.self.setHatHide(_hideHat.selected);
      }
      
      private function __hideSuitChange(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _model.self.setSuiteHide(_hideSuit.selected);
      }
      
      private function __hideWingChange(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _model.self.wingHide = _hideWing.selected;
      }
      
      private function __setColor(param1:Event) : void
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
         var _loc1_:* = null;
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
         _loc1_ = ComponentFactory.Instance.creatCustomObject("changeColor.leftViewBgImgRec");
         ObjectUtils.copyPropertyByRectangle(_bg,_loc1_);
         _charater = CharactoryFactory.createCharacter(_model.self);
         _loc1_ = ComponentFactory.Instance.creatCustomObject("changeColor.charaterRec");
         ObjectUtils.copyPropertyByRectangle(_charater as DisplayObject,_loc1_);
         _charater.show(false,-1);
         _charater.showGun = false;
         addChild(_charater as DisplayObject);
         _cellBg = ComponentFactory.Instance.creatComponentByStylename("ColorEditCell.Bg");
         addChild(_cellBg);
         var _loc2_:Sprite = new Sprite();
         _loc2_.graphics.beginFill(0,0);
         _loc2_.graphics.drawRect(0,0,90,90);
         _loc2_.graphics.endFill();
         _cell = new ColorEditCell(_loc2_);
         _loc1_ = ComponentFactory.Instance.creatCustomObject("changeColor.colorEditCellRec");
         ObjectUtils.copyPropertyByRectangle(_cell as DisplayObject,_loc1_);
         addChild(_cell);
         _colorEditor = ComponentFactory.Instance.creatCustomObject("changeColor.ColorEdit");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("changeColor.colorEditorRec");
         ObjectUtils.copyPropertyByRectangle(_colorEditor as DisplayObject,_loc1_);
         addChild(_colorEditor);
         _hideHat = ComponentFactory.Instance.creatComponentByStylename("personanHideHatCheckBox");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("changeColor.hideHatRec");
         ObjectUtils.copyPropertyByRectangle(_hideHat as DisplayObject,_loc1_);
         _hideHat.text = LanguageMgr.GetTranslation("shop.ShopIITryDressView.hideHat");
         _hideHat.selected = _model.self.getHatHide();
         addChild(_hideHat);
         _hideGlass = ComponentFactory.Instance.creatComponentByStylename("personanHideHatCheckBox");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("changeColor.hideGlassRec");
         ObjectUtils.copyPropertyByRectangle(_hideGlass as DisplayObject,_loc1_);
         _hideGlass.text = LanguageMgr.GetTranslation("tank.view.changeColor.ChangeColorLeftView.glass");
         _hideGlass.selected = _model.self.getGlassHide();
         addChild(_hideGlass);
         _hideSuit = ComponentFactory.Instance.creatComponentByStylename("personanHideHatCheckBox");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("changeColor.hideSuitRec");
         ObjectUtils.copyPropertyByRectangle(_hideSuit as DisplayObject,_loc1_);
         _hideSuit.text = LanguageMgr.GetTranslation("tank.view.changeColor.ChangeColorLeftView.suit");
         _hideSuit.selected = _model.self.getSuitesHide();
         addChild(_hideSuit);
         _hideWing = ComponentFactory.Instance.creatComponentByStylename("personanHideWingCheckBox");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("changeColor.hideWingRec");
         ObjectUtils.copyPropertyByRectangle(_hideWing as DisplayObject,_loc1_);
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
      
      private function setItemColor(param1:InventoryItemInfo, param2:String) : void
      {
         if(param1.Color == "||")
         {
            param1.Color = "";
         }
         var _loc4_:Array = param1.Color.split("|");
         _loc4_[_cell.editLayer - 1] = String(param2);
         var _loc3_:String = _loc4_.join("|").replace(/\|$/,"");
         param1.Color = _loc3_;
         _cell.setColor(_loc3_);
         _model.self.setPartColor(_model.currentItem.CategoryID,_loc3_);
         _model.self.setSkinColor(_model.self.getSkinColor());
      }
      
      private function setItemSkin(param1:InventoryItemInfo, param2:String) : void
      {
         var _loc4_:Array = param1.Color.split("|");
         _loc4_[1] = param2;
         var _loc3_:String = _loc4_.join("|");
         param1.Skin = param2;
         _model.self.setSkinColor(param2);
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
      
      private function checkColorChanged(param1:String, param2:String) : Boolean
      {
         var _loc8_:int = 0;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc3_:Array = param1.split("|");
         var _loc4_:Array = param2.split("|");
         var _loc5_:int = Math.max(_loc3_.length,_loc4_.length);
         _loc8_ = 0;
         while(_loc8_ < _loc5_)
         {
            _loc6_ = !StringHelper.isNullOrEmpty(_loc3_[_loc8_]) && _loc3_[_loc8_] != "undefined";
            _loc7_ = !StringHelper.isNullOrEmpty(_loc4_[_loc8_]) && _loc4_[_loc8_] != "undefined";
            if((_loc6_ || _loc7_) && _loc3_[_loc8_] != _loc4_[_loc8_])
            {
               return true;
            }
            _loc8_++;
         }
         return false;
      }
      
      protected function __reductiveColor(param1:Event) : void
      {
         var _loc3_:Boolean = false;
         var _loc2_:Boolean = false;
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
            _loc3_ = checkColorChanged(_model.initColor,_cell.itemInfo.Color);
            _loc2_ = checkColorChanged(_model.initSkinColor,_cell.itemInfo.Skin);
            if(_loc3_ || _loc2_)
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
         var _loc1_:* = null;
         if(_cell.info == null)
         {
            _colorEditor.skinEditable = false;
            _colorEditor.colorEditable = false;
         }
         else
         {
            _colorEditor.reset();
            _loc1_ = _cell.itemInfo.Color.split("|");
            _colorEditor.colorRestorable = _loc1_.length > _cell.editLayer - 1 && !StringHelper.isNullOrEmpty(_loc1_[_cell.editLayer - 1]) && _loc1_[_cell.editLayer - 1] != "undefined";
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
