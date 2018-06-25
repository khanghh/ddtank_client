package farm.viewx
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddtBuried.BuriedManager;
   import farm.FarmModelController;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CountdownView extends Sprite
   {
       
      
      private var _fastForward:BaseButton;
      
      private var _fieldID:int;
      
      public function CountdownView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _fastForward = ComponentFactory.Instance.creatComponentByStylename("farm.fastForwardBtn");
         addChild(_fastForward);
      }
      
      public function setCountdown(fieldID:int) : void
      {
         _fieldID = fieldID;
      }
      
      public function setFastBtnEnable(flag:Boolean) : void
      {
         _fastForward.visible = flag;
      }
      
      private function initEvent() : void
      {
         _fastForward.addEventListener("click",__fastBtnClick);
      }
      
      protected function __fastBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         this.visible = false;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.farms.fastForwardInfo",FarmModelController.instance.gropPrice),"",LanguageMgr.GetTranslation("cancel"),false,false,false,2,null,"SimpleAlert",30,true,0);
         alert.addEventListener("response",__onResponse);
      }
      
      protected function __onResponse(event:FrameEvent) : void
      {
         var needMoney:int = 0;
         SoundManager.instance.play("008");
         var isBand:Boolean = (event.target as BaseAlerFrame).isBand;
         (event.target as BaseAlerFrame).removeEventListener("response",__onResponse);
         (event.target as BaseAlerFrame).dispose();
         if(event.responseCode == 2 || event.responseCode == 3)
         {
            needMoney = FarmModelController.instance.gropPrice;
            if(BuriedManager.Instance.checkMoney(isBand,needMoney))
            {
               return;
            }
            SocketManager.Instance.out.fastForwardGrop(isBand,false,_fieldID);
         }
      }
      
      private function remvoeEvent() : void
      {
         _fastForward.removeEventListener("click",__fastBtnClick);
      }
      
      public function dispose() : void
      {
         remvoeEvent();
         if(_fastForward)
         {
            _fastForward.dispose();
            _fastForward = null;
         }
      }
   }
}
