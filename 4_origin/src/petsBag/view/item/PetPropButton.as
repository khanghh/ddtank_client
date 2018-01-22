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
      
      public function set propName(param1:String) : void
      {
         _propName.text = param1;
         fixPos();
      }
      
      public function set propValue(param1:int) : void
      {
         _propValue.text = param1.toString();
         fixPos();
      }
      
      public function set propColor(param1:int) : void
      {
         var _loc2_:TextFormat = _propValue.getTextFormat();
         _loc2_.color = param1;
         _propValue.setTextFormat(_loc2_);
      }
      
      public function set valueFilterString(param1:int) : void
      {
         _propValue.setFrame(param1);
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
      
      public function set color(param1:int) : void
      {
         _tipInfo.color = param1;
      }
      
      public function get property() : String
      {
         return _tipInfo.property;
      }
      
      public function set property(param1:String) : void
      {
         _tipInfo.property = LanguageMgr.GetTranslation("ddt.petBag.propTips",param1,_currentPropValue,_addedPropValue,_petsWeaponPropValue,_petsEatPropValue);
      }
      
      public function get currentPropValue() : int
      {
         return _currentPropValue;
      }
      
      public function set currentPropValue(param1:int) : void
      {
         _currentPropValue = param1;
      }
      
      public function get addedPropValue() : int
      {
         return _addedPropValue;
      }
      
      public function set addedPropValue(param1:int) : void
      {
         _addedPropValue = param1;
      }
      
      public function get detail() : String
      {
         return _tipInfo.detail;
      }
      
      public function set detail(param1:String) : void
      {
         _tipInfo.detail = param1;
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
      
      public function set petsWeaponPropValue(param1:int) : void
      {
         _petsWeaponPropValue = param1;
      }
      
      public function get petsEatPropValue() : int
      {
         return _petsEatPropValue;
      }
      
      public function set petsEatPropValue(param1:int) : void
      {
         _petsEatPropValue = param1;
      }
      
      public function get breakAddedValue() : int
      {
         return _afterBreakAddedValue;
      }
      
      public function set breakAddedValue(param1:int) : void
      {
         _afterBreakAddedValue = param1;
      }
   }
}
