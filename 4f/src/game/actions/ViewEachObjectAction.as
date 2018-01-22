package game.actions
{
   import game.view.map.MapView;
   import gameCommon.actions.BaseAction;
   
   public class ViewEachObjectAction extends BaseAction
   {
       
      
      private var _map:MapView;
      
      private var _objects:Array;
      
      private var _interval:Number;
      
      private var _index:int;
      
      private var _count:int;
      
      private var _type:int;
      
      public function ViewEachObjectAction(param1:MapView, param2:Array, param3:int = 0, param4:Number = 1500){super();}
      
      override public function canReplace(param1:BaseAction) : Boolean{return false;}
      
      override public function execute() : void{}
      
      public function get objects() : Array{return null;}
   }
}
