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
      
      public function SpiderBomb13D(param1:Bomb, param2:Living, param3:int = 0, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
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
      
      private function createBomb(param1:Bomb) : void
      {
         var _loc2_:SpiderBomb23D = new SpiderBomb23D(param1,_owner,_refineryLevel);
         _loc2_.sceneEffectCollideId = this.sceneEffectCollideId;
         tempMap.addPhysical(_loc2_);
         if(fastModel)
         {
            _loc2_.bombAtOnce();
         }
      }
      
      override protected function isPillarCollide() : Boolean
      {
         return true;
      }
   }
}
