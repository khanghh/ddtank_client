package character
{
   import character.action.ActionSet;
   import character.action.BaseAction;
   import character.action.MovieClipAction;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import mx.events.PropertyChangeEvent;
   
   public class MovieClipCharacter extends Sprite implements ICharacter
   {
       
      
      private var _assets:Dictionary;
      
      private var _actionSet:ActionSet;
      
      private var _currentAction:MovieClipAction;
      
      private var _label:String = "";
      
      private var _autoStop:Boolean;
      
      private var _isPlaying:Boolean = true;
      
      private var _type:int;
      
      private var _registerPoint:Point;
      
      private var _rect:Rectangle;
      
      private var _realRender:Boolean;
      
      protected var _soundEnabled:Boolean = false;
      
      public function MovieClipCharacter(param1:Dictionary, param2:XML = null, param3:String = "", param4:Boolean = false){super();}
      
      public function get soundEnabled() : Boolean{return false;}
      
      private function set _164832462soundEnabled(param1:Boolean) : void{}
      
      public function getActionFrames(param1:String) : int{return 0;}
      
      private function onEnterFrame(param1:Event) : void{}
      
      public function get actions() : Array{return null;}
      
      public function set description(param1:XML) : void{}
      
      private function set currentAction(param1:MovieClipAction) : void{}
      
      public function get itemWidth() : Number{return 0;}
      
      public function get itemHeight() : Number{return 0;}
      
      public function get label() : String{return null;}
      
      private function set _102727412label(param1:String) : void{}
      
      public function hasAction(param1:String) : Boolean{return false;}
      
      public function doAction(param1:String) : void{}
      
      public function addAction(param1:BaseAction) : void{}
      
      public function toXml() : XML{return null;}
      
      public function get type() : int{return 0;}
      
      public function removeAction(param1:String) : void{}
      
      public function get registerPoint() : Point{return null;}
      
      public function get rect() : Rectangle{return null;}
      
      public function dispose() : void{}
      
      public function get assets() : Dictionary{return null;}
      
      public function get realRender() : Boolean{return false;}
      
      private function set _2032707372realRender(param1:Boolean) : void{}
      
      [Bindable(event="propertyChange")]
      public function set soundEnabled(param1:Boolean) : void{}
      
      [Bindable(event="propertyChange")]
      public function set label(param1:String) : void{}
      
      [Bindable(event="propertyChange")]
      public function set realRender(param1:Boolean) : void{}
   }
}
