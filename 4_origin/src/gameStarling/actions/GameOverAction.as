package gameStarling.actions
{
   import com.pickgliss.utils.ClassUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import gameCommon.GameControl;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.GameInfo;
   import gameCommon.model.Living;
   import gameCommon.model.LocalPlayer;
   import gameCommon.model.Player;
   import gameStarling.view.map.MapView3D;
   import road7th.comm.PackageIn;
   import road7th.utils.MovieClipWrapper;
   import room.RoomManager;
   
   public class GameOverAction extends BaseAction
   {
       
      
      private var _event:CrazyTankSocketEvent;
      
      private var _executed:Boolean;
      
      private var _count:int;
      
      private var _map:MapView3D;
      
      private var _current:GameInfo;
      
      private var _func:Function;
      
      public function GameOverAction(map:MapView3D, event:CrazyTankSocketEvent, func:Function, waitTime:Number = 3000)
      {
         super();
         _func = func;
         _event = event;
         _map = map;
         _count = waitTime / 40;
         _current = GameControl.Instance.Current;
         readInfo(event);
         if(RoomManager.Instance.current.selfRoomPlayer.isViewer)
         {
            _executed = true;
         }
      }
      
      private function readInfo(event:CrazyTankSocketEvent) : void
      {
         var pkg:* = null;
         var tieStatus:int = 0;
         var num:int = 0;
         var i:int = 0;
         var id:int = 0;
         var isWin:Boolean = false;
         var grade:int = 0;
         var gp:int = 0;
         var obj:* = null;
         var info:* = null;
         var redFinalScore:int = 0;
         var blueFinalScore:int = 0;
         if(_current)
         {
            pkg = event.pkg;
            tieStatus = pkg.readInt();
            num = pkg.readInt();
            for(i = 0; i < num; )
            {
               id = pkg.readInt();
               isWin = pkg.readBoolean();
               grade = pkg.readInt();
               gp = pkg.readInt();
               obj = {};
               obj.killGP = pkg.readInt();
               obj.hertGP = pkg.readInt();
               obj.fightGP = pkg.readInt();
               obj.ghostGP = pkg.readInt();
               obj.gpForVIP = pkg.readInt();
               obj.gpForConsortia = pkg.readInt();
               obj.gpForSpouse = pkg.readInt();
               obj.gpForServer = pkg.readInt();
               obj.gpForApprenticeOnline = pkg.readInt();
               obj.gpForApprenticeTeam = pkg.readInt();
               obj.gpForDoubleCard = pkg.readInt();
               obj.gpForPower = pkg.readInt();
               obj.consortiaSkill = pkg.readInt();
               obj.luckyExp = pkg.readInt();
               obj.gainGP = pkg.readInt();
               obj.gpCSMUser = pkg.readInt();
               obj.gpAddWell = pkg.readInt();
               trace("gpCSMUser:" + obj.gpCSMUser);
               obj.offerFight = pkg.readInt();
               obj.offerDoubleCard = pkg.readInt();
               obj.offerVIP = pkg.readInt();
               obj.offerService = pkg.readInt();
               obj.offerBuff = pkg.readInt();
               obj.offerConsortia = pkg.readInt();
               obj.luckyOffer = pkg.readInt();
               obj.gainOffer = pkg.readInt();
               obj.offerCSMUser = pkg.readInt();
               obj.offerAddWell = pkg.readInt();
               trace("offerCSMUser:" + obj.offerCSMUser);
               obj.canTakeOut = pkg.readInt();
               obj.isDouble = pkg.readBoolean();
               obj.prestige = pkg.readInt();
               obj.killNum = pkg.readInt();
               obj.gameOverType = 1;
               info = _current.findPlayer(id);
               if(info)
               {
                  info.isWin = isWin;
                  info.CurrentGP = gp;
                  info.CurrentLevel = grade;
                  info.expObj = obj;
                  info.GainGP = obj.gainGP;
                  info.GainOffer = obj.gainOffer;
                  info.GetCardCount = obj.canTakeOut;
                  info.killNum = obj.killNum;
               }
               if(info is LocalPlayer)
               {
                  info.tieStatus = tieStatus;
               }
               i++;
            }
            _current.GainRiches = pkg.readInt();
            redFinalScore = pkg.readInt();
            blueFinalScore = pkg.readInt();
            var _loc16_:int = 0;
            var _loc15_:* = _current.livings;
            for each(var j in _current.livings)
            {
               if(j.character)
               {
                  j.character.resetShowBitmapBig();
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
         var movie:* = null;
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
                     movie = new MovieClipWrapper(MovieClip(ClassUtils.CreatInstance("asset.game.newTieAsset")),true,true);
                     movie.movie.x = 434;
                     movie.movie.y = 244;
                  }
                  else if(GameControl.Instance.Current.selfGamePlayer.isWin)
                  {
                     movie = new MovieClipWrapper(MovieClip(ClassUtils.CreatInstance("asset.game.newWinAsset")),true,true);
                     movie.movie.x = 359;
                     movie.movie.y = 217;
                  }
                  else
                  {
                     movie = new MovieClipWrapper(MovieClip(ClassUtils.CreatInstance("asset.game.newLostAsset")),true,true);
                     movie.movie.x = 438;
                     movie.movie.y = 244;
                  }
               }
               else
               {
                  if(GameControl.Instance.Current.selfGamePlayer.isWin)
                  {
                     movie = new MovieClipWrapper(MovieClip(ClassUtils.CreatInstance("asset.game.winAsset")),true,true);
                  }
                  else
                  {
                     movie = new MovieClipWrapper(MovieClip(ClassUtils.CreatInstance("asset.game.lostAsset")),true,true);
                  }
                  movie.movie.x = 500;
                  movie.movie.y = 360;
               }
               SoundManager.instance.play("040");
               _map.gameView.addChild(movie.movie);
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
