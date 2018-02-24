package gameStarling.animations
{
   import gameStarling.view.map.MapView3D;
   
   public interface IAnimate
   {
       
      
      function get level() : int;
      
      function prepare(param1:AnimationSet) : void;
      
      function canAct() : Boolean;
      
      function update(param1:MapView3D) : Boolean;
      
      function canReplace(param1:IAnimate) : Boolean;
      
      function cancel() : void;
      
      function get finish() : Boolean;
   }
}
