package game.actions
{
   import ddt.data.PathInfo;
   import ddt.events.CrazyTankSocketEvent;
   import game.objects.GameSmallEnemy;
   import game.objects.SimpleBox;
   import game.view.GameView;
   import game.view.map.MapView;
   import gameCommon.GameControl;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   import gameCommon.model.SmallEnemy;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   
   public class ChangeNpcAction extends BaseAction
   {
       
      
      private var _gameView:GameView;
      
      private var _map:MapView;
      
      private var _info:Living;
      
      private var _pkg:PackageIn;
      
      private var _event:CrazyTankSocketEvent;
      
      private var _ignoreSmallEnemy:Boolean;
      
      public function ChangeNpcAction(param1:GameView, param2:MapView, param3:Living, param4:CrazyTankSocketEvent, param5:PackageIn, param6:Boolean)
      {
         super();
         _gameView = param1;
         _event = param4;
         _event.executed = false;
         _pkg = param5;
         _map = param2;
         _info = param3;
         _ignoreSmallEnemy = param6;
      }
      
      private function syncMap() : void
      {
         var _loc9_:Boolean = false;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc16_:Number = NaN;
         var _loc20_:int = 0;
         var _loc19_:* = null;
         var _loc1_:int = 0;
         var _loc11_:* = 0;
         var _loc18_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc14_:* = 0;
         var _loc17_:* = null;
         var _loc12_:Boolean = false;
         var _loc10_:int = 0;
         var _loc13_:* = null;
         var _loc8_:int = 0;
         var _loc15_:* = null;
         if(_pkg)
         {
            _loc9_ = _pkg.readBoolean();
            _loc3_ = _pkg.readByte();
            _loc5_ = _pkg.readByte();
            _loc4_ = _pkg.readByte();
            _loc2_ = _pkg.readInt();
            _loc16_ = _pkg.readInt() / 100;
            _loc20_ = _pkg.readInt();
            _loc19_ = [_loc9_,_loc3_,_loc5_,_loc4_,_loc2_,_loc20_];
            GameControl.Instance.Current.setWind(GameControl.Instance.Current.wind,false,_loc19_);
            _pkg.readBoolean();
            _pkg.readInt();
            _loc1_ = _pkg.readInt();
            _loc11_ = uint(0);
            while(_loc11_ < _loc1_)
            {
               _loc18_ = _pkg.readInt();
               _loc7_ = _pkg.readInt();
               _loc6_ = _pkg.readInt();
               _loc14_ = uint(_pkg.readInt());
               _loc17_ = new SimpleBox(_loc18_,String(PathInfo.GAME_BOXPIC),_loc14_);
               _loc17_.x = _loc7_;
               _loc17_.y = _loc6_;
               _map.addPhysical(_loc17_);
               _loc11_++;
            }
            _loc12_ = _pkg.readBoolean();
            if(_loc12_)
            {
               _loc10_ = _pkg.readInt();
               _loc13_ = new DictionaryData();
               _loc8_ = 0;
               while(_loc8_ < _loc10_)
               {
                  _loc15_ = new Bomb();
                  _loc15_.Id = _pkg.readInt();
                  _loc15_.X = _pkg.readInt();
                  _loc15_.Y = _pkg.readInt();
                  _loc13_.add(_loc8_,_loc15_);
                  _loc8_++;
               }
               _map.DigOutCrater(_loc13_);
            }
         }
      }
      
      private function updateNpc() : void
      {
         if(GameControl.Instance.Current == null)
         {
            return;
         }
         var _loc3_:int = 0;
         var _loc2_:* = GameControl.Instance.Current.livings;
         for each(var _loc1_ in GameControl.Instance.Current.livings)
         {
            _loc1_.beginNewTurn();
         }
         _map.cancelFocus();
         _gameView.setCurrentPlayer(_info);
         if(!_map.smallMap.locked)
         {
            focusOnSmallEnemy();
         }
         if(!_ignoreSmallEnemy)
         {
            _ignoreSmallEnemy = true;
            _gameView.updateControlBarState(GameControl.Instance.Current.selfGamePlayer);
            return;
         }
      }
      
      private function getClosestEnemy() : SmallEnemy
      {
         var _loc1_:* = null;
         var _loc3_:int = -1;
         var _loc4_:int = GameControl.Instance.Current.selfGamePlayer.pos.x;
         var _loc6_:int = 0;
         var _loc5_:* = GameControl.Instance.Current.livings;
         for each(var _loc2_ in GameControl.Instance.Current.livings)
         {
            if(_loc2_ is SmallEnemy && _loc2_.isLiving && _loc2_.typeLiving != 3)
            {
               if(_loc3_ == -1 || Math.abs(_loc2_.pos.x - _loc4_) < _loc3_)
               {
                  _loc3_ = Math.abs(_loc2_.pos.x - _loc4_);
                  _loc1_ = _loc2_ as SmallEnemy;
               }
            }
         }
         return _loc1_;
      }
      
      private function focusOnSmallEnemy() : void
      {
         var _loc1_:SmallEnemy = getClosestEnemy();
         if(_loc1_)
         {
            if(_loc1_.LivingID && _map.getPhysical(_loc1_.LivingID))
            {
               (_map.getPhysical(_loc1_.LivingID) as GameSmallEnemy).needFocus();
               _map.currentFocusedLiving = _map.getPhysical(_loc1_.LivingID) as GameSmallEnemy;
            }
         }
      }
      
      override public function execute() : void
      {
         _event.executed = true;
         syncMap();
         updateNpc();
         _isFinished = true;
      }
   }
}
