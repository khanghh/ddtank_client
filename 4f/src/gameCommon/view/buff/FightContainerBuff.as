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
      
      public function FightContainerBuff(param1:int, param2:int = 2){super(null);}
      
      public function addFightBuff(param1:FightBuffInfo) : void{}
      
      public function get tipData() : Object{return null;}
      
      public function dispose() : void{}
   }
}
