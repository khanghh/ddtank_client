package gameCommon.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import gameCommon.GameControl;
   import gameCommon.view.smallMap.GameTurnButton;
   
   public class AthleticsHelpView extends DungeonHelpView
   {
       
      
      private var _closeRect:Rectangle;
      
      public function AthleticsHelpView(button:GameTurnButton, barrier:DungeonInfoView, gameContainer:DisplayObjectContainer)
      {
         super(button,barrier,gameContainer);
      }
      
      override protected function init() : void
      {
         var bg:* = null;
         if(GameControl.Instance.Current.gameMode == 56)
         {
            bg = ComponentFactory.Instance.creatBitmap("asset.game.escapeBattle.help");
            _turnButton.text = LanguageMgr.GetTranslation("tank.game.escapeBattle");
         }
         else if(GameControl.Instance.Current.gameMode == 57)
         {
            bg = ComponentFactory.Instance.creatBitmap("asset.game.flagBattle.help");
            _turnButton.text = LanguageMgr.GetTranslation("tank.game.flagBattle");
         }
         _container.addChild(bg);
         _closeBtn = ComponentFactory.Instance.creat("asset.game.DungeonHelpView.closeBtn");
         PositionUtils.setPos(_closeBtn,"game.DungeonHelpView.closeBtnPos");
         _container.addChild(_closeBtn);
         _sourceRect = new Rectangle(0,0,bg.width,bg.height);
         PositionUtils.setPos(_sourceRect,"game.DungeonHelpView.closeTragetPos");
         _closeRect = new Rectangle(950,-50,2,2);
      }
      
      override protected function __timerComplete(evt:TimerEvent) : void
      {
         defaultClose();
         clearTime();
      }
      
      override public function defaultClose() : void
      {
         close(_closeRect);
      }
      
      override protected function __closeHandler(evt:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         close(_closeRect);
         StageReferance.stage.focus = null;
      }
   }
}
