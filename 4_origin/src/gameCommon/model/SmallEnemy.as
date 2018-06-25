package gameCommon.model
{
   import ddt.events.LivingEvent;
   
   [Event(name="modelChanged",type="tank.events.LivingEvent")]
   public class SmallEnemy extends Living
   {
       
      
      public var stateType:int;
      
      private var _modelID:int;
      
      public function SmallEnemy(id:int, team:int, maxBlood:int)
      {
         super(id,team,maxBlood);
      }
      
      public function set modelID(value:int) : void
      {
         var old:int = _modelID;
         _modelID = value;
         dispatchEvent(new LivingEvent("modelChanged",_modelID,old));
      }
      
      public function get modelID() : int
      {
         return _modelID;
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
