package drgnBoat.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.view.common.LevelIcon;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.text.TextFormat;
   import vip.VipController;
   
   public class DrgnBoatNameCell extends Sprite implements Disposeable
   {
       
      
      private var _selectedLight:Bitmap;
      
      private var _sprite:Sprite;
      
      private var _levelIcon:LevelIcon;
      
      private var _vipName:GradientText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _isVIP:Boolean;
      
      private var _name:String;
      
      private var _level:int;
      
      private var _index:int;
      
      public function DrgnBoatNameCell(i:int)
      {
         super();
         _index = i;
         initView();
         addEvents();
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      private function initView() : void
      {
         _selectedLight = ComponentFactory.Instance.creat("drgnBoat.missile.selectedLight");
         _selectedLight.visible = false;
         _sprite = new Sprite();
         _sprite.graphics.beginFill(0,0);
         _sprite.graphics.drawRect(0,0,_selectedLight.width,_selectedLight.height);
         _sprite.graphics.endFill();
         _sprite.x = _selectedLight.x;
         _sprite.y = _selectedLight.y;
         addChild(_sprite);
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("drgnBoat.missileFrame.nameTxt");
         _nameTxt.text = "小妹也带刀";
         addChild(_nameTxt);
         _levelIcon = new LevelIcon();
         _levelIcon.setSize(1);
         addChild(_levelIcon);
         addChild(_selectedLight);
      }
      
      public function setData(name:String, level:int = 25, isVIP:Boolean = true) : void
      {
         _name = name;
         _level = level;
         _isVIP = isVIP;
         addNickName();
         _levelIcon.setInfo(_level,0,0,0,0,0,0,false,false);
      }
      
      private function addNickName() : void
      {
         var textFormat:* = null;
         if(_vipName)
         {
            _vipName.dispose();
            _vipName = null;
         }
         _nameTxt.visible = !_isVIP;
         if(_isVIP)
         {
            _vipName = VipController.instance.getVipNameTxt(1,1);
            textFormat = new TextFormat();
            textFormat.align = "center";
            textFormat.bold = true;
            _vipName.textField.defaultTextFormat = textFormat;
            _vipName.textSize = 16;
            _vipName.textField.width = _nameTxt.width;
            _vipName.x = _nameTxt.x;
            _vipName.y = _nameTxt.y;
            _vipName.text = _name;
            addChild(_vipName);
         }
         else
         {
            _nameTxt.text = _name;
         }
      }
      
      public function set selected(flag:Boolean) : void
      {
         _selectedLight.visible = flag;
      }
      
      public function get selected() : Boolean
      {
         return _selectedLight.visible;
      }
      
      private function addEvents() : void
      {
      }
      
      private function removeEvents() : void
      {
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_selectedLight);
         _selectedLight = null;
         ObjectUtils.disposeObject(_sprite);
         _sprite = null;
         ObjectUtils.disposeObject(_levelIcon);
         _levelIcon = null;
         ObjectUtils.disposeObject(_vipName);
         _vipName = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
      }
   }
}
