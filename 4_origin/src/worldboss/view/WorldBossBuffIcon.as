package worldboss.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import worldboss.WorldBossManager;
   
   public class WorldBossBuffIcon extends Sprite implements Disposeable
   {
       
      
      private var _moneyBtn:SimpleBitmapButton;
      
      private var _bindMoneyBtn:SimpleBitmapButton;
      
      private var _buffIcon:WorldBossBuffItem;
      
      public function WorldBossBuffIcon()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:int = WorldBossManager.Instance.bossInfo.addInjureBuffMoney;
         var _loc2_:int = WorldBossManager.Instance.bossInfo.addInjureValue;
         _moneyBtn = ComponentFactory.Instance.creat("worldbossRoom.money.buffBtn");
         _bindMoneyBtn = ComponentFactory.Instance.creat("worldbossRoom.bindMoney.buffBtn");
         _moneyBtn.tipData = LanguageMgr.GetTranslation("worldboss.money.buffBtn.tip",_loc1_,_loc2_);
         _bindMoneyBtn.tipData = LanguageMgr.GetTranslation("worldboss.bindMoney.buffBtn.tip",_loc1_,_loc2_);
         _buffIcon = new WorldBossBuffItem();
         PositionUtils.setPos(_buffIcon,"worldboss.RoomView.BuffIconPos");
         addChild(_moneyBtn);
         addChild(_bindMoneyBtn);
         addChild(_buffIcon);
      }
      
      private function addEvent() : void
      {
         _moneyBtn.addEventListener("click",buyBuff);
         _bindMoneyBtn.addEventListener("click",buyBuff);
      }
      
      private function buyBuff(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         SoundManager.instance.playButtonSound();
         if(param1.currentTarget == _moneyBtn)
         {
            _loc3_ = 1;
         }
         else
         {
            _loc3_ = 2;
         }
         if(_loc3_ == 1 && SharedManager.Instance.isWorldBossBuyBuff)
         {
            WorldBossManager.Instance.buyNewBuff(_loc3_,SharedManager.Instance.isWorldBossBuyBuffFull);
            return;
         }
         if(_loc3_ == 2 && SharedManager.Instance.isWorldBossBindBuyBuff)
         {
            WorldBossManager.Instance.buyNewBuff(_loc3_,SharedManager.Instance.isWorldBossBindBuyBuffFull);
            return;
         }
         var _loc2_:WorldBossBuyBuffConfirmFrame = ComponentFactory.Instance.creatComponentByStylename("worldboss.buyBuff.confirmFrame");
         _loc2_.show(_loc3_);
         _loc2_.addEventListener("response",__onResponse);
      }
      
      private function __onResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:WorldBossBuyBuffConfirmFrame = param1.currentTarget as WorldBossBuyBuffConfirmFrame;
         _loc2_.removeEventListener("response",__onResponse);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
         }
      }
      
      private function removeEvent() : void
      {
         if(_moneyBtn)
         {
            _moneyBtn.removeEventListener("click",buyBuff);
         }
         if(_bindMoneyBtn)
         {
            _bindMoneyBtn.removeEventListener("click",buyBuff);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            this.parent.removeChild(this);
         }
         _moneyBtn = null;
         _bindMoneyBtn = null;
         _buffIcon = null;
      }
   }
}
