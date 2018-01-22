package floatParade.components
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
   
   public class FloatParadeNameCell extends Sprite implements Disposeable
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
      
      public function FloatParadeNameCell(param1:int)
      {
         super();
         _index = param1;
         initView();
         addEvents();
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      private function initView() : void
      {
         _selectedLight = ComponentFactory.Instance.creat("floatParade.missile.selectedLight");
         _selectedLight.visible = false;
         _sprite = new Sprite();
         _sprite.graphics.beginFill(0,0);
         _sprite.graphics.drawRect(0,0,_selectedLight.width,_selectedLight.height);
         _sprite.graphics.endFill();
         _sprite.x = _selectedLight.x;
         _sprite.y = _selectedLight.y;
         addChild(_sprite);
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("floatParade.missileFrame.nameTxt");
         _nameTxt.text = "小妹也带刀";
         addChild(_nameTxt);
         _levelIcon = new LevelIcon();
         _levelIcon.setSize(1);
         addChild(_levelIcon);
         addChild(_selectedLight);
      }
      
      public function setData(param1:String, param2:int = 25, param3:Boolean = true) : void
      {
         _name = param1;
         _level = param2;
         _isVIP = param3;
         addNickName();
         _levelIcon.setInfo(_level,0,0,0,0,0,0,false,false);
      }
      
      private function addNickName() : void
      {
         var _loc1_:* = null;
         if(_vipName)
         {
            _vipName.dispose();
            _vipName = null;
         }
         _nameTxt.visible = !_isVIP;
         if(_isVIP)
         {
            _vipName = VipController.instance.getVipNameTxt(1,1);
            _loc1_ = new TextFormat();
            _loc1_.align = "center";
            _loc1_.bold = true;
            _vipName.textField.defaultTextFormat = _loc1_;
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
      
      public function set selected(param1:Boolean) : void
      {
         _selectedLight.visible = param1;
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
