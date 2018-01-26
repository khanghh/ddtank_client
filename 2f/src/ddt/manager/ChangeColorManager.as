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
      
      public function ChangeColorManager(){super();}
      
      public static function get instance() : ChangeColorManager{return null;}
      
      public function get changeColorModel() : ChangeColorModel{return null;}
      
      override protected function start() : void{}
      
      public function addOneThing(param1:BagCell) : void{}
      
      public function close() : void{}
      
      public function get isOneThing() : Boolean{return false;}
      
      public function set isOneThing(param1:Boolean) : void{}
   }
}
