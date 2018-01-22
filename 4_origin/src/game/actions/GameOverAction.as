package game.actions
{
   import com.pickgliss.utils.ClassUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import game.view.map.MapView;
   import gameCommon.GameControl;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.GameInfo;
   import gameCommon.model.Living;
   import gameCommon.model.LocalPlayer;
   import gameCommon.model.Player;
   import road7th.comm.PackageIn;
   import road7th.utils.MovieClipWrapper;
   import room.RoomManager;
   
   public class GameOverAction extends BaseAction
   {
       
      
      private var _event:CrazyTankSocketEvent;
      
      private var _executed:Boolean;
      
      private var _count:int;
      
      private var _map:MapView;
      
      private var _current:GameInfo;
      
      private var _func:Function;
      
      public function GameOverAction(param1:MapView, param2:CrazyTankSocketEvent, param3:Function, param4:Number = 3000)
      {
         super();
         _func = param3;
         _event = param2;
         _map = param1;
         _count = param4 / 40;
         _current = GameControl.Instance.Current;
         readInfo(param2);
         if(RoomManager.Instance.current.selfRoomPlayer.isViewer)
         {
            _executed = true;
         }
      }
      
      private function readInfo(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:* = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:Boolean = false;
         var _loc11_:int = 0;
         var _loc13_:int = 0;
         var _loc12_:* = null;
         var _loc7_:* = null;
         var _loc3_:int = 0;
         var _loc14_:int = 0;
         if(_current)
         {
            _loc4_ = param1.pkg;
            _loc9_ = _loc4_.readInt();
            _loc10_ = _loc4_.readInt();
            _loc6_ = 0;
            while(_loc6_ < _loc10_)
            {
               _loc8_ = _loc4_.readInt();
               _loc2_ = _loc4_.readBoolean();
               _loc11_ = _loc4_.readInt();
               _loc13_ = _loc4_.readInt();
               _loc12_ = {};
               _loc12_.killGP = _loc4_.readInt();
               _loc12_.hertGP = _loc4_.readInt();
               _loc12_.fightGP = _loc4_.readInt();
               _loc12_.ghostGP = _loc4_.readInt();
               _loc12_.gpForVIP = _loc4_.readInt();
               _loc12_.gpForConsortia = _loc4_.readInt();
               _loc12_.gpForSpouse = _loc4_.readInt();
               _loc12_.gpForServer = _loc4_.readInt();
               _loc12_.gpForApprenticeOnline = _loc4_.readInt();
               _loc12_.gpForApprenticeTeam = _loc4_.readInt();
               _loc12_.gpForDoubleCard = _loc4_.readInt();
               _loc12_.gpForPower = _loc4_.readInt();
               _loc12_.consortiaSkill = _loc4_.readInt();
               _loc12_.luckyExp = _loc4_.readInt();
               _loc12_.gainGP = _loc4_.readInt();
               _loc12_.gpCSMUser = _loc4_.readInt();
               _loc12_.gpAddWell = _loc4_.readInt();
               trace("gpCSMUser:" + _loc12_.gpCSMUser);
               _loc12_.offerFight = _loc4_.readInt();
               _loc12_.offerDoubleCard = _loc4_.readInt();
               _loc12_.offerVIP = _loc4_.readInt();
               _loc12_.offerService = _loc4_.readInt();
               _loc12_.offerBuff = _loc4_.readInt();
               _loc12_.offerConsortia = _loc4_.readInt();
               _loc12_.luckyOffer = _loc4_.readInt();
               _loc12_.gainOffer = _loc4_.readInt();
               _loc12_.offerCSMUser = _loc4_.readInt();
               _loc12_.offerAddWell = _loc4_.readInt();
               trace("offerCSMUser:" + _loc12_.offerCSMUser);
               _loc12_.canTakeOut = _loc4_.readInt();
               _loc12_.isDouble = _loc4_.readBoolean();
               _loc12_.prestige = _loc4_.readInt();
               _loc12_.killNum = _loc4_.readInt();
               _loc12_.gameOverType = 1;
               _loc7_ = _current.findPlayer(_loc8_);
               if(_loc7_)
               {
                  _loc7_.isWin = _loc2_;
                  _loc7_.CurrentGP = _loc13_;
                  _loc7_.CurrentLevel = _loc11_;
                  _loc7_.expObj = _loc12_;
                  _loc7_.GainGP = _loc12_.gainGP;
                  _loc7_.GainOffer = _loc12_.gainOffer;
                  _loc7_.GetCardCount = _loc12_.canTakeOut;
                  _loc7_.killNum = _loc12_.killNum;
               }
               if(_loc7_ is LocalPlayer)
               {
                  _loc7_.tieStatus = _loc9_;
               }
               _loc6_++;
            }
            _current.GainRiches = _loc4_.readInt();
            _loc3_ = _loc4_.readInt();
            _loc14_ = _loc4_.readInt();
            var _loc16_:int = 0;
            var _loc15_:* = _current.livings;
            for each(var _loc5_ in _current.livings)
            {
               if(_loc5_.character)
               {
                  _loc5_.character.resetShowBitmapBig();
               }
            }
         }
      }
      
      override public function cancel() : void
      {
         if(_event)
         {
            _event.executed = true;
         }
         _current = null;
         _map = null;
         _event = null;
         _func = null;
      }
      
      override public function execute() : void
      {
         var _loc1_:* = null;
         if(!_executed)
         {
            if(_map.hasSomethingMoving() == false && (_map.currentPlayer == null || _map.currentPlayer.actionCount == 0))
            {
               _executed = true;
               _event.executed = true;
               if(_map.currentPlayer && _map.currentPlayer.isExist)
               {
                  _map.currentPlayer.beginNewTurn();
               }
               if(RoomManager.Instance.current.type == 19)
               {
                  if(GameControl.Instance.Current.selfGamePlayer.tieStatus == -1)
                  {
                     _loc1_ = new MovieClipWrapper(MovieClip(ClassUtils.CreatInstance("asset.game.newTieAsset")),true,true);
                     _loc1_.movie.x = 434;
                     _loc1_.movie.y = 244;
                  }
                  else if(GameControl.Instance.Current.selfGamePlayer.isWin)
                  {
                     _loc1_ = new MovieClipWrapper(MovieClip(ClassUtils.CreatInstance("asset.game.newWinAsset")),true,true);
                     _loc1_.movie.x = 359;
                     _loc1_.movie.y = 217;
                  }
                  else
                  {
                     _loc1_ = new MovieClipWrapper(MovieClip(ClassUtils.CreatInstance("asset.game.newLostAsset")),true,true);
                     _loc1_.movie.x = 438;
                     _loc1_.movie.y = 244;
                  }
               }
               else
               {
                  if(GameControl.Instance.Current.selfGamePlayer.isWin)
                  {
                     _loc1_ = new MovieClipWrapper(MovieClip(ClassUtils.CreatInstance("asset.game.winAsset")),true,true);
                  }
                  else
                  {
                     _loc1_ = new MovieClipWrapper(MovieClip(ClassUtils.CreatInstance("asset.game.lostAsset")),true,true);
                  }
                  _loc1_.movie.x = 500;
                  _loc1_.movie.y = 360;
               }
               SoundManager.instance.play("040");
               _map.gameView.addChild(_loc1_.movie);
            }
         }
         else
         {
            _count = Number(_count) - 1;
            if(_count <= 0)
            {
               _func();
               _isFinished = true;
               cancel();
            }
         }
      }
   }
}
