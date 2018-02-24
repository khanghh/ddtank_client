package mx.binding
{
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   
   use namespace mx_internal;
   
   [ExcludeClass]
   public class BindabilityInfo
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
      
      public static const BINDABLE:String = "Bindable";
      
      public static const MANAGED:String = "Managed";
      
      public static const CHANGE_EVENT:String = "ChangeEvent";
      
      public static const NON_COMMITTING_CHANGE_EVENT:String = "NonCommittingChangeEvent";
      
      public static const ACCESSOR:String = "accessor";
      
      public static const METHOD:String = "method";
       
      
      private var typeDescription:XML;
      
      private var classChangeEvents:Object;
      
      private var childChangeEvents:Object;
      
      public function BindabilityInfo(param1:XML){super();}
      
      public function getChangeEvents(param1:String) : Object{return null;}
      
      private function getClassChangeEvents() : Object{return null;}
      
      private function addBindabilityEvents(param1:XMLList, param2:Object) : void{}
      
      private function addChangeEvents(param1:XMLList, param2:Object, param3:Boolean) : void{}
      
      private function copyProps(param1:Object, param2:Object) : Object{return null;}
   }
}
