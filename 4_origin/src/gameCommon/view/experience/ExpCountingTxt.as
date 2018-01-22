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
      
      public function ExpCountingTxt(param1:String, param2:String)
      {
         super();
         _style = param1;
         _filters = param2.split(",");
         init();
      }
      
      public function get value() : Number
      {
         return _value;
      }
      
      public function set value(param1:Number) : void
      {
         _value = param1;
      }
      
      public function get targetValue() : Number
      {
         return _targetValue;
      }
      
      protected function init() : void
      {
         var _loc2_:int = 0;
         _text = ComponentFactory.Instance.creatComponentByStylename(_style);
         _value = 0;
         _targetValue = 0;
         _plus = "+";
         _text.text = _plus + String(_value) + " ";
         var _loc1_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < _filters.length)
         {
            _loc1_.push(ComponentFactory.Instance.model.getSet(_filters[_loc2_]));
            _loc2_++;
         }
         _text.filters = _loc1_;
         addChild(_text);
      }
      
      public function updateNum(param1:Number, param2:Boolean = true) : void
      {
         if(param2)
         {
            var _loc3_:* = _targetValue + param1;
            _targetValue = _loc3_;
            §§push(_loc3_);
         }
         else
         {
            _targetValue = param1;
            §§push(Number(param1));
         }
         §§pop();
         if(_targetValue > maxValue)
         {
            _targetValue = maxValue;
         }
         TweenLite.killTweensOf(this);
         TweenLite.to(this,0.5,{
            "value":_targetValue,
            "ease":Quad.easeOut,
            "onUpdate":updateText,
            "onComplete":complete
         });
         dispatchEvent(new Event("change"));
      }
      
      protected function updateText() : void
      {
         var _loc1_:* = null;
         if(!_text)
         {
            return;
         }
         var _loc2_:String = _text.text;
         if(_value < 0)
         {
            _loc1_ = String(Math.round(_value)) + " ";
         }
         else
         {
            _loc1_ = _plus + String(Math.round(_value)) + " ";
         }
         if(_loc1_.indexOf("+") && int(_loc1_.indexOf("-")))
         {
            _loc1_ = _loc1_.replace("-");
         }
         if(_loc2_ != "+0 " && _loc1_ != _loc2_)
         {
            SoundManager.instance.play("143");
         }
         _text.text = _loc1_;
      }
      
      public function complete(param1:Event = null) : void
      {
         _value = _targetValue;
         updateText();
         dispatchEvent(new Event("complete"));
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_text);
         _text = null;
         _filters = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
