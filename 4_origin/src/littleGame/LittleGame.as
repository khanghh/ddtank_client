package littleGame
{
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.states.BaseStateView;
   import ddt.view.chat.ChatView;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import invite.InviteManager;
   import littleGame.events.LittleGameSocketEvent;
   import littleGame.menu.LittleMenuBar;
   import littleGame.model.LittleLiving;
   import littleGame.model.Scenario;
   import littleGame.view.GameScene;
   import littleGame.view.LittleScoreBar;
   import littleGame.view.LittleSoundButton;
   
   public class LittleGame extends BaseStateView
   {
       
      
      private var _scene:GameScene;
      
      private var _game:Scenario;
      
      private var _chatField:ChatView;
      
      private var _menu:LittleMenuBar;
      
      private var _scoreBar:LittleScoreBar;
      
      private var _soundButton:LittleSoundButton;
      
      private var _inhaleNote:DisplayObject;
      
      public function LittleGame()
      {
         super();
      }
      
      private function configUI() : void
      {
         _scene = new GameScene(_game);
         addChild(_scene);
         _menu = ComponentFactory.Instance.creatCustomObject("LittleMenuBar");
         addChild(_menu);
         _scoreBar = new LittleScoreBar(PlayerManager.Instance.Self);
         _scoreBar.x = 706;
         _scoreBar.y = -2;
         addChild(_scoreBar);
         _soundButton = ComponentFactory.Instance.creatCustomObject("LittleSoundButton");
         addChild(_soundButton);
         if(SharedManager.Instance.allowMusic || SharedManager.Instance.allowSound)
         {
            _game.soundEnabled = true;
         }
         else
         {
            _game.soundEnabled = false;
         }
         var _loc1_:* = !!_game.soundEnabled?SharedManager.Instance.allowSound:false;
         CharacterSoundManager.instance.allowSound = _loc1_;
         SoundManager.instance.allowSound = _loc1_;
         _loc1_ = !!_game.soundEnabled?SharedManager.Instance.allowMusic:false;
         CharacterSoundManager.instance.allowMusic = _loc1_;
         SoundManager.instance.allowMusic = _loc1_;
         _soundButton.state = !!_game.soundEnabled?1:2;
         _inhaleNote = ComponentFactory.Instance.creat("asset.littleGame.InhaleNote");
         _inhaleNote.x = StageReferance.stageWidth - _inhaleNote.width >> 1;
         addChild(_inhaleNote);
         ChatManager.Instance.state = 24;
         _chatField = ChatManager.Instance.view;
         _chatField.output.isLock = true;
         addChild(_chatField);
      }
      
      private function addEvent() : void
      {
         SocketManager.Instance.addEventListener("addsprite",__addSprite);
         SocketManager.Instance.addEventListener("removesprite",__removeSprite);
         SocketManager.Instance.addEventListener("move",__livingMove);
         SocketManager.Instance.addEventListener("updatepos",__updatePos);
         SocketManager.Instance.addEventListener("updatelivingsproperty",__updateLivingProperty);
         SocketManager.Instance.addEventListener("domive",__doMovie);
         SocketManager.Instance.addEventListener("doaction",__doAction);
         SocketManager.Instance.addEventListener("addObject",__addObject);
         SocketManager.Instance.addEventListener("removeObject",__removeObject);
         SocketManager.Instance.addEventListener("invokeObject",__invokeObject);
         SocketManager.Instance.addEventListener("getscore",__selfGetScore);
         SocketManager.Instance.addEventListener("kickpalyer",__kickPlaye);
         _game.addEventListener("selfInhaledChanged",__inhaledChanged);
         _soundButton.addEventListener("click",__soundClick);
      }
      
      private function __kickPlaye(event:LittleGameSocketEvent) : void
      {
         LittleGameManager.Instance.kickPlayer(event.pkg);
      }
      
      private function __invokeObject(event:LittleGameSocketEvent) : void
      {
         LittleGameManager.Instance.invokeObject(_game,event.pkg);
      }
      
      private function __soundClick(event:MouseEvent) : void
      {
         if(SharedManager.Instance.allowMusic || SharedManager.Instance.allowSound)
         {
            _game.soundEnabled = !_game.soundEnabled;
            var _loc2_:* = !!_game.soundEnabled?SharedManager.Instance.allowSound:false;
            CharacterSoundManager.instance.allowSound = _loc2_;
            SoundManager.instance.allowSound = _loc2_;
            _loc2_ = !!_game.soundEnabled?SharedManager.Instance.allowMusic:false;
            CharacterSoundManager.instance.allowMusic = _loc2_;
            SoundManager.instance.allowMusic = _loc2_;
            _soundButton.state = !!_game.soundEnabled?1:2;
            SoundManager.instance.play("015");
         }
      }
      
      private function __inhaledChanged(event:Event) : void
      {
         if(_game.selfInhaled)
         {
            _game.removeEventListener("selfInhaledChanged",__inhaledChanged);
            if(_inhaleNote)
            {
               ObjectUtils.disposeObject(_inhaleNote);
            }
            _inhaleNote = null;
         }
      }
      
      private function __netDelay(event:LittleGameSocketEvent) : void
      {
         LittleGameManager.Instance.setNetDelay(_game,event.pkg);
      }
      
      private function __pong(event:LittleGameSocketEvent) : void
      {
         LittleGameManager.Instance.pong(_game,event.pkg);
      }
      
      private function __setClock(event:LittleGameSocketEvent) : void
      {
         LittleGameManager.Instance.setClock(_game,event.pkg);
      }
      
      private function __selfGetScore(event:LittleGameSocketEvent) : void
      {
         LittleGameManager.Instance.getScore(_game,event.pkg);
      }
      
      private function __doAction(event:LittleGameSocketEvent) : void
      {
         LittleGameManager.Instance.doAction(_game,event.pkg);
      }
      
      private function __doMovie(event:LittleGameSocketEvent) : void
      {
         LittleGameManager.Instance.doMovie(_game,event.pkg);
      }
      
      private function __removeObject(event:LittleGameSocketEvent) : void
      {
         LittleGameManager.Instance.removeObject(_game,event.pkg);
      }
      
      private function __addObject(event:LittleGameSocketEvent) : void
      {
         var type:String = event.pkg.readUTF();
         LittleGameManager.Instance.addObject(_game,type,event.pkg);
      }
      
      private function __updateLivingProperty(event:LittleGameSocketEvent) : void
      {
         LittleGameManager.Instance.updateLivingProperty(_game,event.pkg);
      }
      
      private function __updatePos(event:LittleGameSocketEvent) : void
      {
         LittleGameManager.Instance.updatePos(_game,event.pkg);
      }
      
      private function __livingMove(event:LittleGameSocketEvent) : void
      {
         var living:LittleLiving = LittleGameManager.Instance.livingMove(_game,event.pkg);
      }
      
      private function __addSprite(event:LittleGameSocketEvent) : void
      {
         LittleGameManager.Instance.addLiving(_game,event.pkg);
      }
      
      private function __removeSprite(event:LittleGameSocketEvent) : void
      {
         LittleGameManager.Instance.removeLiving(_game,event.pkg);
      }
      
      private function removeEvent() : void
      {
         SocketManager.Instance.removeEventListener("addsprite",__addSprite);
         SocketManager.Instance.removeEventListener("removesprite",__removeSprite);
         SocketManager.Instance.removeEventListener("move",__livingMove);
         SocketManager.Instance.removeEventListener("updatepos",__updatePos);
         SocketManager.Instance.removeEventListener("updatelivingsproperty",__updateLivingProperty);
         SocketManager.Instance.removeEventListener("domive",__doMovie);
         SocketManager.Instance.removeEventListener("doaction",__doAction);
         SocketManager.Instance.removeEventListener("addObject",__addObject);
         SocketManager.Instance.removeEventListener("removeObject",__removeObject);
         SocketManager.Instance.removeEventListener("invokeObject",__invokeObject);
         SocketManager.Instance.removeEventListener("getscore",__selfGetScore);
         SocketManager.Instance.removeEventListener("setclock",__setClock);
         SocketManager.Instance.removeEventListener("netdelay",__netDelay);
         SocketManager.Instance.removeEventListener("kickpalyer",__kickPlaye);
         _game.removeEventListener("selfInhaledChanged",__inhaledChanged);
         _soundButton.removeEventListener("click",__soundClick);
      }
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         InviteManager.Instance.enabled = false;
         CacheSysManager.lock("alertInFight");
         _game = data as Scenario;
         KeyboardShortcutsManager.Instance.forbiddenFull();
         LittleGameManager.Instance.setMainStage(this);
         configUI();
         LittleGameManager.Instance.setGameScene(_scene);
         addEvent();
         super.enter(prev,data);
         _game.startup();
         SoundManager.instance.playMusic(_game.music);
      }
      
      override public function getType() : String
      {
         return "littleGame";
      }
      
      override public function leaving(next:BaseStateView) : void
      {
         InviteManager.Instance.enabled = true;
         CacheSysManager.unlock("alertInFight");
         CacheSysManager.getInstance().release("alertInFight");
         removeEvent();
         KeyboardShortcutsManager.Instance.cancelForbidden();
         ObjectUtils.disposeObject(_soundButton);
         _soundButton = null;
         ObjectUtils.disposeObject(_menu);
         _menu = null;
         ObjectUtils.disposeObject(_scene);
         _scene = null;
         ObjectUtils.disposeObject(_game);
         _game = null;
         ObjectUtils.disposeObject(_inhaleNote);
         _inhaleNote = null;
         _chatField = null;
         SoundManager.instance.allowSound = SharedManager.Instance.allowSound;
         SoundManager.instance.allowMusic = SharedManager.Instance.allowMusic;
         SoundManager.instance.playMusic("062",true,false);
         var _loc2_:Boolean = false;
         CharacterSoundManager.instance.allowSound = _loc2_;
         CharacterSoundManager.instance.allowMusic = _loc2_;
         CharacterFactory.Instance.releaseResource();
         super.leaving(next);
      }
   }
}
