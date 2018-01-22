package farm.view.compose.model
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import road7th.data.DictionaryData;
   
   public class ComposeHouseModel extends EventDispatcher
   {
       
      
      private var _items:DictionaryData;
      
      private var _foodComposeList:Dictionary;
      
      public function ComposeHouseModel(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function get foodComposeList() : Dictionary
      {
         return _foodComposeList;
      }
      
      public function set foodComposeList(param1:Dictionary) : void
      {
         _foodComposeList = param1;
      }
      
      public function get items() : DictionaryData
      {
         return _items;
      }
      
      public function set items(param1:DictionaryData) : void
      {
         _items = param1;
      }
   }
}
