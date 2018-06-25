package game.view
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import gameCommon.view.effects.BaseMirariEffectIcon;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   
   [Event(name="change",type="flash.events.Event")]
   public class EffectIconContainer extends Sprite
   {
       
      
      private var _data:DictionaryData;
      
      private var _spList:Array;
      
      private var _list:Vector.<BaseMirariEffectIcon>;
      
      public function EffectIconContainer()
      {
         _list = new Vector.<BaseMirariEffectIcon>();
         super();
         mouseEnabled = false;
         mouseChildren = false;
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
         for each(var sp in _spList)
         {
            removeChild(sp);
         }
         _spList = [];
      }
      
      private function drawIcons(iconArr:Array) : void
      {
         var i:int = 0;
         var icon:* = null;
         for(i = 0; i < iconArr.length; )
         {
            icon = _data.list[i];
            icon.x = (i & 3) * 21;
            icon.y = (i >> 2) * 21;
            _spList.push(icon);
            addChild(icon);
            i++;
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
      
      private function __changeEffectHandler(e:DictionaryEvent) : void
      {
         var sp:Sprite = e.data as Sprite;
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
      
      public function handleEffect(type:int, view:DisplayObject) : void
      {
         if(view)
         {
            _data.add(type,view);
         }
      }
      
      public function removeEffect(type:int) : void
      {
         _data.remove(type);
      }
      
      public function clearEffectIcon() : void
      {
         release();
      }
      
      public function dispose() : void
      {
         removeEvent();
         release();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
