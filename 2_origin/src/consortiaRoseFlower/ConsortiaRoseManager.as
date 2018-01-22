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
      
      public function ConsortiaRoseManager(param1:inner)
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
      
      public function onConsortiaRose(param1:PkgEvent) : void
      {
         var _loc3_:* = NaN;
         var _loc9_:* = null;
         var _loc5_:PackageIn = param1.pkg;
         var _loc8_:int = _loc5_.readInt();
         var _loc2_:String = _loc5_.readUTF();
         var _loc6_:int = _loc5_.readInt();
         var _loc4_:String = PlayerManager.Instance.Self.ConsortiaName;
         var _loc7_:Boolean = false;
         if(isInBattle())
         {
            _loc3_ = Number(_showTime / 1000);
            _loc7_ = true;
         }
         else
         {
            _loc3_ = 3;
            _loc7_ = false;
         }
         if(_loc2_ == PlayerManager.Instance.Self.NickName)
         {
            _loc9_ = LanguageMgr.GetTranslation("consortia.roseFlower.myRoseExp",_loc6_);
            MessageTipManager.getInstance().show(_loc9_,0,false,3);
            ChatManager.Instance.sysChatLinkYellow(_loc9_);
         }
         else
         {
            _loc9_ = LanguageMgr.GetTranslation("consortia.roseFlower.Exp",_loc2_,_loc6_);
            ChatManager.Instance.sysChatLinkYellow(_loc9_);
         }
         _playList.push([_loc7_,_loc4_,_loc2_]);
         playRose();
      }
      
      public function playRose() : void
      {
         var _loc1_:* = null;
         if(_playList.length > 0 && _isPlaying == false)
         {
            _isPlaying = true;
            _loc1_ = _playList.shift();
            show(_loc1_[0],_loc1_[1],_loc1_[2]);
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
                  addr10:
                  return true;
               }
               addr9:
               §§goto(addr10);
            }
            addr8:
            §§goto(addr9);
         }
         §§goto(addr8);
      }
      
      public function show(param1:Boolean, param2:String, param3:String) : void
      {
         $isInBattle = param1;
         consortiaName = param2;
         nickName = param3;
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
      
      protected function onDetailClose(param1:Event) : void
      {
         onTimerComplete(null);
      }
      
      protected function onTimerComplete(param1:Event) : void
      {
         e = param1;
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
