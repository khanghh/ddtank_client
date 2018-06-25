package gameCommon.view.buff
{
   import com.pickgliss.ui.core.Disposeable;
   import ddt.data.BuffInfo;
   import ddt.data.BuffType;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.view.tips.BuffTipInfo;
   import gameCommon.model.FightBuffInfo;
   
   public class FightContainerBuff extends FightBuffInfo implements Disposeable
   {
       
      
      private var _buffs:Vector.<FightBuffInfo>;
      
      public function FightContainerBuff(id:int, $type:int = 2)
      {
         _buffs = new Vector.<FightBuffInfo>();
         super(id);
         type = $type;
      }
      
      public function addFightBuff(buff:FightBuffInfo) : void
      {
         _buffs.push(buff);
      }
      
      public function get tipData() : Object
      {
         var buffs:* = undefined;
         var buff:* = null;
         var data:BuffTipInfo = new BuffTipInfo();
         if(type == 2)
         {
            data.isActive = true;
            data.describe = LanguageMgr.GetTranslation("tank.view.buff.PayBuff.Note");
            data.name = LanguageMgr.GetTranslation("tank.view.buff.PayBuff.Name");
            data.isFree = false;
            buffs = new Vector.<BuffInfo>();
            var _loc6_:int = 0;
            var _loc5_:* = _buffs;
            for each(var fightBuff in _buffs)
            {
               if(BuffType.isPayBuff(fightBuff.id) && fightBuff.isSelf)
               {
                  buff = PlayerManager.Instance.Self.getBuff(fightBuff.id);
                  buff.calculatePayBuffValidDay();
               }
               else
               {
                  buff = new BuffInfo(fightBuff.id);
                  buff.day = fightBuff.data;
                  buff.isSelf = false;
               }
               buffs.push(buff);
            }
            data.linkBuffs = buffs;
         }
         else if(type == 3)
         {
            data.isActive = true;
            data.name = LanguageMgr.GetTranslation("tank.view.buff.consortiaBuff");
            data.isFree = false;
            data.linkBuffs = _buffs;
         }
         else
         {
            data.isActive = true;
            data.name = LanguageMgr.GetTranslation("tank.view.buff.cardBuff");
            data.isFree = false;
            data.linkBuffs = _buffs;
         }
         return data;
      }
      
      public function dispose() : void
      {
         _buffs.length = 0;
      }
   }
}
