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
      
      public function SpiderBomb1(info:Bomb, owner:Living, refineryLevel:int = 0, isPhantom:Boolean = false)
      {
         super(info,owner,refineryLevel,isPhantom);
      }
      
      override public function bomb() : void
      {
         super.bomb();
         tempChilds = _info.childs;
         tempMap = this.map;
         if(tempChilds && tempChilds.length > 0)
         {
            SoundManager.instance.play(_info.Template.ShootSound);
            if(tempChilds.length > 0)
            {
               createBomb(tempChilds.shift());
            }
            forCreate();
         }
      }
      
      private function forCreate() : void
      {
         if(tempChilds && tempChilds.length > 0)
         {
            setTimeout(function():void
            {
               createBomb(tempChilds.shift());
               forCreate();
            },500);
         }
         else
         {
            tempChilds = null;
            tempMap = null;
         }
      }
      
      private function createBomb(childBomb:Bomb) : void
      {
         var simpleBomb:SpiderBomb2 = new SpiderBomb2(childBomb,_owner,_refineryLevel);
         simpleBomb.sceneEffectCollideId = this.sceneEffectCollideId;
         tempMap.addPhysical(simpleBomb);
         if(fastModel)
         {
            simpleBomb.bombAtOnce();
         }
      }
      
      override protected function isPillarCollide() : Boolean
      {
         return true;
      }
   }
}
