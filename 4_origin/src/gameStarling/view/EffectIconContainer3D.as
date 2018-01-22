package gameStarling.view
{
   import gameCommon.view.effects.BaseMirariEffectIcon;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import starling.events.Event;
   
   [Event(name="change",type="flash.events.Event")]
   public class EffectIconContainer3D extends Sprite
   {
       
      
      private var _data:DictionaryData;
      
      private var _spList:Array;
      
      private var _list:Vector.<BaseMirariEffectIcon>;
      
      public function EffectIconContainer3D()
      {
         _list = new Vector.<BaseMirariEffectIcon>();
         super();
         touchable = false;
         initialize();
         initEvent();
      }
      
      private function initialize() : void
      {
         if(_spList || _data)
         {
            release();
         }
         _data = new DictionaryData();
         _spList = [];
      }
      
      private function release() : void
      {
         clearIcons();
         if(_data)
         {
            removeEvent();
            _data.clear();
         }
         _data = null;
      }
      
      private function clearIcons() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _spList;
         for each(var _loc1_ in _spList)
         {
            removeChild(_loc1_);
         }
         _spList = [];
      }
      
      private function drawIcons(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = _data.list[_loc3_];
            _loc2_.x = (_loc3_ & 3) * 21;
            _loc2_.y = (_loc3_ >> 2) * 21;
            _spList.push(_loc2_);
            addChild(_loc2_);
            _loc3_++;
         }
      }
      
      private function initEvent() : void
      {
         _data.addEventListener("add",__changeEffectHandler);
         _data.addEventListener("remove",__changeEffectHandler);
      }
      
      private function removeEvent() : void
      {
         if(_data)
         {
            _data.removeEventListener("add",__changeEffectHandler);
            _data.removeEventListener("remove",__changeEffectHandler);
         }
      }
      
      private function __changeEffectHandler(param1:DictionaryEvent) : void
      {
         var _loc2_:Sprite = param1.data as Sprite;
         _updateList();
      }
      
      private function _updateList() : void
      {
         clearIcons();
         drawIcons(_data.list);
         dispatchEvent(new Event("change"));
      }
      
      override public function get width() : Number
      {
         return _spList.length % 5 * 21;
      }
      
      override public function get height() : Number
      {
         return (Math.floor(_spList.length / 5) + 1) * 21;
      }
      
      public function handleEffect(param1:int, param2:DisplayObject) : void
      {
         if(param2)
         {
            _data.add(param1,param2);
         }
      }
      
      public function removeEffect(param1:int) : void
      {
         _data.remove(param1);
      }
      
      public function clearEffectIcon() : void
      {
         release();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         release();
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}
