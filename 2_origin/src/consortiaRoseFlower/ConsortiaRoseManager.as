package consortiaRoseFlower
{
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.utils.HelperUIModuleLoad;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import road7th.comm.PackageIn;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class ConsortiaRoseManager extends EventDispatcher
   {
      
      public static const CLOSE_ROSE:String = "close_rose";
      
      private static var instance:ConsortiaRoseManager;
       
      
      private var _roseView:ConsortiaRoseView;
      
      private var _timer:TimerJuggler;
      
      private var _showTime:Number = 30000;
      
      private var _delaySeconds:Number = 3;
      
      private var _playList:Array;
      
      private var _isPlaying:Boolean = false;
      
      private var _detailView:ConsortiaRoseDetailView;
      
      public function ConsortiaRoseManager(single:inner)
      {
         _playList = [];
         super();
      }
      
      public static function getInstance() : ConsortiaRoseManager
      {
         if(!instance)
         {
            instance = new ConsortiaRoseManager(new inner());
         }
         return instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(320),onConsortiaRose);
      }
      
      public function onConsortiaRose(e:PkgEvent) : void
      {
         var timeDuration:* = NaN;
         var msg:* = null;
         var pkg:PackageIn = e.pkg;
         var consortiaID:int = pkg.readInt();
         var nickName:String = pkg.readUTF();
         var expGained:int = pkg.readInt();
         var consortiaName:String = PlayerManager.Instance.Self.ConsortiaName;
         var isInBtl:Boolean = false;
         if(isInBattle())
         {
            timeDuration = Number(_showTime / 1000);
            isInBtl = true;
         }
         else
         {
            timeDuration = 3;
            isInBtl = false;
         }
         if(nickName == PlayerManager.Instance.Self.NickName)
         {
            msg = LanguageMgr.GetTranslation("consortia.roseFlower.myRoseExp",expGained);
            MessageTipManager.getInstance().show(msg,0,false,3);
            ChatManager.Instance.sysChatLinkYellow(msg);
         }
         else
         {
            msg = LanguageMgr.GetTranslation("consortia.roseFlower.Exp",nickName,expGained);
            ChatManager.Instance.sysChatLinkYellow(msg);
         }
         _playList.push([isInBtl,consortiaName,nickName]);
         playRose();
      }
      
      public function playRose() : void
      {
         var dataArr:* = null;
         if(_playList.length > 0 && _isPlaying == false)
         {
            _isPlaying = true;
            dataArr = _playList.shift();
            show(dataArr[0],dataArr[1],dataArr[2]);
         }
      }
      
      private function isInBattle() : Boolean
      {
         var _loc1_:* = StateManager.currentStateType;
         if("fightLabGameView" !== _loc1_)
         {
            if("matchRoom" !== _loc1_)
            {
               if("challengeRoom" !== _loc1_)
               {
                  if("dungeonRoom" !== _loc1_)
                  {
                     if("fighting" !== _loc1_)
                     {
                        return false;
                     }
                  }
                  addr13:
                  return true;
               }
               addr12:
               §§goto(addr13);
            }
            addr11:
            §§goto(addr12);
         }
         §§goto(addr11);
      }
      
      public function show($isInBattle:Boolean, consortiaName:String, nickName:String) : void
      {
         $isInBattle = $isInBattle;
         consortiaName = consortiaName;
         nickName = nickName;
         onLoaded = function():void
         {
            _roseView = new ConsortiaRoseView();
            StageReferance.stage.addChild(_roseView);
            _roseView.startFly();
            _timer = TimerManager.getInstance().addTimerJuggler(_showTime,1,false);
            _timer.addEventListener("timerComplete",onTimerComplete);
            _timer.start();
            _detailView = new ConsortiaRoseDetailView($isInBattle,consortiaName,nickName);
            PositionUtils.setPos(_detailView,"rose.ViewPos");
            _detailView.addEventListener("close_rose",onDetailClose);
            StageReferance.stage.addChild(_detailView);
            if(!$isInBattle)
            {
               TweenLite.delayedCall(_delaySeconds,exitDetail);
            }
         };
         new HelperUIModuleLoad().loadUIModule(["consortiaRose"],onLoaded);
      }
      
      private function exitDetail() : void
      {
         if(_detailView == null)
         {
            return;
         }
         ObjectUtils.disposeObject(_detailView);
         _detailView = null;
      }
      
      private function onDetailViewAutoClose() : void
      {
         exitDetail();
         _isPlaying = false;
         playRose();
      }
      
      protected function onDetailClose(e:Event) : void
      {
         onTimerComplete(null);
      }
      
      protected function onTimerComplete(e:Event) : void
      {
         e = e;
         onHide = function():void
         {
            _roseView.parent && StageReferance.stage.removeChild(_roseView);
            _roseView.stopFly();
            _roseView = null;
            onDetailViewAutoClose();
         };
         _timer.stop();
         _timer.removeEventListener("timerComplete",onTimerComplete);
         TimerManager.getInstance().removeJugglerByTimer(_timer);
         _timer = null;
         TweenMax.to(_roseView,1,{
            "alpha":0,
            "onComplete":onHide
         });
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
