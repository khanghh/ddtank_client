package happyLittleGame
{
   import com.pickgliss.loader.QueueLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.loader.LoaderCreate;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import happyLittleGame.bombshellGame.view.BombGameView;
   import happyLittleGame.bombshellGame.view.LittleGameEntranceView;
   import uiModeManager.bombUI.HappyLittleGameManager;
   
   public class LittileGameFrame extends Frame
   {
       
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _enterView:LittleGameEntranceView;
      
      private var _gameView:BombGameView;
      
      public function LittileGameFrame()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         this.titleText = LanguageMgr.GetTranslation("ddt.bombgame.frame.title");
         _enterView = new LittleGameEntranceView();
         PositionUtils.setPos(_enterView,"bombgame.enteranceview.point");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("bombgame.frame.helpbtn");
         addToContent(_helpBtn);
         addToContent(_enterView);
         initEvent();
         LoadMapData();
      }
      
      private function LoadMapData() : void
      {
         var _loc1_:* = null;
         if(HappyLittleGameManager.instance.bombManager.Fixeddata == null)
         {
            _loc1_ = new QueueLoader();
            _loc1_.addLoader(LoaderCreate.Instance.createBombFixedMapData());
            _loc1_.addLoader(LoaderCreate.Instance.createBombRandomMapData());
         }
         if(_loc1_)
         {
            _loc1_.start();
         }
      }
      
      private function initEvent() : void
      {
         HappyLittleGameManager.instance.addEventListener("entergame",__enterGameHandler);
         HappyLittleGameManager.instance.addEventListener("cometoback",__backGameHandler);
         _helpBtn.addEventListener("click",__helpBtnClickHandler);
      }
      
      private function __helpBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         HelpFrameUtils.Instance.simpleHelpFrame(LanguageMgr.GetTranslation("store.view.HelpButtonText"),"ddt.littlegame.help",410,490,false);
      }
      
      private function __enterGameHandler(param1:Event) : void
      {
         if(HappyLittleGameManager.instance.currentGameType == 2 || HappyLittleGameManager.instance.currentGameType == 1)
         {
            if(_gameView == null)
            {
               _gameView = new BombGameView();
               LayerManager.Instance.addToLayer(_gameView,3);
            }
            this.visible = false;
            if(_gameView.visible == false)
            {
               _gameView.visible = true;
            }
            _gameView.ReStart();
         }
      }
      
      private function __backGameHandler(param1:Event) : void
      {
         if(HappyLittleGameManager.instance.currentGameType == 2 || HappyLittleGameManager.instance.currentGameType == 1)
         {
            if(_gameView != null)
            {
               ObjectUtils.disposeObject(_gameView);
               _gameView = null;
            }
         }
         this.visible = true;
         HappyLittleGameManager.instance.clearData();
      }
      
      private function removeEvent() : void
      {
         HappyLittleGameManager.instance.removeEventListener("entergame",__enterGameHandler);
         HappyLittleGameManager.instance.removeEventListener("cometoback",__backGameHandler);
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      override protected function onResponse(param1:int) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         HappyLittleGameManager.instance.clearData();
         ObjectUtils.disposeObject(_gameView);
         _gameView = null;
         ObjectUtils.disposeObject(_enterView);
         _enterView = null;
         ObjectUtils.disposeObject(_helpBtn);
         _enterView = null;
         super.dispose();
      }
   }
}
