package littleGame
{
   import ddt.data.player.PlayerInfo;
   import ddt.ddt_internal;
   import ddt.manager.ChatManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import flash.display.DisplayObjectContainer;
   import flash.events.EventDispatcher;
   import littleGame.actions.LittleAction;
   import littleGame.actions.LittleLivingDieAction;
   import littleGame.actions.LittleLivingMoveAction;
   import littleGame.actions.LittleSelfMoveAction;
   import littleGame.data.Grid;
   import littleGame.data.Node;
   import littleGame.interfaces.ILittleObject;
   import littleGame.model.LittleLiving;
   import littleGame.model.LittlePlayer;
   import littleGame.model.LittleSelf;
   import littleGame.model.Scenario;
   import littleGame.object.BoguGiveUp;
   import littleGame.object.NormalBoguInhaled;
   import littleGame.view.GameScene;
   import road7th.comm.PackageIn;
   import road7th.comm.PackageOut;
   
   use namespace ddt_internal;
   
   [Event(name="activedChanged",type="littleGame.events.LittleGameEvent")]
   public class LittleGameManager extends EventDispatcher
   {
      
      public static const Player:int = 1;
      
      public static const Living:int = 2;
      
      public static const GameBackLayer:int = 0;
      
      public static const GameForeLayer:int = 1;
      
      private static var _ins:LittleGameManager;
       
      
      public var soundEnabled:Boolean = true;
      
      private var _current:Scenario;
      
      private var _mainStage:DisplayObjectContainer;
      
      private var _gamescene:GameScene;
      
      public function LittleGameManager()
      {
         super();
      }
      
      public static function get Instance() : LittleGameManager
      {
         return _ins || new LittleGameManager();
      }
      
      public function kickPlayer(param1:PackageIn) : void
      {
         StateManager.setState("main");
      }
      
      public function fillPath(param1:LittleLiving, param2:Grid, param3:int, param4:int, param5:int, param6:int) : Array
      {
         var _loc7_:* = null;
         if(param1.isSelf && param1.MotionState <= 1)
         {
            return null;
         }
         var _loc8_:Node = param2.getNode(param5,param6);
         if(_loc8_ && _loc8_.walkable)
         {
            param2.setStartNode(param3,param4);
            param2.setEndNode(param5,param6);
            if(param2.fillPath())
            {
               _loc7_ = param2.path;
               return _loc7_;
            }
            return null;
         }
         return null;
      }
      
      public function collide(param1:LittleSelf, param2:LittleLiving) : Boolean
      {
         return true;
      }
      
      public function enterWorld() : void
      {
         var _loc1_:PackageOut = createPackageOut();
         _loc1_.writeByte(2);
         sendPackage(_loc1_);
      }
      
      public function enterGame(param1:Scenario, param2:PackageIn) : void
      {
         var _loc4_:int = 0;
         BoguGiveUp.NoteCount = 0;
         NormalBoguInhaled.NoteCount = 0;
         _current = param1;
         _current.drawNum();
         var _loc3_:int = param2.readInt();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            param1.addLiving(readLivingFromPacket(param2,param1));
            _loc4_++;
         }
      }
      
      public function addObject(param1:Scenario, param2:String, param3:PackageIn = null) : ILittleObject
      {
         var _loc4_:ILittleObject = ObjectCreator.CreatObject(param2);
         if(_loc4_)
         {
            _loc4_.initialize(param1,param3);
            param1.addObject(_loc4_);
         }
         return _loc4_;
      }
      
      public function removeObject(param1:Scenario, param2:PackageIn) : ILittleObject
      {
         var _loc3_:int = param2.readInt();
         return param1.removeObject(param1.findObject(_loc3_));
      }
      
      public function invokeObject(param1:Scenario, param2:PackageIn) : ILittleObject
      {
         var _loc3_:int = param2.readInt();
         var _loc4_:ILittleObject = param1.findObject(_loc3_);
         _loc4_.invoke(param2);
         return _loc4_;
      }
      
      public function addLiving(param1:Scenario, param2:PackageIn) : LittleLiving
      {
         return param1.addLiving(readLivingFromPacket(param2,param1));
      }
      
      public function removeLiving(param1:Scenario, param2:PackageIn) : LittleLiving
      {
         var _loc4_:int = param2.readInt();
         var _loc3_:LittleLiving = param1.livings[_loc4_];
         if(_loc3_ && !_loc3_.dieing)
         {
            param1.removeLiving(_loc3_);
         }
         return _loc3_;
      }
      
      public function livingDie(param1:Scenario, param2:LittleLiving, param3:int = 6) : void
      {
         var _loc4_:LittleAction = new LittleLivingDieAction(param1,param2,param3);
         param2.act(_loc4_);
      }
      
      private function readLivingFromPacket(param1:PackageIn, param2:Scenario = null) : LittleLiving
      {
         var _loc5_:* = null;
         var _loc14_:* = null;
         var _loc11_:* = null;
         var _loc10_:* = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc12_:* = null;
         var _loc9_:int = param1.readInt();
         var _loc16_:int = param1.readInt();
         var _loc15_:int = param1.readInt();
         var _loc6_:int = param1.readInt();
         if(_loc6_ == 1)
         {
            _loc14_ = new PlayerInfo();
            _loc14_.ID = param1.readInt();
            _loc14_.Grade = param1.readInt();
            _loc14_.Repute = param1.readInt();
            _loc14_.NickName = param1.readUTF();
            _loc14_.typeVIP = param1.readByte();
            _loc14_.VIPLevel = param1.readInt();
            _loc14_.Sex = param1.readBoolean();
            _loc14_.Style = param1.readUTF();
            _loc14_.Colors = param1.readUTF();
            _loc14_.Skin = param1.readUTF();
            _loc14_.Hide = param1.readInt();
            _loc14_.FightPower = param1.readInt();
            _loc14_.WinCount = param1.readInt();
            _loc14_.TotalCount = param1.readInt();
            if(_loc14_.ID == PlayerManager.Instance.Self.ID)
            {
               _loc5_ = new LittleSelf(PlayerManager.Instance.Self,_loc9_,_loc16_,_loc15_,_loc6_);
            }
            else
            {
               _loc5_ = new LittlePlayer(_loc14_,_loc9_,_loc16_,_loc15_,_loc6_);
            }
         }
         else
         {
            _loc11_ = param1.readUTF();
            _loc10_ = param1.readUTF();
            _loc5_ = new LittleLiving(_loc9_,_loc16_,_loc15_,_loc6_,_loc10_);
            _loc5_.name = _loc11_;
         }
         var _loc7_:Boolean = param1.readBoolean();
         if(_loc7_)
         {
            _loc3_ = param1.readInt();
            _loc4_ = param1.readInt();
            if(param2)
            {
               fillPath(_loc5_,param2.grid,_loc16_,_loc15_,_loc3_,_loc4_);
            }
         }
         var _loc13_:int = param1.readInt();
         _loc8_ = 0;
         while(_loc8_ < _loc13_)
         {
            _loc12_ = doAction(param2,param1);
            _loc12_.initializeLiving(_loc5_);
            _loc5_.act(_loc12_);
            _loc8_++;
         }
         return _loc5_;
      }
      
      private function setLivingSize(param1:LittleLiving, param2:String) : void
      {
         if(param2 == "bogu4" || param2 == "bogu5" || param2 == "bogu8")
         {
            param1.size = 1;
         }
         else if(param2 == "bogu6")
         {
            param1.size = 2;
         }
         else if(param2 == "bogu7")
         {
            param1.size = 3;
         }
      }
      
      public function updatePos(param1:Scenario, param2:PackageIn) : void
      {
         var _loc8_:int = 0;
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = null;
         param2.readDouble();
         var _loc4_:int = param2.readInt();
         _loc8_ = 0;
         while(_loc8_ < _loc4_)
         {
            _loc3_ = param2.readInt();
            _loc7_ = param2.readInt();
            _loc6_ = param2.readInt();
            _loc5_ = param1.findLiving(_loc3_);
            _loc8_++;
         }
      }
      
      public function livingMove(param1:Scenario, param2:PackageIn) : LittleLiving
      {
         var _loc6_:* = null;
         var _loc3_:int = param2.readInt();
         var _loc4_:int = param2.readInt();
         var _loc5_:int = param2.readInt();
         var _loc7_:LittleLiving = param1.findLiving(_loc3_);
         if(_loc7_ && !_loc7_.lock && !_loc7_.dieing && !_loc7_.borning && _loc7_.MotionState > 1)
         {
            _loc6_ = LittleGameManager.Instance.fillPath(_loc7_,param1.grid,_loc7_.pos.x,_loc7_.pos.y,_loc4_,_loc5_);
            if(_loc6_)
            {
               if(!_loc7_.isSelf)
               {
                  _loc7_.act(new LittleLivingMoveAction(_loc7_,_loc6_,param1));
               }
            }
            return _loc7_;
         }
         return null;
      }
      
      public function selfMoveTo(param1:Scenario, param2:LittleSelf, param3:int, param4:int, param5:int, param6:int, param7:int, param8:Array) : void
      {
         param2.act(new LittleSelfMoveAction(param2,param8,_current,param7,param7 + param8.length * 40,true));
         var _loc9_:PackageOut = createPackageOut();
         _loc9_.writeByte(32);
         _loc9_.writeInt(param3);
         _loc9_.writeInt(param4);
         _loc9_.writeInt(param5);
         _loc9_.writeInt(param6);
         _loc9_.writeInt(param7);
         sendPackage(_loc9_);
      }
      
      public function inhaled(param1:LittleSelf) : void
      {
         param1.inhaled = false;
      }
      
      public function updateLivingProperty(param1:Scenario, param2:PackageIn) : void
      {
         var _loc6_:* = null;
         var _loc8_:int = 0;
         var _loc3_:* = undefined;
         var _loc9_:int = 0;
         var _loc4_:int = param2.readInt();
         var _loc5_:int = param2.readInt();
         var _loc7_:LittleLiving = param1.findLiving(_loc4_);
         if(_loc7_)
         {
            _loc9_ = 0;
            for(; _loc9_ < _loc5_; _loc9_++)
            {
               _loc6_ = param2.readUTF();
               _loc8_ = param2.readInt();
               switch(int(_loc8_) - 1)
               {
                  case 0:
                     _loc3_ = param2.readInt();
                     break;
                  case 1:
                     _loc3_ = param2.readBoolean();
                     break;
                  case 2:
                     _loc3_ = param2.readUTF();
               }
               if(_loc7_.hasOwnProperty(_loc6_))
               {
                  _loc7_[_loc6_] = _loc3_;
                  continue;
               }
            }
         }
      }
      
      public function doAction(param1:Scenario, param2:PackageIn) : LittleAction
      {
         var _loc4_:String = param2.readUTF();
         var _loc3_:LittleAction = LittleActionCreator.CreatAction(_loc4_);
         if(_loc3_)
         {
            _loc3_.parsePackege(param1,param2);
         }
         return _loc3_;
      }
      
      public function doMovie(param1:Scenario, param2:PackageIn) : void
      {
         var _loc3_:int = param2.readInt();
         var _loc5_:LittleLiving = param1.findLiving(_loc3_);
         var _loc4_:String = param2.readUTF();
         if(!_loc5_)
         {
         }
      }
      
      public function setClock(param1:Scenario, param2:PackageIn) : void
      {
         var _loc3_:int = param2.readInt();
      }
      
      public function pong(param1:Scenario, param2:PackageIn) : void
      {
         var _loc3_:int = param2.readInt();
         var _loc4_:PackageOut = createPackageOut();
         _loc4_.writeByte(6);
         _loc4_.writeInt(_loc3_);
         sendPackage(_loc4_);
      }
      
      public function ping(param1:int) : void
      {
         var _loc2_:PackageOut = createPackageOut();
         _loc2_.writeByte(6);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function setNetDelay(param1:Scenario, param2:PackageIn) : void
      {
         var _loc3_:int = param2.readInt();
         param1.delay = _loc3_;
         ChatManager.Instance.sysChatYellow("delay:" + _loc3_);
      }
      
      public function getScore(param1:Scenario, param2:PackageIn) : void
      {
         var _loc3_:int = param2.readInt();
         param1.selfPlayer.getScore(_loc3_);
      }
      
      public function livingClick(param1:Scenario, param2:LittleLiving, param3:int, param4:int) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc9_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         if(!param2.isPlayer && !param2.dieing)
         {
            _loc5_ = param3 / _current.grid.cellSize;
            _loc6_ = param4 / _current.grid.cellSize;
            _loc9_ = _current.selfPlayer;
            _loc7_ = fillPath(_loc9_,_current.grid,_loc9_.pos.x,_loc9_.pos.y,_loc5_,_loc6_);
            if(!_loc7_)
            {
            }
            if(!param2.borning && _loc9_.MotionState > 1)
            {
               _loc8_ = createPackageOut();
               _loc8_.writeByte(65);
               _loc8_.writeInt(param2.id);
               _loc8_.writeInt(param2.pos.x);
               _loc8_.writeInt(param2.pos.y);
               _loc8_.writeInt(_loc9_.pos.x);
               _loc8_.writeInt(_loc9_.pos.y);
               sendPackage(_loc8_);
            }
         }
      }
      
      public function cancelInhaled(param1:int) : void
      {
         var _loc2_:PackageOut = createPackageOut();
         _loc2_.writeByte(66);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function synchronousLivingPos(param1:int, param2:int) : void
      {
         trace("同步位置: ",param1,"  ",param2);
         var _loc3_:PackageOut = createPackageOut();
         _loc3_.writeByte(33);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function loadComplete() : void
      {
         var _loc1_:PackageOut = createPackageOut();
         _loc1_.writeByte(3);
         sendPackage(_loc1_);
      }
      
      public function createGame(param1:PackageIn) : Scenario
      {
         var _loc2_:Scenario = new Scenario();
         _loc2_.worldID = param1.readInt();
         _loc2_.id = param1.readInt();
         _loc2_.monsters = param1.readUTF();
         _loc2_.music = param1.readUTF();
         return _loc2_;
      }
      
      public function leave() : void
      {
         var _loc1_:PackageOut = createPackageOut();
         _loc1_.writeByte(4);
         sendPackage(_loc1_);
         StateManager.setState("littleHall");
         LittleGamePacketQueue.Instance.shutdown();
      }
      
      public function get Current() : Scenario
      {
         return _current;
      }
      
      public function sendScore(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = createPackageOut();
         _loc3_.writeByte(64);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      private function createPackageOut() : PackageOut
      {
         return new PackageOut(166);
      }
      
      public function sendPackage(param1:PackageOut) : void
      {
         SocketManager.Instance.out.sendPackage(param1);
      }
      
      public function setMainStage(param1:DisplayObjectContainer) : void
      {
         _mainStage = param1;
      }
      
      public function setGameScene(param1:GameScene) : void
      {
         _gamescene = param1;
      }
      
      public function get gameScene() : GameScene
      {
         return _gamescene;
      }
      
      public function get mainStage() : DisplayObjectContainer
      {
         return _mainStage;
      }
   }
}
