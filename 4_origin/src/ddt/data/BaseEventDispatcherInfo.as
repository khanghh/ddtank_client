package ddt.data
{
   import ddt.events.CEvent;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   
   public class BaseEventDispatcherInfo extends EventDispatcher
   {
      
      public static const PROPERTY_CHANGE:String = "propertychange";
       
      
      protected var _changeCount:int = 0;
      
      protected var _changedPropeties:Dictionary;
      
      public function BaseEventDispatcherInfo(param1:IEventDispatcher = null)
      {
         _changedPropeties = new Dictionary();
         super(param1);
      }
      
      public function beginChanges() : void
      {
         _changeCount = Number(_changeCount) + 1;
      }
      
      public function commitChanges() : void
      {
         _changeCount = Number(_changeCount) - 1;
         if(_changeCount <= 0)
         {
            _changeCount = 0;
            updateProperties();
         }
      }
      
      protected function onPropertiesChanged(param1:String = null) : void
      {
         if(param1 != null)
         {
            _changedPropeties[param1] = true;
         }
         if(_changeCount <= 0)
         {
            _changeCount = 0;
            updateProperties();
         }
      }
      
      public function updateProperties() : void
      {
         var _loc1_:Dictionary = _changedPropeties;
         _changedPropeties = new Dictionary();
         dispatchEvent(new CEvent("propertychange",_loc1_));
      }
   }
}
