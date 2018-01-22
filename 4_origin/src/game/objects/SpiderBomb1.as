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
      
      public function SpiderBomb1(param1:Bomb, param2:Living, param3:int = 0, param4:Boolean = false)
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
         var _loc2_:SpiderBomb2 = new SpiderBomb2(param1,_owner,_refineryLevel);
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
