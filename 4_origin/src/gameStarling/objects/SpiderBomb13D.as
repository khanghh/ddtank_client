package gameStarling.objects
{
   import ddt.manager.SoundManager;
   import flash.utils.setTimeout;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   import gameStarling.view.map.MapView3D;
   
   public class SpiderBomb13D extends SimpleBomb3D
   {
       
      
      private var tempChilds:Array;
      
      private var tempMap:MapView3D;
      
      public function SpiderBomb13D(info:Bomb, owner:Living, refineryLevel:int = 0, isPhantom:Boolean = false)
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
         var simpleBomb:SpiderBomb23D = new SpiderBomb23D(childBomb,_owner,_refineryLevel);
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
