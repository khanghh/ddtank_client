package game.objects
{
   import ddt.manager.SoundManager;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   
   public class FenShenBomb extends SimpleBomb
   {
       
      
      public function FenShenBomb(info:Bomb, owner:Living, refineryLevel:int = 0)
      {
         super(info,owner,refineryLevel);
      }
      
      override public function die() : void
      {
         var i:int = 0;
         var childBomb:* = null;
         var simpleBomb:* = null;
         if(_info.childs.length > 0)
         {
            SoundManager.instance.play(_info.Template.ShootSound);
            for(i = 0; i < _info.childs.length; )
            {
               childBomb = _info.childs[i] as Bomb;
               simpleBomb = new SimpleBomb(childBomb,_owner,_refineryLevel);
               this.map.addPhysical(simpleBomb);
               if(fastModel)
               {
                  simpleBomb.bombAtOnce();
               }
               i++;
            }
         }
         super.die();
      }
   }
}
