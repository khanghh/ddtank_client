package store
{
   import ddt.manager.PlayerManager;
   import road7th.data.DictionaryData;
   import store.data.StoreModel;
   
   public class StoreController
   {
       
      
      private var _type:String;
      
      private var _model:StoreModel;
      
      private var _viewArr:Array;
      
      public var selectedIndex:DictionaryData;
      
      public function StoreController()
      {
         super();
         init();
         initEvents();
      }
      
      private function init() : void
      {
         _model = new StoreModel(PlayerManager.Instance.Self);
         selectedIndex = new DictionaryData();
      }
      
      private function initEvents() : void
      {
      }
      
      private function removeEvents() : void
      {
      }
      
      public function startupEvent() : void
      {
      }
      
      public function shutdownEvent() : void
      {
      }
      
      public function get Model() : StoreModel
      {
         return _model;
      }
      
      public function dispose() : void
      {
         shutdownEvent();
         removeEvents();
         _model.clear();
         _model = null;
         selectedIndex = null;
      }
   }
}
