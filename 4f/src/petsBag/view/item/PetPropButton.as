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
      
      public function PetPropButton(){super();}
      
      protected function initView() : void{}
      
      public function set propName(param1:String) : void{}
      
      public function set propValue(param1:int) : void{}
      
      public function set propColor(param1:int) : void{}
      
      public function set valueFilterString(param1:int) : void{}
      
      private function fixPos() : void{}
      
      override public function get tipStyle() : String{return null;}
      
      override public function get tipData() : Object{return null;}
      
      public function get color() : int{return 0;}
      
      public function set color(param1:int) : void{}
      
      public function get property() : String{return null;}
      
      public function set property(param1:String) : void{}
      
      public function get currentPropValue() : int{return 0;}
      
      public function set currentPropValue(param1:int) : void{}
      
      public function get addedPropValue() : int{return 0;}
      
      public function set addedPropValue(param1:int) : void{}
      
      public function get detail() : String{return null;}
      
      public function set detail(param1:String) : void{}
      
      override public function dispose() : void{}
      
      public function get petsWeaponPropValue() : int{return 0;}
      
      public function set petsWeaponPropValue(param1:int) : void{}
      
      public function get petsEatPropValue() : int{return 0;}
      
      public function set petsEatPropValue(param1:int) : void{}
      
      public function get breakAddedValue() : int{return 0;}
      
      public function set breakAddedValue(param1:int) : void{}
   }
}
