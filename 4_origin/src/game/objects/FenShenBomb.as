package game.objects
{
   import ddt.manager.SoundManager;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   
   public class FenShenBomb extends SimpleBomb
   {
       
      
      public function FenShenBomb(param1:Bomb, param2:Living, param3:int = 0)
      {
         super(param1,param2,param3);
      }
      
      override public function die() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(_info.childs.length > 0)
         {
            SoundManager.instance.play(_info.Template.ShootSound);
            _loc3_ = 0;
            while(_loc3_ < _info.childs.length)
            {
               _loc1_ = _info.childs[_loc3_] as Bomb;
               _loc2_ = new SimpleBomb(_loc1_,_owner,_refineryLevel);
               this.map.addPhysical(_loc2_);
               if(fastModel)
               {
                  _loc2_.bombAtOnce();
               }
               _loc3_++;
            }
         }
         super.die();
      }
   }
}
