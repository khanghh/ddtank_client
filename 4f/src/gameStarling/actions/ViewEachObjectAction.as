package gameStarling.actions
{
   import gameCommon.actions.BaseAction;
   import gameStarling.view.map.MapView3D;
   
   public class ViewEachObjectAction extends BaseAction
   {
       
      
      private var _map:MapView3D;
      
      private var _objects:Array;
      
      private var _interval:Number;
      
      private var _index:int;
      
      private var _count:int;
      
      private var _type:int;
      
      public function ViewEachObjectAction(param1:MapView3D, param2:Array, param3:int = 0, param4:Number = 1500){super();}
      
      override public function canReplace(param1:BaseAction) : Boolean{return false;}
      
      override public function execute() : void{}
      
      public function get objects() : Array{return null;}
   }
}
