package particleSystem.extensions
{
   public class Particle
   {
       
      
      public var x:Number;
      
      public var y:Number;
      
      public var scale:Number;
      
      public var rotation:Number;
      
      public var color:uint;
      
      public var alpha:Number;
      
      public var currentTime:Number;
      
      public var totalTime:Number;
      
      public function Particle()
      {
         super();
         currentTime = 0;
         rotation = 0;
         y = 0;
         x = 0;
         scale = 1;
         alpha = 1;
         totalTime = 1;
         color = 16777215;
      }
   }
}
