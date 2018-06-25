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
         var i:int = 0;
         var ci:* = null;
         var j:int = 0;
         var si:* = null;
         for(i = 0; i < _colors.length; )
         {
            ci = ComponentFactory.Instance.creatComponentByStylename("shop.ColorItem");
            ci.setup(_colors[i]);
            _colorsArr.push(ci);
            _colorlist.addChild(ci);
            _ciGroup.addSelectItem(ci);
            ci.addEventListener("mouseDown",__colorItemClick);
            i++;
         }
         for(j = 0; j < _skins.length; )
         {
            si = ComponentFactory.Instance.creatComponentByStylename("shop.ColorItem");
            si.setup(_skins[j]);
            _skinsArr.push(si);
            _skincolorlist.addChild(si);
            _siGroup.addSelectItem(si);
            si.addEventListener("mouseDown",__skinItemClick);
            j++;
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
      
      public function set colorRestorable(value:Boolean) : void
      {
         _colorRestorable = value;
         if(colorEditable && selectedType == 1)
         {
            _restoreColorBtn.enable = _colorRestorable;
         }
      }
      
      public function get skinRestorable() : Boolean
      {
         return _skinRestorable;
      }
      
      public function set skinRestorable(value:Boolean) : void
      {
         _skinRestorable = value;
         if(skinEditable && selectedType == 2)
         {
            _restoreColorBtn.enable = _skinRestorable;
         }
      }
      
      public function set restorable(value:Boolean) : void
      {
         _restoreColorBtn.visible = value;
      }
      
      public function get colorEditable() : Boolean
      {
         return _colorBtn.enable;
      }
      
      public function set colorEditable(value:Boolean) : void
      {
         if(_colorBtn.enable != value)
         {
            _colorBtn.enable = value;
            if(!value && _colorlist.visible)
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
      
      public function set skinEditable(value:Boolean) : void
      {
         if(_textureBtn.enable != value)
         {
            _textureBtn.enable = value;
            if(!value && _skincolorlist.visible)
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
      
      public function editColor(color:int = -1) : void
      {
         if(colorEditable)
         {
            selectedColor = color;
            _colorlist.visible = true;
            _restoreColorBtn.enable = _selectedColor != -1 || _colorRestorable;
            _skincolorlist.visible = false;
            _colorPanelMask.visible = false;
            if(color == -1)
            {
               _ciGroup.selectIndex = -1;
            }
         }
      }
      
      public function editSkin(skin:int = -1) : void
      {
         if(skinEditable)
         {
            selectedSkin = skin;
            _colorlist.visible = false;
            _restoreColorBtn.enable = _selectedSkin != -1 || _skinRestorable;
            _skincolorlist.visible = true;
            _colorPanelMask.visible = false;
            if(skin == -1)
            {
               _siGroup.selectIndex = -1;
            }
         }
      }
      
      public function get selectedType() : int
      {
         return _btnGroup.selectIndex + 1;
      }
      
      public function set selectedType(value:int) : void
      {
         _btnGroup.selectIndex = value - 1;
      }
      
      public function get selectedColor() : int
      {
         return _selectedColor;
      }
      
      public function set selectedColor(value:int) : void
      {
         if(value != _selectedColor && colorEditable)
         {
            _selectedColor = value;
            _colorlist.selectedIndex = _colors.indexOf(value);
            updateReductiveColorBtn();
            dispatchEvent(new Event("change"));
         }
      }
      
      public function get selectedSkin() : int
      {
         return _selectedSkin;
      }
      
      public function set selectedSkin(value:int) : void
      {
         if(value != _selectedSkin && skinEditable)
         {
            _selectedSkin = value;
            _skincolorlist.selectedIndex = _skins.indexOf(value);
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
      
      private function __colorItemClick(event:Event) : void
      {
         SoundManager.instance.play("047");
         var item:ColorItem = event.currentTarget as ColorItem;
         selectedColor = item.getColor();
         dispatchEvent(new Event("change_color"));
      }
      
      private function __skinItemClick(event:Event) : void
      {
         SoundManager.instance.play("047");
         var item:ColorItem = event.currentTarget as ColorItem;
         selectedSkin = item.getColor();
      }
      
      private function __colorEditClick(event:Event) : void
      {
         SoundManager.instance.play("047");
         editColor(selectedColor);
      }
      
      private function __skinEditClick(event:Event) : void
      {
         SoundManager.instance.play("047");
         editSkin(selectedSkin);
      }
      
      protected function __restoreColorBtnClick(event:MouseEvent) : void
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
         var i:int = 0;
         var j:int = 0;
         _colorBtn.removeEventListener("click",__colorEditClick);
         _textureBtn.removeEventListener("click",__skinEditClick);
         _restoreColorBtn.removeEventListener("click",__restoreColorBtnClick);
         _colorBtn = null;
         _textureBtn = null;
         _restoreColorBtn = null;
         for(i = 0; i < _colors.length; )
         {
            _colorsArr[i].removeEventListener("mouseDown",__colorItemClick);
            _colorsArr[i].dispose();
            _colorsArr[i] = null;
            i++;
         }
         for(j = 0; j < _skinsArr.length; )
         {
            _skinsArr[j].removeEventListener("mouseDown",__skinItemClick);
            _skinsArr[j].dispose();
            _skinsArr[j] = null;
            j++;
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
