package guardCore
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import guardCore.data.GuardCoreInfo;
   import trainer.view.NewHandContainer;
   
   public class GuardCoreIcon extends Component
   {
       
      
      private var _info:GuardCoreInfo;
      
      private var _icon:Bitmap;
      
      private var _player:PlayerInfo;
      
      public function GuardCoreIcon()
      {
         super();
      }
      
      public function setup(param1:PlayerInfo, param2:Boolean = true) : void
      {
         if(_player)
         {
            _player.removeEventListener("propertychange",__onGuardChange);
            this.removeEventListener("click",__onClick);
         }
         _player = param1;
         _player.addEventListener("propertychange",__onGuardChange);
         _info = GuardCoreManager.instance.getGuardCoreInfoByID(_player.guardCoreID);
         if(_player.isSelf && param2)
         {
            this.buttonMode = true;
            this.addEventListener("click",__onClick);
         }
         else
         {
            this.buttonMode = false;
         }
         updateIcon();
      }
      
      private function __onClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         GuardCoreManager.instance.show();
         checkGuide();
      }
      
      private function checkGuide() : void
      {
         if(!PlayerManager.Instance.Self.isNewOnceFinish(140))
         {
            NewHandContainer.Instance.clearArrowByID(150);
            SocketManager.Instance.out.syncWeakStep(140);
         }
      }
      
      private function __onGuardChange(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["GuardCoreID"])
         {
            _info = GuardCoreManager.instance.getGuardCoreInfoByID(param1.target.guardCoreID);
            updateIcon();
         }
      }
      
      private function updateIcon() : void
      {
         if(_info)
         {
            ObjectUtils.disposeObject(_icon);
            _icon = null;
            _icon = ComponentFactory.Instance.creatBitmap("asset.ddtcorei.guardCoreIcon" + _info.Type);
            addChild(_icon);
            tipData = _info.Name;
         }
         else
         {
            tipData = LanguageMgr.GetTranslation("guardCore.tipsError");
         }
      }
      
      override public function dispose() : void
      {
         this.removeEventListener("click",__onClick);
         _player.removeEventListener("propertychange",__onGuardChange);
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         _info = null;
         _player = null;
         super.dispose();
      }
   }
}
