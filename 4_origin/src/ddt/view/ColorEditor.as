package ddt.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.data.ColorEnum;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   [Event(name="change",type="flash.events.Event")]
   public class ColorEditor extends Sprite implements Disposeable
   {
      
      public static const REDUCTIVE_COLOR:String = "reductiveColor";
      
      public static const CHANGE_COLOR:String = "change_color";
       
      
      private var _colors:Array;
      
      private var _skins:Array;
      
      private var _colorsArr:Array;
      
      private var _skinsArr:Array;
      
      private var _colorlist:SimpleTileList;
      
      private var _skincolorlist:SimpleTileList;
      
      private var _colorBtn:SelectedButton;
      
      private var _textureBtn:SelectedButton;
      
      private var _restoreColorBtn:BaseButton;
      
      private var _colorPanelMask:Bitmap;
      
      private var _colorPanelBg:Bitmap;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _ciGroup:SelectedButtonGroup;
      
      private var _siGroup:SelectedButtonGroup;
      
      private var _colorRestorable:Boolean;
      
      private var _skinRestorable:Boolean;
      
      private var _selectedColor:int;
      
      private var _selectedSkin:int;
      
      public function ColorEditor()
      {
         super();
         _selectedColor = -1;
         _selectedSkin = -1;
         _btnGroup = new SelectedButtonGroup();
         _colorBtn = ComponentFactory.Instance.creatComponentByStylename("ddtshop.ColorBtn");
         _textureBtn = ComponentFactory.Instance.creatComponentByStylename("ddtshop.TextureBtn");
         _restoreColorBtn = ComponentFactory.Instance.creatComponentByStylename("shop.ReductiveColorBtn");
         _colorPanelBg = ComponentFactory.Instance.creatBitmap("asset.ddtshop.ColorChoosePanel");
         _colorPanelMask = ComponentFactory.Instance.creatBitmap("asset.ddtshop.ColorMask");
         _colors = ColorEnum.COLORS;
         _skins = ColorEnum.SKIN_COLORS;
         _colorsArr = [];
         _skinsArr = [];
         _colorlist = new SimpleTileList(14);
         _skincolorlist = new SimpleTileList(14);
         var _loc1_:* = 1;
         _skincolorlist.hSpace = _loc1_;
         _loc1_ = _loc1_;
         _skincolorlist.vSpace = _loc1_;
         _loc1_ = _loc1_;
         _colorlist.hSpace = _loc1_;
         _colorlist.vSpace = _loc1_;
         _btnGroup.addSelectItem(_colorBtn);
         _btnGroup.addSelectItem(_textureBtn);
         PositionUtils.setPos(_colorlist,"shop.ColorPanelPos");
         PositionUtils.setPos(_skincolorlist,"shop.ColorPanelPos");
         addChild(_colorPanelBg);
         addChild(_colorBtn);
         addChild(_textureBtn);
         addChild(_restoreColorBtn);
         addChild(_colorlist);
         addChild(_skincolorlist);
         _colorBtn.addEventListener("click",__colorEditClick);
         _textureBtn.addEventListener("click",__skinEditClick);
         _restoreColorBtn.addEventListener("click",__restoreColorBtnClick);
         colorEditable = true;
         skinEditable = false;
         _ciGroup = new SelectedButtonGroup(true);
         _siGroup = new SelectedButtonGroup(true);
         initColors();
         addChild(_colorPanelMask);
      }
      
      private function initColors() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         var _loc2_:int = 0;
         var _loc3_:* = null;
         _loc4_ = 0;
         while(_loc4_ < _colors.length)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("shop.ColorItem");
            _loc1_.setup(_colors[_loc4_]);
            _colorsArr.push(_loc1_);
            _colorlist.addChild(_loc1_);
            _ciGroup.addSelectItem(_loc1_);
            _loc1_.addEventListener("mouseDown",__colorItemClick);
            _loc4_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _skins.length)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("shop.ColorItem");
            _loc3_.setup(_skins[_loc2_]);
            _skinsArr.push(_loc3_);
            _skincolorlist.addChild(_loc3_);
            _siGroup.addSelectItem(_loc3_);
            _loc3_.addEventListener("mouseDown",__skinItemClick);
            _loc2_++;
         }
      }
      
      public function reset() : void
      {
         _selectedColor = -1;
         _selectedSkin = -1;
         _ciGroup.selectIndex = -1;
         _siGroup.selectIndex = -1;
         _colorRestorable = false;
         _skinRestorable = false;
      }
      
      public function get colorRestorable() : Boolean
      {
         return _colorRestorable;
      }
      
      public function set colorRestorable(param1:Boolean) : void
      {
         _colorRestorable = param1;
         if(colorEditable && selectedType == 1)
         {
            _restoreColorBtn.enable = _colorRestorable;
         }
      }
      
      public function get skinRestorable() : Boolean
      {
         return _skinRestorable;
      }
      
      public function set skinRestorable(param1:Boolean) : void
      {
         _skinRestorable = param1;
         if(skinEditable && selectedType == 2)
         {
            _restoreColorBtn.enable = _skinRestorable;
         }
      }
      
      public function set restorable(param1:Boolean) : void
      {
         _restoreColorBtn.visible = param1;
      }
      
      public function get colorEditable() : Boolean
      {
         return _colorBtn.enable;
      }
      
      public function set colorEditable(param1:Boolean) : void
      {
         if(_colorBtn.enable != param1)
         {
            _colorBtn.enable = param1;
            if(!param1 && _colorlist.visible)
            {
               _colorlist.visible = false;
               _colorPanelMask.visible = true;
            }
         }
         updateReductiveColorBtn();
      }
      
      public function get skinEditable() : Boolean
      {
         return _textureBtn.enable;
      }
      
      public function set skinEditable(param1:Boolean) : void
      {
         if(_textureBtn.enable != param1)
         {
            _textureBtn.enable = param1;
            if(!param1 && _skincolorlist.visible)
            {
               _skincolorlist.visible = false;
               _colorPanelMask.visible = true;
            }
         }
         updateReductiveColorBtn();
      }
      
      private function updateReductiveColorBtn() : void
      {
         if(!colorEditable && !skinEditable)
         {
            _restoreColorBtn.enable = false;
         }
         else
         {
            _restoreColorBtn.enable = true;
         }
      }
      
      public function editColor(param1:int = -1) : void
      {
         if(colorEditable)
         {
            selectedColor = param1;
            _colorlist.visible = true;
            _restoreColorBtn.enable = _selectedColor != -1 || _colorRestorable;
            _skincolorlist.visible = false;
            _colorPanelMask.visible = false;
            if(param1 == -1)
            {
               _ciGroup.selectIndex = -1;
            }
         }
      }
      
      public function editSkin(param1:int = -1) : void
      {
         if(skinEditable)
         {
            selectedSkin = param1;
            _colorlist.visible = false;
            _restoreColorBtn.enable = _selectedSkin != -1 || _skinRestorable;
            _skincolorlist.visible = true;
            _colorPanelMask.visible = false;
            if(param1 == -1)
            {
               _siGroup.selectIndex = -1;
            }
         }
      }
      
      public function get selectedType() : int
      {
         return _btnGroup.selectIndex + 1;
      }
      
      public function set selectedType(param1:int) : void
      {
         _btnGroup.selectIndex = param1 - 1;
      }
      
      public function get selectedColor() : int
      {
         return _selectedColor;
      }
      
      public function set selectedColor(param1:int) : void
      {
         if(param1 != _selectedColor && colorEditable)
         {
            _selectedColor = param1;
            _colorlist.selectedIndex = _colors.indexOf(param1);
            updateReductiveColorBtn();
            dispatchEvent(new Event("change"));
         }
      }
      
      public function get selectedSkin() : int
      {
         return _selectedSkin;
      }
      
      public function set selectedSkin(param1:int) : void
      {
         if(param1 != _selectedSkin && skinEditable)
         {
            _selectedSkin = param1;
            _skincolorlist.selectedIndex = _skins.indexOf(param1);
            updateReductiveColorBtn();
            dispatchEvent(new Event("change"));
         }
      }
      
      public function resetColor() : void
      {
         _selectedColor = -1;
         _colorRestorable = false;
      }
      
      public function resetSkin() : void
      {
         _selectedSkin = -1;
         _skinRestorable = false;
         _skincolorlist.selectedIndex = _skins.indexOf(_selectedSkin);
      }
      
      private function __colorItemClick(param1:Event) : void
      {
         SoundManager.instance.play("047");
         var _loc2_:ColorItem = param1.currentTarget as ColorItem;
         selectedColor = _loc2_.getColor();
         dispatchEvent(new Event("change_color"));
      }
      
      private function __skinItemClick(param1:Event) : void
      {
         SoundManager.instance.play("047");
         var _loc2_:ColorItem = param1.currentTarget as ColorItem;
         selectedSkin = _loc2_.getColor();
      }
      
      private function __colorEditClick(param1:Event) : void
      {
         SoundManager.instance.play("047");
         editColor(selectedColor);
      }
      
      private function __skinEditClick(param1:Event) : void
      {
         SoundManager.instance.play("047");
         editSkin(selectedSkin);
      }
      
      protected function __restoreColorBtnClick(param1:MouseEvent) : void
      {
         if(selectedType == 1)
         {
            resetColor();
         }
         else
         {
            resetSkin();
         }
         _restoreColorBtn.enable = false;
         SoundManager.instance.play("008");
         dispatchEvent(new Event("reductiveColor"));
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _colorBtn.removeEventListener("click",__colorEditClick);
         _textureBtn.removeEventListener("click",__skinEditClick);
         _restoreColorBtn.removeEventListener("click",__restoreColorBtnClick);
         _colorBtn = null;
         _textureBtn = null;
         _restoreColorBtn = null;
         _loc2_ = 0;
         while(_loc2_ < _colors.length)
         {
            _colorsArr[_loc2_].removeEventListener("mouseDown",__colorItemClick);
            _colorsArr[_loc2_].dispose();
            _colorsArr[_loc2_] = null;
            _loc2_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _skinsArr.length)
         {
            _skinsArr[_loc1_].removeEventListener("mouseDown",__skinItemClick);
            _skinsArr[_loc1_].dispose();
            _skinsArr[_loc1_] = null;
            _loc1_++;
         }
         if(_colorlist)
         {
            if(_colorlist.parent)
            {
               _colorlist.parent.removeChild(_colorlist);
            }
            _colorlist.disposeAllChildren();
         }
         _colorlist = null;
         if(_skincolorlist)
         {
            if(_skincolorlist.parent)
            {
               _skincolorlist.parent.removeChild(_skincolorlist);
            }
            _skincolorlist.disposeAllChildren();
         }
         _skincolorlist = null;
         _colors = null;
         _skins = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
