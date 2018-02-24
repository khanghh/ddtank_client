package character
{
   import character.action.ActionSet;
   import character.action.BaseAction;
   import character.action.ComplexBitmapAction;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import mx.events.PropertyChangeEvent;
   
   public class ComplexBitmapCharacter extends ComplexItem implements ICharacter
   {
       
      
      protected var _assets:Dictionary;
      
      protected var _actionSet:ActionSet;
      
      protected var _currentAction:ComplexBitmapAction;
      
      protected var _label:String = "";
      
      protected var _autoStop:Boolean;
      
      protected var _bitmapRendItems:Vector.<FrameByFrameItem>;
      
      private var _registerPoint:Point;
      
      private var _rect:Rectangle;
      
      protected var _soundEnabled:Boolean = false;
      
      public function ComplexBitmapCharacter(param1:Dictionary, param2:XML = null, param3:String = "", param4:Number = 0, param5:Number = 0, param6:String = "original", param7:Boolean = false){super(null,null,null,null,null);}
      
      public function get soundEnabled() : Boolean{return false;}
      
      private function set _164832462soundEnabled(param1:Boolean) : void{}
      
      public function set description(param1:XML) : void{}
      
      public function getActionFrames(param1:String) : int{return 0;}
      
      public function get label() : String{return null;}
      
      private function set _102727412label(param1:String) : void{}
      
      public function hasAction(param1:String) : Boolean{return false;}
      
      private function set _1408207997assets(param1:Dictionary) : void{}
      
      public function get assets() : Dictionary{return null;}
      
      public function get actions() : Array{return null;}
      
      public function addAction(param1:BaseAction) : void{}
      
      public function doAction(param1:String) : void{}
      
      protected function set currentAction(param1:ComplexBitmapAction) : void{}
      
      override protected function update() : void{}
      
      public function get registerPoint() : Point{return null;}
      
      public function get rect() : Rectangle{return null;}
      
      override public function toXml() : XML{return null;}
      
      public function removeAction(param1:String) : void{}
      
      override public function dispose() : void{}
      
      [Bindable(event="propertyChange")]
      public function set assets(param1:Dictionary) : void{}
      
      [Bindable(event="propertyChange")]
      public function set soundEnabled(param1:Boolean) : void{}
      
      [Bindable(event="propertyChange")]
      public function set label(param1:String) : void{}
   }
}
