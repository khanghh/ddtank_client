package boguAdventure
{
   import boguAdventure.event.BoguAdventureEvent;
   import boguAdventure.model.BoguAdventureCellInfo;
   import boguAdventure.model.BoguAdventureModel;
   import boguAdventure.player.BoguAdventurePlayer;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import road7th.comm.PackageIn;
   
   public class BoguAdventureControl extends EventDispatcher
   {
      
      public static const SIGN_MAX_COUNT:int = 10;
       
      
      public var changeMouse:Boolean;
      
      public var currentIndex:int;
      
      private var _hp:int;
      
      public var isMove:Boolean;
      
      public var signFocus:Point;
      
      public var mineFocus:Point;
      
      public var mineNumFocus:Point;
      
      private var _bogu:BoguAdventurePlayer;
      
      private var _model:BoguAdventureModel;
      
      public function BoguAdventureControl()
      {
         super();
         init();
         SocketManager.Instance.addEventListener("boguadventure",__onAllEvent);
      }
      
      private function init() : void
      {
         _model = new BoguAdventureModel();
         signFocus = new Point(9,39);
         mineFocus = new Point(21,42);
         mineNumFocus = new Point(9,70);
      }
      
      private function __onAllEvent(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = param1._cmd;
         switch(int(_loc2_) - 90)
         {
            case 0:
               enterGame(_loc3_);
               break;
            case 1:
               updateCell(_loc3_);
               break;
            case 2:
               revive(_loc3_);
               break;
            case 3:
               acquireAward(_loc3_);
               break;
            default:
               acquireAward(_loc3_);
               break;
            default:
               acquireAward(_loc3_);
               break;
            default:
               acquireAward(_loc3_);
               break;
            default:
               acquireAward(_loc3_);
               break;
            default:
               acquireAward(_loc3_);
               break;
            case 9:
               _model.resetCount = _loc3_.readInt();
               _model.isFreeReset = _loc3_.readBoolean();
               dispatchEvent(new BoguAdventureEvent("boguadventureeventupdatereset"));
         }
      }
      
      private function enterGame(param1:PackageIn) : void
      {
         var _loc3_:int = 0;
         var _loc9_:* = null;
         var _loc8_:int = 0;
         var _loc7_:* = null;
         var _loc6_:int = 0;
         var _loc2_:Vector.<BoguAdventureCellInfo> = new Vector.<BoguAdventureCellInfo>();
         currentIndex = param1.readInt();
         hp = param1.readInt();
         _model.isAcquireAward1 = param1.readInt() == 1;
         _model.isAcquireAward2 = param1.readInt() == 1;
         _model.isAcquireAward3 = param1.readInt() == 1;
         _model.openCount = param1.readInt();
         _model.findMinePrice = param1.readInt();
         _model.revivePrice = param1.readInt();
         _model.resetPrice = param1.readInt();
         _model.isFreeReset = param1.readBoolean();
         _model.resetCount = param1.readInt();
         _loc3_ = param1.readInt();
         _loc8_ = 0;
         while(_loc8_ < _loc3_)
         {
            _loc9_ = new BoguAdventureCellInfo();
            _loc9_.index = param1.readInt();
            _loc9_.state = param1.readInt();
            _loc9_.result = param1.readInt();
            _loc9_.aroundMineCount = param1.readInt();
            _loc2_.push(_loc9_);
            _loc8_++;
         }
         _model.mapInfoList = _loc2_;
         var _loc5_:Array = [];
         var _loc4_:Array = [];
         _loc8_ = 0;
         while(_loc8_ < 3)
         {
            _loc5_.push(param1.readInt());
            _loc3_ = param1.readInt();
            _loc7_ = "";
            _loc6_ = 0;
            while(_loc6_ < _loc3_)
            {
               _loc7_ = _loc7_ + (ItemManager.Instance.getTemplateById(param1.readInt()).Name + "x");
               _loc7_ = _loc7_ + param1.readInt().toString();
               _loc7_ = _loc7_ + "\n";
               _loc6_++;
            }
            _loc4_.push(_loc7_);
            _loc8_++;
         }
         _model.awardCount = _loc5_;
         _model.awardGoodsTip = _loc4_;
         if(_bogu)
         {
            dispatchEvent(new BoguAdventureEvent("boguadventureeventupdatemap"));
         }
      }
      
      private function updateCell(param1:PackageIn) : void
      {
         var _loc4_:int = param1.readInt();
         var _loc3_:int = param1.readInt();
         var _loc2_:int = param1.readInt();
         _model.findMinePrice = param1.readInt();
         if(_loc4_ == 4)
         {
            currentIndex = _loc3_;
            hp = param1.readInt();
            _model.openCount = param1.readInt();
         }
         dispatchEvent(new BoguAdventureEvent("boguadventureeventupdatecell",{
            "type":_loc4_,
            "result":_loc2_,
            "index":_loc3_
         }));
      }
      
      private function revive(param1:PackageIn) : void
      {
         hp = param1.readInt();
      }
      
      private function acquireAward(param1:PackageIn) : void
      {
         _model.isAcquireAward1 = param1.readInt() == 1;
         _model.isAcquireAward2 = param1.readInt() == 1;
         _model.isAcquireAward3 = param1.readInt() == 1;
      }
      
      public function checkGameOver() : Boolean
      {
         if(_model.openCount >= _model.awardCount[2])
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("boguAdventure.view.gameOver"));
            return true;
         }
         if(_hp <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("boguAdventure.view.hpNotEnough"));
            return true;
         }
         if(!BoguAdventureManager.instance.isOpen)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("boguAdventure.view.activityOver"));
            return true;
         }
         return false;
      }
      
      public function walk(param1:Array) : void
      {
         dispatchEvent(new BoguAdventureEvent("boguadventureeventwalk",param1));
      }
      
      public function walkComplete() : void
      {
         dispatchEvent(new BoguAdventureEvent("boguadventureeventstop"));
      }
      
      public function playActionComplete(param1:Object = null) : void
      {
         dispatchEvent(new BoguAdventureEvent("boguadventureeventactioncomplete",param1));
      }
      
      public function get hp() : int
      {
         return _hp;
      }
      
      public function set hp(param1:int) : void
      {
         if(_hp == param1)
         {
            return;
         }
         _hp = param1;
         dispatchEvent(new BoguAdventureEvent("boguadventureeventchangehp"));
      }
      
      public function get bogu() : BoguAdventurePlayer
      {
         return _bogu;
      }
      
      public function set bogu(param1:BoguAdventurePlayer) : void
      {
         _bogu = param1;
         if(_model.mapInfoList != null)
         {
            dispatchEvent(new BoguAdventureEvent("boguadventureeventupdatemap"));
         }
      }
      
      public function get model() : BoguAdventureModel
      {
         return _model;
      }
      
      public function checkGetAward() : Boolean
      {
         if(_model.openCount >= _model.awardCount[0] && !_model.isAcquireAward1 || _model.openCount >= _model.awardCount[1] && !_model.isAcquireAward2 || _model.openCount >= _model.awardCount[2] && !_model.isAcquireAward3)
         {
            return true;
         }
         return false;
      }
      
      public function dispose() : void
      {
         SocketManager.Instance.removeEventListener("boguadventure",__onAllEvent);
         _bogu = null;
         _model.dispose();
         _model = null;
         signFocus = null;
         mineFocus = null;
         mineNumFocus = null;
      }
   }
}
