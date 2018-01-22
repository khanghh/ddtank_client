package game.actions
{
   import bombKing.BombKingManager;
   import com.pickgliss.utils.ClassUtils;
   import ddt.data.PathInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import game.objects.GameLiving;
   import game.objects.SimpleBox;
   import game.view.GameView;
   import game.view.map.MapView;
   import gameCommon.GameControl;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   import gameCommon.model.LocalPlayer;
   import gameCommon.model.TurnedLiving;
   import org.aswing.KeyboardManager;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import road7th.utils.MovieClipWrapper;
   import room.RoomManager;
   
   public class ChangePlayerAction extends BaseAction
   {
       
      
      private var _map:MapView;
      
      private var _info:Living;
      
      private var _count:int;
      
      private var _changed:Boolean;
      
      private var _pkg:PackageIn;
      
      private var _event:CrazyTankSocketEvent;
      
      private var _turnTime:int;
      
      public function ChangePlayerAction(param1:MapView, param2:Living, param3:CrazyTankSocketEvent, param4:PackageIn, param5:Number = 200, param6:int = -1)
      {
         super();
         _event = param3;
         _event.executed = false;
         _pkg = param4;
         _map = param1;
         _info = param2;
         _count = param5 / 40;
         _turnTime = param6;
      }
      
      private function syncMap() : void
      {
         var _loc1_:* = null;
         var _loc28_:* = 0;
         var _loc14_:int = 0;
         var _loc9_:int = 0;
         var _loc8_:int = 0;
         var _loc33_:int = 0;
         var _loc36_:* = null;
         var _loc25_:int = 0;
         var _loc15_:int = 0;
         var _loc10_:Boolean = false;
         var _loc31_:int = 0;
         var _loc30_:int = 0;
         var _loc23_:int = 0;
         var _loc18_:Boolean = false;
         var _loc19_:int = 0;
         var _loc13_:int = 0;
         var _loc20_:int = 0;
         var _loc22_:int = 0;
         var _loc2_:int = 0;
         var _loc32_:int = 0;
         var _loc16_:int = 0;
         var _loc38_:int = 0;
         var _loc3_:* = null;
         var _loc27_:int = 0;
         var _loc12_:* = null;
         var _loc26_:int = 0;
         var _loc34_:* = null;
         var _loc11_:Boolean = _pkg.readBoolean();
         var _loc5_:int = _pkg.readByte();
         var _loc7_:int = _pkg.readByte();
         var _loc6_:int = _pkg.readByte();
         var _loc21_:int = _pkg.readInt();
         var _loc35_:Number = _pkg.readInt() / 100;
         var _loc39_:int = _pkg.readInt();
         var _loc37_:Array = [_loc11_,_loc5_,_loc7_,_loc6_,_loc21_,_loc39_];
         GameControl.Instance.Current.setWind(GameControl.Instance.Current.wind,_info.LivingID == GameControl.Instance.Current.selfGamePlayer.LivingID,_loc37_);
         _info.isHidden = _pkg.readBoolean();
         var _loc17_:int = _pkg.readInt();
         if(_info is LocalPlayer)
         {
            _loc1_ = LocalPlayer(_info);
            if(_turnTime == -1)
            {
               if(_loc17_ > 0)
               {
                  _loc1_.turnTime = _loc17_;
               }
               else
               {
                  _loc1_.turnTime = RoomManager.getTurnTimeByType(RoomManager.Instance.current.timeType);
               }
            }
            else
            {
               _loc1_.turnTime = _turnTime;
               GameInSocketOut.sendGameSkipNext(0);
            }
            if(_loc17_ == RoomManager.getTurnTimeByType(RoomManager.Instance.current.timeType))
            {
            }
         }
         var _loc4_:int = _pkg.readInt();
         _loc28_ = uint(0);
         while(_loc28_ < _loc4_)
         {
            _loc14_ = _pkg.readInt();
            _loc9_ = _pkg.readInt();
            _loc8_ = _pkg.readInt();
            _loc33_ = _pkg.readInt();
            _loc36_ = new SimpleBox(_loc14_,String(PathInfo.GAME_BOXPIC),_loc33_);
            _loc36_.x = _loc9_;
            _loc36_.y = _loc8_;
            _map.addPhysical(_loc36_);
            _loc28_++;
         }
         var _loc24_:int = _pkg.readInt();
         _loc25_ = 0;
         while(_loc25_ < _loc24_)
         {
            _loc15_ = _pkg.readInt();
            _loc10_ = _pkg.readBoolean();
            _loc31_ = _pkg.readInt();
            _loc30_ = _pkg.readInt();
            _loc23_ = _pkg.readInt();
            _loc18_ = _pkg.readBoolean();
            _loc19_ = _pkg.readInt();
            _loc13_ = _pkg.readInt();
            _loc20_ = _pkg.readInt();
            _loc22_ = _pkg.readInt();
            _loc2_ = _pkg.readInt();
            _loc32_ = _pkg.readInt();
            _loc16_ = _pkg.readInt();
            _loc38_ = _pkg.readInt();
            _loc3_ = GameControl.Instance.Current.livings[_loc15_];
            if(_loc3_)
            {
               if(!_loc3_.isLiving && _loc10_)
               {
                  (_map.gameView as GameView).revivePlayerChangePlayer(_loc3_.LivingID);
               }
               _loc3_.updateBlood(_loc23_,5);
               _loc3_.isNoNole = _loc18_;
               _loc3_.maxEnergy = _loc19_;
               _loc3_.psychic = _loc13_;
               _loc3_.turnCount = _loc38_;
               if(_loc3_.isSelf)
               {
                  _loc1_ = LocalPlayer(_loc3_);
                  _loc1_.energy = _loc3_.maxEnergy;
                  _loc1_.shootCount = _loc32_;
                  _loc1_.dander = _loc20_;
                  if(_loc1_.currentPet)
                  {
                     _loc1_.currentPet.MaxMP = _loc22_;
                     _loc1_.currentPet.MP = _loc2_;
                  }
                  _loc1_.soulPropCount = 0;
                  _loc1_.flyCount = _loc16_;
               }
               if(!_loc10_)
               {
                  _loc3_.die();
               }
               else
               {
                  _loc3_.onChange = false;
                  _loc3_.pos = new Point(_loc31_,_loc30_);
                  _loc3_.onChange = true;
               }
            }
            _loc25_++;
         }
         _map.currentTurn = _pkg.readInt();
         var _loc29_:Boolean = _pkg.readBoolean();
         if(_loc29_)
         {
            _loc27_ = _pkg.readInt();
            _loc12_ = new DictionaryData();
            _loc26_ = 0;
            while(_loc26_ < _loc27_)
            {
               _loc34_ = new Bomb();
               _loc34_.Id = _pkg.readInt();
               _loc34_.X = _pkg.readInt();
               _loc34_.Y = _pkg.readInt();
               _loc12_.add(_loc26_,_loc34_);
               _loc26_++;
            }
            _map.DigOutCrater(_loc12_);
         }
      }
      
      override public function execute() : void
      {
         if(!_changed)
         {
            if(_map.hasSomethingMoving() == false && (_map.currentPlayer == null || _map.currentPlayer.actionCount == 0))
            {
               executeImp(false);
            }
         }
         else
         {
            _count = Number(_count) - 1;
            if(_count <= 0)
            {
               changePlayer();
            }
         }
      }
      
      private function changePlayer() : void
      {
         if(_info is TurnedLiving && !BombKingManager.instance.Recording)
         {
            TurnedLiving(_info).isAttacking = true;
         }
         _map.gameView.updateControlBarState(_info);
         _isFinished = true;
      }
      
      override public function cancel() : void
      {
         _event.executed = true;
      }
      
      private function executeImp(param1:Boolean) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(!_info.isExist)
         {
            _isFinished = true;
            _map.gameView.updateControlBarState(null);
            return;
         }
         if(!_changed)
         {
            _event.executed = true;
            _changed = true;
            if(_pkg)
            {
               syncMap();
            }
            var _loc6_:* = 0;
            var _loc5_:* = GameControl.Instance.Current.livings;
            for each(var _loc4_ in GameControl.Instance.Current.livings)
            {
               _loc4_.beginNewTurn();
            }
            _map.gameView.setCurrentPlayer(_info);
            _loc3_ = _map.getPhysical(_info.LivingID) as GameLiving;
            if(_loc3_)
            {
               _loc3_.needFocus(0,0,{"priority":3});
            }
            else
            {
               trace("ChangePlayerAction->infoLivingID:" + _info.LivingID + " 未在map.getPhysical方法中找到！");
            }
            _info.gemDefense = false;
            if(_info is LocalPlayer && !param1 && !BombKingManager.instance.Recording)
            {
               KeyboardManager.getInstance().reset();
               SoundManager.instance.play("016");
               _loc2_ = new MovieClipWrapper(MovieClip(ClassUtils.CreatInstance("asset.game.TurnAsset")),true,true);
               _loc2_.repeat = false;
               _loc6_ = false;
               _loc2_.movie.mouseEnabled = _loc6_;
               _loc2_.movie.mouseChildren = _loc6_;
               _loc2_.movie.x = 440;
               _loc2_.movie.y = 180;
               _map.gameView.addChild(_loc2_.movie);
            }
            else
            {
               SoundManager.instance.play("038");
               changePlayer();
            }
         }
      }
      
      override public function executeAtOnce() : void
      {
         super.executeAtOnce();
         executeImp(false);
         changePlayer();
      }
   }
}
