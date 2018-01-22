package mysteriousRoullete.components
{
   import ddt.manager.SoundManager;
   
   public class RouletteSound
   {
       
      
      private var _oneArray:Array;
      
      private var _number:int = 0;
      
      public function RouletteSound()
      {
         _oneArray = ["130","131","133","132","135","134","129","128","127","132","135","134","129","128","127"];
         super();
      }
      
      public function playOneStep() : void
      {
         var _loc1_:String = _oneArray[_number];
         SoundManager.instance.play(_loc1_);
         _number = _number >= 4?0:Number(_number + 1);
      }
   }
}
