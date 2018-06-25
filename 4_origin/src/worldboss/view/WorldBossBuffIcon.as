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
         var addInjureBuffMoney:int = WorldBossManager.Instance.bossInfo.addInjureBuffMoney;
         var addInjureValue:int = WorldBossManager.Instance.bossInfo.addInjureValue;
         _moneyBtn = ComponentFactory.Instance.creat("worldbossRoom.money.buffBtn");
         _bindMoneyBtn = ComponentFactory.Instance.creat("worldbossRoom.bindMoney.buffBtn");
         _moneyBtn.tipData = LanguageMgr.GetTranslation("worldboss.money.buffBtn.tip",addInjureBuffMoney,addInjureValue);
         _bindMoneyBtn.tipData = LanguageMgr.GetTranslation("worldboss.bindMoney.buffBtn.tip",addInjureBuffMoney,addInjureValue);
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
      
      private function buyBuff(event:MouseEvent) : void
      {
         var tag:int = 0;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         SoundManager.instance.playButtonSound();
         if(event.currentTarget == _moneyBtn)
         {
            tag = 1;
         }
         else
         {
            tag = 2;
         }
         if(tag == 1 && SharedManager.Instance.isWorldBossBuyBuff)
         {
            WorldBossManager.Instance.buyNewBuff(tag,SharedManager.Instance.isWorldBossBuyBuffFull);
            return;
         }
         if(tag == 2 && SharedManager.Instance.isWorldBossBindBuyBuff)
         {
            WorldBossManager.Instance.buyNewBuff(tag,SharedManager.Instance.isWorldBossBindBuyBuffFull);
            return;
         }
         var alert:WorldBossBuyBuffConfirmFrame = ComponentFactory.Instance.creatComponentByStylename("worldboss.buyBuff.confirmFrame");
         alert.show(tag);
         alert.addEventListener("response",__onResponse);
      }
      
      private function __onResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:WorldBossBuyBuffConfirmFrame = evt.currentTarget as WorldBossBuyBuffConfirmFrame;
         alert.removeEventListener("response",__onResponse);
         if(evt.responseCode == 2 || evt.responseCode == 3)
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
