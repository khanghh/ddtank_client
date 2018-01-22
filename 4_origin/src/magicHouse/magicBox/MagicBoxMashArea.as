package magicHouse.magicBox
{
   import flash.display.Sprite;
   
   public class MagicBoxMashArea extends Sprite
   {
       
      
      private var _areaWidth:int = 900;
      
      private var _areaHeight:int = 560;
      
      public function MagicBoxMashArea()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         graphics.beginFill(255,0);
         graphics.drawRect(0,0,_areaWidth,_areaHeight);
         graphics.endFill();
      }
   }
}
