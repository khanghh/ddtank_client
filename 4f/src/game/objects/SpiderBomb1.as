package game.objects
{
   import ddt.manager.SoundManager;
   import flash.utils.setTimeout;
   import game.view.map.MapView;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   
   public class SpiderBomb1 extends SimpleBomb
   {
       
      
      private var tempChilds:Array;
      
      private var tempMap:MapView;
      
      public function SpiderBomb1(param1:Bomb, param2:Living, param3:int = 0, param4:Boolean = false){super(null,null,null,null);}
      
      override public function bomb() : void{}
      
      private function forCreate() : void{}
      
      private function createBomb(param1:Bomb) : void{}
      
      override protected function isPillarCollide() : Boolean{return false;}
   }
}
