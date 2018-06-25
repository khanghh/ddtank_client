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
      
      public function ExpCountingTxt(textStyle:String, textFilterStr:String)
      {
         super();
         _style = textStyle;
         _filters = textFilterStr.split(",");
         init();
      }
      
      public function get value() : Number
      {
         return _value;
      }
      
      public function set value(value:Number) : void
      {
         _value = value;
      }
      
      public function get targetValue() : Number
      {
         return _targetValue;
      }
      
      protected function init() : void
      {
         var i:int = 0;
         _text = ComponentFactory.Instance.creatComponentByStylename(_style);
         _value = 0;
         _targetValue = 0;
         _plus = "+";
         _text.text = _plus + String(_value) + " ";
         var arr:Array = [];
         for(i = 0; i < _filters.length; )
         {
            arr.push(ComponentFactory.Instance.model.getSet(_filters[i]));
            i++;
         }
         _text.filters = arr;
         addChild(_text);
      }
      
      public function updateNum(newValue:Number, isAdd:Boolean = true) : void
      {
         if(isAdd)
         {
            var _loc3_:* = _targetValue + newValue;
            _targetValue = _loc3_;
            §§push(_loc3_);
         }
         else
         {
            _targetValue = newValue;
            §§push(Number(newValue));
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
         var tempStr:* = null;
         if(!_text)
         {
            return;
         }
         var str:String = _text.text;
         if(_value < 0)
         {
            tempStr = String(Math.round(_value)) + " ";
         }
         else
         {
            tempStr = _plus + String(Math.round(_value)) + " ";
         }
         if(tempStr.indexOf("+") && int(tempStr.indexOf("-")))
         {
            tempStr = tempStr.replace("-");
         }
         if(str != "+0 " && tempStr != str)
         {
            SoundManager.instance.play("143");
         }
         _text.text = tempStr;
      }
      
      public function complete(e:Event = null) : void
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
