package game.animations
{
   import game.objects.SimpleBomb;
   import game.view.map.MapView;
   import phy.object.PhysicalObj;
   
   public class ShockMapAnimation implements IAnimate
   {
       
      
      private var _bomb:PhysicalObj;
      
      private var _finished:Boolean;
      
      private var _age:Number;
      
      private var _life:Number;
      
      private var _radius:Number;
      
      private var _x:Number;
      
      private var _y:Number;
      
      private var _scale:int;
      
      public function ShockMapAnimation(param1:PhysicalObj, param2:Number = 7, param3:Number = 0){super();}
      
      public function get level() : int{return 0;}
      
      public function get scale() : int{return 0;}
      
      public function canAct() : Boolean{return false;}
      
      public function canReplace(param1:IAnimate) : Boolean{return false;}
      
      public function prepare(param1:AnimationSet) : void{}
      
      public function cancel() : void{}
      
      public function update(param1:MapView) : Boolean{return false;}
      
      public function get finish() : Boolean{return false;}
   }
}
