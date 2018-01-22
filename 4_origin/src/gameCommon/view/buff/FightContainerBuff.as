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
      
      public function FightContainerBuff(param1:int, param2:int = 2)
      {
         _buffs = new Vector.<FightBuffInfo>();
         super(param1);
         type = param2;
      }
      
      public function addFightBuff(param1:FightBuffInfo) : void
      {
         _buffs.push(param1);
      }
      
      public function get tipData() : Object
      {
         var _loc1_:* = undefined;
         var _loc4_:* = null;
         var _loc2_:BuffTipInfo = new BuffTipInfo();
         if(type == 2)
         {
            _loc2_.isActive = true;
            _loc2_.describe = LanguageMgr.GetTranslation("tank.view.buff.PayBuff.Note");
            _loc2_.name = LanguageMgr.GetTranslation("tank.view.buff.PayBuff.Name");
            _loc2_.isFree = false;
            _loc1_ = new Vector.<BuffInfo>();
            var _loc6_:int = 0;
            var _loc5_:* = _buffs;
            for each(var _loc3_ in _buffs)
            {
               if(BuffType.isPayBuff(_loc3_.id) && _loc3_.isSelf)
               {
                  _loc4_ = PlayerManager.Instance.Self.getBuff(_loc3_.id);
                  _loc4_.calculatePayBuffValidDay();
               }
               else
               {
                  _loc4_ = new BuffInfo(_loc3_.id);
                  _loc4_.day = _loc3_.data;
                  _loc4_.isSelf = false;
               }
               _loc1_.push(_loc4_);
            }
            _loc2_.linkBuffs = _loc1_;
         }
         else if(type == 3)
         {
            _loc2_.isActive = true;
            _loc2_.name = LanguageMgr.GetTranslation("tank.view.buff.consortiaBuff");
            _loc2_.isFree = false;
            _loc2_.linkBuffs = _buffs;
         }
         else
         {
            _loc2_.isActive = true;
            _loc2_.name = LanguageMgr.GetTranslation("tank.view.buff.cardBuff");
            _loc2_.isFree = false;
            _loc2_.linkBuffs = _buffs;
         }
         return _loc2_;
      }
      
      public function dispose() : void
      {
         _buffs.length = 0;
      }
   }
}
