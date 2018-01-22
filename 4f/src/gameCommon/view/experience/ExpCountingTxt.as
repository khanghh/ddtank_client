package gameCommon.view.experience
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Quad;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class ExpCountingTxt extends Sprite implements Disposeable
   {
       
      
      protected var _text;
      
      protected var _value:Number;
      
      protected var _targetValue:Number;
      
      protected var _style:String;
      
      protected var _filters:Array;
      
      protected var _plus:String;
      
      public var maxValue:int = 2147483647;
      
      public function ExpCountingTxt(param1:String, param2:String){super();}
      
      public function get value() : Number{return 0;}
      
      public function set value(param1:Number) : void{}
      
      public function get targetValue() : Number{return 0;}
      
      protected function init() : void{}
      
      public function updateNum(param1:Number, param2:Boolean = true) : void{}
      
      protected function updateText() : void{}
      
      public function complete(param1:Event = null) : void{}
      
      public function dispose() : void{}
   }
}
