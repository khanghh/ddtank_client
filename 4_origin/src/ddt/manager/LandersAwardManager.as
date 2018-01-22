package ddt.manager
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.MovieImage;
   import ddt.events.PkgEvent;
   import flash.events.MouseEvent;
   import microenddownload.MicroendDownloadAwardsManager;
   import road7th.comm.PackageIn;
   
   public class LandersAwardManager
   {
      
      private static var _instance:LandersAwardManager;
       
      
      private var _landersBtn:MovieImage;
      
      private var _getFlag:Boolean = true;
      
      private var _hBox:HBox;
      
      private var _landersAwardOfficial:Boolean;
      
      public function LandersAwardManager()
      {
         super();
      }
      
      public static function get instance() : LandersAwardManager
      {
         if(!_instance)
         {
            _instance = new LandersAwardManager();
         }
         return _instance;
      }
      
      public function get landersAwardOfficial() : Boolean
      {
         return _landersAwardOfficial;
      }
      
      public function set landersAwardOfficial(param1:Boolean) : void
      {
         _landersAwardOfficial = param1;
         checkShowIcon();
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(404,48),__onIsReceiveAward);
      }
      
      protected function __onIsReceiveAward(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _getFlag = _loc2_.readBoolean();
         checkShowIcon();
      }
      
      private function checkShowIcon() : void
      {
         if(!_getFlag && landersAwardOfficial)
         {
            showIcon();
         }
         else
         {
            disposeEntryBtn();
         }
      }
      
      private function showIcon() : void
      {
         if(_hBox)
         {
            createEntryBtn(_hBox);
         }
      }
      
      public function createEntryBtn(param1:HBox) : void
      {
         _hBox = param1;
         if(landersAwardOfficial && !_getFlag)
         {
            if(!_landersBtn)
            {
               _landersBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.landersAward");
               _landersBtn.buttonMode = true;
               _landersBtn.tipData = LanguageMgr.GetTranslation("ddt.hallStateView.landerAward");
               _landersBtn.addEventListener("click",__onGetAward);
               _hBox.addChild(_landersBtn);
            }
         }
      }
      
      protected function __onGetAward(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(DesktopManager.Instance.landersAwardFlag || DesktopManager.Instance.isDesktop)
         {
            SocketManager.Instance.out.receiveLandersAward();
         }
         else
         {
            MicroendDownloadAwardsManager.getInstance().show();
         }
      }
      
      public function disposeEntryBtn() : void
      {
         if(_landersBtn)
         {
            _landersBtn.removeEventListener("click",__onGetAward);
            _landersBtn.dispose();
            _landersBtn = null;
            _hBox = null;
         }
      }
   }
}
