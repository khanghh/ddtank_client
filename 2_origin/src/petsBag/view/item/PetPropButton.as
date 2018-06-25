package petsBag.view.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.view.tips.PropTxtTipInfo;
   import flash.text.TextFormat;
   
   public class PetPropButton extends Component
   {
       
      
      private var _propName:FilterFrameText;
      
      private var _propValue:FilterFrameText;
      
      protected var _tipInfo:PropTxtTipInfo;
      
      private var _currentPropValue:int;
      
      private var _addedPropValue:int;
      
      private var _petsWeaponPropValue:int;
      
      private var _petsEatPropValue:int;
      
      private var _afterBreakAddedValue:int;
      
      public function PetPropButton()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _propName = ComponentFactory.Instance.creatComponentByStylename("petsBag.text.propName");
         addChild(_propName);
         _propValue = ComponentFactory.Instance.creatComponentByStylename("petsBag.text.propValue");
         addChild(_propValue);
         _propName.mouseEnabled = false;
         _propValue.mouseEnabled = false;
         _tipInfo = new PropTxtTipInfo();
      }
      
      public function set propName(name:String) : void
      {
         _propName.text = name;
         fixPos();
      }
      
      public function set propValue(value:int) : void
      {
         _propValue.text = value.toString();
         fixPos();
      }
      
      public function set propColor(value:int) : void
      {
         var format:TextFormat = _propValue.getTextFormat();
         format.color = value;
         _propValue.setTextFormat(format);
      }
      
      public function set valueFilterString(index:int) : void
      {
         _propValue.setFrame(index);
      }
      
      private function fixPos() : void
      {
         _propValue.x = 77;
      }
      
      override public function get tipStyle() : String
      {
         return "core.PropTxtTips";
      }
      
      override public function get tipData() : Object
      {
         return _tipInfo;
      }
      
      public function get color() : int
      {
         return _tipInfo.color;
      }
      
      public function set color(val:int) : void
      {
         _tipInfo.color = val;
      }
      
      public function get property() : String
      {
         return _tipInfo.property;
      }
      
      public function set property(val:String) : void
      {
         _tipInfo.property = LanguageMgr.GetTranslation("ddt.petBag.propTips",val,_currentPropValue,_addedPropValue,_petsWeaponPropValue,_petsEatPropValue);
      }
      
      public function get currentPropValue() : int
      {
         return _currentPropValue;
      }
      
      public function set currentPropValue(value:int) : void
      {
         _currentPropValue = value;
      }
      
      public function get addedPropValue() : int
      {
         return _addedPropValue;
      }
      
      public function set addedPropValue(value:int) : void
      {
         _addedPropValue = value;
      }
      
      public function get detail() : String
      {
         return _tipInfo.detail;
      }
      
      public function set detail(val:String) : void
      {
         _tipInfo.detail = val;
      }
      
      override public function dispose() : void
      {
         _tipInfo = null;
         ObjectUtils.disposeObject(_propName);
         _propName = null;
         ObjectUtils.disposeObject(_propValue);
         _propValue = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
      
      public function get petsWeaponPropValue() : int
      {
         return _petsWeaponPropValue;
      }
      
      public function set petsWeaponPropValue(value:int) : void
      {
         _petsWeaponPropValue = value;
      }
      
      public function get petsEatPropValue() : int
      {
         return _petsEatPropValue;
      }
      
      public function set petsEatPropValue(value:int) : void
      {
         _petsEatPropValue = value;
      }
      
      public function get breakAddedValue() : int
      {
         return _afterBreakAddedValue;
      }
      
      public function set breakAddedValue(value:int) : void
      {
         _afterBreakAddedValue = value;
      }
   }
}
