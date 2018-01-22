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
      
      public function setCountdown(param1:int) : void
      {
         _fieldID = param1;
      }
      
      public function setFastBtnEnable(param1:Boolean) : void
      {
         _fastForward.visible = param1;
      }
      
      private function initEvent() : void
      {
         _fastForward.addEventListener("click",__fastBtnClick);
      }
      
      protected function __fastBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         this.visible = false;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.farms.fastForwardInfo",FarmModelController.instance.gropPrice),"",LanguageMgr.GetTranslation("cancel"),false,false,false,2,null,"SimpleAlert",30,true,0);
         _loc2_.addEventListener("response",__onResponse);
      }
      
      protected function __onResponse(param1:FrameEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("008");
         var _loc3_:Boolean = (param1.target as BaseAlerFrame).isBand;
         (param1.target as BaseAlerFrame).removeEventListener("response",__onResponse);
         (param1.target as BaseAlerFrame).dispose();
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            _loc2_ = FarmModelController.instance.gropPrice;
            if(BuriedManager.Instance.checkMoney(_loc3_,_loc2_))
            {
               return;
            }
            SocketManager.Instance.out.fastForwardGrop(_loc3_,false,_fieldID);
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
