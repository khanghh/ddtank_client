package ddt.manager
{
   import bagAndInfo.cell.BagCell;
   import ddt.CoreManager;
   import ddt.data.ChangeColorModel;
   import flash.events.Event;
   
   public class ChangeColorManager extends CoreManager
   {
      
      public static var CHAGNECOLOR_OPENVIEW:String = "changecolorOpenView";
      
      public static var _instance:ChangeColorManager;
       
      
      private var _isOneThing:Boolean = false;
      
      private var _changeColorModel:ChangeColorModel;
      
      public function ChangeColorManager()
      {
         super();
      }
      
      public static function get instance() : ChangeColorManager
      {
         if(!_instance)
         {
            _instance = new ChangeColorManager();
         }
         return _instance;
      }
      
      public function get changeColorModel() : ChangeColorModel
      {
         if(!_changeColorModel)
         {
            _changeColorModel = new ChangeColorModel();
         }
         return _changeColorModel;
      }
      
      override protected function start() : void
      {
         dispatchEvent(new Event(CHAGNECOLOR_OPENVIEW));
      }
      
      public function addOneThing(param1:BagCell) : void
      {
         _isOneThing = true;
         _changeColorModel.setOnlyOneEditableThing(param1.itemInfo);
      }
      
      public function close() : void
      {
         if(_changeColorModel)
         {
            _changeColorModel.dispose();
            _changeColorModel = null;
         }
      }
      
      public function get isOneThing() : Boolean
      {
         return _isOneThing;
      }
      
      public function set isOneThing(param1:Boolean) : void
      {
         _isOneThing = param1;
      }
   }
}
